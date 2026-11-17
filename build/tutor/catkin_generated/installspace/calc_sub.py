#!/usr/bin/env python3
import rospy
from tutor.msg import Operation

def callback(msg):
    if msg.op == '+':
        result = msg.a + msg.b
    elif msg.op == '-':
        result = msg.a - msg.b
    elif msg.op == '*':
        result = msg.a * msg.b
    elif msg.op == '/':
        if msg.b == 0:
            rospy.logwarn('Division by zero!')
            return
        result = msg.a / msg.b
    else:
        rospy.logwarn('Unknown operator: %s', msg.op)
        return
    rospy.loginfo('Result: %.2f %s %.2f = %.2f', msg.a, msg.op, msg.b, result)

def subscriber():
    rospy.init_node('subscriber')
    rospy.Subscriber('calc_topic', Operation, callback)
    rospy.spin()

if __name__ == '__main__':
    subscriber()