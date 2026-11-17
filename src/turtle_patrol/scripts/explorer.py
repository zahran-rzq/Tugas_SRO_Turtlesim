#!/usr/bin/env python3
"""Node: penjelajah. Maju sambil sedikit berkelok; jika dekat dinding,
berputar ke sisi yang lebih lapang sampai aman (hysteresis)."""
import math
import rospy
from geometry_msgs.msg import Twist
from turtle_patrol.msg import WallSensor


class Explorer:
    def __init__(self):
        self.speed = rospy.get_param('~speed', 1.5)
        self.turn_speed = rospy.get_param('~turn_speed', 2.0)
        self.turn_front = rospy.get_param('~turn_front', 1.5)    # mulai belok
        self.clear_front = rospy.get_param('~clear_front', 3.0)  # selesai belok
        self.side_margin = rospy.get_param('~side_margin', 1.0)  # mulai menjauhi dinding samping
        self.side_gain = rospy.get_param('~side_gain', 2.0)
        self.sensor = None
        self.turning = False
        self.turn_dir = 1.0
        self.pub = rospy.Publisher('/turtle1/cmd_vel', Twist, queue_size=10)
        rospy.Subscriber('/wall_sensor', WallSensor, self.sensor_cb)

    def sensor_cb(self, msg):
        self.sensor = msg

    def step(self):
        s = self.sensor
        if s is None:
            return
        # Putar di tempat hanya mengubah arah, bukan posisi. Jadi syarat mulai dan
        # selesai berputar harus bergantung pada jarak DEPAN saja (bukan `nearest`,
        # yang tidak berubah saat berputar dan membuat kura-kura terjebak di pojok).
        danger = s.front < self.turn_front
        safe = s.front > self.clear_front

        if not self.turning and danger:
            self.turning = True
            # pilih arah putar sekali, ke sisi yang lebih lapang (+ = kiri)
            self.turn_dir = 1.0 if s.left >= s.right else -1.0
        elif self.turning and safe:
            self.turning = False

        cmd = Twist()
        if self.turning:
            cmd.angular.z = self.turn_dir * self.turn_speed
        else:
            cmd.linear.x = self.speed
            cmd.angular.z = 0.4 * math.sin(0.5 * rospy.get_time())  # berkelok
            # menjauh dari dinding di samping (kiri dekat -> belok kanan, dst)
            if s.left < self.side_margin:
                cmd.angular.z -= self.side_gain * (self.side_margin - s.left)
            if s.right < self.side_margin:
                cmd.angular.z += self.side_gain * (self.side_margin - s.right)
        self.pub.publish(cmd)


if __name__ == '__main__':
    rospy.init_node('explorer')
    e = Explorer()
    rate = rospy.Rate(20)
    while not rospy.is_shutdown():
        e.step()
        rate.sleep()
