# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "tutor: 1 messages, 0 services")

set(MSG_I_FLAGS "-Itutor:/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(tutor_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg/Operation.msg" NAME_WE)
add_custom_target(_tutor_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "tutor" "/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg/Operation.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(tutor
  "/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg/Operation.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tutor
)

### Generating Services

### Generating Module File
_generate_module_cpp(tutor
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tutor
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(tutor_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(tutor_generate_messages tutor_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg/Operation.msg" NAME_WE)
add_dependencies(tutor_generate_messages_cpp _tutor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tutor_gencpp)
add_dependencies(tutor_gencpp tutor_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tutor_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(tutor
  "/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg/Operation.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tutor
)

### Generating Services

### Generating Module File
_generate_module_eus(tutor
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tutor
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(tutor_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(tutor_generate_messages tutor_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg/Operation.msg" NAME_WE)
add_dependencies(tutor_generate_messages_eus _tutor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tutor_geneus)
add_dependencies(tutor_geneus tutor_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tutor_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(tutor
  "/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg/Operation.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tutor
)

### Generating Services

### Generating Module File
_generate_module_lisp(tutor
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tutor
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(tutor_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(tutor_generate_messages tutor_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg/Operation.msg" NAME_WE)
add_dependencies(tutor_generate_messages_lisp _tutor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tutor_genlisp)
add_dependencies(tutor_genlisp tutor_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tutor_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(tutor
  "/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg/Operation.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tutor
)

### Generating Services

### Generating Module File
_generate_module_nodejs(tutor
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tutor
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(tutor_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(tutor_generate_messages tutor_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg/Operation.msg" NAME_WE)
add_dependencies(tutor_generate_messages_nodejs _tutor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tutor_gennodejs)
add_dependencies(tutor_gennodejs tutor_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tutor_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(tutor
  "/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg/Operation.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tutor
)

### Generating Services

### Generating Module File
_generate_module_py(tutor
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tutor
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(tutor_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(tutor_generate_messages tutor_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/zahran/D/proj/prog/kuliah/SRO/learn_ros/src/tutor/msg/Operation.msg" NAME_WE)
add_dependencies(tutor_generate_messages_py _tutor_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(tutor_genpy)
add_dependencies(tutor_genpy tutor_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS tutor_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tutor)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/tutor
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(tutor_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tutor)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/tutor
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(tutor_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tutor)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/tutor
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(tutor_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tutor)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/tutor
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(tutor_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tutor)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tutor\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/tutor
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(tutor_generate_messages_py std_msgs_generate_messages_py)
endif()
