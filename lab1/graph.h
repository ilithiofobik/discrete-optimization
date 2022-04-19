#ifndef LAB1_GRAPH_H
#define LAB1_GRAPH_H
#include <map>
#include <set>

enum Color { black, gray, white };

void gen_graph(bool directed, int size, const std::string &filename);
void gen_bipartite_graph(bool directed, int size, const std::string &filename);
void gen_dag(int size, const std::string &filename);

struct graph {
    bool directed;
    std::map<int, std::set<int>> adj;
    int size;
    int *d;
    int *f;
    int *pi;
    Color *color;
    int time;
    int *topological_sort;
};

struct graph read_graph();

#endif  // LAB1_GRAPH_H
