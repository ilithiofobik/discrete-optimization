from cmath import log, sqrt
import matplotlib.pyplot as plt

x = []

edmonds_karp_time_all = []
glpk_time_all = []
shortest_augmenting_path_time_all = []

edmonds_karp_visited_paths = []
shortest_augmenting_path_visited_paths = []

edmonds_karp_time = []
shortest_augmenting_path_time = []

maxflow = []

for i in range(1, 11):
    x.append(2 ** i)
    rustfile = open(f'outputs/rustsize{i}v1.txt', 'r')
    lines = rustfile.readlines()
    edmonds_karp_time_all.append(float(lines[1]))
    shortest_augmenting_path_time_all.append(float(lines[4]))
    juliafile = open(f'outputs/juliasize{i}v1.txt', 'r')
    lines = juliafile.readlines()
    glpk_time_all.append(float(lines[1]))

    edmonds_karp_visited_paths_val = 0.0
    shortest_augmenting_path_visited_paths_val = 0.0
    edmonds_karp_time_val = 0.0
    shortest_augmenting_path_time_val = 0.0
    maxflow_val = 0.0

    for j in range(1, 10):
        rustfile = open(f'outputs/rustsize{i}v{j}.txt', 'r')
        lines = rustfile.readlines()
        edmonds_karp_visited_paths_val += float(lines[2])
        shortest_augmenting_path_visited_paths_val += float(lines[5])
        edmonds_karp_time_val += float(lines[1])
        shortest_augmenting_path_time_val += float(lines[4])
        maxflow_val += float(lines[0])

    edmonds_karp_visited_paths_val /= 10.0
    shortest_augmenting_path_visited_paths_val /= 10.0
    edmonds_karp_time_val /= 10.0
    shortest_augmenting_path_time_val /= 10.0
    maxflow_val /= 10.0

    edmonds_karp_visited_paths.append(edmonds_karp_visited_paths_val)
    shortest_augmenting_path_visited_paths.append(
        shortest_augmenting_path_visited_paths_val)
    edmonds_karp_time.append(edmonds_karp_time_val)
    shortest_augmenting_path_time.append(shortest_augmenting_path_time_val)
    maxflow.append(maxflow_val)

plt.clf()
plt.xlabel('n=2^k')
plt.ylabel('Time [s]')
plt.title(f'One graph time plot [s]')
plt.plot(x, edmonds_karp_time_all, label='Edmonds-Karp')
plt.plot(x, glpk_time_all, label='GLPK')
plt.plot(x, shortest_augmenting_path_time_all,
         label='Shortest Augmenting Path')
plt.legend()
plt.savefig('D:\\Wojtazz\\SEM5\\aod\\lab4\\sprawko\\timealllplot.png', dpi=600)

for i in range(11, 17):
    x.append(2 ** i)
    rustfile = open(f'outputs/rustsize{i}v1.txt', 'r')
    lines = rustfile.readlines()

    edmonds_karp_visited_paths_val = 0.0
    shortest_augmenting_path_visited_paths_val = 0.0
    edmonds_karp_time_val = 0.0
    shortest_augmenting_path_time_val = 0.0
    maxflow_val = 0.0

    for j in range(1, 10):
        rustfile = open(f'outputs/rustsize{i}v{j}.txt', 'r')
        lines = rustfile.readlines()
        edmonds_karp_visited_paths_val += float(lines[2])
        shortest_augmenting_path_visited_paths_val += float(lines[5])
        edmonds_karp_time_val += float(lines[1])
        shortest_augmenting_path_time_val += float(lines[4])
        maxflow_val += float(lines[0])

    edmonds_karp_visited_paths_val /= 10.0
    shortest_augmenting_path_visited_paths_val /= 10.0
    edmonds_karp_time_val /= 10.0
    shortest_augmenting_path_time_val /= 10.0
    maxflow_val /= 10.0

    edmonds_karp_visited_paths.append(edmonds_karp_visited_paths_val)
    shortest_augmenting_path_visited_paths.append(
        shortest_augmenting_path_visited_paths_val)
    edmonds_karp_time.append(edmonds_karp_time_val)
    shortest_augmenting_path_time.append(shortest_augmenting_path_time_val)
    maxflow.append(maxflow_val)

plt.clf()
plt.xlabel('n=2^k')
plt.ylabel('Average maxflow')
plt.title('Average maxflow')
plt.plot(x, maxflow)
plt.savefig('D:\\Wojtazz\\SEM5\\aod\\lab4\\sprawko\\maxflowplot.png', dpi=600)

plt.clf()
plt.xlabel('n=2^k')
plt.ylabel('Average time [s]')
plt.title('Average time')
plt.plot(x, edmonds_karp_time, label='Edmonds-Karp')
plt.plot(x, shortest_augmenting_path_time, label='Shortest Augmenting Path')
plt.legend()
plt.savefig('D:\\Wojtazz\\SEM5\\aod\\lab4\\sprawko\\timeplot.png', dpi=600)

plt.clf()
plt.xlabel('n=2^k')
plt.ylabel('Average time [s]')
plt.title('Average time')
plt.plot(x, shortest_augmenting_path_time, label='Shortest Augmenting Path')
plt.legend()
plt.savefig('D:\\Wojtazz\\SEM5\\aod\\lab4\\sprawko\\timeplotonlysap.png', dpi=600)

plt.clf()
plt.xlabel('n=2^k')
plt.ylabel('Average visited paths')
plt.title('Visited paths')
plt.plot(x, edmonds_karp_visited_paths, label='Edmonds-Karp')
plt.plot(x, shortest_augmenting_path_visited_paths,
         label='Shortest Augmenting Path')
plt.legend()
plt.savefig(
    'D:\\Wojtazz\\SEM5\\aod\\lab4\\sprawko\\visitedpathsplot.png', dpi=600)


plt.clf()
plt.xlabel('n=2^k')
plt.ylabel('Average maxflow / nlogn')
plt.title('Average maxflow / nlogn')
for i in range(len(maxflow)):
    maxflow[i] = maxflow[i] / ((i + 1) * (2 ** (i + 1)))
plt.plot(x, maxflow)
plt.savefig('D:\\Wojtazz\\SEM5\\aod\\lab4\\sprawko\\maxflowplotbyn.png', dpi=600)

plt.clf()
plt.xlabel('n=2^k')
plt.ylabel('Average time [s] / n')
plt.title('Average time / n')
for i in range(len(maxflow)):
    shortest_augmenting_path_time[i] = shortest_augmenting_path_time[i] / (
        (2 ** (i + 1)))
plt.plot(x, shortest_augmenting_path_time, label='Shortest Augmenting Path')
plt.legend()
plt.savefig(
    'D:\\Wojtazz\\SEM5\\aod\\lab4\\sprawko\\timeplotonlysapbyn.png', dpi=600)
