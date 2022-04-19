import os

# os.system("make")

for i in range(0, 16):
    for family in ["Long", "Square", "Random4"]:

        grfile = "inputs/" + family + "-C/" + family + "-C." + str(i) + ".0.gr"
        ssfile = "inputs/" + family + "-C/" + family + "-C." + str(i) + ".0.ss"
        p2pfile = "inputs/" + family + "-C/" + \
            family + "-C." + str(i) + ".0.p2p"

        for algo in ["dijkstra", "dial", "radixheap"]:
            ossfile = "outputs/" + family + "-C/" + \
                algo + family + "-C." + str(i) + ".0.ss.res"
            op2pfile = "outputs/" + family + "-C/" + \
                algo + family + "-C." + str(i) + ".0.p2p.res"
            sscmd = "./" + algo + " -d " + grfile + " -ss " + ssfile + " -oss " + ossfile
            p2pcmd = "./" + algo + " -d " + grfile + \
                " -p2p " + p2pfile + " -op2p " + op2pfile
            print(sscmd)
            os.system(sscmd)
            print(p2pcmd)
            os.system(p2pcmd)
