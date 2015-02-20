
MODULE := tools

#######################################################################
# Tools directory
#######################################################################

MAKE := \
	delua \
	imc2wav \
	int2flt \
	cosb2cos \
	meshb2obj \
	sklb2txt \
	animb2txt \
	setb2set \
	set2fig \
	til2bmp \
	unlab \
	mklab \
	vima \
	luac \
	patchex \
	diffr \
	patchr \
	bm2bmp \
	fixbik

# 	these below are not added because they depend on the ppm and bpm libraries
#	mat2ppm
#	bm2ppm


#
# Build rules for the tools
#

TOOL := diffr
TOOL_OBJS := diffr.o
TOOL_LDFLAGS := -lcommon -lz
include $(srcdir)/rules.mk

TOOL := patchr
TOOL_OBJS := patchr.o
TOOL_LDFLAGS := -lcommon -lz
include $(srcdir)/rules.mk

TOOL := delua
TOOL_OBJS := delua.o lua/liblua.a
include $(srcdir)/rules.mk

TOOL := mat2ppm
TOOL_OBJS := mat2ppm.o
TOOL_LDFLAGS := -lppm -lpbm
include $(srcdir)/rules.mk

TOOL := bmtoppm
TOOL_OBJS := bmtoppm.o
TOOL_LDFLAGS := -lppm -lpbm
include $(srcdir)/rules.mk

TOOL := imc2wav
TOOL_OBJS := imc2wav.o
include $(srcdir)/rules.mk

TOOL := int2flt
TOOL_OBJS := int2flt.o
include $(srcdir)/rules.mk

TOOL := cosb2cos
TOOL_OBJS := emi/cosb2cos.o
include $(srcdir)/rules.mk

TOOL := meshb2obj
TOOL_OBJS := emi/meshb2obj.o lab.o
include $(srcdir)/rules.mk

TOOL := animb2txt
TOOL_OBJS := emi/animb2txt.o lab.o
include $(srcdir)/rules.mk

TOOL := setb2set
TOOL_OBJS := emi/setb2set.o lab.o
include $(srcdir)/rules.mk

TOOL := sklb2txt
TOOL_OBJS := emi/sklb2txt.o lab.o
include $(srcdir)/rules.mk

TOOL := set2fig
TOOL_OBJS := set2fig.o
include $(srcdir)/rules.mk

TOOL := til2bmp
TOOL_OBJS := emi/til2bmp.o lab.o
TOOL_LDFLAGS := -lz
include $(srcdir)/rules.mk

TOOL := unlab
TOOL_OBJS := unlab.o lab.o
include $(srcdir)/rules.mk

TOOL := mklab
TOOL_OBJS := mklab.o
include $(srcdir)/rules.mk

TOOL := vima
TOOL_OBJS := vima.o
include $(srcdir)/rules.mk

TOOL := labcopy
TOOL_OBJS := labcopy.o
include $(srcdir)/rules.mk

TOOL := patchex
TOOL_OBJS := patchex/patchex.o patchex/mszipd.o patchex/cabd.o
include $(srcdir)/rules.mk

TOOL := bm2bmp
TOOL_OBJS := bm2bmp.o lab.o
include $(srcdir)/rules.mk

TOOL := fixbik
TOOL_OBJS := fixbik.o
include $(srcdir)/rules.mk

.PHONY: clean-tools tools
