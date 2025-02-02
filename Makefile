#
# Simple Makefile that compiles all .c and .s files in the same folder
#

# If you move this project you can change the directory 
# to match your GBDK root directory (ex: GBDK_HOME = "C:/GBDK/"
GBDK_HOME = ../../../

LCC = echo | $(GBDK_HOME)bin/lcc -Wl-m -yc

# You can uncomment the line below to turn on debug output
# LCC = $(LCC) -debug

# You can set the name of the .gb ROM file here
PROJECTNAME    = FIVER

BINS	    = $(PROJECTNAME).gb
CSOURCES   := $(wildcard *.c)
ASMSOURCES := $(wildcard *.s)
CHEADERS   := $(wildcard *.h)

all:	$(BINS)

encoded.h sizes.h: compress/compress5.py compress/full.txt compress/answers.txt
	cd compress && python3 compress5.py

compile.bat: Makefile
	@echo "REM Automatically generated from Makefile" > compile.bat
	@make -sn | sed y/\\//\\\\/ | grep -v make >> compile.bat

# Compile and link all source files in a single call to LCC
$(BINS):	$(CSOURCES) $(ASMSOURCES) $(CHEADERS)
	$(LCC) -o $@ $(CSOURCES) $(ASMSOURCES)

clean:
	rm -f *.o *.lst *.map *.gb *.ihx *.sym *.cdb *.adb *.asm

