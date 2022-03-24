#!/bin/bash

echo "Compile library object"
## To become a shared library, the -fPIC option is required
## This may be related to using std::cout in the code
g++ -fPIC -c lib.cpp

echo
echo "Compile main"
g++ -c main.cpp

echo
echo "Make static library"
ar rvs libtest.a lib.o

echo
echo "Make dynamic library"
g++ -shared -o libtest.so lib.o

echo
echo "Link statically"
g++ main.o libtest.a -o main-static

echo
echo "See that libtest isn't dynamically linked (but other things are)"
ldd main-static

echo
echo "Link more statically"
g++ -static main.o libtest.a -o main-staticer

echo
echo "See that main-staticer is completely static"
ldd main-staticer

echo
echo "Link dynamically"
g++ main.o libtest.so -o main-dynamic

echo
echo "See that main-dynamic dynamically links to libtest"
LD_LIBRARY_PATH=. ldd main-dynamic

echo
echo "Test them"
./main-static static
./main-staticer staticer
LD_LIBRARY_PATH=. ./main-dynamic dynamic

## It appears that using -L. -ltest prefers dynamic linking
# g++ main.o -L. -ltest -o main-also-dynamic

## But the -static flag can prevent that
# g++ -static main.o -L. -ltest -o main-also-static

## This also results in a static linking
# g++ main.o libtest.a -L. -o main
## As does this
# g++ main.o libtest.a -L. -ltest -o main
