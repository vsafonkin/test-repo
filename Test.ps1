cd cppsample
clang -v -c -Wall check_prime.c -o check_prime.o
clang -v check_prime.o -o check_prime
echo "--------"
echo "113" | ./check_prime
