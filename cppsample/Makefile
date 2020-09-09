OBJS := \
	main.o \
	primes.o \
	primes_in_range.o \

OUTFILE := primes_in_range

.PHONY: all clean

all: $(OUTFILE)

$(OBJS): %.o: %.cpp
	clang -v -c -Wall -std=c++14 $< -o $@

$(OUTFILE): $(OBJS)
	clang $(OBJS) -o $(OUTFILE)

clean:
	rm -f *.o $(OUTFILE)
