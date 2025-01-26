
######################################################################################################################

macro(do)
    set(status_code -1)
    execute_process(
        COMMAND ${ARGN}
        RESULT_VARIABLE status_code
        )
    if(NOT status_code EQUAL 0)
        message(FATAL_ERROR "\n======> Command failed with exit code ${status_code}! <======\n\n")
    endif()
endmacro()

######################################################################################################################

macro(external_git_repo dir repo)
    if(NOT EXISTS "${dir}/.git")
        do(git clone "${repo}" "${dir}")
    endif()
endmacro()

######################################################################################################################

macro(require_win32_host what)
    if(NOT WIN32)
        message(FATAL_ERROR "${what} requires Win32 host.")
    endif()
endmacro()

######################################################################################################################

macro(add_PATH path)
    if(WIN32)
        set(ENV{PATH} "${path};$ENV{PATH}")
    else()
        set(ENV{PATH} "${path}:$ENV{PATH}")
    endif()
endmacro()

######################################################################################################################

macro(get_build_types var in)
    set(t_debug FALSE)
    set(t_release FALSE)
    set(t_relwithdebinfo FALSE)
    set(t_minsizerel FALSE)
    foreach(type ${in})
        if("${type}" STREQUAL "debug" OR "${type}" STREQUAL "Debug")
            set(t_debug TRUE)
        elseif("${type}" STREQUAL "release" OR "${type}" STREQUAL "Release")
            set(t_release TRUE)
        elseif("${type}" STREQUAL "relwithdebinfo" OR "${type}" STREQUAL "RelWithDebInfo")
            set(t_relwithdebinfo TRUE)
        elseif("${type}" STREQUAL "minsizerel" OR "${type}" STREQUAL "MinSizeRel")
            set(t_minsizerel TRUE)
        else()
            message(FATAL_ERROR "Invalid build type \"${type}\".")
        endif()
    endforeach()
    if(NOT t_debug AND NOT t_release AND NOT t_relwithdebinfo AND NOT t_minsizerel)
        set(out "Release")
    else()
        set(out)
        if(t_debug)
            list(APPEND out Debug)
        endif()
        if(t_release)
            list(APPEND out Release)
        endif()
        if(t_relwithdebinfo)
            list(APPEND out RelWithDebInfo)
        endif()
        if(t_minsizerel)
            list(APPEND out MinSizeRel)
        endif()
    endif()
    set(${var} ${out})
endmacro()

######################################################################################################################

macro(generate_project)
    set(options)
    set(one DIRECTORY GENERATOR TOOLCHAIN BUILD_TYPE SOURCES)
    set(multi OPTIONS)
    cmake_parse_arguments(gp "${options}" "${one}" "${multi}" ${ARGN})

    if(NOT gp_DIRECTORY)
        message(FATAL_ERROR "generate_project: directory not specified!")
    endif()
    if(NOT gp_SOURCES)
        set(gp_SOURCES "${PROJECT_DIR}")
    endif()

    if(NOT EXISTS "${BUILD_DIR}/${gp_DIRECTORY}/cmake")
        file(MAKE_DIRECTORY "${BUILD_DIR}/${gp_DIRECTORY}/cmake")
    endif()

    set(generated_marker "${BUILD_DIR}/${gp_DIRECTORY}/cmake/.generated")
    if(NOT EXISTS "${generated_marker}")
        set(args)

        if(NOT gp_GENERATOR)
            set(generator Ninja)
        elseif(NOT "${gp_GENERATOR}" STREQUAL "Makefiles")
            set(generator "${gp_GENERATOR}")
        else()
            if(NOT WIN32)
                set(generator "Unix Makefiles")
            else()
                set(generator "MinGW Makefiles")
            endif()
        endif()
        list(APPEND args -G "${generator}")
        if("${generator}" STREQUAL "Ninja")
            require_ninja()
            if(WIN32)
                list(APPEND args "-DCMAKE_MAKE_PROGRAM=${TOOLS_DIR}/ninja/ninja.exe")
            endif()
        elseif("${generator}" STREQUAL "MinGW Makefiles")
            require_mingw32_make()
            list(APPEND args "-DCMAKE_MAKE_PROGRAM=${TOOLS_DIR}/mingw32_make/mingw32-make.exe")
        endif()

        if(gp_ARCHITECTURE)
            list(APPEND args -A "${gp_ARCHITECTURE}")
        endif()

        if(gp_TOOLCHAIN)
            if(EXISTS "${gp_TOOLCHAIN}")
                set(path "${gp_TOOLCHAIN}")
            else()
                set(path "${CMAKE_DIR}/toolchain/${gp_TOOLCHAIN}.cmake")
            endif()
            list(APPEND args "-DCMAKE_TOOLCHAIN_FILE=${path}")
        endif()

        if(gp_BUILD_TYPE)
            list(APPEND args "-DCMAKE_BUILD_TYPE=${gp_BUILD_TYPE}")
        endif()

        foreach(tool ${buildtool_host_tools})
            list(APPEND args "-DHOST_${tool}")
        endforeach()

        if(gp_OPTIONS)
            foreach(opt ${gp_OPTIONS})
                list(APPEND args "-D${opt}")
            endforeach()
        endif()

        do("${CMAKE_COMMAND}" --no-warn-unused-cli ${args} "${gp_SOURCES}"
            WORKING_DIRECTORY "${BUILD_DIR}/${gp_DIRECTORY}/cmake")
        file(WRITE "${generated_marker}" "")
    endif()
