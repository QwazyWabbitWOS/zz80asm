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

/*
 *	module for output functions to list, object and error files
 */

#include <stdio.h>
#include <string.h>

#include "zz80asm.h"

static void	flush_hex(void);
static int	chksum(void);
static void	btoh(const unsigned char, char ** const);

static char	*errmsg[] = {		/* error messages for asmerr() */
	"illegal opcode",           /* 0 */
	"illegal operand",          /* 1 */
	"missing operand",          /* 2 */
	"multiply defined symbol",  /* 3 */
	"undefined symbol",         /* 4 */
	"value out of range",       /* 5 */
	"missing )",                /* 6 */
	"missing string separator", /* 7 */
	"memory override",          /* 8 */
	"missing IF",               /* 9 */
	"IF nesting to deep",       /* 10 */
	"missing ENDIF",            /* 11 */
	"INCLUDE nesting to deep"   /* 12 */
};

#define MAXHEX 255			/* max num of bytes per hex record */

size_t		p_line;			/* no. printed lines on page */

static unsigned	short hex_adr;		/* current address in hex record */
static size_t	hex_cnt;		/* current no bytes in hex buffer */

static unsigned	char hex_buf[MAXHEX];	/* buffer for one hex record */
static char	hex_out[MAXHEX * 2 + 11]; /* ASCII buffer for one hex record */

static int	errnum = 0;		/* error number in pass 2 */

/*
 *	print error message to listfile and increase error counter
 */
void
asmerr(enum err_type et)
{
	if (pass == 1) {
		fprintf(errfp, "\nError in file: %s Line: %zu\n", srcfn, c_line);
		fprintf(errfp, "%s \n", line);
		fprintf(errfp, "%s\n", errmsg[et]);
	}

	if (verbose) {
		fprintf(stdout, "\nError in file: %s Line: %zu \n", srcfn, c_line);
		fprintf(stdout, "%s \n", line);
		fprintf(stdout, "%s\n", errmsg[et]);
		errnum = et;
	}
	errors++;
}

/*
 *	begin new page in listfile
 */
void
lst_header(void)
{
	static size_t	page = 0;	/* no. of pages for listing */

	fprintf(lstfp, "\f%s\t\tRelease %s\t\t\t\tPage %zu\n",
	    __progname, REL, ++page);
	fprintf(lstfp, "File:  %s\n", srcfn);
	fprintf(lstfp, "Date:  %s", date);
	fprintf(lstfp, "Title: %s\n", title);
	p_line = 4;
}

/*
 *	print header for source lines
 */
void
lst_attl(void)
{
	fprintf(lstfp, "\nLOC   OBJECT CODE   LINE   STMT SOURCE CODE\n");
	p_line += 2;
}

/*
 *	print one line into listfile if -l option set
 */
void
lst_line(const int val, int opanz)
{
	int	i;

	if (!list_flag || sd_flag == 4) {
		sd_flag = 0;
		return;
	}
	if ((ppl != 0) && ((p_line >= ppl) || (c_line == 1))) {
		lst_header();
		lst_attl();
	}
	switch (sd_flag) {
	case 0:
		fprintf(lstfp, "%04X  ", val & 0xffff);
		break;
	case 1:
		fprintf(lstfp, "%04X  ", sd_val & 0xffff);
		break;
	case 2:
		fprintf(lstfp, "      ");
		break;
	case 3:
		fprintf(lstfp, "%04X              ", sd_val & 0xffff);
		goto no_data;
	default:
		fatal(F_INTERN, "illegal listflag for function lst_line");
		/* NOTREACHED */
	}
	if (opanz >= 1)
		fprintf(lstfp, "%02X ", ops[0] & 0xff);
	else
		fprintf(lstfp, "   ");
	if (opanz >= 2)
		fprintf(lstfp, "%02X ", ops[1] & 0xff);
	else
		fprintf(lstfp, "   ");
	if (opanz >= 3)
		fprintf(lstfp, "%02X ", ops[2] & 0xff);
	else
		fprintf(lstfp, "   ");
	if (opanz >= 4)
		fprintf(lstfp, "%02X ", ops[3] & 0xff);
	else
		fprintf(lstfp, "   ");
no_data:
	fprintf(lstfp, "%6zu %6zu %s", c_line, s_line, line);
	if (errnum) {
		fprintf(errfp, "=> %s\n", errmsg[errnum]);
		errnum = 0;
		p_line++;
	}
	sd_flag = 0;
	p_line++;
	if (opanz > 4 && sd_flag == 0) {
		opanz -= 4;
		i = 4;
		sd_val = val;
		while (opanz > 0) {
			if ((ppl != 0) && (p_line >= ppl)) {
				lst_header();
				lst_attl();
			}
			s_line++;
			sd_val += 4;
			fprintf(lstfp, "%04X  ", sd_val & 0xffff);
			if (opanz-- > 0)
				fprintf(lstfp, "%02X ", ops[i++] & 0xff);
			else
				fprintf(lstfp, "   ");
			if (opanz-- > 0)
				fprintf(lstfp, "%02X ", ops[i++] & 0xff);
			else
				fprintf(lstfp, "   ");
			if (opanz-- > 0)
				fprintf(lstfp, "%02X ", ops[i++] & 0xff);
			else
				fprintf(lstfp, "   ");
			if (opanz-- > 0)
				fprintf(lstfp, "%02X ", ops[i++] & 0xff);
			else
				fprintf(lstfp, "   ");
			fprintf(lstfp, "%6zu %6zu\n", c_line, s_line);
			p_line++;
		}
	}
}

