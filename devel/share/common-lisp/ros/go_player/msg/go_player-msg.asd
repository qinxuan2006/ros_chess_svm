
(cl:in-package :asdf)

(defsystem "go_player-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "player_command" :depends-on ("_package_player_command"))
    (:file "_package_player_command" :depends-on ("_package"))
  ))