endmacro()

######################################################################################################################

macro(build_project)
    set(options PARALLEL)
    set(one DIRECTORY)
    set(multi TARGETS)
    cmake_parse_arguments(bp "${options}" "${one}" "${multi}" ${ARGN})

    if(NOT bp_DIRECTORY)
        message(FATAL_ERROR "build_project: directory not specified!")
    endif()

    set(args)
    if(bp_BUILD_TYPE)
        list(APPEND args --config "${bp_BUILD_TYPE}")
    endif()
    if(bp_PARALLEL)
        list(APPEND args --parallel)
    endif()

    set(work_dir "${BUILD_DIR}/${bp_DIRECTORY}/cmake")
    if(NOT bp_TARGETS)
        do("${CMAKE_COMMAND}" --build . ${args}
            WORKING_DIRECTORY "${work_dir}")
    else()
        foreach(target ${bp_TARGETS})
            do("${CMAKE_COMMAND}" --build . --target "${target}" ${args}
                WORKING_DIRECTORY "${work_dir}")
        endforeach()
    endif()
endmacro()

######################################################################################################################

macro(build_host_tool name)
    set(options)
    set(one DIRECTORY)
    set(multi TARGETS EXECUTABLES OPTIONS)
    cmake_parse_arguments(bht "${options}" "${one}" "${multi}" ${ARGN})

    if(NOT bht_DIRECTORY)
        message(FATAL_ERROR "build_host_tool: directory not specified!")
    endif()

    require_ninja()
    if(WIN32)
        require_mingw810_32()
    endif()

    set(dir "_host_/${name}/Release")
    generate_project(
        DIRECTORY "${dir}"
        SOURCES "${bht_DIRECTORY}"
        BUILD_TYPE "Release"
        OPTIONS ${bht_OPTIONS}
        )

    if(NOT bht_EXECUTABLES)
        if(bht_TARGETS)
            set(bht_EXECUTABLES ${bht_TARGET})
        else()
            set(bht_EXECUTABLES "${name}")
        endif()
    endiF()

    if(NOT bht_TARGETS)
        build_project(
            DIRECTORY "${dir}"
            )
    else()
        build_project(
            DIRECTORY "${dir}"
            TARGETS ${bht_TARGETS}
            )
    endif()

    foreach(exename ${bht_EXECUTABLES})
        set(exe "${BUILD_DIR}/${dir}/${exename}")
        if(WIN32)
            set(exe "${exe}.exe")
        endif()
        if(NOT EXISTS "${exe}")
            message(FATAL_ERROR "build_host_tool: file \"${exe}\" does not exist.")
        endif()
        string(TOUPPER "${exename}" upper_name)
        list(APPEND buildtool_host_tools "${upper_name}=${exe}")
    endforeach()
endmacro()
