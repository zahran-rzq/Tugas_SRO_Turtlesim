
(cl:in-package :asdf)

(defsystem "tutor-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Operation" :depends-on ("_package_Operation"))
    (:file "_package_Operation" :depends-on ("_package"))
  ))