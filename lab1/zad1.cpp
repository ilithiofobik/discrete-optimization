#include "zad1.h"

#include <climits>
#include <iostream>
#include <queue>
#include <string>

#include "graph.h"

void BFS(struct graph G, int s, bool print) {
    int n = G.size;

    G.color = new Color[n + 1];
    G.d = new int[n + 1];
    G.pi = new int[n + 1];

    std::memset(G.d, INT_MAX - 1, (n + 1) * sizeof(int));
    std::memset(G.pi, 0, (n + 1) * sizeof(int));  // 0 <- NULL

    for (int i = 0; i < n + 1; i++) {
        G.color[i] = white;
    }

    G.color[s] = gray;
    G.d[s] = 0;

    std::queue<int> Q;
    Q.push(s);
    std::string path = "Path:";

    while (!Q.empty()) {
        int u = Q.front();
        path += " " + std::to_string(u);
        Q.pop();
        for (int v : G.adj[u]) {
            if (G.color[v] == white) {
                G.color[v] = gray;
                G.d[v] = G.d[u] + 1;
                G.pi[v] = u;
                Q.push(v);
            }
        }
        G.color[u] = black;
    }

    std::cout << path << std::endl;

    if (print) {
        print_search_tree(G);
    }

    delete[] G.color;
    delete[] G.d;
    delete[] G.pi;
}

void DFS(struct graph& G, bool print) {
    int n = G.size;

    G.color = new Color[n + 1];
    G.d = new int[n + 1];
    G.f = new int[n + 1];
    G.pi = new int[n + 1];

    G.d[0] = -1;

    for (int u = 1; u <= n; u++) {
        G.color[u] = white;
        G.pi[u] = 0;
    }

    G.time = 0;

    for (int u = 1; u <= n; u++) {
        if (G.color[u] == white) {
            DFS_visit(G, u);
        }
    }

    print_dfs_path(G);

    if (print) {
        print_search_tree(G);
    }

    delete[] G.color;
    delete[] G.d;
    delete[] G.f;
    delete[] G.pi;
}

void DFS_visit(struct graph& G, int u) {
    G.time += 1;
    G.d[u] = G.time;
    G.color[u] = gray;
    for (int v : G.adj[u]) {
        if (G.color[v] == white) {
            G.pi[v] = u;
            DFS_visit(G, v);
        }
    }
    G.color[u] = black;
    G.time += 1;
    G.f[u] = G.time;
}

void print_search_tree(const struct graph& G) {
    int v;
    std::cout << "Search tree:" << std::endl;
    std::cout << "V = {1, ..., " << G.size << "}\n";
    std::string edges = "E = {";

    if (G.directed) {
        for (int u = 1; u <= G.size; u++) {
            v = G.pi[u];
            if (v > 0) {
                edges +=
                    "(" + std::to_string(v) + "," + std::to_string(u) + "), ";
            }
        }
    } else {
        for (int u = 1; u <= G.size; u++) {
            v = G.pi[u];
            if (v > 0) {
                edges +=
                    "{" + std::to_string(v) + "," + std::to_string(u) + "}, ";
            }
        }
    }

    if (edges.length() > 5) {
        edges.pop_back();  // ,
        edges.pop_back();  // space
    }

    edges = edges + "}";
    std::cout << edges << std::endl;
}

void print_dfs_path(struct graph G) {
    int n = G.size;
    std::string path = "Path:";
    int* sorted_d = new int[n + 1];
    memcpy(sorted_d, G.d, (n + 1) * sizeof(int));
    std::sort(sorted_d, sorted_d + n + 1);
    for (int i = 1; i <= n; i++) {
        int val = sorted_d[i];
        for (int j = 1; j <= n; j++) {
            if (G.d[j] == val) {
                path += " " + std::to_string(j);
            }
        }
    }
    std::cout << path << std::endl;
    delete[] sorted_d;
}