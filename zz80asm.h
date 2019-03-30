/*
 * Copyright (c) 1987-2014 Udo Munk
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#ifndef ZZ80ASM_H
#define ZZ80ASM_H

#ifdef _WIN32
#include <windows.h>
#define PATH_MAX MAX_PATH
 /* Remap deprecated POSIX function names (C99) */
#define strdup _strdup
#define unlink _unlink
#endif

#include <limits.h>
#include <stdint.h>

#if defined(LINUX) && !defined(__APPLE__)
#include <linux/limits.h>
#endif

#if defined(LINUX) || defined(_WIN32)
#ifndef LINE_MAX
#define LINE_MAX 2048 /* minimum acceptable from GNU is _POSIX2_LINE_MAX or 2048 */ 
#endif
#include "getopt.h"
#endif

 /*
 *	various constants
 */
#define PROGNAME	"zz80asm"
#define REL		"1.6"
#define COPYR		"Copyright (C) 1987-2014 by Udo Munk"
#define SRCEXT		".asm"	/* filename extension source */
#define OBJEXTBIN	".bin"	/* filename extension object */
#define OBJEXTHEX	".hex"	/* filename extension hex */
#define LSTEXT		".lst"	/* filename extension listing */
#define ENDFILE		"END"	/* end of source */
#define MAXFN		512	/* max. no. source files */
#define SYMSIZE		8	/* max. symbol length */
#define INCNEST		5	/* max. INCLUDE nesting depth */
#define IFNEST		5	/* max IF.. nesting depth */
#define HASHSIZE	500	/* max. entries in symbol hash array */
#define OPCARRAY	256	/* size of object buffer */
#define SYMINC		100	/* start size of sorted symbol array */

enum {
	COMMENT		= ';',	/* inline comment character */
	LINCOM		= '*',	/* comment line if in column 1 */
	LABSEP		= ':',	/* label separator */
	STRSEP		= '\''	/* string separator */
};

enum {
	OUTBIN,			/* format of object: binary */
	OUTMOS,			/* format of object: Mostek binary */
	OUTHEX			/* format of object: Intel hex */
};

/*
 *	definition of operand symbols
 *	definitions for registers A, B, C, D, H, L and (HL)
 *	are defined as the bits used in operands and may not
 *	be changed!
 */
enum {
	REGB		= 0,	/* register B */
	REGC		= 1,	/* register C */
	REGD		= 2,	/* register D */
	REGE		= 3,	/* register E */
	REGH		= 4,	/* register H */
	REGL		= 5,	/* register L */
	REGIHL		= 6,	/* register indirect HL */
	REGA		= 7,	/* register A */
	REGI		= 8,	/* register I */
	REGR		= 9,	/* register R */
	REGAF		= 10,	/* register pair AF */
	REGBC		= 11,	/* register pair BC */
	REGDE		= 12,	/* register pair DE */
	REGHL		= 13,	/* register pair HL */
	REGIX		= 14,	/* register IX */
	REGIY		= 15,	/* register IY */
	REGSP		= 16,	/* register SP */
	REGIBC		= 17,	/* register indirect BC */
	REGIDE		= 18,	/* register indirect DE */
	REGIIX		= 19,	/* register indirect IX */
	REGIIY		= 20,	/* register indirect IY */
	REGISP		= 21,	/* register indirect SP */
	FLGNC		= 30,	/* flag no carry */
	FLGNZ		= 31,	/* flag not zero */
	FLGZ		= 32,	/* flag zero */
	FLGM		= 33,	/* flag minus */
	FLGP		= 34,	/* flag plus */
	FLGPE		= 35,	/* flag parity even */
	FLGPO		= 36,	/* flag parity odd */
	NOOPERA		= 98,	/* no operand */
	NOREG		= 99	/* operand isn't register */
};

/*
 *	definitions of error numbers for error messages in listfile
 */
enum err_type {
	E_ILLOPC	= 0,	/* illegal opcode */
	E_ILLOPE	= 1,	/* illegal operand */
	E_MISOPE	= 2,	/* missing operand */
	E_MULSYM	= 3,	/* multiple defined symbol */
	E_UNDSYM	= 4,	/* undefined symbol */
	E_VALOUT	= 5,	/* value out of bounds */
	E_MISPAR	= 6,	/* missing paren */
	E_MISHYP	= 7,	/* missing string separator */
	E_MEMOVR	= 8,	/* memory override (ORG) */
	E_MISIFF	= 9,	/* missing IF at ELSE or ENDIF */
	E_IFNEST	= 10,	/* to many IF's nested */
	E_MISEIF	= 11,	/* missing ENDIF */
	E_INCNEST	= 12	/* to many INCLUDE's nested */
};

/*
 *	definition fatal errors
 */
enum fatal_type {
	F_OUTMEM	= 0,	/* out of memory */
	F_HALT		= 1,	/* assembly halted */
	F_FOPEN		= 2,	/* can't open file */
	F_INTERN	= 3	/* internal error */
};

/*
 *	structure opcode table
 */
struct opc {
	char	*op_name;	/* opcode name */
	int	 (*op_fun)();	/* function pointer code generation */
	int	 op_c1;		/* first base opcode */
	int	 op_c2;		/* second base opcode */
};

