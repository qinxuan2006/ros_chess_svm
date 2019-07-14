;; Auto-generated. Do not edit!


(when (boundp 'go_player::Player_order)
  (if (not (find-package "GO_PLAYER"))
    (make-package "GO_PLAYER"))
  (shadow 'Player_order (find-package "GO_PLAYER")))
(unless (find-package "GO_PLAYER::PLAYER_ORDER")
  (make-package "GO_PLAYER::PLAYER_ORDER"))
(unless (find-package "GO_PLAYER::PLAYER_ORDERREQUEST")
  (make-package "GO_PLAYER::PLAYER_ORDERREQUEST"))
(unless (find-package "GO_PLAYER::PLAYER_ORDERRESPONSE")
  (make-package "GO_PLAYER::PLAYER_ORDERRESPONSE"))

(in-package "ROS")





(defclass go_player::Player_orderRequest
  :super ros::object
  :slots (_state _kind _level ))

(defmethod go_player::Player_orderRequest
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

(defclass go_player::Player_orderResponse
  :super ros::object
  :slots (_success _do_step _remove_step _win_side ))

(defmethod go_player::Player_orderResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:do_step __do_step) (make-array 0 :initial-element 0 :element-type :integer))
    ((:remove_step __remove_step) (make-array 0 :initial-element 0 :element-type :integer))
    ((:win_side __win_side) "")
    )
   (send-super :init)
   (setq _success __success)
   (setq _do_step __do_step)
   (setq _remove_step __remove_step)
   (setq _win_side (string __win_side))
   self)
  (:success
   (&optional __success)
   (if __success (setq _success __success)) _success)
  (:do_step
   (&optional __do_step)
   (if __do_step (setq _do_step __do_step)) _do_step)
  (:remove_step
   (&optional __remove_step)
   (if __remove_step (setq _remove_step __remove_step)) _remove_step)
  (:win_side
   (&optional __win_side)
   (if __win_side (setq _win_side __win_side)) _win_side)
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; int8[] _do_step
    (* 1    (length _do_step)) 4
    ;; int8[] _remove_step
    (* 1    (length _remove_step)) 4
    ;; string _win_side
    4 (length _win_side)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; int8[] _do_step
     (write-long (length _do_step) s)
     (dotimes (i (length _do_step))
       (write-byte (elt _do_step i) s)
       )
     ;; int8[] _remove_step
     (write-long (length _remove_step) s)
     (dotimes (i (length _remove_step))
       (write-byte (elt _remove_step i) s)
       )
     ;; string _win_side
       (write-long (length _win_side) s) (princ _win_side s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int8[] _do_step
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _do_step (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _do_step i) (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> (elt _do_step i) 127) (setf (elt _do_step i) (- (elt _do_step i) 256)))
     ))
   ;; int8[] _remove_step
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _remove_step (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _remove_step i) (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> (elt _remove_step i) 127) (setf (elt _remove_step i) (- (elt _remove_step i) 256)))
     ))
   ;; string _win_side
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _win_side (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass go_player::Player_order
  :super ros::object
  :slots ())

(setf (get go_player::Player_order :md5sum-) "8b5ce4bcaa3e0d90fdecb196f6925e60")
(setf (get go_player::Player_order :datatype-) "go_player/Player_order")
(setf (get go_player::Player_order :request) go_player::Player_orderRequest)
(setf (get go_player::Player_order :response) go_player::Player_orderResponse)

(defmethod go_player::Player_orderRequest
  (:response () (instance go_player::Player_orderResponse :init)))

(setf (get go_player::Player_orderRequest :md5sum-) "8b5ce4bcaa3e0d90fdecb196f6925e60")
(setf (get go_player::Player_orderRequest :datatype-) "go_player/Player_orderRequest")
(setf (get go_player::Player_orderRequest :definition-)
      "
string state
string kind
string level
---

bool success
int8[] do_step
int8[] remove_step
string win_side

")

(setf (get go_player::Player_orderResponse :md5sum-) "8b5ce4bcaa3e0d90fdecb196f6925e60")
(setf (get go_player::Player_orderResponse :datatype-) "go_player/Player_orderResponse")
(setf (get go_player::Player_orderResponse :definition-)
      "
string state
string kind
string level
---

bool success
int8[] do_step
int8[] remove_step
string win_side

")



(provide :go_player/Player_order "8b5ce4bcaa3e0d90fdecb196f6925e60")


