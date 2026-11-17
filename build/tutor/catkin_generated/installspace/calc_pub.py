#!/usr/bin/env python3
import rospy
from tutor.msg import Operation          # #include "calculator/Operation.h"

def publisher():
    rospy.init_node('publisher')
    pub = rospy.Publisher('calc_topic', Operation, queue_size=10)
    while not rospy.is_shutdown():
        msg = Operation()
        msg.a = float(input('Enter number A: '))
        msg.b = float(input('Enter number B: '))
        msg.op = input('Enter operator (+, -, *, /): ')
        rospy.loginfo('Publishing: %.2f %s %.2f', msg.a, msg.op, msg.b)
        pub.publish(msg)

if __name__ == '__main__':
    try:
        publisher()
    except (rospy.ROSInterruptException, EOFError, KeyboardInterrupt):
        pass