/*
 *	structure operand table
 */
struct ope {
	char	*ope_name;	/* operand name */
	int	 ope_sym;	/* symbol value operand */
};

/*
 *	structure symbol table entries
 */
struct sym {
	struct	 sym *sym_next;	/* next entry */
	char	*sym_name;	/* symbol name */
	int	 sym_val;	/* symbol value */
};

/*
 *	structure nested INCLUDE's
 */
struct inc {
	char	*inc_fn;	/* filename */
	FILE	*inc_fp;	/* file pointer */
	size_t	 inc_line;	/* line counter for listing */
};

/*
 *	global variables other than CPU specific tables
 */
extern FILE	*srcfp;		/* file pointer for current source */
extern FILE	*objfp;		/* file pointer for object code */
extern FILE	*lstfp;		/* file pointer for listing */
extern FILE	*errfp;		/* file pointer for error output */

extern char	*srcfn;		/* filename of current processed source file */
extern char	 line[LINE_MAX];	/* buffer for one line source */
extern char	 tmp[LINE_MAX];		/* temporary buffer */
extern char	 label[SYMSIZE + 1];	/* buffer for label */
extern char	 operand[LINE_MAX];	/* buffer for operand */
extern char	 title[LINE_MAX];	/* buffer for title of source */

extern int	 ops[OPCARRAY];	/* buffer for generated object code */

extern uint8_t	 list_flag;	/* flag for option -l */
extern uint8_t	 ver_flag;	/* flag for option -v */
extern uint8_t	 dump_flag;	/* flag for option -x */
extern int	 pc;		/* program counter */
extern uint8_t	 pass;		/* processed pass */
extern int	 iflevel;	/* IF nesting level */
extern int	 gencode;	/* flag for conditional object code */
extern int	 errors;	/* error counter */
extern uint8_t	 sd_flag;	/* list flag for PSEUDO opcodes */
				/* = 0: addr from <val>, data from <ops> */
				/* = 1: addr from <sd_val>, data from <ops> */
				/* = 2: no addr, data from <ops> */
				/* = 3: addr from <sd_val>, no data */
				/* = 4: suppress whole line */
extern int	 sd_val;	/* output value for PSEUDO opcodes */
extern int	 prg_adr;	/* start address of program */
extern uint8_t	 out_form;	/* format of object file */

extern size_t	 c_line;	/* current line no. in current source */
extern size_t	 s_line;	/* line no. counter for listing */
extern size_t	 p_line;	/* no. printed lines on page */
extern size_t	 ppl;		/* page length */
extern size_t	 datalen;	/* number of bytes per hex record */

extern struct	sym *symtab[HASHSIZE];	/* symbol table */
extern struct	sym **symarray;		/* sorted symbol table */

/*
 *	function prototypes
 */
/* num.c */
int	eval(const char *s);
int	chk_v1(const int i);
int	chk_v2(const int i);

/* out.c */
void 	asmerr(enum err_type et);
void 	lst_header(void);
void 	lst_attl(void);
void 	lst_line(const int val, int opanz);
void 	lst_sort_sym(const size_t len);
void 	obj_header(void);
void 	obj_end(void);
void 	obj_writeb(size_t opanz, size_t len);
void 	obj_fill(int count);

/* pfun.c */
int 	op_org(void);
int 	op_equ(void);
int 	op_dl(void);
int 	op_ds(void);
int 	op_db(void);
int 	op_dm(void);
int 	op_dw(void);
int 	op_misc(const int op_code);
int 	op_cond(const int op_code);
int 	op_glob(const int op_code);

/* rfun.c */
int 	op_1b(const int), op_2b(const int, const int), op_pupo(const int);
int 	op_ex(void), op_ld(void), op_call(void), op_ret(void);
int 	op_jp(void), op_jr(void), op_djnz(void), op_rst(void);
int 	op_add(void), op_adc(void), op_sub(void), op_sbc(void), op_cp(void);
int 	op_inc(void), op_dec(void), op_or(void), op_xor(void), op_and(void);
int 	op_rl(void), op_rr(void), op_sla(void), op_sra(void), op_srl(void);
int 	op_rlc(void), op_rrc(void);
int 	op_out(void), op_in(void), op_im(void);
int 	op_set(void), op_res(void), op_bit(void);

/* tab.c */
struct opc	*search_op(const char * const);
struct sym	*get_sym(const char * const);
int		 put_sym(const char * const, const int);
int		 get_reg(const char * const);
void		 put_label(void);
size_t		 copy_sym(void);
void		 sort_sym(const size_t, int);

/* zz80asm.c */
#if defined _WIN32
void _declspec(noreturn) fatal(enum fatal_type ft, const char * const arg);
#else
void fatal(enum fatal_type ft, const char * const arg) __attribute__((noreturn));
#endif
void 	p1_file(char * const);
void 	p2_file(char * const);

#if !defined(__APPLE__)
/* strlcat.c */
size_t strlcat(char *dst, const char *src, size_t size);

/* strlcpy.c */
size_t strlcpy(char *dst, const char *src, size_t size);
#endif
#endif /* ZZ80ASM_H */
