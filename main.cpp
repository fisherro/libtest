#include "lib.hpp"
#include <string>
#include <vector>

int main(const int argc, const char** argv)
{
    std::vector<std::string> args(argv + 1, argv + argc);
    if (args.empty()) {
        libtest("No arguments!");
    }
    for (const auto& arg: args) {
        libtest(arg);
    }
}
