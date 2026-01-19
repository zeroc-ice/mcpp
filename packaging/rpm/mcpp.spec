#
# Copyright (c) ZeroC, Inc. All rights reserved.
#

# git_tag, when defined, is typically a branch or tag, for example master or v2.7.4
%if 0%{?git_tag:1}
   %define archive_tag %{git_tag}
%else
   %define archive_tag master
%endif

Summary: mcpp, a portable C/C++ preprocessor
Name: mcpp-devel
Version: 2.7.4
Release: 1ice%{?dist}
Source: https://github.com/zeroc-ice/mcpp/archive/%{archive_tag}.tar.gz#/mcpp-%{version}.tar.gz
URL: http://mcpp.sourceforge.net/
License: BSD
Group: System Environment/Libraries
Requires: pkgconfig

BuildRequires: glibc-devel

%description
mcpp is a C/C++ preprocessor with the following features.

    * Implements all of C90, C99 and C++98 specifications.
    * Provides a validation suite to test C/C++ preprocessor's conformance
      and quality comprehensively. When this validation suite is applied,
       mcpp distinguishes itself among many existing preprocessors.
    * Has plentiful and accurate diagnostics to check all the preprocessing
      problems such as latent bug or lack of portability in source code.
    * Has #pragma directives to output debugging information.
    * Is portable and has been ported to many compliler-systems, including
      GCC and Visual C++, on UNIX-like systems and Windows.
    * Preprocessors of various behavior modes are able to be generated from
      the source code.
    * Can be built either as a compiler-specific preprocessor to replace the
      resident preprocessor of a particular compiler system, or as a
      compiler-independent command, or even as a subroutine called from some
      other main program.
    * Provides comprehensive documents both in Japanese and in English.
    * Is an open source software released under BSD-style-license.

# disable debuginfo package
%define debug_package %{nil}

%prep
%setup -q -n mcpp-%{archive_tag}

%build
make CFLAGS="%{optflags}"

%install
make PREFIX=%{buildroot}%{_prefix} install

# create pkgconfig file
mkdir %{buildroot}%{_libdir}/pkgconfig
cat << "EOF" > %{buildroot}%{_libdir}/pkgconfig/mcpp.pc
prefix=/usr
exec_prefix=${prefix}
libdir=%{_libdir}

Name: mcpp
Version: %{version}
Description: %{summary}
URL: %{url}
Libs: -L${libdir} -lmcpp
EOF

%files -n mcpp-devel
%doc LICENSE
%{_libdir}/libmcpp.a
%{_libdir}/pkgconfig/mcpp.pc

%changelog
* Sun Jan 19 2026 Jose Gutierrez de la Concha  <jose@zeroc.com> 2.7.4-1ice
- Fix heap-use-after-free in substitute() (issue #9)
- Fix heap-based buffer overflow in do_msg() (issue #10)

* Tue Jun 17 2025 Jose Gutierrez de la Concha  <jose@zeroc.com> 2.7.2-19ice
- Add support for Red Hat 10 platforms

* Wed Apr 8 2020 Benoit Foucher <benoit@zeroc.com> 2.7.2-15ice
- x86 multilib build for EL8 platforms

* Thu Aug 22 2019 Bernard Normier <bernard@zeroc.com> 2.7.2-14ice
- Upgrade to 2.7.2.14

* Fri Mar 10 2017 Bernard Normier <bernard@zeroc.com> 2.7.2-6ice
- Added pkgconfig file

* Tue Feb 21 2017 Bernard Normier <bernard@zeroc.com> 2.7.2-5ice
- Simplified spec file
- Build with optflags

* Tue Apr 7 2015 Bernard Normier <bernard@zeroc.com>
- Update to use source from https://github:zeroc-ice/mcpp

* Wed Jan 14 2009 Dwayne Boone <dwayne@zeroc.com>
- mcpp 2.7.2 update

* Wed Apr 30 2008 Bernard Normier <bernard@zeroc.com>
- mcpp 2.7 update

* Thu Feb 7 2008  Bernard Normier <bernard@zeroc.com>
- Initial version
