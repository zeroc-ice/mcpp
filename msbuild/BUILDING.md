# Building NuGet Packages

This document describes how to build the mcpp NuGet packages.

## Prerequisites

- Visual Studio 2022 with C++ workload
- For v142 packages: MSVC v142 toolset (VS2019 toolset)

## Build Instructions

Clone the repository and run MSBuild from the `msbuild` directory:

```shell
git clone git@github.com:zeroc-ice/mcpp.git
cd mcpp\msbuild
```

### ZeroC.Mcpp

This package supports both v142 and v143 platform toolsets:

```shell
MSBuild mcpp.proj /t:NugetPack /p:PackageName=ZeroC.Mcpp
```

### mcpp.v143

```shell
MSBuild mcpp.proj /t:NugetPack /p:DefaultPlatformToolset=v143 /p:PackageName=mcpp.v143
```

### mcpp.v142

```shell
MSBuild mcpp.proj /t:NugetPack /p:DefaultPlatformToolset=v142 /p:PackageName=mcpp.v142
```

## Output

The resulting packages are produced in `build\<PackageName>\`.
