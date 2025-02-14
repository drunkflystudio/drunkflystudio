
set(CMAKE_EXECUTABLE_SUFFIX ".html")

add_compiler_flag(-fno-ident FORCE)
add_compiler_flag(-fno-plt FORCE)
add_compiler_flag(-fvisibility=hidden FORCE)
add_compiler_flag(-fvisibility-inlines-hidden FORCE)

macro(enable_warnings)
    add_compiler_flag_release(-Werror FORCE)
    add_compiler_flag(-ansi FORCE)
    add_compiler_flag(-pedantic FORCE)
    add_compiler_flag(-Wall FORCE)
    add_compiler_flag(-Wextra FORCE)
    add_compiler_flag(-Wshadow FORCE)
    add_compiler_flag(-Wconversion FORCE)
endmacro()
