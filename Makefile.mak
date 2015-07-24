# **********************************************************************
#
# Copyright (c) 2015 ZeroC, Inc. All rights reserved.
#
# **********************************************************************

PREFIX		= C:\mcpp-2.7.2

RELEASE_OBJS 	= Release\directive.obj \
		  Release\eval.obj \
		  Release\expand.obj \
		  Release\main.obj \
		  Release\mbchar.obj \
		  Release\support.obj \
		  Release\system.obj

DEBUG_OBJS 	= Debug\directive.obj \
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

install: mcpp.lib mcppd.lib
	@if not exist "$(PREFIX)\Release" mkdir "$(PREFIX)\Release"
	copy mcpp.lib $(PREFIX)\Release\mcpp.lib
	@if not exist "$(PREFIX)\Debug" mkdir "$(PREFIX)\Debug"
	copy mcppd.lib $(PREFIX)\Debug\mcppd.lib

clean:
	del /q $(RELEASE_OBJS)
	del /q $(DEBUG_OBJS)
	del /q mcpp.lib
	del /q mcppd.lib

