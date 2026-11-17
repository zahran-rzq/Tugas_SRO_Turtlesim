#!/usr/bin/env python3
"""Node: pengelola perburuan (Level 3).
Spawn kura-kura target di posisi acak (/spawn), mengirim posisinya ke
waypoint_controller lewat /current_target, lalu /kill target saat tertangkap
(controller melapor reached lewat /mission_status), menambah skor, dan mengulang."""
import math
import random
import rospy
from turtlesim.msg import Pose
from turtlesim.srv import Spawn, Kill
from turtle_patrol.msg import Waypoint, MissionStatus, Score


class HunterManager:
    def __init__(self):
        self.margin = rospy.get_param('~margin', 1.0)              # jauh dari dinding
        self.min_dist = rospy.get_param('~min_spawn_distance', 3.0)  # jauh dari turtle1
        self.max_targets = rospy.get_param('~max_targets', 0)      # 0 = tanpa batas
        self.pose = None
        self.n = 0              # nomor target saat ini (juga dipakai sebagai index)
        self.caught = 0
        self.active = False
        self.name = ''

        self.pub_target = rospy.Publisher('/current_target', Waypoint, queue_size=1, latch=True)
        self.pub_score = rospy.Publisher('/score', Score, queue_size=10, latch=True)
        rospy.Subscriber('/turtle1/pose', Pose, self.pose_cb)
        rospy.Subscriber('/mission_status', MissionStatus, self.status_cb)

        rospy.wait_for_service('/spawn')
        rospy.wait_for_service('/kill')
        self.spawn = rospy.ServiceProxy('/spawn', Spawn)
        self.kill = rospy.ServiceProxy('/kill', Kill)

    def pose_cb(self, msg):
        self.pose = msg

    def random_position(self):
        lo, hi = self.margin, 11.0 - self.margin
        while True:
            x, y = random.uniform(lo, hi), random.uniform(lo, hi)
            if self.pose is None or math.hypot(x - self.pose.x, y - self.pose.y) > self.min_dist:
                return x, y

    def spawn_target(self):
        self.n += 1
        self.name = 'target%d' % self.n
        x, y = self.random_position()
        self.spawn(x, y, random.uniform(-math.pi, math.pi), self.name)
        # total=0: ini perburuan, bukan daftar waypoint
        self.pub_target.publish(Waypoint(x=x, y=y, index=self.n, total=0))
        self.publish_score(0.0)
        rospy.loginfo('Target %s di (%.1f, %.1f)', self.name, x, y)

    def publish_score(self, distance):
        self.pub_score.publish(Score(caught=self.caught, target_name=self.name,
                                     distance=distance))

    def status_cb(self, st):
        # abaikan status basi: hanya untuk target yang sedang aktif
        if not self.active or st.index != self.n:
            return
        if not st.reached:
            self.publish_score(st.distance)
            return
        self.active = False            # cegah penanganan ganda selama service berjalan
        self.kill(self.name)
        self.caught += 1
        rospy.loginfo('%s tertangkap! Skor: %d', self.name, self.caught)
        self.publish_score(st.distance)
        if self.max_targets and self.caught >= self.max_targets:
            rospy.loginfo('Selesai: %d target tertangkap.', self.caught)
            return
        self.spawn_target()
        self.active = True

    def run(self):
        while self.pose is None and not rospy.is_shutdown():
            rospy.sleep(0.1)          # tunggu pose turtle1
        rospy.sleep(1.0)              # beri waktu controller subscribe
        self.spawn_target()
        self.active = True
        rospy.spin()


if __name__ == '__main__':
    rospy.init_node('hunter_manager')
    HunterManager().run()
