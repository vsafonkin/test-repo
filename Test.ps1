cd cppsample
clang -v -c -Wall -std=c++14 main.cpp
clang -v -c -Wall -std=c++14 primes_in_range.cpp
clang -v -c -Wall -std=c++14 primes.cpp
clang main.o -o primes_in_range

echo "--------"
ls .
