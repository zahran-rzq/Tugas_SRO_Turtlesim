#!/usr/bin/env python3
"""Node: sensor virtual. Menghitung jarak ke dinding dari /turtle1/pose
(seperti lidar 3 arah) dan mempublikasikannya di /wall_sensor."""
import math
import rospy
from turtlesim.msg import Pose
from turtle_patrol.msg import WallSensor

ARENA_MIN = 0.0
ARENA_MAX = 11.0


def ray_distance(x, y, angle):
    """Jarak dari (x, y) ke dinding arena sepanjang arah `angle`."""
    dx, dy = math.cos(angle), math.sin(angle)
    best = float('inf')
    # dinding vertikal x = MIN / MAX, horizontal y = MIN / MAX
    for wall, pos, comp in ((ARENA_MIN, x, dx), (ARENA_MAX, x, dx),
                            (ARENA_MIN, y, dy), (ARENA_MAX, y, dy)):
        if abs(comp) < 1e-9:
            continue
        t = (wall - pos) / comp
        if t > 0:
            best = min(best, t)
    return best


class WallSensorNode:
    def __init__(self):
        self.safe = rospy.get_param('~safe_distance', 1.5)
        self.pub = rospy.Publisher('/wall_sensor', WallSensor, queue_size=10)
        rospy.Subscriber('/turtle1/pose', Pose, self.pose_cb)

    def pose_cb(self, p):
        msg = WallSensor()
        msg.front = ray_distance(p.x, p.y, p.theta)
        msg.left = ray_distance(p.x, p.y, p.theta + math.pi / 2)
        msg.right = ray_distance(p.x, p.y, p.theta - math.pi / 2)
        msg.nearest = min(p.x - ARENA_MIN, ARENA_MAX - p.x,
                          p.y - ARENA_MIN, ARENA_MAX - p.y)
        msg.near_wall = msg.nearest < self.safe
        self.pub.publish(msg)


if __name__ == '__main__':
    rospy.init_node('wall_sensor')
    WallSensorNode()
    rospy.spin()
