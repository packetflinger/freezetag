#
# Quake2 gamei386.so Makefile for Linux 2.0
#
# Jan '98 by Zoid <zoid@idsoftware.com>
#
# Jan 2010 by QwazyWabbit <wabbit@clawos.org> 
# Modified for Linux Red Hat 4.x and GNU Make 3.81
# Do 'make depend' to build new dependencies file based on sources.
#
# ELF only
#
# Probably requires GNU make
#

# Jan 2010 by quadz:
# NOTE: added forced -m32 flags (i'm on x86_64 but want to build i386)
#


ARCH=i386
CC=gcc
BASE_CFLAGS=-Dstricmp=strcasecmp -D__linux__ -DLINUX

#use these cflags to optimize it
CFLAGS=$(BASE_CFLAGS) -DNDEBUG -m32 -O2 -g -ffast-math -funroll-loops -fomit-frame-pointer -fexpensive-optimizations -falign-loops=2 -falign-jumps=2 -falign-functions=2
#use these when debugging 
#CFLAGS=$(BASE_CFLAGS) -g

LDFLAGS=-ldl -lm
SHLIBEXT=so
SHLIBCFLAGS=-fPIC
SHLIBLDFLAGS=-shared

DO_CC=$(CC) $(CFLAGS) $(SHLIBCFLAGS) -o $@ -c $<

#############################################################################
# SETUP AND BUILD
# GAME
#############################################################################

.c.o:
	$(DO_CC)

# This is where you put the mod's source files
GAME_OBJS = freeze.o g_ai.o g_chase.o g_cmds.o g_combat.o g_func.o g_items.o g_main.o g_misc.o g_monster.o g_phys.o g_save.o g_spawn.o g_svcmds.o g_target.o g_trigger.o g_turret.o g_utils.o g_weapon.o gslog.o m_actor.o m_berserk.o m_boss2.o m_boss3.o m_boss31.o m_boss32.o m_brain.o m_chick.o m_flash.o m_flipper.o m_float.o m_flyer.o m_gladiator.o m_gunner.o m_hover.o m_infantry.o m_insane.o m_medic.o m_move.o m_mutant.o m_parasite.o m_soldier.o m_supertank.o m_tank.o p_client.o p_hud.o p_trail.o p_view.o p_weapon.o q_shared.o sl_packet.o stdlog.o


game$(ARCH).$(SHLIBEXT) : $(GAME_OBJS)
	$(CC) $(CFLAGS) $(SHLIBLDFLAGS) -o $@ $(GAME_OBJS)
	chmod 0755 $@
	ldd -r $@
#	cp $@ ..


#############################################################################
# MISC
#############################################################################

clean:
	-rm -f $(GAME_OBJS)
	-rm -f gamei386.so

depend:
	gcc -MM $(GAME_OBJS:.o=.c) > dependencies

-include dependencies
