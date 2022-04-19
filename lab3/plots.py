from cmath import log, sqrt
import matplotlib.pyplot as plt

x = []
dijkstra = []
dial = []
radixheap = []

for family in ['Long-n', 'Random4-n', 'Square-n']:
    for i in range(10, 18):
        x.append(2 ** i)
        dijkstrafile = open(
            f'outputs/{family}/dijkstra{family}.{i}.0.ss.res', 'r')
        lines = dijkstrafile.readlines()
        for line in lines:
            row = line.split(" ")
            if row[0] == 't':
                dijkstra.append(1000.0 * float(row[1][:-1]))
        dialfile = open(f'outputs/{family}/dial{family}.{i}.0.ss.res', 'r')
        lines = dialfile.readlines()
        for line in lines:
            row = line.split(" ")
            if row[0] == 't':
                dial.append(1000.0 * float(row[1][:-1]))
        radixheapfile = open(
            f'outputs/{family}/radixheap{family}.{i}.0.ss.res', 'r')
        lines = radixheapfile.readlines()
        for line in lines:
            row = line.split(" ")
            if row[0] == 't':
                radixheap.append(1000.0 * float(row[1][:-1]))

    plt.clf()
    plt.xlabel('n=2^i')
    plt.ylabel('Average Time [ms]')
    plt.title(f'{family} Time Plot')
    plt.plot(x, dijkstra, label='Dijsktra')
    plt.plot(x, dial, label='Dial')
    plt.plot(x, radixheap, label='Radix Heap')
    plt.legend()
    plt.savefig(
        f'D:\\Wojtazz\\SEM5\\aod\\lab3\\sprawko\\{family}timeplot.png', dpi=600)
    x = []
    dijkstra = []
    dial = []
    radixheap = []


x = []
y = []
for family in ['Long-n', 'Random4-n', 'Square-n']:
    for i in range(15, 18):
        avg = 0.0
        x.append(2 ** i)
        dijkstrafile = open(
            f'outputs/{family}/dijkstra{family}.{i}.0.p2p.res', 'r')
        lines = dijkstrafile.readlines()
        for line in lines:
            row = line.split(" ")
            if row[0] == 'd':
                avg = avg + float(row[3]) / 1000.0
        y.append(avg)

    plt.clf()
    plt.xlabel('n=2^i')
    plt.ylabel('Average Distance')
    plt.title(f'{family} Distance Plot')
    plt.plot(x, y)
    plt.savefig(
        f'D:\\Wojtazz\\SEM5\\aod\\lab3\\sprawko\\{family}distplot.png', dpi=600)
    x = []
    y = []


x = []
ylong = []
ysquare = []
yrandom = []
ylong2 = []
ysquare2 = []
yrandom2 = []
for i in range(15, 18):
    avg = 0.0
    avg2 = 0.0
    x.append(2 ** i)
    longfile = open(f'outputs/Long-n/dijkstraLong-n.{i}.0.p2p.res', 'r')
    lines = longfile.readlines()
    for line in lines:
        row = line.split(" ")
        if row[0] == 'd':
            avg = avg + float(row[3]) / 1000.0
            avg2 = avg2 + (float(row[3])) ** 2 / 1000.0

    ylong.append(avg)
    ylong2.append(avg2)

    avg = 0.0
    avg2 = 0.0
    squarefile = open(f'outputs/Square-n/dijkstraSquare-n.{i}.0.p2p.res', 'r')
    lines = squarefile.readlines()
    for line in lines:
        row = line.split(" ")
        if row[0] == 'd':
            avg = avg + float(row[3]) / 1000.0
            avg2 = avg2 + (float(row[3])) ** 2 / 1000.0
    ysquare.append(avg)
    ysquare2.append(avg2)
    avg = 0.0
    avg2 = 0.0
    randomfile = open(
        f'outputs/Random4-n/dijkstraRandom4-n.{i}.0.p2p.res', 'r')
    lines = randomfile.readlines()
    for line in lines:
        row = line.split(" ")
        if row[0] == 'd':
            avg = avg + float(row[3]) / 1000.0
            avg2 = avg2 + (float(row[3])) ** 2 / 1000.0
    yrandom.append(avg)
    yrandom2.append(avg2)

plt.clf()
plt.xlabel('n=2^i')
plt.ylabel('Average Distance')
plt.title(f'Distance Plot')
plt.plot(x, ylong, label='Long-n')
plt.plot(x, ysquare, label='Square-n')
plt.plot(x, yrandom, label='Random4-n')
plt.legend()
plt.savefig(f'D:\\Wojtazz\\SEM5\\aod\\lab3\\sprawko\\distplot.png', dpi=600)


plt.clf()
plt.xlabel('n=2^i')
plt.ylabel('Average Distance')
plt.title(f'Distance Plot')
plt.plot(x, ysquare, label='Square-n')
plt.plot(x, yrandom, label='Random4-n')
plt.legend()
plt.savefig(f'D:\\Wojtazz\\SEM5\\aod\\lab3\\sprawko\\distnolongplot.png', dpi=600)

for i in range(len(ylong)):
    ylong[i] = sqrt(ylong2[i] - (ylong[i] ** 2)).real
    ysquare[i] = sqrt(ysquare2[i] - (ysquare[i] ** 2)).real
    yrandom[i] = sqrt(yrandom2[i] - (yrandom[i] ** 2)).real

plt.clf()
plt.xlabel('n=2^i')
plt.ylabel('Distance SD')
plt.title(f'Distance SD Plot')
plt.plot(x, ylong, label='Long-n')
plt.plot(x, ysquare, label='Square-n')
plt.plot(x, yrandom, label='Random4-n')
plt.legend()
plt.savefig(f'D:\\Wojtazz\\SEM5\\aod\\lab3\\sprawko\\sddistplot.png', dpi=600)

plt.clf()
plt.xlabel('n=2^i')
plt.ylabel('Distance SD')
plt.title(f'Distance SD Plot')
plt.plot(x, ysquare, label='Square-n')
plt.plot(x, yrandom, label='Random4-n')
plt.legend()
plt.savefig(
    f'D:\\Wojtazz\\SEM5\\aod\\lab3\\sprawko\\sdnolongdistplot.png', dpi=600)

plt.clf()
plt.xlabel('n=2^i')
plt.ylabel('Distance SD')
plt.title(f'Distance SD Plot')
plt.plot(x, yrandom, label='Random4-n')
plt.legend()
plt.savefig(
    f'D:\\Wojtazz\\SEM5\\aod\\lab3\\sprawko\\sdonlyrandomdistplot.png', dpi=600)
