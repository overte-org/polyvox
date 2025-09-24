# PolyVox - The voxel management and manipulation library (The 0.2.1 overte fork)

This is a C++20 upgrade of the polyvox library for primary use in overte, so not all things build/work.

here are the following changes made:
- [x] upgrade code to support c++20
- [x] add various nix files for testing and development
- [x] format code with clang-format
- [x] remove helper code for older MSVC compilers
- [x] updated to Qt5 testing framework (TODO: update to Qt6)
- [x] upgrade cmake files to support more modern cmake versions
- [ ] fix examples
- [ ] maybe restore Doxygen functionality

## Original README
PolyVox is the core technology which lies behind our games. It is a fast, lightweight C++ library for the storage and processing of volumetric (voxel-based) environments. It has applications in both games and medical/scientific visualisation, and is released under the terms of the `zlib license <http://www.tldrlegal.com/l/ZLIB>`_.

PolyVox is a relatively low-level library, and you will need experience in C++ and computer graphics/shaders to use it effectively. It is designed to be easily integrated into existing applications and is independent of your chosen graphics API. For more details please see `this page <http://www.volumesoffun.com/polyvox-about/>`_ on our website.