/*
 *	print sorted symbol table into listfile
 */
void
lst_sort_sym(const size_t len)
{
	size_t	i, j;

	p_line = j = 0;
	strncpy(title, "Symbol table", sizeof(title));
	if (ppl == 0)
		fprintf(lstfp, "\n");
	for (i = 0; i < len; i++) {
		if ((ppl != 0) && (p_line == 0)) {
			lst_header();
			fprintf(lstfp, "\n");
			p_line++;
		}
		fprintf(lstfp, "%-8s %04X\t", symarray[i]->sym_name,
		    symarray[i]->sym_val & 0xffff);
		if (++j == 4) {
			fprintf(lstfp, "\n");
			if (p_line++ >= ppl)
				p_line = 0;
			j = 0;
		}
	}
}

/*
 *	write header record into object file
 */
void
obj_header(void)
{
	switch (out_form) {
	case OUTBIN:
		break;
	case OUTMOS:
		putc(0xff, objfp);
		putc(prg_adr & 0xff, objfp);
		putc(prg_adr >> 8, objfp);
		break;
	case OUTHEX:
		hex_adr = (unsigned short)prg_adr;
		break;
	}
}

/*
 *	write end record into object file
 */
void
obj_end(void)
{
	switch (out_form) {
	case OUTBIN:
	case OUTMOS:
		break;
	case OUTHEX:
		flush_hex();
		fprintf(objfp, ":00000001FF\n");
		break;
	}
}

/*
 *	write opcodes in ops[] into object file
 */
void
obj_writeb(size_t opanz, size_t len)
{
	int	i;

	switch (out_form) {
	case OUTBIN:
	case OUTMOS:
		for (i = 0; i < (int) opanz; i++)
			fwrite(&ops[i], 1, 1, objfp);
		break;
	case OUTHEX:
		for (i = 0; opanz; opanz--) {
			if (hex_cnt >= len)
				flush_hex();
			hex_buf[hex_cnt++] = (unsigned char)ops[i++];
		}
		break;
	}
}

/*
 *	write <count> bytes 0xff into object file
 */
void
obj_fill(int count)
{
	switch (out_form) {
	case OUTBIN:
	case OUTMOS:
		while (count--)
			putc(0xff, objfp);
		break;
	case OUTHEX:
		flush_hex();
		hex_adr += (unsigned short) count;
		break;
	}
}

/*
 *	create a hex record in ASCII and write into object file
 */
static void
flush_hex(void)
{
	char	*p;
	size_t	 i;

	if (!hex_cnt)
		return;
	p = hex_out;
	*p++ = ':';
	btoh((unsigned char)hex_cnt, &p);
	btoh((unsigned char)(hex_adr >> 8), &p);
	btoh((unsigned char)(hex_adr & 0xff), &p);
	*p++ = '0';
	*p++ = '0';
	for (i = 0; i < hex_cnt; i++)
		btoh(hex_buf[i], &p);
	btoh((unsigned char) chksum(), &p);
	*p++ = '\n';
	*p = '\0';
	fwrite(hex_out, 1, strlen(hex_out), objfp);
	hex_adr += (unsigned short) hex_cnt;
	hex_cnt = 0;
}

/*
 *	convert unsigned char into ASCII hex and copy to string at p
 *	increase p by 2
 */
static void
btoh(const unsigned char byte, char ** const p)
{
	unsigned char	c;

	c = byte >> 4;
	*(*p)++ = (c < 10) ? (char)(c + '0') : (char)(c - 10 + 'A');
	c = byte & 0xf;
	*(*p)++ = (c < 10) ? (char)(c + '0') : (char)(c - 10 + 'A');
}

/*
 *	compute checksum for Intel hex record
 */
static int
chksum(void)
{
	size_t	i, sum;

	sum = hex_cnt;
	sum += hex_adr >> 8;
	sum += hex_adr & 0xff;
	for (i = 0; i < hex_cnt; i++)
		sum += hex_buf[i] & 0xff;
	return (0x100 - (sum & 0xff));
}
