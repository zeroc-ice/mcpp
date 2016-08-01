# **********************************************************************
#
# Copyright (c) 2015 ZeroC, Inc. All rights reserved.
#
# **********************************************************************

PREFIX ?= /opt/mcpp-2.7.2

CFLAGS += -O -w

UNAME = $(shell uname)
MACHINE = $(shell uname -m)

LIBDIR = lib

ifeq ($(UNAME),Darwin)
	CFLAGS += -mmacosx-version-min=10.9
endif

ifeq ($(UNAME),Linux)
	CFLAGS += -fPIC

	ifeq ($(MACHINE),i686)
	CFLAGS += -m32

	#
	# Ubuntu.
	#
	ifeq ($(shell test -d /usr/lib/i386-linux-gnu && echo 0),0)
		LIBDIR = lib/i386-linux-gnu
	endif
	else
	#
	# Ubuntu.
	#
	ifeq ($(shell test -d /usr/lib/x86_64-linux-gnu && echo 0),0)
		LIBDIR = lib/x86_64-linux-gnu
	endif

	#
	# Rhel/SLES
	#
	ifeq ($(shell test -d /usr/lib64 && echo 0),0)
		LIBDIR = lib64
	endif
	endif
endif

ifeq ($(UNAME),AIX)
	CC ?= xlc_r
endif

#
# The default C compiler (cc) is undefined with MinGW
#
ifneq ($(findstring MINGW,$(UNAME)),)
	CC ?= gcc
endif

OBJS = directive.o eval.o expand.o main.o mbchar.o support.o system.o

$(LIBDIR)/libmcpp.a: $(OBJS)
	-mkdir -p $(LIBDIR)
	ar rcs $(LIBDIR)/libmcpp.a $(OBJS)
	ranlib $(LIBDIR)/libmcpp.a

install: $(LIBDIR)/libmcpp.a
ifneq ($(findstring MINGW,$(UNAME)),)
	cp $(LIBDIR)/libmcpp.a $(PREFIX)
else
	@mkdir -p $(PREFIX)/lib
	cp $(LIBDIR)/libmcpp.a $(PREFIX)/lib
endif

clean:
	rm -f $(OBJS)
	rm -rf $(LIBDIR)
