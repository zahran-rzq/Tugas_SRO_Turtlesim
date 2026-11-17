; Auto-generated. Do not edit!


(cl:in-package tutor-msg)


;//! \htmlinclude Operation.msg.html

(cl:defclass <Operation> (roslisp-msg-protocol:ros-message)
  ((a
    :reader a
    :initarg :a
    :type cl:float
    :initform 0.0)
   (b
    :reader b
    :initarg :b
    :type cl:float
    :initform 0.0)
   (op
    :reader op
    :initarg :op
    :type cl:string
    :initform ""))
)

(cl:defclass Operation (<Operation>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Operation>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Operation)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tutor-msg:<Operation> is deprecated: use tutor-msg:Operation instead.")))

(cl:ensure-generic-function 'a-val :lambda-list '(m))
(cl:defmethod a-val ((m <Operation>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tutor-msg:a-val is deprecated.  Use tutor-msg:a instead.")
  (a m))

(cl:ensure-generic-function 'b-val :lambda-list '(m))
(cl:defmethod b-val ((m <Operation>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tutor-msg:b-val is deprecated.  Use tutor-msg:b instead.")
  (b m))

(cl:ensure-generic-function 'op-val :lambda-list '(m))
(cl:defmethod op-val ((m <Operation>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tutor-msg:op-val is deprecated.  Use tutor-msg:op instead.")
  (op m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Operation>) ostream)
  "Serializes a message object of type '<Operation>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'a))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'b))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'op))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'op))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Operation>) istream)
  "Deserializes a message object of type '<Operation>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'a) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'b) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'op) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'op) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Operation>)))
  "Returns string type for a message object of type '<Operation>"
  "tutor/Operation")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Operation)))
  "Returns string type for a message object of type 'Operation"
  "tutor/Operation")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Operation>)))
  "Returns md5sum for a message object of type '<Operation>"
  "c39f692aae57e32e2fe4bae7149f5c06")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Operation)))
  "Returns md5sum for a message object of type 'Operation"
  "c39f692aae57e32e2fe4bae7149f5c06")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Operation>)))
  "Returns full string definition for message of type '<Operation>"
  (cl:format cl:nil "float64 a~%float64 b~%string op~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Operation)))
  "Returns full string definition for message of type 'Operation"
  (cl:format cl:nil "float64 a~%float64 b~%string op~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Operation>))
  (cl:+ 0
     8
     8
     4 (cl:length (cl:slot-value msg 'op))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Operation>))
  "Converts a ROS message object to a list"
  (cl:list 'Operation
    (cl:cons ':a (a msg))
    (cl:cons ':b (b msg))
    (cl:cons ':op (op msg))
))
