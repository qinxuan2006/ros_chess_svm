; Auto-generated. Do not edit!


(cl:in-package go_player-srv)


;//! \htmlinclude Player_order-request.msg.html

(cl:defclass <Player_order-request> (roslisp-msg-protocol:ros-message)
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

(cl:defclass Player_order-request (<Player_order-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Player_order-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Player_order-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name go_player-srv:<Player_order-request> is deprecated: use go_player-srv:Player_order-request instead.")))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <Player_order-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader go_player-srv:state-val is deprecated.  Use go_player-srv:state instead.")
  (state m))

(cl:ensure-generic-function 'kind-val :lambda-list '(m))
(cl:defmethod kind-val ((m <Player_order-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader go_player-srv:kind-val is deprecated.  Use go_player-srv:kind instead.")
  (kind m))

(cl:ensure-generic-function 'level-val :lambda-list '(m))
(cl:defmethod level-val ((m <Player_order-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader go_player-srv:level-val is deprecated.  Use go_player-srv:level instead.")
  (level m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Player_order-request>) ostream)
  "Serializes a message object of type '<Player_order-request>"
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
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Player_order-request>) istream)
  "Deserializes a message object of type '<Player_order-request>"
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
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Player_order-request>)))
  "Returns string type for a service object of type '<Player_order-request>"
  "go_player/Player_orderRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Player_order-request)))
  "Returns string type for a service object of type 'Player_order-request"
  "go_player/Player_orderRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Player_order-request>)))
  "Returns md5sum for a message object of type '<Player_order-request>"
  "1e0b8396f26d47b0b616e36d5b4d6a67")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Player_order-request)))
  "Returns md5sum for a message object of type 'Player_order-request"
  "1e0b8396f26d47b0b616e36d5b4d6a67")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Player_order-request>)))
  "Returns full string definition for message of type '<Player_order-request>"
  (cl:format cl:nil "~%string state~%string kind~%string level~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Player_order-request)))
  "Returns full string definition for message of type 'Player_order-request"
  (cl:format cl:nil "~%string state~%string kind~%string level~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Player_order-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'state))
     4 (cl:length (cl:slot-value msg 'kind))
     4 (cl:length (cl:slot-value msg 'level))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Player_order-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Player_order-request
    (cl:cons ':state (state msg))
    (cl:cons ':kind (kind msg))
    (cl:cons ':level (level msg))
))
;//! \htmlinclude Player_order-response.msg.html

(cl:defclass <Player_order-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (step
    :reader step
    :initarg :step
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass Player_order-response (<Player_order-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Player_order-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Player_order-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name go_player-srv:<Player_order-response> is deprecated: use go_player-srv:Player_order-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <Player_order-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader go_player-srv:success-val is deprecated.  Use go_player-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'step-val :lambda-list '(m))
(cl:defmethod step-val ((m <Player_order-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader go_player-srv:step-val is deprecated.  Use go_player-srv:step instead.")
  (step m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Player_order-response>) ostream)
  "Serializes a message object of type '<Player_order-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'step))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    ))
   (cl:slot-value msg 'step))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Player_order-response>) istream)
  "Deserializes a message object of type '<Player_order-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'step) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'step)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Player_order-response>)))
  "Returns string type for a service object of type '<Player_order-response>"
  "go_player/Player_orderResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Player_order-response)))
  "Returns string type for a service object of type 'Player_order-response"
  "go_player/Player_orderResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Player_order-response>)))
  "Returns md5sum for a message object of type '<Player_order-response>"
  "1e0b8396f26d47b0b616e36d5b4d6a67")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Player_order-response)))
  "Returns md5sum for a message object of type 'Player_order-response"
  "1e0b8396f26d47b0b616e36d5b4d6a67")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Player_order-response>)))
  "Returns full string definition for message of type '<Player_order-response>"
  (cl:format cl:nil "~%bool success~%int8[] step~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Player_order-response)))
  "Returns full string definition for message of type 'Player_order-response"
  (cl:format cl:nil "~%bool success~%int8[] step~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Player_order-response>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'step) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Player_order-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Player_order-response
    (cl:cons ':success (success msg))
    (cl:cons ':step (step msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Player_order)))
  'Player_order-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Player_order)))
  'Player_order-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Player_order)))
  "Returns string type for a service object of type '<Player_order>"
  "go_player/Player_order")