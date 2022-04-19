#ifndef LAB1_ZAD3_H
#define LAB1_ZAD3_H
#include "graph.h"

int* topological_sort_no_print(struct graph& G);
void topological_visit_no_print(struct graph& G, int u);
struct graph graph_transposition(struct graph& G);
void scc(struct graph& G);
void scc_visit(struct graph& G, int u);

#endif  // LAB1_ZAD3_H
