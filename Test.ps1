Get-Command bash

gcc -Wall sample.c -o sample
ls .

git clone https://github.com/memcached/memcached
cd memcached
./autogen.sh
./configure
make
make test
