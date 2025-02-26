
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

macro(require_linux_host what)
    if(NOT CMAKE_HOST_SYSTEM_NAME MATCHES Linux)
        message(FATAL_ERROR "${what} requires Linux host.")
    endif()
endmacro()

######################################################################################################################

macro(require_linux_or_win32_host what)
    if(NOT WIN32 AND NOT CMAKE_HOST_SYSTEM_NAME MATCHES Linux)
        message(FATAL_ERROR "${what} requires Linux or Win32 host.")
    endif()
endmacro()

######################################################################################################################

macro(require_macos_host what)
    if(NOT APPLE)
        message(FATAL_ERROR "${what} requires MacOS host.")
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
    set(one DIRECTORY GENERATOR ARCHITECTURE TOOLCHAIN BUILD_TYPE SOURCES CC CXX OSX_ARCHITECTURES)
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

    set(args)

    if(NOT gp_GENERATOR)
        if(APPLE)
            set(generator Xcode)
        else()
            if(WINDOWS_VERSION_MAJOR LESS 6)
                set(generator "MinGW Makefiles")
            else()
                set(generator Ninja)
            endif()
        endif()
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
            execute_process(COMMAND "${TOOLS_DIR}/ninja/ninja.exe" --version
                OUTPUT_VARIABLE out RESULT_VARIABLE status)
            if(status EQUAL 0)
                list(APPEND args "-DCMAKE_MAKE_PROGRAM=${TOOLS_DIR}/ninja/ninja.exe")
                list(APPEND args "-DNINJA=1")
            else()
                set(generator "MinGW Makefiles")
            endif()
        endif()
    endif()
    if("${generator}" STREQUAL "MinGW Makefiles")
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

    if(gp_OSX_ARCHITECTURES)
        list(APPEND args "-DCMAKE_OSX_ARCHITECTURES=${gp_OSX_ARCHITECTURES}")
    endif()

    set(config "args=${args}\n")
    set(config "${config}BUILD_DIR=${BUILD_DIR}\n")
    set(config "${config}gp_SOURCES=${gp_SOURCES}\n")
    set(config "${config}gp_DIRECTORY=${gp_DIRECTORY}\n")
    set(config "${config}gp_CC=${gp_CC}\n")
    set(config "${config}gp_CXX=${gp_CXX}\n")

    set(generated_marker "${BUILD_DIR}/${gp_DIRECTORY}/cmake/.generated")
    if(EXISTS "${generated_marker}")
        file(READ "${generated_marker}" generated_config)
    else()
        set(generated_config "")
    endif()

    if(NOT config STREQUAL generated_config)
        if(gp_CC)
            if(ENV{CC})
                set(oldCC "$ENV{CC}")
            else()
                unset(oldCC)
            endif()
            set(ENV{CC} "${gp_CC}")
        endif()

        if(gp_CXX)
            if(ENV{CXX})
                set(oldCXX "$ENV{CXX}")
            else()
                unset(oldCXX)
            endif()
            set(ENV{CXX} "${gp_CXX}")
        endif()

        do("${CMAKE_COMMAND}" --no-warn-unused-cli ${args} "${gp_SOURCES}"
            WORKING_DIRECTORY "${BUILD_DIR}/${gp_DIRECTORY}/cmake")
        file(WRITE "${generated_marker}" "${config}")

        if(gp_CC)
            if(oldCC)
                set(ENV{CC} "${oldCC}")
            else()
                unset(ENV{CC})
            endif()
        endif()
        if(gp_CXX)
            if(oldCXX)
                set(ENV{CXX} "${oldCXX}")
            else()
                unset(ENV{CXX})
            endif()
        endif()
    endif()
endmacro()

######################################################################################################################

macro(build_project)
    set(options PARALLEL)
    set(one DIRECTORY BUILD_TYPE)
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
    set(options ONLY_WHEN_CROSSCOMPILING)
    set(one DIRECTORY)
    set(multi TARGETS EXECUTABLES OPTIONS)
    cmake_parse_arguments(bht "${options}" "${one}" "${multi}" ${ARGN})

    if(NOT bht_DIRECTORY)
        message(FATAL_ERROR "build_host_tool: directory not specified!")
    endif()

    if(CROSSCOMPILING OR NOT bht_ONLY_WHEN_CROSSCOMPILING)
        set(flags)
        if(APPLE)
            set(dir "_host_/${name}")
        else()
            require_ninja()
            if(WIN32)
                require_mingw440_32()
                set(flags
                    CC "${TOOLS_DIR}/mingw440_32/bin/gcc.exe"
                    CXX "${TOOLS_DIR}/mingw440_32/bin/g++.exe"
                    )
            endif()
            set(dir "_host_/${name}/Release")
        endif()

        generate_project(
            DIRECTORY "${dir}"
            SOURCES "${bht_DIRECTORY}"
            BUILD_TYPE "Release"
            OPTIONS ${bht_OPTIONS}
            ${flags}
            )

        if(NOT bht_EXECUTABLES)
            if(bht_TARGETS)
                set(bht_EXECUTABLES ${bht_TARGET})
            else()
                set(bht_EXECUTABLES "${name}")
            endif()
        endif()

        if(NOT bht_TARGETS)
            build_project(
                DIRECTORY "${dir}"
                BUILD_TYPE "Release"
                )
        else()
            build_project(
                DIRECTORY "${dir}"
                BUILD_TYPE "Release"
                TARGETS ${bht_TARGETS}
                )
        endif()

        foreach(exename ${bht_EXECUTABLES})
            if(APPLE)
                set(exe "${BUILD_DIR}/${dir}/Release/${exename}")
            else()
                set(exe "${BUILD_DIR}/${dir}/${exename}")
                if(WIN32)
                    set(exe "${exe}.exe")
                endif()
            endif()
            if(NOT EXISTS "${exe}")
                message(FATAL_ERROR "build_host_tool: file \"${exe}\" does not exist.")
            endif()
            string(TOUPPER "${exename}" upper_name)
            list(APPEND buildtool_host_tools "${upper_name}=${exe}")
        endforeach()
    else()
        set(index 0)
        foreach(exename ${bht_EXECUTABLES})
            string(TOUPPER "${exename}" upper_name)
            list(GET bht_TARGETS "${index}" target)
            list(APPEND buildtool_host_tools "${upper_name}=${target}")
            math(EXPR index "${index}+1")
        endforeach()
    endif()
endmacro()
