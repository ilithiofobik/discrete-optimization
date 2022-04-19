#include "graphio.h"

#include <stdio.h>
#include <string.h>
#include <time.h>

#include <fstream>
#include <iostream>
#include <limits>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

void read_graph(const char *filename, int &n, int &m, int &max_cost,
                std::unordered_map<int, std::unordered_set<int>> &arcs,
                int **&cost) {
    std::ifstream file(filename);
    if (file.is_open()) {
        std::string delimiter = " ";
        std::string line;
        size_t pos;
        max_cost = 0;
        int a, b, c;
        while (std::getline(file, line)) {
            if (line.at(0) == 'a') {
                line.erase(0, 2);
                pos = line.find(delimiter);
                a = atoi(line.substr(0, pos).c_str());
                line.erase(0, pos + 1);
                pos = line.find(delimiter);
                b = atoi(line.substr(0, pos).c_str());
                line.erase(0, pos + 1);
                c = atoi(line.c_str());
                max_cost = std::max(max_cost, c);
                arcs[a].insert(b);
                cost[a][b] = c;
            } else if (line.at(0) == 'p') {
                line.erase(0, 5);
                pos = line.find(delimiter);
                n = atoi(line.substr(0, pos).c_str());
                line.erase(0, pos + 1);
                m = atoi(line.c_str());
                cost = (int **)malloc((n + 1) * sizeof(int *));
                for (int i = 0; i <= n; i++) {
                    cost[i] = (int *)malloc((n + 1) * sizeof(int));
                }
            }
        }
        file.close();
    }
}

void read_ss_file(const char *filename, std::vector<int> &sources, float &num) {
    std::ifstream file(filename);
    if (file.is_open()) {
        std::string line;
        while (std::getline(file, line)) {
            if (line.at(0) == 's') {
                line.erase(0, 2);
                sources.push_back(atoi(line.c_str()));
            } else if (line.at(0) == 'p') {
                line.erase(0, 12);
                num = atoi(line.c_str());
            }
        }
        file.close();
    }
}

void read_p2p_file(const char *filename,
                   std::vector<std::pair<int, int>> &pairs) {
    std::ifstream file(filename);
    if (file.is_open()) {
        std::string delimiter = " ";
        std::string line;
        size_t pos;
        int a, b;
        while (std::getline(file, line)) {
            if (line.at(0) == 'q') {
                line.erase(0, 2);
                pos = line.find(delimiter);
                a = atoi(line.substr(0, pos).c_str());
                line.erase(0, pos + 1);
                b = atoi(line.c_str());
                pairs.push_back(std::make_pair(a, b));
            }
        }
        file.close();
    }
}