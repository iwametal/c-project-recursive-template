/*
 * ============================================================================
 *
 *       Filename:  main.c
 *
 *    Description:  Main file of the project
 *
 *         Author:  Leo Andrade
 *
 * ============================================================================
 */

#include <stdio.h>
#include <stdlib.h>

#include "../utils/args.h"
#include "../utils/colors.h"


int
main (int argc, char* argv[])
{
    /* Read command line options */
    options_t options;
    options_parser(argc, argv, &options);

#ifdef DEBUG
    fprintf(stdout, BLUE "Command line options:\n" NO_COLOR);
    fprintf(stdout, BROWN "help: %d\n" NO_COLOR, options.help);
    fprintf(stdout, BROWN "version: %d\n" NO_COLOR, options.version);
    fprintf(stdout, BROWN "use colors: %d\n" NO_COLOR, options.use_colors);
    fprintf(stdout, BROWN "filename: %s\n" NO_COLOR, options.file_name);
#endif

    /* code */

    return EXIT_SUCCESS;
}
