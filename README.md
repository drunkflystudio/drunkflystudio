
Drunk Fly Studio
================

[![GitHub release (latest by date)](https://img.shields.io/github/v/release/drunkflystudio/drunkflystudio)](https://github.com/drunkflystudio/drunkflystudio/releases)
&nbsp;
[![CI/CD](https://github.com/drunkflystudio/drunkflystudio/actions/workflows/ci.yml/badge.svg)](https://github.com/drunkflystudio/drunkflystudio/actions/workflows/ci.yml)
&nbsp;
[![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fdrunkflystudio%2Fdrunkflystudio&countColor=%230c7ebe&style=flat&labelStyle=none)](https://visitorbadge.io/status?path=https%3A%2F%2Fgithub.com%2Fdrunkflystudio%2Fdrunkflystudio)

[![Windows badge](https://custom-icon-badges.demolab.com/badge/Windows-0078D6?logo=windows11&logoColor=white)](#building-on-windows)
&nbsp;
[![Linux badge](https://img.shields.io/badge/Linux-FCC624?logo=linux&logoColor=black)](#building-on-linux)
&nbsp;
[![MacOS badge](https://img.shields.io/badge/macOS-5F5F5F?style=flat&logo=apple&logoColor=white)](#building-on-macos)
&nbsp;
[![HTML5 badge](https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=html5&logoColor=white)](#)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
[![YouTube](https://img.shields.io/badge/YouTube-%23FF0000.svg?logo=YouTube&logoColor=white)](https://youtube.com/drunkfly)

___

This project is under active development and has not yet reached any usable state.

___

Building from source
--------------------

### Building on Windows

Run `build_win32_all.cmd` to build executables for all supported targets.

Optionally, run one of the `win32_*.cmd` files in the `_build` directory to build for a specified target.

Built executables will be placed in the `_build` directory.

Also you can run one of `open_*.cmd` scripts to open project
in the corresponding version of Visual Studio.

### Building on Linux

The build system is currently designed to run on Ubuntu Linux.

Run `build_linux_all.sh` to build executables for all supported targets.

Optionally, run one of the `linux_*.sh` files in the `_build` directory to build for a specified target.

Built executables will be placed in the `_build` directory.

### Building on MacOS

Run `build_macos_all.sh` to build executables for all supported targets.

Optionally, run one of the `macos_*.sh` files in the `_build` directory to build for a specified target.

Built executables will be placed in the `_build` directory.

Also you can run `open_xcode.sh` script to open project in Xcode.

License
-------

Copyright &copy; 2024-2025 Nikolay Zapolnov
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. The name of the author may not be used to endorse or promote products
   derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
