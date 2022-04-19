#include <stdio.h>
#include <string.h>
#include <time.h>

#include <fstream>
#include <iostream>
#include <limits>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#include "graphio.h"

void heapify(std::vector<std::pair<unsigned int, int>> &H, int i) {
    int size = H.size();
    int left = 2 * i + 1;
    int right = 2 * i + 2;
    if (right < size && H[right] < H[i]) {
        if (H[right] < H[left]) {
            std::pair<unsigned int, int> tmp = H[right];
            H[right] = H[i];
            H[i] = tmp;
            heapify(H, right);
        } else {
            std::pair<unsigned int, int> tmp = H[left];
            H[left] = H[i];
            H[i] = tmp;
            heapify(H, left);
        }
    } else if (left < size && H[left] < H[i]) {
        std::pair<unsigned int, int> tmp = H[left];
        H[left] = H[i];
        H[i] = tmp;
        heapify(H, left);
    }
}

int extract_min(std::vector<std::pair<unsigned int, int>> &H) {
    int min = H[0].second;
    H[0] = H.back();
    H.pop_back();
    heapify(H, 0);
    return min;
}

void decrease_key(std::vector<std::pair<unsigned int, int>> &H, int key,
                  int new_val) {
    int i = 0;
    while (H[i].second != key) {
        i++;
    }
    H[i].first = new_val;
    int parent = (i - 1) / 2;
    while (i > 0 && H[i] < H[parent]) {
        std::pair<unsigned int, int> tmp = H[parent];
        H[parent] = H[i];
        H[i] = tmp;
        i = parent;
        parent = (i - 1) / 2;
    }
}

void insert(std::vector<std::pair<unsigned int, int>> &H,
            std::pair<unsigned int, int> new_val) {
    H.push_back(new_val);
    int i = H.size() - 1;
    int parent = (i - 1) / 2;
    while (i > 0 && H[parent] > new_val) {
        H[i] = H[parent];
        i = parent;
        parent = (i - 1) / 2;
    }
    H[i] = new_val;
}

unsigned int *dijkstra(int s, int &n, int &m,
                       std::unordered_map<int, std::unordered_set<int>> &arcs,
                       int **&cost) {
    std::vector<std::pair<unsigned int, int>> H;
    unsigned int *d = (unsigned int *)malloc((n + 1) * sizeof(unsigned int));
    for (int i = 1; i <= n; i++) {
        d[i] = std::numeric_limits<unsigned int>::max();
    }
    d[s] = 0;
    insert(H, std::make_pair(d[s], s));
    while (!H.empty()) {
        int i = extract_min(H);
        for (int j : arcs[i]) {
            unsigned int value = d[i] + cost[i][j];
            if (d[j] > value) {
                if (d[j] == std::numeric_limits<unsigned int>::max()) {
                    d[j] = value;
                    insert(H, std::make_pair(value, j));
                } else {
                    d[j] = value;
                    decrease_key(H, j, value);
                }
            }
        }
    }
    return d;
}

int main(int argc, char **argv) {
    const char *graph_filename = "";
    const char *source_filename = "";
    const char *result_filename = "";
    char problem = 's';

    for (int i = 1; i < argc; i++) {
        if (!strcmp(argv[i], "-d")) {
            i++;
            graph_filename = argv[i];
        } else if (!strcmp(argv[i], "-ss")) {
            problem = 's';
            i++;
            source_filename = argv[i];
        } else if (!strcmp(argv[i], "-oss")) {
            i++;
            result_filename = argv[i];
        } else if (!strcmp(argv[i], "-p2p")) {
            problem = 'p';
            i++;
            source_filename = argv[i];
        } else if (!strcmp(argv[i], "-op2p")) {
            i++;
            result_filename = argv[i];
        }
    }

    int n, m, max_cost;
    int **cost;
    std::unordered_map<int, std::unordered_set<int>> arcs;
    const clock_t begin_time = clock();
    read_graph(graph_filename, n, m, max_cost, arcs, cost);
    float time = float(clock() - begin_time) / CLOCKS_PER_SEC;
    std::cout << graph_filename << " read in " << time << "s\n";
    std::ofstream myfile;
    myfile.open(result_filename);

    if (problem == 's') {
        std::vector<int> sources;
        float num;
        read_ss_file(source_filename, sources, num);
        const clock_t begin_time = clock();
        for (int source : sources) {
            unsigned int *d = dijkstra(source, n, m, arcs, cost);
            free(d);
        }
        float time = float(clock() - begin_time) / CLOCKS_PER_SEC;
        float avg_time = time / num;
        myfile << "p res sp ss dijkstra" << std::endl;
        myfile << "f " << graph_filename << " " << source_filename << std::endl;
        myfile << "g " << n << " " << m << " 0 " << max_cost << std::endl;
        myfile << "t " << avg_time << "s";
    } else if (problem == 'p') {
        std::vector<std::pair<int, int>> pairs;
        read_p2p_file(source_filename, pairs);
        myfile << "p res sp ss dijkstra" << std::endl;
        myfile << "f " << graph_filename << " " << source_filename << std::endl;
        myfile << "g " << n << " " << m << " 0 " << max_cost << std::endl;
        for (std::pair<int, int> pair : pairs) {
            unsigned int *d = dijkstra(pair.first, n, m, arcs, cost);
            myfile << "d " << pair.first << " " << pair.second << " "
                   << d[pair.second] << std::endl;
            free(d);
        }
    }

    myfile.close();

    for (int i = 0; i <= n; i++) {
        free(cost[i]);
    }
    free(cost);

    return 0;
}