
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

set(lua_interpreter_required FALSE)
macro(lua_interpreter_required)
    set(lua_interpreter_required TRUE)
endmacro()

set(lua_compiler_required FALSE)
macro(lua_compiler_required)
    set(lua_compiler_required TRUE)
endmacro()

set(fly_compiler_required FALSE)
macro(require_fly_compiler)
    set(fly_compiler_required TRUE)
endmacro()

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

if(lua_interpreter_required OR lua_compiler_required OR fly_compiler_required)
    set(targets)
    set(executables)
    if(lua_interpreter_required)
        set(targets ${targets} LuaInterpreter)
        set(executables ${executables} lua)
    endif()
    if(lua_compiler_required)
        set(targets ${targets} LuaCompiler)
        set(executables ${executables} luac)
    endif()
    if(fly_compiler_required)
        set(targets ${targets} FlyCompiler)
        set(executables ${executables} flycc)
    endif()
    build_host_tool(compiler
        DIRECTORY "${PROJECT_DIR}"
        TARGETS ${targets}
        EXECUTABLES ${executables}
        ONLY_WHEN_CROSSCOMPILING
        )
endif()

######################################################################################################################

include("${BUILDTOOL_DIR}/targets.cmake")
