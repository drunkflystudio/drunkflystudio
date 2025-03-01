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

macro(fly_module name)
    set(options)
    set(one)
    set(multi SOURCES USES)
    cmake_parse_arguments(fm "${options}" "${one}" "${multi}" ${ARGN})

    set(compiled_c "${CMAKE_CURRENT_BINARY_DIR}/${name}.c")
    set(compiled_bun "${CMAKE_CURRENT_BINARY_DIR}/${name}.bun")
    source_group("Source Files" FILES ${fm_SOURCES})
    source_group("Generated Files" FILES "${compiled_c}" "${compiled_bun}")
    set(src_c)
    set(src_fly)
    foreach(file ${fm_SOURCES})
        get_filename_component(path "${file}" ABSOLUTE)
        get_filename_component(ext "${file}" EXT)
        if("${ext}" STREQUAL ".c" OR "${ext}" STREQUAL ".h")
            list(APPEND src_c "${path}")
        elseif("${ext}" STREQUAL ".fly")
            list(APPEND src_fly "${path}")
        else()
            message(FATAL_ERROR "fly_module: unsupported file extension '${ext}'.")
        endif()
    endforeach()

    set(src_bun)
    foreach(bundle ${fm_USES})
        get_target_property(bundle_binary_dir "${bundle}" BINARY_DIR)
        list(APPEND src_bun "${bundle_binary_dir}/${bundle}.bun")
    endforeach()

    add_custom_command(OUTPUT "${compiled_c}" "${compiled_bun}"
        COMMAND "${HOST_FLYCC}" -bootstrap -bundle "${name}" -o "${compiled_c}" ${src_fly} ${src_bun}
        DEPENDS ${src_fly} ${src_bun} FlyCompiler
        )

    add_library("${name}" STATIC
        "${compiled_c}"
        "${compiled_bun}"
        ${src_c}
        ${src_fly}
        )

    target_link_libraries("${name}" PUBLIC FlyCommon)
    foreach(bundle ${fm_USES})
        target_link_libraries("${name}" PUBLIC "${bundle}")
    endforeach()
endmacro()

######################################################################################################################
