#ifndef GETOPT_H
#define GETOPT_H

extern int optind;
extern char *optarg;

#ifdef __cplusplus
extern "C" {
#endif

int getopt( int argc, char** argv, char* optstring );

#ifdef __cplusplus
}
#endif

#endif
