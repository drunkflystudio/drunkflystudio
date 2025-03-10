
if(BORLAND_4_5)
    require_win32_host("BORLAND_4_5")
    require_gnu_tools()
    require_borland_4_5()
    get_build_types(build_types "${BORLAND_4_5}")
    foreach(build_type ${build_types})
        set(dir "win32/borlnd45/${build_type}")
        generate_project(
            DIRECTORY "${dir}"
            GENERATOR "MinGW Makefiles"
            BUILD_TYPE "${build_type}"
            TOOLCHAIN "borland45/_win32"
            )
        build_project(
            DIRECTORY "${dir}"
            )
    endforeach()
endif()

######################################################################################################################

if(MINGW440_32)
    require_win32_host("MINGW440_32")
    require_mingw440_32()
    get_build_types(build_types "${MINGW440_32}")
    foreach(build_type ${build_types})
        set(dir "win32/mingw440/${build_type}")
        generate_project(
            DIRECTORY "${dir}"
            BUILD_TYPE "${build_type}"
            CC "${TOOLS_DIR}/mingw440_32/bin/gcc.exe"
            CXX "${TOOLS_DIR}/mingw440_32/bin/g++.exe"
            )
        build_project(
            DIRECTORY "${dir}"
            )
    endforeach()
endif()

######################################################################################################################

if(MINGW810_32)
    require_win32_host("MINGW810_32")
    require_mingw810_32()
    get_build_types(build_types "${MINGW810_32}")
    foreach(build_type ${build_types})
        set(dir "win32/mingw810/${build_type}")
        generate_project(
            DIRECTORY "${dir}"
            BUILD_TYPE "${build_type}"
            CC "${TOOLS_DIR}/mingw810_32/bin/gcc.exe"
            CXX "${TOOLS_DIR}/mingw810_32/bin/g++.exe"
            )
        build_project(
            DIRECTORY "${dir}"
            )
    endforeach()
endif()

######################################################################################################################

if(MINGW810_64)
    require_win32_host("MINGW810_64")
    require_mingw810_64()
    get_build_types(build_types "${MINGW810_64}")
    foreach(build_type ${build_types})
        set(dir "win64/mingw810/${build_type}")
        generate_project(
            DIRECTORY "${dir}"
            BUILD_TYPE "${build_type}"
            CC "${TOOLS_DIR}/mingw810_64/bin/gcc.exe"
            CXX "${TOOLS_DIR}/mingw810_64/bin/g++.exe"
            )
        build_project(
            DIRECTORY "${dir}"
            )
    endforeach()
endif()

######################################################################################################################

if(MSVC2022_32)
    require_win32_host("MSVC2022_32")
    set(dir "win32/msvc2022")
    generate_project(
        DIRECTORY "${dir}"
        GENERATOR "Visual Studio 17 2022"
        ARCHITECTURE "Win32"
        )
    if(NOT MSVC2022_32 STREQUAL "generate-only")
        get_build_types(build_types "${MSVC2022_32}")
        foreach(build_type ${build_types})
            build_project(
                DIRECTORY "${dir}"
                BUILD_TYPE "${build_type}"
                PARALLEL
                )
        endforeach()
    endif()
endif()

######################################################################################################################

if(MSVC2022_64)
    require_win32_host("MSVC2022_64")
    set(dir "win64/msvc2022")
    generate_project(
        DIRECTORY "${dir}"
        GENERATOR "Visual Studio 17 2022"
        ARCHITECTURE "x64"
        )
    if(NOT MSVC2022_64 STREQUAL "generate-only")
        get_build_types(build_types "${MSVC2022_64}")
        foreach(build_type ${build_types})
            build_project(
                DIRECTORY "${dir}"
                BUILD_TYPE "${build_type}"
                PARALLEL
                )
        endforeach()
    endif()
endif()

######################################################################################################################

if(LINUX32)
    require_linux_host("LINUX32")
    get_build_types(build_types "${LINUX32}")
    foreach(build_type ${build_types})
        set(dir "linux32/${build_type}")
        generate_project(
            DIRECTORY "${dir}"
            BUILD_TYPE "${build_type}"
            CC "gcc -m32"
            CXX "g++ -m32"
            )
        build_project(
            DIRECTORY "${dir}"
            )
    endforeach()
endif()

######################################################################################################################

if(LINUX64)
    require_linux_or_win32_host("LINUX64")
    get_build_types(build_types "${LINUX64}")
    if(WIN32)
        require_clang350_linux64()
        foreach(build_type ${build_types})
            set(dir "linux64/${build_type}")
            generate_project(
                DIRECTORY "${dir}"
                BUILD_TYPE "${build_type}"
                TOOLCHAIN "clang350_linux64"
                )
            build_project(
                DIRECTORY "${dir}"
                )
        endforeach()
    else()
        foreach(build_type ${build_types})
            set(dir "linux64/${build_type}")
            generate_project(
                DIRECTORY "${dir}"
                BUILD_TYPE "${build_type}"
                CC "gcc -m64"
                CXX "g++ -m64"
                )
            build_project(
                DIRECTORY "${dir}"
                )
        endforeach()
    endif()
endif()

######################################################################################################################

if(XCODE)
    require_macos_host("XCODE")
    set(dir "macos/xcode")
    generate_project(
        DIRECTORY "${dir}"
        GENERATOR "Xcode"
        OSX_ARCHITECTURES "x86_64;arm64"
        )
    if(NOT XCODE STREQUAL "generate-only")
        get_build_types(build_types "${XCODE}")
        foreach(build_type ${build_types})
            build_project(
                DIRECTORY "${dir}"
                BUILD_TYPE "${build_type}"
                PARALLEL
                )
        endforeach()
    endif()
endif()

######################################################################################################################

if(HTML5)
    require_emscripten("3.1.50")
    get_build_types(build_types "${HTML5}")
    foreach(build_type ${build_types})
        set(dir "html5/${build_type}")
        generate_project(
            DIRECTORY "${dir}"
            BUILD_TYPE "${build_type}"
            TOOLCHAIN "${EMSCRIPTEN}/cmake/Modules/Platform/Emscripten.cmake"
            )
        build_project(
            DIRECTORY "${dir}"
            )
    endforeach()
endif()

######################################################################################################################

if(WATCOM10)
    require_win32_host("WATCOM10")
    require_watcom10()
    get_build_types(build_types "${WATCOM10}")
    foreach(build_type ${build_types})
        set(dir "win32/watcom10/${build_type}")
        generate_project(
            DIRECTORY "${dir}"
            GENERATOR "Makefiles"
            BUILD_TYPE "${build_type}"
            TOOLCHAIN "watcom10/_win32"
            )
        build_project(
            DIRECTORY "${dir}"
            )
    endforeach()
endif()
