cd cppsample
clang -v -c -Wall main.cpp
clang -v -c -Wall primes_in_range.cpp
clang -v -c -Wall primes.cpp
clang main.o -o sample

echo "--------"
ls .
