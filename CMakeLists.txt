cmake_minimum_required(VERSION 3.5...3.31)
project(Studio)

include(_cmake/common.cmake)

include("${CMAKE_DIR}/projects.cmake")
foreach(com ${common})
    get_filename_component(CURRENT_PROJECT_DIR "${com}" PATH)
    get_filename_component(CURRENT_PROJECT_DIR "${CURRENT_PROJECT_DIR}" PATH)
    include("${com}")
endforeach()

foreach(dir ${subdirs})
    add_subdirectory("${dir}")
endforeach()
