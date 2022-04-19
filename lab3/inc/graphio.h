#ifndef LAB3_GRAPHIO_H
#define LAB3_GRAPHIO_H
#include <vector>
#include <unordered_map>
#include <unordered_set>


void read_graph(const char *filename, int &n, int &m, int &max_cost,
                std::unordered_map<int, std::unordered_set<int>> &arcs,
                int **&cost);

void read_ss_file(const char *filename, std::vector<int> &sources, float &num);

void read_p2p_file(const char *filename,
                   std::vector<std::pair<int, int>> &pairs);

#endif //LAB3_GRAPHIO_H
