#!/usr/bin/env python3
import math
import rospy
from geometry_msgs.msg import Twist
from turtlesim.msg import Pose

KP_LIN = 1.5
KP_ANG = 1.0
TOL = 0.1


def normalize(angle):
    """Bungkus sudut ke [-pi, pi] supaya kura-kura memilih arah putar terpendek."""
    return math.atan2(math.sin(angle), math.cos(angle))


class Controller:
    def __init__(self):
        self.pose = None
        self.idx = 0
        # daftar waypoint dari YAML (~waypoints), bukan hardcode
        self.waypoints = rospy.get_param('~waypoints')
        self.pub = rospy.Publisher('/turtle1/cmd_vel', Twist, queue_size=10)
        rospy.Subscriber('/turtle1/pose', Pose, self.pose_cb)

    def pose_cb(self, msg):
        self.pose = msg

    def step(self):
        # TODO 1: belum ada pose -> tunggu
        if self.pose is None:
            return
        # semua waypoint selesai -> diam
        if self.idx >= len(self.waypoints):
            self.pub.publish(Twist())
            return

        gx, gy = self.waypoints[self.idx]

        dx = gx - self.pose.x
        dy = gy - self.pose.y
        distance = math.hypot(dx, dy)

        # TODO 5: sampai -> berhenti sebentar, lanjut ke waypoint berikutnya
        if distance < TOL:
            self.pub.publish(Twist())
            rospy.loginfo('Waypoint %d (%.1f, %.1f) tercapai', self.idx, gx, gy)
            self.idx += 1
            return

        # TODO 3 + 4: error sudut, dinormalisasi
        desired = math.atan2(dy, dx)
        err = normalize(desired - self.pose.theta)

        # TODO 6: P-controller
        cmd = Twist()
        cmd.angular.z = KP_ANG * err
        # putar dulu kalau masih melenceng jauh, baru maju
        if abs(err) < 0.5:
            cmd.linear.x = KP_LIN * distance
        self.pub.publish(cmd)


if __name__ == '__main__':
    rospy.init_node('waypoint_controller')
    c = Controller()
    rate = rospy.Rate(20)
    while not rospy.is_shutdown():
        c.step()
        rate.sleep()
