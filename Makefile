CC=g++
CCFLAGS=-Wall -ansi -pedantic -std=c++11

OBJ=bin/variable.o bin/domain.o bin/factor.o bin/io.o bin/operations.o bin/inference.o bin/main.o

all: dbn

test: dbn
	valgrind --leak-check=full --dsymutil=yes --suppressions=dbn.supp ./dbn data/models/enough-sleep.duai data/models/enough-sleep.evidence

dbn: $(OBJ)
	$(CC) -o $@ $^

bin/%.o: src/%.cpp include/%.h
	$(CC) $(CCFLAGS) -I include/ -g -c -o $@ $<

bin/main.o: src/main.cpp
	$(CC) $(CCFLAGS) -I include/ -g -c -o $@ $<

.PHONY: clean

clean:
	rm -rfv dbn bin/*.o dbn.dSYM/
