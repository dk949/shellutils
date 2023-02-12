#include <cstdio>
#include <iostream>
#include <ranges>
#include <string>
#include <string_view>
#include <tuple>

#ifndef VERSION
#    define VERSION "unknonw"
#endif

namespace rng = std::ranges;
namespace vie = std::views;
using namespace std::string_view_literals;

constexpr auto BUFSZ = 10;

template<int ec, typename... Args>
void die(Args &&...args) {
    (std::cerr << ... << args) << '\n';
    std::exit(ec);
}

std::string readOutput(FILE *fp) {
    static char buf[BUFSZ];
    std::string out;
    while (true) {
        auto const read = fread(buf, sizeof(char), BUFSZ - 1, fp);
        buf[read] = 0;
        out += buf;
        if (read != BUFSZ - 1) break;
    }
    return out;
}

std::string getStdout(std::string_view cmd) {
    FILE *pipe = popen(cmd.data(), "r");
    auto out = readOutput(pipe);
    if (pclose(pipe)) die<1>("Command `", cmd, "` failed");
    return out;
}

template<typename S1, typename S2, typename... Strs>
bool isOneOf(S1 match, S2 str, Strs... strs) {
    if constexpr (sizeof...(strs) == 0)
        return match == str;
    else
        return match == str || isOneOf(match, strs...);
}

#define IF_ARG(arg, ...) if (isOneOf(arg, __VA_ARGS__))

struct Args {
private:
    Args() = default;
public:
    char const *input = nullptr;
    char const *file = nullptr;
    bool no_demangle : 1 = false;
    bool all_symbols : 1 = false;
    bool line_numbers: 1 = false;
    bool undefined   : 1 = false;
    bool data        : 1 = false;
    bool std         : 1 = false;

    Args(int argc, char **argv) {
        for (int i = 1; i < argc; i++) {
            auto const arg = std::string_view {argv[i]};
            IF_ARG (arg, "-h", "--help")
                die<0>("Usage: ",
                    argv[0],
                    R"( [OPTIONS...] FILE
                    -n --no-demangle          Do not try to demangle symbol names
                    -a --all-symbols          Print all symbols, not just extern
                    -l --line-numbers         Print line numbers (reuires debug symbols)
                    -u --undefined            Print both defined and undefined symbols
                    -f --file FILE            Only print symbols from this translation unit
                    -d --data                 Include symbols from `.bss` and `.data` sections (static values)
                       --std                  Include symbols from the 'std::' namespace (C++ only)
)");
            else IF_ARG (arg, "-v", "--version")
                die<0>(argv[0], " v" VERSION);
            else IF_ARG (arg, "-n", "--no-demangle")
                no_demangle = true;
            else IF_ARG (arg, "-a", "--all-symbols")
                all_symbols = true;
            else IF_ARG (arg, "-l", "--line-numbers")
                line_numbers = true;
            else IF_ARG (arg, "-u", "--undefined")
                undefined = true;
            else IF_ARG (arg, "-d", "--data")
                data = true;
            else IF_ARG (arg, "--std")
                std = true;
            else IF_ARG (arg, "-f", "--file") {
                if (!argv[i + 1]) die<1>("Expected filename after argument ", arg);
                file = argv[++i];
            } else if (arg[0] == '-')
                die<1>("Unknonw flag ", arg);
            else
                input = argv[i];
        }
        if (!input) die<1>("Input file required");
    }
};

int main(int argc, char **argv) {
    auto const args = Args(argc, argv);
    std::string cmd = "nm ";
    if (!args.all_symbols) cmd += "-g ";
    if (!args.undefined) cmd += "--defined-only ";
    if (!args.no_demangle) cmd += "-C ";
    if (args.line_numbers) cmd += "-l ";
    cmd += args.input;
    auto const out = getStdout(cmd);
    for (auto const &x : vie::split(out, '\n')) {
        auto const line = [&] {
            auto const tmp = std::string_view {x.begin(), x.end()};
            return (tmp.size() > 17 ? tmp.substr(17) : tmp);
        }();
        std::cout << line << "\n\n";
    }
}
