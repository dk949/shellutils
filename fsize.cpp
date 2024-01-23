#include <cmath>
#include <cstdio>
#include <filesystem>
#include <functional>
#include <optional>
#include <string_view>
#include <vector>

#ifndef VERSION
#    define VERSION "unknonw"
#endif


template<auto err>
decltype(err) eputs(char const *str) {
    std::fputs(str, stderr);
    std::fputc('\n', stderr);
    return err;
}

template<auto err, typename... Ts>
decltype(err) eprintf(char const *fmt, Ts &&...args) {
    std::fprintf(stderr, fmt, args...);
    return err;
}

int version(char const *argv0) {
    std::printf("%s: " VERSION "\n", argv0);
    return 0;
}

enum struct Error { None, Some, Fatal };

struct Args {
    double bytes_per_kb = 1024;
    bool readable = false;
    bool file_name = false;
    bool ignore_dash = false;
    Error error = Error::Some;
};

using ParsedArgs = std::optional<std::pair<Args, std::vector<std::string_view>>>;

int usage(char const *argv0) {
    std::printf(R"(Usage: %s [-rnkfihv]... FILE [FILE...]
    -r              human readable format
    -n              print file name
    -k              use 1000 bytes per KB when calculating human redable values

    -e              on file error: print error and carry on (default)
    -f              on file error: exit
    -i              on file error: carry on

    -h              print this message
    -v              print version number

note: if multiple -f, -i or -e are specified, last argument takes precedence

return values
   -1: internal error
    0: ok (or errors ignored with -i)
    1: argument error
    2: one of the files does not exist
)",
        argv0);
    return 0;
}

ParsedArgs unsupportedFlag(char c) {
    return eprintf<std::nullopt>(
        "unsupported flag `-%c`. if `-%c` is a file name pass `--` before it. try `-h` for more info\n",
        c,
        c);
}

void printReadable(double fsize, double bytes_per_kb) {
    int i = 0;
    for (; fsize >= bytes_per_kb; fsize /= bytes_per_kb, ++i) { }
    printf("%.1f%c", std::ceil(fsize * 10.) / 10., "BKMGTPE"[i]);
}

Error printFiles(std::pair<Args, std::vector<std::string_view>> const &inp) {
    auto const &[args, files] = inp;
    bool error = false;
    for (auto const file : files) {
        try {
            auto const fsize = std::filesystem::file_size(file);
            if (args.file_name) std::printf("%.*s: ", int(file.size()), file.data());

            if (args.readable)
                printReadable(fsize, args.bytes_per_kb);
            else
                std::printf("%lu", fsize);

            std::putc('\n', stdout);

        } catch (std::filesystem::filesystem_error const &err) {
            switch (args.error) {
                using enum Error;
                case None: break;
                case Fatal: return eputs<Fatal>(err.what());
                case Some: eputs<0>(err.what()); error = true;
            }
        }
    }
    return error ? Error::Some : Error::None;
}

ParsedArgs parseArgs(char **argv) {
    auto const busage = std::bind_front(usage, argv[0]);
    auto const bversion = std::bind_front(version, argv[0]);

    Args args;
    std::vector<std::string_view> files;
    for (char const *arg = *(++argv); arg; arg = *(++argv)) {
        if (arg[0] == '-' && !args.ignore_dash) {
            int i = 1;
            for (; arg[i]; i++) {
                switch (arg[i]) {
                    case 'h': std::exit(busage());
                    case 'v': std::exit(bversion());
                    case 'r': args.readable = true; break;
                    case 'n': args.file_name = true; break;
                    case 'f': args.error = Error::Fatal; break;
                    case 'i': args.error = Error::None; break;
                    case 'e': args.error = Error::Some; break;
                    case 'k': args.bytes_per_kb = 1000; break;
                    case '-':
                        if (!arg[i + 1]) {
                            args.ignore_dash = true;
                            break;
                        } else
                            return eputs<std::nullopt>("long options are not supported. try `-h` for help");
                    default: return unsupportedFlag(arg[i]);
                }
            }
            if (i == 1) return unsupportedFlag(0);

        } else
            files.push_back(arg);
    }
    if (files.empty()) return eputs<std::nullopt>("No files specified");
    return std::pair {args, files};
}

int main(int, char **argv) try {

    if (auto ap = parseArgs(argv)) {
        switch (printFiles(*ap)) {
            using enum Error;
            case None: return 0;
            case Fatal: return eputs<2>("\nErrors are fatal");
            case Some: return eputs<2>("\nSome files caused errors");
        }
    } else
        return 1;

} catch (std::exception const &err) {

    return eprintf<-1>("unexpected error: \n", err.what());
} catch (...) {
    return eputs<-1>("unknown error");
}
