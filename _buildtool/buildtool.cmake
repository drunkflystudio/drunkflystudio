
if(POLICY CMP0011)
    cmake_policy(SET CMP0011 NEW)
endif()
if(POLICY CMP0054)
    cmake_policy(SET CMP0054 NEW)
endif()

######################################################################################################################

if(VERBOSE)
    set(CMAKE_EXECUTE_PROCESS_COMMAND_ECHO STDOUT)
endif()

######################################################################################################################

get_filename_component(BUILDTOOL_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(PROJECT_DIR "${BUILDTOOL_DIR}" PATH)

set(BUILD_DIR "${PROJECT_DIR}/_build")
set(CMAKE_DIR "${PROJECT_DIR}/_cmake")
set(TOOLS_DIR "${PROJECT_DIR}/_tools")

######################################################################################################################

if(WIN32)
    execute_process(COMMAND "${TOOLS_DIR}/winver/winver.exe" OUTPUT_VARIABLE winver)
    list(GET winver 0 WINDOWS_VERSION_MAJOR)
    list(GET winver 1 WINDOWS_VERSION_MINOR)
endif()

######################################################################################################################

include(CMakeParseArguments)

include("${BUILDTOOL_DIR}/macros.cmake")
include("${BUILDTOOL_DIR}/dependencies.cmake")

######################################################################################################################

file(STRINGS "${PROJECT_DIR}/.gitmodules" lines)
foreach(line ${lines})
    if(line MATCHES "path = ")
        string(REGEX REPLACE "[ \t]*path[ \t]*=[ \t]*" "" path "${line}")
        if(NOT EXISTS "${PROJECT_DIR}/${path}/CMakeLists.txt")
            do(git submodule update --init --recursive
                WORKING_DIRECTORY "${PROJECT_DIR}")
        endif()
    endif()
endforeach()

######################################################################################################################

set(buildtool_host_tools)

include("${CMAKE_DIR}/projects.cmake")
foreach(dep ${deps})
    get_filename_component(CURRENT_PROJECT_DIR "${dep}" PATH)
    get_filename_component(CURRENT_PROJECT_DIR "${CURRENT_PROJECT_DIR}" PATH)
    if(WIN32 AND (LINUX64 OR HTML5))
        set(CROSSCOMPILING TRUE)
    else()
        set(CROSSCOMPILING FALSE)
    endif()
    include("${dep}")
endforeach()

######################################################################################################################

include("${BUILDTOOL_DIR}/targets.cmake")
