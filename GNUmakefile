PREFIX?=	/usr/local
BINDIR?=	${PREFIX}/bin
MANDIR?=	${PREFIX}/man/man

PROG=		zz80asm

# flavors of Linux
ifeq ($(shell uname),Linux)
SRCS=		zz80asm.c num.c out.c pfun.c rfun.c tab.c
CFLAGS += -DLINUX
LIBTOOL = ldd
endif

# OS X wants to be Linux and FreeBSD too.
ifeq ($(shell uname),Darwin)
SRCS=		zz80asm.c num.c out.c pfun.c rfun.c tab.c
LIBTOOL = otool
endif

CLFAGS+=	-g
CFLAGS+=	-O2 -pipe
#CFLAGS+=	-Wall -Werror -Wextra -Wformat=2 -Wstrict-prototypes
CFLAGS+=	-Wall -Werror -pedantic -Wextra -Wformat=2
#CFLAGS+=	-Wmissing-declarations -pedantic -std=c99 -Wcast-qual
#CFLAGS+=	-Wpointer-arith -Wuninitialized -Wmissing-prototypes
#CFLAGS+=	-Wsign-compare -Wshadow -Wdeclaration-after-statement
#CFLAGS+=	-Wfloat-equal -Wcast-align -Wundef -Wstrict-aliasing=2

OBJS+=		${SRCS:.c=.o}

all: ${PROG} readme

${PROG}: ${OBJS}
	${CC} ${CFLAGS} ${LDFLAGS} -o $@ ${OBJS}

readme: ${PROG}.1
	mandoc ${PROG}.1 | col -bx > README

uninstall:
	rm ${BINDIR}/${PROG}
	rm ${MANDIR}1/${PROG}.1

clean:
	rm -f a.out [Ee]rrs mklog *.core y.tab.h ${PROG} *.o *.d

.PHONY: all readme uninstall clean
