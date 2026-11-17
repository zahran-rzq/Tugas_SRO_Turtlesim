#!/usr/bin/env python3
"""Node 2: pengelola misi. Menyimpan daftar waypoint (dari YAML),
menyediakan service /start_mission, dan mengirim target aktif lewat /current_target."""
import rospy
from turtle_patrol.msg import Waypoint, MissionStatus
from turtle_patrol.srv import StartMission, StartMissionResponse


class MissionManager:
    def __init__(self):
        self.waypoints = rospy.get_param('~waypoints')   # dari config/waypoints.yaml
        self.idx = 0
        self.active = False
        self.loop = False
        self.pub = rospy.Publisher('/current_target', Waypoint, queue_size=1, latch=True)
        rospy.Subscriber('/mission_status', MissionStatus, self.status_cb)
        rospy.Service('/start_mission', StartMission, self.start_cb)
        rospy.loginfo('Siap. %d waypoint dimuat. Panggil /start_mission.', len(self.waypoints))

    def send_target(self):
        x, y = self.waypoints[self.idx]
        self.pub.publish(Waypoint(x=x, y=y, index=self.idx, total=len(self.waypoints)))

    def start_cb(self, req):
        if self.active or not self.waypoints:
            return StartMissionResponse(accepted=False)
        self.idx, self.loop, self.active = 0, req.loop, True
        rospy.loginfo('Misi dimulai (loop=%s)', self.loop)
        self.send_target()
        return StartMissionResponse(accepted=True)

    def status_cb(self, st):
        # abaikan status basi: hanya proses kalau untuk target yang sedang aktif
        if not self.active or st.index != self.idx or not st.reached:
            return
        rospy.loginfo('Waypoint %d/%d tercapai', self.idx + 1, len(self.waypoints))
        if self.idx + 1 < len(self.waypoints):
            self.idx += 1
            self.send_target()
        elif self.loop:
            self.idx = 0
            self.send_target()
        else:
            self.active = False
            rospy.loginfo('Misi selesai. Turtle berhenti.')


if __name__ == '__main__':
    rospy.init_node('mission_manager')
    m = MissionManager()
    if rospy.get_param('~auto_start', False):
        rospy.sleep(1.0)  # beri waktu controller subscribe
        m.start_cb(type('Req', (), {'loop': False})())
    rospy.spin()
