#include "graph.h"

#include <cstdlib>
#include <ctime>
#include <fstream>
#include <iostream>
#include <set>

void gen_graph(bool directed, const int n, const std::string &filename) {
    int m = 0;
    int chance = n / 4;
    std::ofstream graph_file;
    bool *edges = new bool[n * n];

    srand(time(nullptr));
    graph_file.open(filename);
    std::memset(edges, false, n * n * sizeof(bool));

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (directed) {
                if (rand() % chance == 0) {
                    edges[n * i + j] = true;
                    m++;
                }
                if (rand() % chance == 0) {
                    edges[n * j + i] = true;
                    m++;
                }
            } else {
                if (rand() % chance == 0) {
                    edges[n * i + j] = true;
                    m = m + 1;
                }
            }
        }
    }

    if (directed) {
        graph_file << "D\n";
    } else {
        graph_file << "U\n";
    }

    graph_file << n << "\n";
    graph_file << m << "\n";

    if (directed) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (edges[i * n + j]) {
                    graph_file << i + 1 << " " << j + 1 << "\n";
                }
            }
        }
    } else {
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (edges[i * n + j]) {
                    graph_file << i + 1 << " " << j + 1 << "\n";
                }
            }
        }
    }

    delete[] edges;
    graph_file.close();
}

void gen_bipartite_graph(bool directed, const int n,
                         const std::string &filename) {
    int m = 0;
    int chance = n / 16;
    chance = std::max(chance, 2);
    std::ofstream graph_file;
    bool *edges = new bool[n * n];

    srand(time(nullptr));
    graph_file.open(filename);
    std::memset(edges, false, n * n * sizeof(bool));

    for (int i = 0; i < n; i += 2) {
        for (int j = i + 1; j < n; j += 2) {
            if (directed) {
                if (rand() % chance == 0) {
                    edges[n * i + j] = true;
                    m++;
                }
                if (rand() % chance == 0) {
                    edges[n * j + i] = true;
                    m++;
                }
            } else {
                if (rand() % chance == 0) {
                    edges[n * i + j] = true;
                    m = m + 1;
                }
            }
        }
    }

    if (directed) {
        graph_file << "D\n";
    } else {
        graph_file << "U\n";
    }

    graph_file << n << "\n";
    graph_file << m << "\n";

    if (directed) {
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (edges[i * n + j]) {
                    graph_file << i + 1 << " " << j + 1 << "\n";
                }
            }
        }
    } else {
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                if (edges[i * n + j]) {
                    graph_file << i + 1 << " " << j + 1 << "\n";
                }
            }
        }
    }

    delete[] edges;
    graph_file.close();
}

void gen_dag(const int n, const std::string &filename) {
    int m = 0;
    int chance = n / 8;
    chance = std::max(chance, 2);
    std::ofstream graph_file;
    bool *edges = new bool[n * n];

    srand(time(nullptr));
    graph_file.open(filename);
    std::memset(edges, false, n * n * sizeof(bool));

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (rand() % chance == 0) {
                edges[n * i + j] = true;
                m++;
            }
        }
    }

    graph_file << "D\n";

    graph_file << n << "\n";
    graph_file << m << "\n";

    for (int i = 0; i < n; i++) {
        for (int j = i + 1; j < n; j++) {
            if (edges[i * n + j]) {
                graph_file << i + 1 << " " << j + 1 << "\n";
            }
        }
    }

    delete[] edges;
    graph_file.close();
}

struct graph read_graph() {
    std::string flag;
    bool directed;
    std::cin >> flag;
    if (flag != "D" && flag != "U") {
        printf("Wrong flag!");
        exit(1);
    } else {
        directed = flag == "D";
    }

    int n, m, u, v;
    std::cin >> n >> m;

    struct graph my_graph;
    my_graph.directed = directed;
    my_graph.size = n;
    for (int i = 0; i < m; i++) {
        std::cin >> u >> v;
        my_graph.adj[u].insert(v);
        if (!my_graph.directed) {
            my_graph.adj[v].insert(u);
        }
    }

    return my_graph;
}