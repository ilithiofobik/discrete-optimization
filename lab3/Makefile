CFLAGS = -Wall -pedantic -O3

all:
	g++ $(CFLAGS) dijkstra.cpp ./src/*.cpp -I./inc -o dijkstra
	g++ $(CFLAGS) dial.cpp ./src/*.cpp -I./inc -o dial
	g++ $(CFLAGS) radixheap.cpp ./src/*.cpp -I./inc -o radixheap

clean:
	rm dijkstra
	rm dial
	rm radixheap

