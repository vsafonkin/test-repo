Get-Command bash
Get-Command gcc

gcc -Wall sample.c -o sample


git clone https://github.com/memcached/memcached
cd memcached
bash.exe -c "./autogen.sh"
bash.exe -c "./configure"
make
make test
