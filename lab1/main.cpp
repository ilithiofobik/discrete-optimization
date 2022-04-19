#include <iostream>
#include <string>

#include "graph.h"
#include "zad1.h"
#include "zad2.h"
#include "zad3.h"
#include "zad4.h"

int main() {
    /*
    for (int n = 10; n <= 10000; n = 10 * n) {
        gen_graph(true, n, "directed" + std::to_string(n) + "graph.txt");
        gen_graph(false, n, "undirected" + std::to_string(n) + "graph.txt");
        gen_bipartite_graph(true, n, "directed" + std::to_string(n) +
    "bipartite.txt"); gen_bipartite_graph(false, n, "undirected" +
    std::to_string(n) + "bipartite.txt"); gen_dag(n, "directed" +
    std::to_string(n) + "acyclic.txt");
    }
    */
    struct graph G = read_graph();
    if (G.directed) {
        std::cout << "Choose the algorithm: DFS(1), BFS(2), Bipartiteness(3), "
                     "Topological sort(4), SCC(5)\n";
    } else {
        std::cout << "Choose the algorithm: DFS(1), BFS(2), Bipartiteness(3)\n";
    }
    int algo = 0;
    std::cin >> algo;

    if (algo == 1) {
        std::cout << "Should I print the DFS tree? [Y/n]\n";
        std::string answer;
        std::cin >> answer;
        DFS(G, answer == "Y");
    } else if (algo == 2) {
        std::cout << "Should I print the BFS tree? [Y/n]\n";
        std::string answer;
        std::cin >> answer;
        srand(time(nullptr));
        BFS(G, rand() % G.size + 1, answer == "Y");
    } else if (algo == 3) {
        check_bipartite(G);
    } else if (algo == 4 && G.directed) {
        topological_sort(G);
    } else if (algo == 5 && G.directed) {
        scc(G);
    } else {
        std::cout << "Wrong number";
    }

    return 0;
}
