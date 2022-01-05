#include <filesystem>
#include <fstream>
#include <iostream>
#include <optional>
#include <string_view>
namespace fs = std::filesystem;

#ifndef VERSION
#define VERSION "unknonw"
#endif

std::optional<fs::path> getShabang(const fs::path path) {
    auto f = std::ifstream(path);
    std::string shebang;
    std::getline(f, shebang);
    if (!f.good() || shebang.size() < 3 || std::string_view {std::begin(shebang), std::begin(shebang) + 2} != "#!")
        return std::nullopt;
    return fs::path {std::begin(shebang) + 3, std::end(shebang)};
}

void print(const char *type, const fs::path &path) {
    std::cout << std::setw(7) << std::right << type << ' ' << std::right << path.c_str() << '\n';
}

int main(int argc, const char **argv) {
    if (argc != 1) {
        if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'v') {
            std::cout << argv[0] << ": v" VERSION << '\n';
            return 0;
        }
        std::cerr << "Usage: " << argv[0] << " -h -v\n";
        return 1;
    }

    for (const auto &entry : fs::directory_iterator(".")) {
        if (entry.is_regular_file()) {
            if (const auto shebang = getShabang(entry.path())) {
                print(shebang->filename().c_str(), entry.path().filename());
                continue;
            }
            print("0", entry.path().filename());
        }
    }
}
