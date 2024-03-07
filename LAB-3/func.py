class Node:
    def __init__(self, data, parent=None):
        self.data = data
        self.child_nodes = []
        self.visited = False
        self.weapon = 0
        self.parent = parent

    def add_child(self, node):
        self.child_nodes.append(node)

    def set_parent(self, a):
        self.parent = a


def reset(node):
    node.visited = False
    for i in node.child_nodes:
        reset(i)


def file_handler(x):
    file = open(x, "r")
    matrix = []
    counter_space = 0
    counter_hash = 0
    for line in file:
        row = []
        for char in line.strip():
            if char == " ":
                counter_hash = 0
                counter_space += 1
                if counter_space >= 3:
                    row.append(0)
                    if counter_space > 3:
                        counter_space = 0
            elif char == '-':          # Walls
                counter_space = 0
                counter_hash += 1
                if counter_hash == 3:
                    counter_hash = 0
                    row.append(1)
            elif char in ("+", "|"):   # Walls
                counter_hash = 0
                counter_space = 0
                row.append(1)
            elif char in ("w", "W"):  # w's are the weapons
                counter_hash = 0
                counter_space = 0
                row.append("W")
            elif char in ("z", "Z"):  # z's are the zombies
                counter_hash = 0
                counter_space = 0
                row.append("Z")
            elif char in ("s", "S"):   # safe zones
                counter_space = 0
                counter_hash = 0
                row.append("S")
            elif char in ("a", "A"):
                counter_hash = 0
                counter_space = 0  # character Anato
                row.append("A")
        matrix.append(row)
    file.close()
    return matrix


def write_matrix_to_file(matrix, filename):
    with open(filename, 'w') as f:
        for row in matrix:
            for item in row:
                f.write(str(item))
            f.write('\n')


def construct_tree_from_map(map_grid):
    rows = len(map_grid)
    cols = len(map_grid[0])
    nodes_map = {}  # To store nodes corresponding to each coordinate

    # Creating nodes
    for i in range(rows):
        for j in range(cols):
            if map_grid[i][j] != 1:  # making everything a node except the walls
                node_data = (i, j)
                nodes_map[(i, j)] = Node((node_data,map_grid[i][j]))

    # Connect nodes by checking up down left and right 0's
    for i in range(rows):
        for j in range(cols):
            if map_grid[i][j] != 1:
                current_node = nodes_map[(i, j)]
                for dx, dy in [(1, 0), (-1, 0), (0, 1), (0, -1)]:
                    new_x, new_y = i + dx, j + dy
                    if (new_x, new_y) in nodes_map:  # If adjacent cell exists and is not a wall
                        adjacent_node = nodes_map[(new_x, new_y)]
                        current_node.add_child(adjacent_node)
                        adjacent_node.set_parent(current_node)

    # Find and return the start node
    start_node = None
    for node in nodes_map.values():
        if node.data[1] == 'A':
            start_node = node
            break

    return start_node


def dfs(start, goal):
    if start is None:
        print("Start node not found.")
        return -1

    stack = [start]
    index = 0
    while stack:
        current = stack.pop()
        print(current.data)
        if current.data[1] == goal:
            return index
        current.visited = True
        index += 1
        for child in current.child_nodes:
            if not child.visited:
                stack.append(child)
    print("Goal not Found")
    return index


def bfs(start, goal):
    queue = [start]
    counter = 0
    while queue:
        current = queue.pop(0)
        print(current.data)
        if current.data[1] == goal:
            return counter
        current.visited = True
        counter += 1
        for child in current.child_nodes:
            if not child.visited:
                queue.append(child)
                child.visited = True
    print("Goal not Found")
    return counter
