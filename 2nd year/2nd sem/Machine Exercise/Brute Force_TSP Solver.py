import itertools 
import networkx as nx 

def get_input(test_cases):

    #Container of node names
    nodes = []

    #Initialize nodes
    for x in range(test_cases):
        nodes.append(x)
        node_info = input().split()
        G.add_node(x, activity = node_info[0], venue = node_info[1], coords = (float(node_info[2]), float(node_info[3])))

    #Initialize edges
    for node in range(5):
        for j in nodes[node + 1::]:
            if len(nodes[node + 1::]) == 0:
                break
            G.add_edge(node, j)

def calculate_distance(coords1, coords2):
    # Calculate the Euclidean distance between two coordinates
    x1, y1 = coords1
    x2, y2 = coords2
    return (((x2 - x1) ** 2 + (y2 - y1) ** 2) ** 0.5) * 1000

def TSP_solver(graph, start_node):
    # Generate all possible permutations of the remaining nodes
    remaining_nodes = set(graph.nodes()) - {start_node}
    all_permutations = itertools.permutations(remaining_nodes)

    shortest_path = None
    shortest_distance = float('inf')

    # Try each permutation to find the shortest Hamiltonian path
    for permutation in all_permutations:
        path = [start_node] + list(permutation) + [start_node]
        distance = 0

        # Calculate the total distance of the path
        for i in range(len(path) - 1):
            node1 = path[i]
            node2 = path[i + 1]
            distance += calculate_distance(graph.nodes[node1]['coords'], graph.nodes[node2]['coords'])

        # Check if the current path is the shortest
        if distance < shortest_distance:
            shortest_path = path
            shortest_distance = distance

    return shortest_path, shortest_distance


if __name__ == '__main__':
    G = nx.Graph()
    test_cases = int(input())
    get_input(test_cases)
    shortest_path, total_distance = TSP_solver(G, 0)
    print(round(total_distance, 3))
    for venue in shortest_path:
        print(G.nodes[venue]['activity'])