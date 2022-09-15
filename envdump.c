#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char sep = '\n';
static bool csv = false;

void parseArgs(char const *const *argv) {
    for (char const *const *it = argv; *it; it++) {
        if ((*it)[0] == '-') {
            switch ((*it)[1]) {
                case 0:
                    puts("expected option after -");
                    exit(1);
                case 'h':
                    printf("Usage: %s [OPTIONS]\n"
                           "\n"
                           "  -0    Use NULL as a seporator between records\n"
                           "  -c    Output in CSV format (col 0: variable name, col 1: variable value)\n"
                           "  -h    Print this message\n"
                           "\n",
                        argv[0]);
                    exit(0);
                case 'v':
                    printf("%s v" VERSION "\n", argv[0]);
                    exit(0);
                case '0':
                    sep = 0;
                    if (csv) {
                        puts("-c and -0 are incompatible");
                        exit(1);
                    }
                    break;
                case '-':
                    puts("Long options (e.g. --thing) are not supported. Use -h for help");
                    exit(1);
                case 'c':
                    csv = true;
                    if (sep != '\n') {
                        puts("-0 and -c are incompatible");
                        exit(1);
                    }
                    break;
                default:
                    printf("Unrecognised option -%c\n", (*it)[1]);
                    exit(1);
            }
        }
    }
}

int main(int argc, char const *const *argv, char *const *env) {
    (void)argc;
    parseArgs(argv);

    if (csv) {
        for (char *const *it = env; *it; it++)
            for (char *letter = *it; *letter; letter++)
                if (*letter == '=') {
                    *letter = ',';
                    continue;
                }
    }

    for (char *const *it = env; *it; it++)
        printf("%s%c", *it, sep);

    return 0;
}
