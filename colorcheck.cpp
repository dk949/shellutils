#include <cstring>
#include <iostream>
int main(int argc, const char **argv) {
    if (argc == 2) {
        if (std::strcmp(argv[1], "-v") == 0) {
            std::cout << argv[0] << ": v" VERSION << '\n';
            return 0;
        }
        if (std::strcmp(argv[1], "-h") == 0) {
            std::cout << "Usage: " << argv[0] << " -hv\n";
            return 0;
        }
        std::cerr << "Usage: " << argv[0] << " -hv\n";
        return 1;
    }
    if (argc > 2) {
        std::cerr << "Usage: " << argv[0] << " -hv\n";
        return 1;
    }


    for (int r = 0; r < 32; r++) {
        for (int g = 0; g < 32; g++) {
            for (int b = 0; b < 32; b++) {
                std::cout            //
                    << "\x1b[48;2;"  //
                    << r * 8 << ';'  //
                    << g * 8 << ';'  //
                    << b * 8         //
                    << "m \x1b[0m";  //
            }
        }
    }
    std::cout << '\n';
}
