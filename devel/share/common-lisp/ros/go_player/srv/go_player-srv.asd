
(cl:in-package :asdf)

(defsystem "go_player-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Player_order" :depends-on ("_package_Player_order"))
    (:file "_package_Player_order" :depends-on ("_package"))
  ))