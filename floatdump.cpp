static_assert(sizeof(unsigned long) == 8, "expected 64 bit unsigned long");
static_assert(sizeof(unsigned int) == 4, "expected 32 bit unsigned int");
static_assert(sizeof(unsigned short) == 2, "expected 16 bit unsigned short");
static_assert(sizeof(unsigned char) == 1, "expected 8 bit unsigned char");
static_assert(sizeof(long) == 8, "expected 64 bit long");
static_assert(sizeof(int) == 4, "expected 32 bit int");
static_assert(sizeof(short) == 2, "expected 16 bit short");
static_assert(sizeof(char) == 1, "expected 8 bit char");
static_assert(sizeof(long double) == 16, "expected 128 bit long double");
static_assert(sizeof(double) == 8, "expected 64 bit double");
static_assert(sizeof(float) == 4, "expected 32 bit float");
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>

#ifndef VERSION
#    define VERSION "unknonw"
#endif

int version(char const *argv0) {
    std::cout << argv0 << ": v" VERSION << '\n';
    return 0;
}

int usage(char const *argv0) {
    std::cout << "Usage: " << argv0 << " [OPTIONS...] [FILE]\n"
              <<
        R"(
    -b              use big endian
    -l              use little endian (default)
    -f              use fixed notation
    -s              use scientific notation (default)
    -float          decode as floating point numbers (default)
    -int            decode as integers
    -uint           decode as unsigned integers
    -bytes [NUM]    number of bytes in each decoded number (default 4)
    -h              print this message
    -v              print version number
    -n [NUM]        number of entries to print per line (default 4)
    -p [NUM]        precission (default 7)

mutually exclusive:
    -b and -l
    -f and -s
    -float, -int and -uint

note: if mutually exclusive options are used, only the last one in the list is taken into account

return values
    0: ok
    1: too few option parameters
    2: unsupported number of bytes for integer or floating point number

)";
    return 0;
}

template<typename Num>
void printNum(std::string const &input, int precision, bool sci, int numPerLine, bool big) {
    static int count = 0;
    static int charNum = 0;
    constexpr int size = sizeof(Num);

    static union {
        Num n;
        char c[sizeof(Num)];
    } u;

    for (auto const ch : input) {
        u.c[(big ? (size - 1) : 0) - (charNum++ % size) * (big ? 1 : -1)] = ch;
        if (charNum > (size - 1) && charNum % size == 0) {
            std::cout << (sci ? std::scientific : std::fixed) << std::setprecision(precision) << u.n
                      << ((count++) % numPerLine == numPerLine - 1 ? '\n' : ' ');
        }
    }
}

enum class Type { Float, Int, Uint };

int main(int argc, char const **argv) {
    int precision = 7;
    bool sci = true;
    int numPerLine = 4;
    bool big = false;
    Type type = Type::Float;
    int bytes = 4;
    char const *fileName = nullptr;
    auto const busage = [argv]() {
        return usage(argv[0]);
    };
    auto const bversion = [argv]() {
        return version(argv[0]);
    };
    for (char const *arg = *(++argv); arg; arg = *(++argv)) {
        if (std::strcmp(arg, "-b") == 0)
            big = true;
        else if (std::strcmp(arg, "-l") == 0)
            big = false;
        else if (std::strcmp(arg, "-f") == 0)
            sci = false;
        else if (std::strcmp(arg, "-s") == 0)
            sci = true;
        else if (std::strcmp(arg, "-float") == 0)
            type = Type::Float;
        else if (std::strcmp(arg, "-int") == 0)
            type = Type::Int;
        else if (std::strcmp(arg, "-uint") == 0)
            type = Type::Uint;
        else if (std::strcmp(arg, "-h") == 0)
            return busage();
        if (std::strcmp(arg, "-v") == 0) return bversion();
        if (std::strcmp(arg, "-n") == 0) {
            if (*(++argv) == nullptr) {
                std::cerr << "not enough arguments for option -n. try `-h` for help\n";
                return 1;
            }
            numPerLine = std::atoi(*argv);
            if (numPerLine < 1) {
                std::cerr << "number of lines has to be greater then 0\n";
                return 1;
            }
        } else if (std::strcmp(arg, "-p") == 0) {
            if (*(++argv) == nullptr) {
                std::cerr << "not enough arguments for option -p. try `-h` for help\n";
                return 1;
            }
            precision = std::atoi(*argv);
        } else if (std::strcmp(arg, "-bytes") == 0) {
            if (*(++argv) == nullptr) {
                std::cerr << "not enough arguments for option -bytes. try `-h` for help\n";
                return 1;
            }
            bytes = std::atoi(*argv);
        } else {
            fileName = arg;
        }
    }
    std::string input;
    auto file = std::ifstream(fileName);
    auto useFile = file.good();
    while (useFile ? file >> input : std::cin >> input) {
        if (type == Type::Float) {
            switch (bytes) {
                case 4: printNum<float>(input, precision, sci, numPerLine, big); break;
                case 8: printNum<double>(input, precision, sci, numPerLine, big); break;
                case 16: printNum<long double>(input, precision, sci, numPerLine, big); break;
                default: std::cerr << "unsupported floating point number with " << bytes << " bytes\n"; return 2;
            }
        } else if (type == Type::Int) {
            switch (bytes) {
                case 1: printNum<char>(input, precision, sci, numPerLine, big); break;
                case 2: printNum<short>(input, precision, sci, numPerLine, big); break;
                case 4: printNum<int>(input, precision, sci, numPerLine, big); break;
                case 8: printNum<long>(input, precision, sci, numPerLine, big); break;
                default: std::cerr << "unsupported integer number with " << bytes << " bytes\n"; return 2;
            }

        } else {
            switch (bytes) {
                case 1: printNum<unsigned char>(input, precision, sci, numPerLine, big);
                case 2: printNum<unsigned short>(input, precision, sci, numPerLine, big);
                case 4: printNum<unsigned int>(input, precision, sci, numPerLine, big);
                case 8: printNum<unsigned long>(input, precision, sci, numPerLine, big);
                default: std::cerr << "unsupported integer number with " << bytes << " bytes\n"; return 2;
            }
        }
    }
    std::cout << '\n';
    return 0;
}
