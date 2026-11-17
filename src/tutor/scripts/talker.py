#!/usr/bin/env python3
import rospy
from std_msgs.msg import String

def talker():
    rospy.init_node('talker')                                  # ros::init
    pub = rospy.Publisher('chatter', String, queue_size=1000)  # n.advertise
    rate = rospy.Rate(10)                                      # ros::Rate loop_rate(10)
    count = 0
    while not rospy.is_shutdown():                             # while (ros::ok())
        msg = String()
        msg.data = 'hello world %d' % count                    # std::stringstream
        rospy.loginfo(msg.data)                                # ROS_INFO
        pub.publish(msg)
        rate.sleep()
        count += 1

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass