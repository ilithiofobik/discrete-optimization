#ifndef LAB1_ZAD1_H
#define LAB1_ZAD1_H
#include "graph.h"

void BFS(struct graph G, int s, bool print);
void DFS(struct graph &G, bool print);
void DFS_visit(struct graph &G, int u);
void print_search_tree(const struct graph& G);
void print_dfs_path(struct graph G);

#endif //LAB1_ZAD1_H
