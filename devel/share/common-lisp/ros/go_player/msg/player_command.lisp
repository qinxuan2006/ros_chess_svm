; Auto-generated. Do not edit!


(cl:in-package go_player-msg)


;//! \htmlinclude player_command.msg.html

(cl:defclass <player_command> (roslisp-msg-protocol:ros-message)
  ((state
    :reader state
    :initarg :state
    :type cl:string
    :initform "")
   (kind
    :reader kind
    :initarg :kind
    :type cl:string
    :initform "")
   (level
    :reader level
    :initarg :level
    :type cl:string
    :initform ""))
)

(cl:defclass player_command (<player_command>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <player_command>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'player_command)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name go_player-msg:<player_command> is deprecated: use go_player-msg:player_command instead.")))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <player_command>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader go_player-msg:state-val is deprecated.  Use go_player-msg:state instead.")
  (state m))

(cl:ensure-generic-function 'kind-val :lambda-list '(m))
(cl:defmethod kind-val ((m <player_command>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader go_player-msg:kind-val is deprecated.  Use go_player-msg:kind instead.")
  (kind m))

(cl:ensure-generic-function 'level-val :lambda-list '(m))
(cl:defmethod level-val ((m <player_command>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader go_player-msg:level-val is deprecated.  Use go_player-msg:level instead.")
  (level m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <player_command>) ostream)
  "Serializes a message object of type '<player_command>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'state))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'state))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'kind))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'kind))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'level))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'level))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <player_command>) istream)
  "Deserializes a message object of type '<player_command>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'state) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'state) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'kind) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'kind) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'level) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'level) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<player_command>)))
  "Returns string type for a message object of type '<player_command>"
  "go_player/player_command")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'player_command)))
  "Returns string type for a message object of type 'player_command"
  "go_player/player_command")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<player_command>)))
  "Returns md5sum for a message object of type '<player_command>"
  "a3c58b4f1576da4268c38a742885e2c3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'player_command)))
  "Returns md5sum for a message object of type 'player_command"
  "a3c58b4f1576da4268c38a742885e2c3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<player_command>)))
  "Returns full string definition for message of type '<player_command>"
  (cl:format cl:nil "string state~%string kind~%string level~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'player_command)))
  "Returns full string definition for message of type 'player_command"
  (cl:format cl:nil "string state~%string kind~%string level~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <player_command>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'state))
     4 (cl:length (cl:slot-value msg 'kind))
     4 (cl:length (cl:slot-value msg 'level))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <player_command>))
  "Converts a ROS message object to a list"
  (cl:list 'player_command
    (cl:cons ':state (state msg))
    (cl:cons ':kind (kind msg))
    (cl:cons ':level (level msg))
))
