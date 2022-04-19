#include "zad2.h"

#include <iostream>
#include <queue>

#include "graph.h"

void topological_sort(struct graph& G) {
    int n = G.size;

    G.color = new Color[n + 1];
    G.f = new int[n + 1];
    G.topological_sort = new int[n];

    for (int u = 1; u <= n; u++) {
        G.color[u] = white;
    }

    G.time = 0;

    for (int u = 1; u <= n; u++) {
        if (G.color[u] == white) {
            topological_visit(G, u);
        }
    }

    std::cout << "Topological order:";
    for (int i = 0; i < n; i++) {
        std::cout << " " << G.topological_sort[i];
    }
    std::cout << std::endl;

    delete[] G.color;
    delete[] G.f;
    delete[] G.topological_sort;
}

void topological_visit(struct graph& G, int u) {
    G.color[u] = gray;
    for (int v : G.adj[u]) {
        if (G.color[v] == white) {
            topological_visit(G, v);
        } else if (G.color[v] == gray) {
            std::cout << "Back edge found: " << u << " -> " << v << std::endl;
        }
    }
    G.color[u] = black;
    G.time += 1;
    G.f[u] = G.time;
    G.topological_sort[G.size - G.time] = u;
}