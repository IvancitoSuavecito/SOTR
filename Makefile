#Make

EXE:=test
EXE1:=test_g
EXE2:=test_uclibc.xtn	
EXE3:=test_g_uclibc.xtn	

CC = gcc
LD = ld

MYCFLAGS = -DTEST1 -I./include

ADDFLAG = -I./include
TARGET_PREFIX = /usr/x86_64-linux-uclibc
STARTUP_FILES = ${TARGET_PREFIX}/usr/lib/crt1.o ${TARGET_PREFIX}/usr/lib/crti.o
END_FILES = ${TARGET_PREFIX}/usr/lib/crtn.o
LINKED_FILES = ${STARTUP_FILES} ${OBJS} ${END_FILES}
LIBS = -lc
USER_CFLAGS += -static -nostdlib ${LINKED_FILES} -L${TARGET_PREFIX}/usr/lib ${LIBS}

INC_DIR =/include
all:$(EXE1) $(EXE) $(EXE2) $(EXE3)
default: $(EXE)

#Reglas:+
$(EXE): hello.c
		$(CC) -I./include $< -o $@
$(EXE1): g.c hello.c
		$(CC) $(MYCFLAGS) -o $@ $^
hola.o: hola.c
		$(CC) -I./include $< -c -o $@
g.o: g.c
		$(CC) -DTEST1 -I./include $< -c -o $@
$(EXE2): hola.o
		$(LD) $< $(USER_CFLAGS) -o $@
		rm -v hello.o
		$(CC) $(MYCFLAGS) hello.c -c -o hello.o
$(EXE3): g.o hola.o
		$(LD) $^ $(USER_CFLAGS) -o $@
clean:
		@rm -v $(EXE) $(EXE1) $(EXE2) $(EXE3) *.o
