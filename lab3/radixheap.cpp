#include <stdio.h>
#include <string.h>
#include <time.h>

#include <cmath>
#include <fstream>
#include <iostream>
#include <limits>
#include <list>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

#include "graphio.h"

long long *radixheap(int s, int &n, int &m,
                     std::unordered_map<int, std::unordered_set<int>> &arcs,
                     int **&cost, int &max_cost) {
    int K = (int)ceil(log2(n) + log2(max_cost));

    long long *d = (long long *)malloc((n + 1) * sizeof(long long));
    int *bucket_idx = (int *)malloc((n + 1) * sizeof(int));
    std::vector<std::list<long long>> content(K + 1);

    for (int i = 1; i <= n; i++) {
        d[i] = std::numeric_limits<long long>::max();
        bucket_idx[i] = K;
    }

    d[s] = 0;
    bucket_idx[s] = 0;
    content[0].push_back(s);

    int S = 1;
    int k = 0;
    long long *range_begin = (long long *)malloc((K + 1) * sizeof(long long));
    range_begin[0] = 0;
    long long x = 1;
    for (int i = 1; i <= K; i++) {
        range_begin[i] = x;
        x = 2 * x;
    }
    int a, old_bucket_idx, new_bucket_idx;
    long long old_val, new_val, min_val;

    while (S < n) {
        k = 0;
        while (content[k].empty()) {
            k = k + 1;
        }
        if (k <= 1) {
            while (!content[k].empty()) {
                a = content[k].back();
                content[k].pop_back();
                S = S + 1;

                for (int b : arcs[a]) {
                    old_val = d[b];
                    new_val = range_begin[k] + cost[a][b];

                    if (new_val < old_val) {
                        old_bucket_idx = bucket_idx[b];

                        if (old_val < std::numeric_limits<long long>::max()) {
                            content[old_bucket_idx].remove(b);
                        }

                        new_bucket_idx = old_bucket_idx;
                        while (range_begin[new_bucket_idx] > new_val) {
                            new_bucket_idx = new_bucket_idx - 1;
                        }

                        content[new_bucket_idx].push_back(b);
                        d[b] = new_val;
                        bucket_idx[b] = new_bucket_idx;
                    }
                }
            }
        } else {
            min_val = std::numeric_limits<long long>::max();
            for (auto it = content[k].begin(); it != content[k].end(); ++it) {
                if (d[*it] < min_val) {
                    min_val = d[*it];
                }
            }
            range_begin[0] = min_val;
            long long x = 1;
            for (int i = 1; i <= k; i++) {
                range_begin[i] = min_val + x;
                x = 2 * x;
            }
            while (!content[k].empty()) {
                a = content[k].back();
                content[k].pop_back();
                new_bucket_idx = k - 1;
                while (range_begin[new_bucket_idx] > d[a]) {
                    new_bucket_idx = new_bucket_idx - 1;
                }
                bucket_idx[a] = new_bucket_idx;
                content[new_bucket_idx].push_back(a);
            }
        }
    }

    free(range_begin);
    free(bucket_idx);
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
            long long *d = radixheap(source, n, m, arcs, cost, max_cost);
            free(d);
        }
        float time = float(clock() - begin_time) / CLOCKS_PER_SEC;
        float avg_time = time / num;
        myfile << "p res sp ss radixheap" << std::endl;
        myfile << "f " << graph_filename << " " << source_filename << std::endl;
        myfile << "g " << n << " " << m << " 0 " << max_cost << std::endl;
        myfile << "t " << avg_time << "s";
    } else if (problem == 'p') {
        std::vector<std::pair<int, int>> pairs;
        read_p2p_file(source_filename, pairs);
        myfile << "p res sp ss radixheap" << std::endl;
        myfile << "f " << graph_filename << " " << source_filename << std::endl;
        myfile << "g " << n << " " << m << " 0 " << max_cost << std::endl;
        for (std::pair<int, int> pair : pairs) {
            long long *d = radixheap(pair.first, n, m, arcs, cost, max_cost);
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