
print([[

# This continuous integration pipeline is triggered anytime a user pushes code to the repo.
name: Continuous Integration (Linux)

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
    runs-on: ubuntu-20.04
    steps:

    - name: Checkout
      uses: actions/checkout@v4]])

function build(name, config, command, dir)
    local str = ([[\n
    - name: Build with ]]..name..[[ (]]..config..[[)
      run: sudo apt-get update && _build/]]..command..[[\n
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

build('Ubuntu GCC 32-bit',
    'Debug',
    'linux_gcc32_debug.sh',
    'linux32')

build('Ubuntu GCC 32-bit',
    'Release',
    'linux_gcc32_release.sh',
    'linux32')

build('Ubuntu GCC 64-bit',
    'Debug',
    'linux_gcc64_debug.sh',
    'linux64')

build('Ubuntu GCC 64-bit',
    'Release',
    'linux_gcc64_release.sh',
    'linux64')
