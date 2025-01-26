
file(GLOB dirs
    LIST_DIRECTORIES TRUE
    RELATIVE "${PROJECT_DIR}"
    "${PROJECT_DIR}/*"
    )

set(common)
set(deps)
set(subdirs)

foreach(name ${dirs})
    if(NOT "${name}" MATCHES "^[_.](.*)")
        set(path "${PROJECT_DIR}/${name}")
        if (IS_DIRECTORY "${path}")
            if(EXISTS "${path}/cmake/common.cmake")
                list(APPEND common "${path}/cmake/common.cmake")
            endif()
            if(EXISTS "${path}/cmake/dependencies.cmake")
                list(APPEND deps "${path}/cmake/dependencies.cmake")
            endif()
            if(EXISTS "${path}/CMakeLists.txt")
                list(APPEND subdirs "${path}")
            endif()
        endif()
    endif()
endforeach()
