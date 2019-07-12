# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "go_player: 1 messages, 1 services")

set(MSG_I_FLAGS "-Igo_player:/home/mrobot/ros_chess_svm/src/go_player/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(go_player_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/mrobot/ros_chess_svm/src/go_player/srv/Player_order.srv" NAME_WE)
add_custom_target(_go_player_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "go_player" "/home/mrobot/ros_chess_svm/src/go_player/srv/Player_order.srv" ""
)

get_filename_component(_filename "/home/mrobot/ros_chess_svm/src/go_player/msg/player_command.msg" NAME_WE)
add_custom_target(_go_player_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "go_player" "/home/mrobot/ros_chess_svm/src/go_player/msg/player_command.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(go_player
  "/home/mrobot/ros_chess_svm/src/go_player/msg/player_command.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/go_player
)

### Generating Services
_generate_srv_cpp(go_player
  "/home/mrobot/ros_chess_svm/src/go_player/srv/Player_order.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/go_player
)

### Generating Module File
_generate_module_cpp(go_player
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/go_player
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(go_player_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(go_player_generate_messages go_player_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/mrobot/ros_chess_svm/src/go_player/srv/Player_order.srv" NAME_WE)
add_dependencies(go_player_generate_messages_cpp _go_player_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/mrobot/ros_chess_svm/src/go_player/msg/player_command.msg" NAME_WE)
add_dependencies(go_player_generate_messages_cpp _go_player_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(go_player_gencpp)
add_dependencies(go_player_gencpp go_player_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS go_player_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(go_player
  "/home/mrobot/ros_chess_svm/src/go_player/msg/player_command.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/go_player
)

### Generating Services
_generate_srv_eus(go_player
  "/home/mrobot/ros_chess_svm/src/go_player/srv/Player_order.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/go_player
)

### Generating Module File
_generate_module_eus(go_player
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/go_player
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(go_player_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(go_player_generate_messages go_player_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/mrobot/ros_chess_svm/src/go_player/srv/Player_order.srv" NAME_WE)
add_dependencies(go_player_generate_messages_eus _go_player_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/mrobot/ros_chess_svm/src/go_player/msg/player_command.msg" NAME_WE)
add_dependencies(go_player_generate_messages_eus _go_player_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(go_player_geneus)
add_dependencies(go_player_geneus go_player_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS go_player_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(go_player
  "/home/mrobot/ros_chess_svm/src/go_player/msg/player_command.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/go_player
)

### Generating Services
_generate_srv_lisp(go_player
  "/home/mrobot/ros_chess_svm/src/go_player/srv/Player_order.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/go_player
)

### Generating Module File
_generate_module_lisp(go_player
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/go_player
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(go_player_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(go_player_generate_messages go_player_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/mrobot/ros_chess_svm/src/go_player/srv/Player_order.srv" NAME_WE)
add_dependencies(go_player_generate_messages_lisp _go_player_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/mrobot/ros_chess_svm/src/go_player/msg/player_command.msg" NAME_WE)
add_dependencies(go_player_generate_messages_lisp _go_player_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(go_player_genlisp)
add_dependencies(go_player_genlisp go_player_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS go_player_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(go_player
  "/home/mrobot/ros_chess_svm/src/go_player/msg/player_command.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/go_player
)

### Generating Services
_generate_srv_nodejs(go_player
  "/home/mrobot/ros_chess_svm/src/go_player/srv/Player_order.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/go_player
)

### Generating Module File
_generate_module_nodejs(go_player
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/go_player
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(go_player_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(go_player_generate_messages go_player_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/mrobot/ros_chess_svm/src/go_player/srv/Player_order.srv" NAME_WE)
add_dependencies(go_player_generate_messages_nodejs _go_player_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/mrobot/ros_chess_svm/src/go_player/msg/player_command.msg" NAME_WE)
add_dependencies(go_player_generate_messages_nodejs _go_player_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(go_player_gennodejs)
add_dependencies(go_player_gennodejs go_player_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS go_player_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(go_player
  "/home/mrobot/ros_chess_svm/src/go_player/msg/player_command.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/go_player
)

### Generating Services
_generate_srv_py(go_player
  "/home/mrobot/ros_chess_svm/src/go_player/srv/Player_order.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/go_player
)

### Generating Module File
_generate_module_py(go_player
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/go_player
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(go_player_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(go_player_generate_messages go_player_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/mrobot/ros_chess_svm/src/go_player/srv/Player_order.srv" NAME_WE)
add_dependencies(go_player_generate_messages_py _go_player_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/mrobot/ros_chess_svm/src/go_player/msg/player_command.msg" NAME_WE)
add_dependencies(go_player_generate_messages_py _go_player_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(go_player_genpy)
add_dependencies(go_player_genpy go_player_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS go_player_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/go_player)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/go_player
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(go_player_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/go_player)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/go_player
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(go_player_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/go_player)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/go_player
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(go_player_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/go_player)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/go_player
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(go_player_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/go_player)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/go_player\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/go_player
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(go_player_generate_messages_py std_msgs_generate_messages_py)
endif()
