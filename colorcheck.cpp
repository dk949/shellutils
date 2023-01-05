#include <stdlib.h>

#include <array>
#include <cstring>
#include <iostream>

#ifndef VERSION
#    define VERSION "unknonw"
#endif

constexpr std::array toStr = []() {
    std::array<char[3], 256> ret;
    for (int i = 0; i < 256; i++) {
        ret[i][0] = (i / 100) + '0';
        ret[i][1] = (i % 100) / 10 + '0';
        ret[i][2] = (i % 10) + '0';
    }
    return ret;
}();

constinit std::array buf = []() {
    constexpr auto emptyColor = "\x1b[48;2;000;000;000m \x1b[0m";
    constexpr auto len = std::char_traits<char>::length(emptyColor);
    std::array<char[len], 256> ret;
    for (int b = 0; b < 256; b++) {
        std::char_traits<char>::copy(ret[b], emptyColor, len);
        ret[b][15] = toStr[b][0];
        ret[b][16] = toStr[b][1];
        ret[b][17] = toStr[b][2];
    }
    return ret;
}();

int main(int argc, char const **argv) {
    if (argc != 1) {
        if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'v') {
            std::cout << argv[0] << ": v" VERSION << '\n';
            return 0;
        }
        std::cerr << "Usage: " << argv[0] << " -h -v\n";
        return 1;
    }

    for (int r = 0; r < 256; r++) {
        for (int g = 0; g < 256; g++) {
            for (int b = 0; b < 256; b++) {
                buf[b][7] = toStr[r][0];
                buf[b][8] = toStr[r][1];
                buf[b][9] = toStr[r][2];

                buf[b][11] = toStr[g][0];
                buf[b][12] = toStr[g][1];
                buf[b][13] = toStr[g][2];
            }
            std::fwrite(buf.data(), sizeof(char), sizeof(buf), stdout);
        }
    }
    std::putc('\n', stdout);
}
