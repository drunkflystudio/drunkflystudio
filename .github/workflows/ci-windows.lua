
print([[

# This continuous integration pipeline is triggered anytime a user pushes code to the repo.
name: Continuous Integration (Windows)

# Trigger on every master branch push and pull request
on:
  push:
    branches:
      - master
  pull_request:
    branches:
      - master

jobs:
  build:
    runs-on: windows-2022
    steps:

    - name: Checkout
      uses: actions/checkout@v4]])

function build(name, config, command, dir)
    local str = ([[\n
    - name: Build with ]]..name..[[ (]]..config..[[)
      run: _build\]]..command..[[\n
    - name: Upload artifacts for ]]..name..[[ (]]..config..[[)
      uses: actions/upload-artifact@v4
      with:
        name: ]]..name..[[ (]]..config..[[)
        path: |
          _build/]]..dir..[[/]]..config..[[\n
          !_build/]]..dir..[[/]]..config..[[/cmake\n
        if-no-files-found: error
        include-hidden-files: false
        compression-level: 9]]):gsub("\\([n])", {n=""})
    print(str)
end

function build_multiconfig(name, command, dir)
    local str = ([[\n
    - name: Build with ]]..name..[[\n
      run: |
        _build\]]..command..[[\n
    - name: Upload artifacts for ]]..name..[[ (Debug)
      uses: actions/upload-artifact@v4
      with:
        name: ]]..name..[[ (Debug)
        path: _build/]]..dir..[[/Debug
        if-no-files-found: error
        include-hidden-files: false
        compression-level: 9
    - name: Upload artifacts for ]]..name..[[ (Release)
      uses: actions/upload-artifact@v4
      with:
        name: ]]..name..[[ (Release)
        path: _build/]]..dir..[[/Release
        if-no-files-found: error
        include-hidden-files: false
        compression-level: 9]]):gsub("\\([n])", {n=""})
    print(str)
end

build('Borland C++ 4.52',
    'Debug',
    'win32_bc45_debug.cmd',
    'win32/borlnd45')

build('Borland C++ 4.52',
    'Release',
    'win32_bc45_release.cmd',
    'win32/borlnd45')

build('HTML5',
    'Debug',
    'win32_html5_debug.cmd',
    'html5')

build('HTML5',
    'Release',
    'win32_html5_release.cmd',
    'html5')

build('Linux 64-bit',
    'Debug',
    'win32_linux64_debug.cmd',
    'linux64')

build('Linux 64-bit',
    'Release',
    'win32_linux64_release.cmd',
    'linux64')

build('MinGW 4.4.0 32-bit',
    'Debug',
    'win32_mingw32_440_debug.cmd',
    'win32/mingw440')

build('MinGW 4.4.0 32-bit',
    'Release',
    'win32_mingw32_440_release.cmd',
    'win32/mingw440')

build('MinGW 8.1.0 32-bit',
    'Debug',
    'win32_mingw32_810_debug.cmd',
    'win32/mingw810')

build('MinGW 8.1.0 32-bit',
    'Release',
    'win32_mingw32_810_release.cmd',
    'win32/mingw810')

build('MinGW 8.1.0 64-bit',
    'Debug',
    'win32_mingw64_810_debug.cmd',
    'win64/mingw810')

build('MinGW 8.1.0 64-bit',
    'Release',
    'win32_mingw64_810_release.cmd',
    'win64/mingw810')

build_multiconfig('MSVC 2022 32-bit',
    'win32_msvc2022_32.cmd',
    'win32/msvc2022')

build_multiconfig('MSVC 2022 64-bit',
    'win32_msvc2022_64.cmd',
    'win64/msvc2022')

build('Watcom 10.0a',
    'Debug',
    'win32_watcom10_debug.cmd',
    'win32/watcom10')

build('Watcom 10.0a',
    'Release',
    'win32_watcom10_release.cmd',
    'win32/watcom10')
