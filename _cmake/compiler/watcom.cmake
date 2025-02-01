
add_compiler_flag(-w0 FORCE)

macro(enable_warnings)
    add_compiler_flag_release(-we FORCE)
    add_compiler_flag(-w4 FORCE)
endmacro()
