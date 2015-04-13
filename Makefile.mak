# **********************************************************************
#
# Copyright (c) 2015 ZeroC, Inc. All rights reserved.
#
# **********************************************************************

RELEASE_OBJS = Release\directive.obj \
	       Release\eval.obj \
	       Release\expand.obj \
	       Release\main.obj \
	       Release\mbchar.obj \
	       Release\support.obj \
	       Release\system.obj

DEBUG_OBJS = Debug\directive.obj \
	     Debug\eval.obj \
	     Debug\expand.obj \
	     Debug\main.obj \
	     Debug\mbchar.obj \
	     Debug\support.obj \
	     Debug\system.obj

{.\}.c{Debug}.obj::
	$(CC) /MDd /Od /c /FoDebug\  $<

{.\}.c{Release}.obj::
	$(CC) /MD /O2 /DNDEBUG /c /FoRelease\ $<

all: targets mcpp.lib mcppd.lib

targets:
	if not exist Debug mkdir Debug
	if not exist Release mkdir Release

mcpp.lib: $(RELEASE_OBJS)
	lib /nologo /out:mcpp.lib $(RELEASE_OBJS)

mcppd.lib: $(DEBUG_OBJS)
	lib /nologo /out:mcppd.lib $(DEBUG_OBJS)

clean:
	del /q $(RELEASE_OBJS)
	del /q $(DEBUG_OBJS)
	del /q mcpp.lib
	del /q mcppd.lib

