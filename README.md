# mcpp

This is a fork of [mcpp](http://mcpp.sourceforge.net/). mcpp is a C/C++ preprocessor used by the [Ice](https://github.com/zeroc-ice/ice) Slice compilers.

This fork consists of a simplified version of mcpp 2.7.2 plus various fixes, tailored to the Slice compilers requirements. Its build system creates only a static library and no command-line preprocessor. The configure script was replaced by a custom `config.h` suitable for Windows, OS X and Linux builds. Tests and other optional files were removed.

The resulting static library is later used when creating the [Ice](https://github.com/zeroc-ice/ice) Slice shared library or statically-linked Slice compilers such as `slice2js`.

## Build Instructions

### Linux, OS X and Windows with MinGW
Simply type:
```
  make
```  

This creates a static library `libmcpp.a`. Depending on your platform, the library is created in the following directory:

* `lib64` - RHEL 64-bit
* `lib/i386-linux-gnu` - Ubuntu 32-bit
* `lib/x86_64-linux-gnu` - Ubuntu 64-bit
* `lib` - Other platforms

The exceptions are RHEL 64 bit systems where 'lib64' is used,  Ubuntu 32 bit systems where 'lib/i386-linux-gnu' is used, and Ubuntu 
64 bit system where 'lib/x86_64-linux-gnu' is used.

This creates a static library 'libmcpp.a`'. On most systems this library is placed in a directory named 'lib'.

The exceptions are RHEL 64 bit systems where 'lib64' is used,  Ubuntu 32 bit systems where 'lib/i386-linux-gnu' is used, and Ubuntu 
64 bit system where 'lib/x86_64-linux-gnu' is used.


### Windows with Visual Studio

Open a Visual Studio Command Prompt, and type:
```
  nmake -f Makefile.mak
```
This creates two static libraries: `mcpp.lib`, built with `/MD` ("release") and `mcppd.lib`, built with `/MDd` ("debug").
