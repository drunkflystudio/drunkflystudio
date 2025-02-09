
Drunk Fly Studio
================

[![CI/CD](https://github.com/drunkflystudio/drunkflystudio/actions/workflows/ci.yml/badge.svg)](https://github.com/drunkflystudio/drunkflystudio/actions/workflows/ci.yml)
[![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fdrunkflystudio%2Fdrunkflystudio&countColor=%230c7ebe&style=flat&labelStyle=none)](https://visitorbadge.io/status?path=https%3A%2F%2Fgithub.com%2Fdrunkflystudio%2Fdrunkflystudio)
[![YouTube](https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=html5&logoColor=white)](https://youtube.com/drunkfly)

![Windows badge](https://custom-icon-badges.demolab.com/badge/Windows-0078D6?logo=windows11&logoColor=white)
![MacOS badge](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=white)
![Ubuntu badge](https://img.shields.io/badge/Ubuntu-E95420?style=flat&logo=ubuntu&logoColor=white)
![HTML5 badge](https://img.shields.io/badge/HTML5-E34F26?style=flat&logo=html5&logoColor=white)

Building on Windows
-------------------

Run `build_win32_all.cmd` to build executables for all supported targets.

Optionally, run one of the `win32_*.cmd` files in the `_build` directory to build for a specified target.

Built executables will be placed in the `_build` directory.

Also you can run one of `open_*.cmd` scripts to open project
in the corresponding version of Visual Studio.

Building on Linux
-----------------

The build system is currently designed to run on Ubuntu Linux.

Run `build_linux_all.sh` to build executables for all supported targets.

Optionally, run one of the `linux_*.sh` files in the `_build` directory to build for a specified target.

Built executables will be placed in the `_build` directory.

Building on MacOS
-----------------

Run `build_macos_all.sh` to build executables for all supported targets.

Optionally, run one of the `macos_*.sh` files in the `_build` directory to build for a specified target.

Built executables will be placed in the `_build` directory.

Also you can run `open_xcode.sh` script to open project in Xcode.
