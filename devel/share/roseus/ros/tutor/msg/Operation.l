;; Auto-generated. Do not edit!


(when (boundp 'tutor::Operation)
  (if (not (find-package "TUTOR"))
    (make-package "TUTOR"))
  (shadow 'Operation (find-package "TUTOR")))
(unless (find-package "TUTOR::OPERATION")
  (make-package "TUTOR::OPERATION"))

(in-package "ROS")
;;//! \htmlinclude Operation.msg.html


(defclass tutor::Operation
  :super ros::object
  :slots (_a _b _op ))

(defmethod tutor::Operation
  (:init
   (&key
    ((:a __a) 0.0)
    ((:b __b) 0.0)
    ((:op __op) "")
    )
   (send-super :init)
   (setq _a (float __a))
   (setq _b (float __b))
   (setq _op (string __op))
   self)
  (:a
   (&optional __a)
   (if __a (setq _a __a)) _a)
  (:b
   (&optional __b)
   (if __b (setq _b __b)) _b)
  (:op
   (&optional __op)
   (if __op (setq _op __op)) _op)
  (:serialization-length
   ()
   (+
    ;; float64 _a
    8
    ;; float64 _b
    8
    ;; string _op
    4 (length _op)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _a
       (sys::poke _a (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _b
       (sys::poke _b (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _op
       (write-long (length _op) s) (princ _op s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _a
     (setq _a (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _b
     (setq _b (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _op
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _op (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get tutor::Operation :md5sum-) "c39f692aae57e32e2fe4bae7149f5c06")
(setf (get tutor::Operation :datatype-) "tutor/Operation")
(setf (get tutor::Operation :definition-)
      "float64 a
float64 b
string op
")



(provide :tutor/Operation "c39f692aae57e32e2fe4bae7149f5c06")


