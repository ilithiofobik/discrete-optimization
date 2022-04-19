#include <stdio.h>
#include <string.h>
#include <time.h>

#include <fstream>
#include <iostream>
#include <limits>
#include <list>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#include "graphio.h"

unsigned int *dial(int s, int &n, int &m,
                   std::unordered_map<int, std::unordered_set<int>> &arcs,
                   int **&cost, int &max_cost) {
    unsigned int *d = (unsigned int *)malloc((n + 1) * sizeof(unsigned int));
    for (int i = 1; i <= n; i++) {
        d[i] = std::numeric_limits<unsigned int>::max();
    }
    d[s] = 0;
    int S = 1;
    int curr = 0;
    int k = 0;
    std::vector<std::list<int>> content(max_cost + 1);
    content[0].push_back(s);
    int a;
    unsigned int old_val, new_val;

    while (S < n) {
        while (!content[k].empty()) {
            a = content[k].back();
            content[k].pop_back();
            S = S + 1;
            for (int b : arcs[a]) {
                old_val = d[b];
                new_val = curr + cost[a][b];

                if (new_val < old_val) {
                    if (old_val < std::numeric_limits<unsigned int>::max()) {
                        content[old_val % (max_cost + 1)].remove(b);
                    }
                    content[new_val % (max_cost + 1)].push_back(b);
                    d[b] = new_val;
                }
            }
        }
        curr = curr + 1;
        k = curr % (max_cost + 1);
    }

    return d;
}

int main(int argc, char **argv) {
    const char *graph_filename = "";
    const char *source_filename = "";
    const char *result_filename = "";
    char problem = 's';

    for (int i = 1; i < argc; i++) {
        if (!strcmp(argv[i], "-d")) {
            i++;
            graph_filename = argv[i];
        } else if (!strcmp(argv[i], "-ss")) {
            problem = 's';
            i++;
            source_filename = argv[i];
        } else if (!strcmp(argv[i], "-oss")) {
            i++;
            result_filename = argv[i];
        } else if (!strcmp(argv[i], "-p2p")) {
            problem = 'p';
            i++;
            source_filename = argv[i];
        } else if (!strcmp(argv[i], "-op2p")) {
            i++;
            result_filename = argv[i];
        }
    }

    int n, m, max_cost;
    int **cost;
    std::unordered_map<int, std::unordered_set<int>> arcs;
    const clock_t begin_time = clock();
    read_graph(graph_filename, n, m, max_cost, arcs, cost);
    float time = float(clock() - begin_time) / CLOCKS_PER_SEC;
    std::cout << graph_filename << " read in " << time << "s\n";
    std::ofstream myfile;
    myfile.open(result_filename);

    if (problem == 's') {
        std::vector<int> sources;
        float num;
        read_ss_file(source_filename, sources, num);
        const clock_t begin_time = clock();
        for (int source : sources) {
            unsigned int *d = dial(source, n, m, arcs, cost, max_cost);
            free(d);
        }
        float time = float(clock() - begin_time) / CLOCKS_PER_SEC;
        float avg_time = time / num;
        myfile << "p res sp ss dial" << std::endl;
        myfile << "f " << graph_filename << " " << source_filename << std::endl;
        myfile << "g " << n << " " << m << " 0 " << max_cost << std::endl;
        myfile << "t " << avg_time << "s";
    } else if (problem == 'p') {
        std::vector<std::pair<int, int>> pairs;
        read_p2p_file(source_filename, pairs);
        myfile << "p res sp ss dial" << std::endl;
        myfile << "f " << graph_filename << " " << source_filename << std::endl;
        myfile << "g " << n << " " << m << " 0 " << max_cost << std::endl;
        for (std::pair<int, int> pair : pairs) {
            unsigned int *d = dial(pair.first, n, m, arcs, cost, max_cost);
            myfile << "d " << pair.first << " " << pair.second << " "
                   << d[pair.second] << std::endl;
            free(d);
        }
    }

    myfile.close();

    for (int i = 0; i <= n; i++) {
        free(cost[i]);
    }
    free(cost);

    return 0;
}