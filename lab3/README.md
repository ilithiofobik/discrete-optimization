## Table of contents
* [Author](#author)
* [Files](#files)
* [Running programs](#running)

## Author: 
Wojciech Sęk

## Files:
The code was divided into three files with algorithms and one file with functions to read files:
* `dijsktra.cpp` - implementation of generic dijkstra algorithm
* `dial.cpp` - implementation of Dial modification of Dijkstra
* `radixheap.cpp` - implementation of Radix Heap algorithm
* `graphio.cpp` - methods to read files, with the header `graphio.h`
## Running:
* To compile all the files please do use make command. It will result in three binary files named dijkstra, dial and radixheap.
* To find the shortest paths between given pairs of nodes use\
`"algorithm" -d file_with_data.gr -ss sources.ss -oss results.ss.res`\
where algorithm is `dijkstra`,  `dial` or `radixheap` and `-d` is the source files with the graph, `-ss` means it should calculate shortest paths between sources in `sources.ss` file and every other node, and `-oss` means the results should be written in `results.ss.res` file.
* To find the shortest paths between given pairs of nodes use\
`"algorithm" -d file_with_data.gr -p2p pairs.p2p -op2p results.p2p.res`\
where algorithm is `dijkstra`,  `dial` or `radixheap` and `-d` is the source files with the graph, `-p2p` means it should calculate shortest paths between pairs in `pairs.p2p` file and `-op2p` means the results should be written in `results.p2p.res` file.