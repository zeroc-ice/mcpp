# **********************************************************************
#
# Copyright (c) 2015 ZeroC, Inc. All rights reserved.
#
# **********************************************************************

CFLAGS += -O -w

UNAME = $(shell uname)
MACHINE = $(shell uname -m)

LIBDIR = lib

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

#
# The default C compiler (cc) is undefined with MinGW
#
ifneq ($(findstring MINGW,$(UNAME)),)
    CC = gcc
endif 

OBJS = directive.o eval.o expand.o main.o mbchar.o support.o system.o

$(LIBDIR)/libmcpp.a: $(OBJS)
	-mkdir -p $(LIBDIR)
	ar rcs $(LIBDIR)/libmcpp.a $(OBJS)
	ranlib $(LIBDIR)/libmcpp.a

clean:
	rm -f $(OBJS)
	rm -rf $(LIBDIR)

