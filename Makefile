PAL=1
NTSC=0
VESA=0
MOUSE=0
IOPRESET=1

EE_OBJS =\
	src/chase.o \
	src/cl_demo.o \
	src/cl_input.o \
	src/cl_main.o \
	src/cl_parse.o \
        src/cl_tent.o \
	src/cmd.o \
	src/common.o \
	src/console.o \
	src/crc.o \
	src/cvar.o \
	src/draw.o \
        src/d_edge.o \
	src/d_fill.o \
	src/d_init.o \
	src/d_modech.o \
	src/d_part.o \
	src/d_polyse.o \
	src/d_scan.o \
	src/d_sky.o \
	src/d_sprite.o \
	src/d_surf.o \
	src/d_vars.o \
	src/d_zpoint.o \
	src/host.o \
	src/host_cmd.o \
	src/keys.o \
	src/menu.o \
	src/mathlib.o \
	src/model.o \
	src/nonintel.o \
	src/pr_cmds.o \
	src/pr_edict.o \
	src/pr_exec.o \
	src/r_aclip.o \
	src/r_alias.o \
	src/r_bsp.o \
	src/r_light.o \
	src/r_draw.o \
	src/r_efrag.o \
	src/r_edge.o \
	src/r_misc.o \
	src/r_main.o \
	src/r_sky.o \
	src/r_sprite.o \
	src/r_surf.o \
	src/r_part.o \
	src/r_vars.o \
	src/screen.o \
	src/sbar.o \
	src/sv_main.o \
	src/sv_phys.o \
	src/sv_move.o \
	src/sv_user.o \
	src/zone.o	\
	src/view.o	\
	src/wad.o \
	src/world.o \
	src/cd_null.o \
	src/net_vcr.o \
	src/net_main.o \
	src/net_loop.o \
	src/net_none.o \
	src/sys_ps2.o \
        src/snd_null.o \
	src/in_ps2.o \
	src/ps2_gs.o \
	src/vid_ps2.o \
        obj/usbd_irx.o \
	obj/usbhdfsd_irx.o \
	obj/iomanx_irx.o \
	src/ps2.o \
	src/pad.o 

EE_BIN = quake.elf

EE_LIBS = -lmouse -lkbd -lm -lc -lkernel -lpad

EE_INCS :=  -I$(PS2SDK)/sbv/include -I$(PS2SDK)/ports/include/SDL -I$(PS2SDK)/ee/include -I$(PS2DEV)/ee/ee/include

EE_CFLAGS = -g -Dstricmp=strcasecmp -funroll-loops -fomit-frame-pointer -fexpensive-optimizations

EE_LDFLAGS := -L$(PS2SDK)/sbv/lib -L$(PS2SDK)/ports/lib

ifeq ($(_PAL), 1)
	 EE_CFLAGS += -D_PAL
endif
ifeq ($(_NTSC), 1)
	 EE_CFLAGS += -D_NTSC
endif
ifeq ($(_VESA), 1)
	 EE_CFLAGS += -D_VESA
endif
ifeq ($(_MOUSE), 1)
	 EE_CFLAGS += -D_MOUSE
endif
ifeq ($(_IOPRESET), 1)
	 EE_CFLAGS += -D_IOPRESET
endif

all: $(EE_BIN)
	 mv $(EE_BIN) bin/

clean:
	rm -f $(EE_BIN) $(EE_OBJS)

run:
	ps2client -h 10.0.0.10 execee host:$(EE_BIN)

obj/usbd_irx.s:
	bin2s irx/usbd.irx obj/usbd_irx.s usbd_irx
obj/usbhdfsd_irx.s:
	bin2s irx/usbhdfsd.irx obj/usbhdfsd_irx.s usbhdfsd_irx
obj/iomanx_irx.s:
	bin2s irx/iomanx.irx obj/iomanx_irx.s iomanx_irx	
	
include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal
