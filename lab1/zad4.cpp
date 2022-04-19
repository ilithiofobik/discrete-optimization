#include "zad4.h"

#include <iostream>

#include "zad3.h"

void check_bipartite(struct graph& G) {
    int n = G.size;

    G.color = new Color[n + 1];
    G.pi = new int[n + 1];

    for (int u = 1; u <= n; u++) {
        G.color[u] = white;
        G.pi[u] = 0;
    }

    // changing to undirected
    if (G.directed) {
        for (int u = 1; u <= n; u++) {
            for (int v : G.adj[u]) {
                G.adj[v].insert(u);
            }
        }
    }

    for (int u = 1; u <= n; u++) {
        if (G.color[u] == white) {
            G.color[u] = black;
            bipartite_visit(G, u);
        }
    }

    bool is_bipartite = true;

    for (int u = 1; u <= G.size; u++) {
        for (int v : G.adj[u]) {
            if (G.color[u] == G.color[v]) {
                is_bipartite = false;
                std::cout << "Graph is not bipartite!\n";
                break;
            }
        }
        if (!is_bipartite) {
            break;
        }
    }

    if (is_bipartite) {
        std::cout << "V0:";
        for (int u = 1; u <= G.size; u++) {
            if (G.color[u] == black) {
                std::cout << " " << u;
            }
        }
        std::cout << std::endl;
        std::cout << "V1:";
        for (int u = 1; u <= G.size; u++) {
            if (G.color[u] == gray) {
                std::cout << " " << u;
            }
        }
        std::cout << std::endl;
    }

    delete[] G.color;
    delete[] G.pi;
}

void bipartite_visit(struct graph& G, int u) {
    Color u_color = G.color[u];
    Color next_color;
    if (u_color == black) {
        next_color = gray;
    } else {
        next_color = black;
    }

    for (int v : G.adj[u]) {
        if (G.color[v] == white) {
            G.pi[v] = u;
            G.color[v] = next_color;
            bipartite_visit(G, v);
        }
    }
}
