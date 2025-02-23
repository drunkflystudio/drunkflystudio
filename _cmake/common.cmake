if(DRUNKFLY_COMMON_CMAKE_INCLUDED)
    return()
else()
    set(DRUNKFLY_COMMON_CMAKE_INCLUDED TRUE)
endif()

######################################################################################################################

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set_property(GLOBAL PROPERTY PREDEFINED_TARGETS_FOLDER "CMake")

######################################################################################################################

get_filename_component(CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" DIRECTORY)
get_filename_component(PROJECT_DIR "${CMAKE_DIR}" DIRECTORY)

get_filename_component(BINARY_DIR "${CMAKE_BINARY_DIR}" DIRECTORY)

######################################################################################################################

include("${CMAKE_DIR}/flags.cmake")
include("${CMAKE_DIR}/tests.cmake")

######################################################################################################################

if(MSVC)
    include("${CMAKE_DIR}/compiler/msvc.cmake")
elseif(BORLAND)
    include("${CMAKE_DIR}/compiler/borland.cmake")
elseif(WATCOM)
    include("${CMAKE_DIR}/compiler/watcom.cmake")
elseif(EMSCRIPTEN)
    include("${CMAKE_DIR}/compiler/emscripten.cmake")
else()
    include("${CMAKE_DIR}/compiler/gnu.cmake")
endif()

######################################################################################################################

macro(maybe_write_file file contents)
    set(do_write TRUE)
    if(EXISTS "${file}")
        file(READ "${file}" old)
        if("${old}" STREQUAL "${contents}")
            set(do_write FALSE)
        endif()
    endif()
    if(do_write)
        file(WRITE "${file}" "${contents}")
    endif()
endmacro()

######################################################################################################################

macro(compile_fly)
    set(compiled_c "${CMAKE_CURRENT_BINARY_DIR}/compiled.c")
    source_group("Source Files" FILES ${ARGN})
    source_group("Generated Files" FILES "${compiled_c}")
    set(args)
    foreach(file ${ARGN})
        get_filename_component(path "${file}" ABSOLUTE)
        list(APPEND args "${path}")
    endforeach()
    list(APPEND src ${args} "${compiled_c}")
    add_custom_command(OUTPUT "${compiled_c}"
        COMMAND "${HOST_FLYCC}" -bootstrap -o "${compiled_c}" ${args}
        DEPENDS ${ARGN} FlyCompiler
        )
endmacro()

######################################################################################################################
