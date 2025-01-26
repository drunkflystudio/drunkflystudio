
print([[

# This continuous integration pipeline is triggered anytime a user pushes code to the repo.
name: Continuous Integration

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
    runs-on: windows-latest
    steps:

    - name: Checkout
      uses: actions/checkout@v4
]])

function build(name, config, command, dir)
    local str = ([[
    - name: Build with ]]..name..[[ (]]..config..[[)
      run: |
        _build\]]..command..[[\n
    - name: Prepare artifacts for ]]..name..[[ (]]..config..[[)
      run: |
        attrib +h _build/]]..dir..[[/]]..config..[[/cmake
    - name: Upload artifacts for ]]..name..[[ (]]..config..[[)
      uses: actions/upload-artifact@v4
      with:
        name: ]]..name..[[ (]]..config..[[)
        path: _build/]]..dir..[[/]]..config..[[\n
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

build('MinGW 32-bit',
    'Debug',
    'win32_mingw32_debug.cmd',
    'win32/mingw')

build('MinGW 32-bit',
    'Release',
    'win32_mingw32_release.cmd',
    'win32/mingw')

build('MinGW 64-bit',
    'Debug',
    'win32_mingw64_debug.cmd',
    'win64/mingw')

build('MinGW 64-bit',
    'Release',
    'win32_mingw64_release.cmd',
    'win64/mingw')

build('Watcom 10.0a',
    'Debug',
    'win32_watcom10_debug.cmd',
    'win32/watcom10')

build('Watcom 10.0a',
    'Release',
    'win32_watcom10_release.cmd',
    'win32/watcom10')
