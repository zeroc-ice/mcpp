# MCPP.V143

This package contains debug and release builds of the mcpp 2.7.4 static library. It was built with Visual Studio 2022.

## Source

The source code used to build this package is available at https://github.com/zeroc-ice/mcpp.

## Build Instructions

git clone git@github.com:zeroc-ice/mcpp.git
cd mcpp
MSBuild msbuild\mcpp.proj /t:NugetPack
