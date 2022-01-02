#include <cmath>
#include <filesystem>
#include <iostream>
#include <string_view>
#include <vector>

#ifndef VERSION
#define VERSION "unknonw"
#endif

int version(const char *argv0) {
    std::cout << argv0 << ": v" VERSION << '\n';
    return 0;
}
int usage(const char *argv0) {
    std::cout << "Usage: " << argv0 << " [OPTIONS...] FILE [FILE...]\n"
              <<
        R"(
    -r              human readable format
    -n              print file name
    -k              use 1000 bytes per KB when calculating human redable values
    -h              print this message
    -v              print version number

node: if a file is not found it is skipped

return values
   -1: internal error
    0: ok
    1: argument error
    2: file does not exist
)";
    return 0;
}


void printReadable(double fsize, double bytesPerKB) {
    int i = 0;
    for (; fsize >= bytesPerKB; fsize /= bytesPerKB, ++i) {}
    std::cout << std::ceil(fsize * 10.) / 10. << "BKMGTPE"[i];
}


int main(int, char **argv) try {
    const auto busage = [argv]() { return usage(argv[0]); };
    const auto bversion = [argv]() { return version(argv[0]); };
    bool readable = false;
    bool filename = false;
    bool ignoreDash = false;
    double bytesPerKB = 1024;
    std::vector<std::string_view> files;
    for (const char *arg = *(++argv); arg; arg = *(++argv)) {
        if (arg[0] == '-' && !ignoreDash) {
            switch (arg[1]) {
                case 'h':
                    return busage();
                case 'v':
                    return bversion();
                case 'r':
                    readable = true;
                    break;
                case 'n':
                    filename = true;
                    break;
                case 'k':
                    bytesPerKB = 1000;
                    break;
                case '-':
                    if (arg[2] == '\0') {
                        ignoreDash = true;
                        break;
                    } else {
                        std::cerr << "long options are not supported. try `-h` for help\n";
                        return 1;
                    }
                default:
                    std::cerr << "unsupported flag -" << arg[1] << ". if -" << arg[1]
                              << " is a file name, pass `--` before it. try `-h` for more info.\n";
                    return 1;
            }
            continue;
        }
        files.push_back(arg);
    }
    for (const auto file : files) {
        try {
            const auto fsize = std::filesystem::file_size(file);
            if (filename) {
                std::cout << file << ": ";
            }
            if (readable) {
                printReadable(fsize, bytesPerKB);
            } else {
                std::cout << fsize;
            }
            std::putc('\n', stdout);

        } catch (const std::filesystem::filesystem_error &err) { std::cerr << err.what() << '\n'; }
    }
} catch (const std::exception &err) {
    std::cerr << "unexpected error: " << err.what() << '\n';
    return -1;
} catch (...) {
    std::cerr << "unknown error\n";
    return -1;
}
