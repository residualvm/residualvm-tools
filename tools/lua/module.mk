MODULE := tools/lua

MODULE_OBJS := \
	lapi.o \
	lauxlib.o \
	lbuffer.o \
	lbuiltin.o \
	ldo.o \
	lfunc.o \
	lgc.o \
	liolib.o \
	llex.o \
	lmathlib.o \
	lmem.o \
	lobject.o \
	lparser.o \
	lstate.o \
	lstring.o \
	lstrlib.o \
	ltable.o \
	ltask.o \
	ltm.o \
	lundump.o \
	lvm.o \
	lzio.o

# Include common rules
include $(srcdir)/rules.mk
