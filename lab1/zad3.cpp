#include "zad3.h"

#include <iostream>
#include <queue>

#include "graph.h"

void scc(struct graph& G) {
    int* topological_sort = topological_sort_no_print(G);

    struct graph G_T = graph_transposition(G);

    int n = G_T.size;

    G_T.color = new Color[n + 1];
    G_T.d = new int[n + 1];
    G_T.f = new int[n + 1];
    G_T.pi = new int[n + 1];

    for (int u = 1; u <= n; u++) {
        G_T.color[u] = white;
        G_T.pi[u] = 0;
    }

    G_T.time = 0;

    int number_of_components = 0;

    for (int i = n; i > 0; i--) {
        int u = topological_sort[i];
        if (G_T.color[u] == white) {
            number_of_components++;
            std::cout << number_of_components << ". component:";
            scc_visit(G_T, u);
            std::cout << std::endl;
        }
    }

    delete[] G_T.color;
    delete[] G_T.d;
    delete[] G_T.f;
    delete[] G_T.pi;
    delete[] topological_sort;
}

void scc_visit(struct graph& G, int u) {
    std::cout << " " << u;
    G.time += 1;
    G.d[u] = G.time;
    G.color[u] = gray;
    for (int v : G.adj[u]) {
        if (G.color[v] == white) {
            G.pi[v] = u;
            scc_visit(G, v);
        }
    }
    G.color[u] = black;
    G.time += 1;
    G.f[u] = G.time;
}

struct graph graph_transposition(struct graph& G) {
    struct graph G_T;
    G_T.directed = G.directed;
    G_T.size = G.size;

    for (int u = 1; u <= G.size; u++) {
        for (int v : G.adj[u]) {
            G_T.adj[v].insert(u);
        }
    }

    return G_T;
}

int* topological_sort_no_print(struct graph& G) {
    int n = G.size;

    G.color = new Color[n + 1];
    G.f = new int[n + 1];
    G.topological_sort = new int[n + 1];

    for (int u = 1; u <= n; u++) {
        G.color[u] = white;
    }

    G.time = 0;

    for (int u = 1; u <= n; u++) {
        if (G.color[u] == white) {
            topological_visit_no_print(G, u);
        }
    }

    delete[] G.color;
    delete[] G.f;

    return G.topological_sort;
}

void topological_visit_no_print(struct graph& G, int u) {
    G.color[u] = gray;
    for (int v : G.adj[u]) {
        if (G.color[v] == white) {
            topological_visit_no_print(G, v);
        }
    }
    G.color[u] = black;
    G.time += 1;
    G.f[u] = G.time;
    G.topological_sort[G.time] = u;
}