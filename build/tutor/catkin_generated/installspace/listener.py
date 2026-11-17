#!/usr/bin/env python3
import rospy
from std_msgs.msg import String

def chatter_callback(msg):
    rospy.loginfo('I heard: [%s]', msg.data)

def chatterpy_callback(msg):
    rospy.loginfo('Py said: [%s]', msg.data)

def listener():
    rospy.init_node('listener')
    rospy.Subscriber('chatter', String, chatter_callback)      # n.subscribe
    rospy.Subscriber('chatter_py', String, chatterpy_callback)
    rospy.spin()                                               # ros::spin

if __name__ == '__main__':
    listener()