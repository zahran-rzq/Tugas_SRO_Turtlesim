#!/usr/bin/env python3
"""Node 1: P-controller. Mengejar /current_target berdasarkan /turtle1/pose."""
import math
import rospy
from geometry_msgs.msg import Twist
from turtlesim.msg import Pose
from turtle_patrol.msg import Waypoint, MissionStatus


def normalize(angle):
    """Bungkus sudut ke [-pi, pi] supaya kura-kura memilih arah putar terpendek."""
    return math.atan2(math.sin(angle), math.cos(angle))


class Controller:
    def __init__(self):
        self.kp_lin = rospy.get_param('~kp_lin', 1.5)
        self.kp_ang = rospy.get_param('~kp_ang', 4.0)
        self.tol = rospy.get_param('~tolerance', 0.1)
        self.pose = None
        self.target = None
        self.pub_cmd = rospy.Publisher('/turtle1/cmd_vel', Twist, queue_size=10)
        self.pub_status = rospy.Publisher('/mission_status', MissionStatus, queue_size=10)
        rospy.Subscriber('/turtle1/pose', Pose, self.pose_cb)
        rospy.Subscriber('/current_target', Waypoint, self.target_cb)

    def pose_cb(self, msg):
        self.pose = msg

    def target_cb(self, msg):
        self.target = msg
        rospy.loginfo('Target baru #%d: (%.1f, %.1f)', msg.index, msg.x, msg.y)

    def step(self):
        if self.pose is None or self.target is None:
            return  # belum ada pose / belum ada misi

        dx = self.target.x - self.pose.x
        dy = self.target.y - self.pose.y
        distance = math.hypot(dx, dy)
        reached = distance < self.tol

        cmd = Twist()
        if not reached:
            err = normalize(math.atan2(dy, dx) - self.pose.theta)
            cmd.angular.z = self.kp_ang * err
            if abs(err) < 0.5:  # putar dulu kalau masih melenceng jauh
                cmd.linear.x = self.kp_lin * distance
        self.pub_cmd.publish(cmd)

        st = MissionStatus()
        st.index = self.target.index
        st.total = self.target.total
        st.distance = distance
        st.reached = reached
        st.finished = reached and self.target.index == self.target.total - 1
        self.pub_status.publish(st)


if __name__ == '__main__':
    rospy.init_node('waypoint_controller')
    c = Controller()
    rate = rospy.Rate(20)
    while not rospy.is_shutdown():
        c.step()
        rate.sleep()
