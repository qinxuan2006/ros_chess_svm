;; Auto-generated. Do not edit!


(when (boundp 'go_player::player_command)
  (if (not (find-package "GO_PLAYER"))
    (make-package "GO_PLAYER"))
  (shadow 'player_command (find-package "GO_PLAYER")))
(unless (find-package "GO_PLAYER::PLAYER_COMMAND")
  (make-package "GO_PLAYER::PLAYER_COMMAND"))

(in-package "ROS")
;;//! \htmlinclude player_command.msg.html


(defclass go_player::player_command
  :super ros::object
  :slots (_state _kind _level ))

(defmethod go_player::player_command
  (:init
   (&key
    ((:state __state) "")
    ((:kind __kind) "")
    ((:level __level) "")
    )
   (send-super :init)
   (setq _state (string __state))
   (setq _kind (string __kind))
   (setq _level (string __level))
   self)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:kind
   (&optional __kind)
   (if __kind (setq _kind __kind)) _kind)
  (:level
   (&optional __level)
   (if __level (setq _level __level)) _level)
  (:serialization-length
   ()
   (+
    ;; string _state
    4 (length _state)
    ;; string _kind
    4 (length _kind)
    ;; string _level
    4 (length _level)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _state
       (write-long (length _state) s) (princ _state s)
     ;; string _kind
       (write-long (length _kind) s) (princ _kind s)
     ;; string _level
       (write-long (length _level) s) (princ _level s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _state
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _state (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _kind
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _kind (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _level
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _level (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get go_player::player_command :md5sum-) "a3c58b4f1576da4268c38a742885e2c3")
(setf (get go_player::player_command :datatype-) "go_player/player_command")
(setf (get go_player::player_command :definition-)
      "string state
string kind
string level

")



(provide :go_player/player_command "a3c58b4f1576da4268c38a742885e2c3")


