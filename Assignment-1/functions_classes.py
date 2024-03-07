class Node:
    def __init__(self, matrix, parent=None):
        self.matrix = matrix
        self.child_nodes = []
        self.visited = False
        self.parent = parent

    def add_child(self, node):
        self.child_nodes.append(node)


def reset(node):
    node.visited = False
    for i in node.child_nodes:
        reset(i)


def dfs(start, goal):
    stack = [start]
    index = 0
    while stack:
        current = stack.pop()
        print(current.matrix)
        if current.matrix == goal:
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
        print(current.matrix)
        if current.matrix == goal:
            return counter
        current.visited = True
        counter += 1
        for child in current.child_nodes:
            if not child.visited:
                queue.append(child)
                child.visited = True
    print("Goal not Found")
    return counter


def dls(start, goal, max_level):
    stack = [(start, 0)]  # Initialize stack with the start node and its level
    index = 0
    while stack:
        current, level = stack.pop()
        print(current.matrix)
        if current.matrix == goal:
            return index
        current.visited = True
        index += 1
        if level < max_level:  # Check if the current level is within the maximum level
            for child in current.child_nodes:
                if not child.visited:
                    stack.append((child, level + 1))  # Add child node with incremented level
    print("Goal not Found")
    return False


def max_depth(node):
    if not node:
        return 0
    max_child_depth = 0
    for child in node.child_nodes:
        max_child_depth = max(max_child_depth, max_depth(child))
    return max_child_depth + 1


def ids(start, goal, limit):
    for i in range(limit + 1):
        reset(start)
        result = dls(start, goal, i)
        if result is not False:
            return result
    return None


def find_element(x, matrix):
    for i in range(3):
        for j in range(3):
            if x == matrix[i][j]:
                return i, j


def generate_tree(root_state, final_state):
    queue = [Node(root_state)]

    while queue:
        current_node = queue.pop(0)

        if current_node.matrix == final_state:
            return True

        current_node.child_nodes.extend(check_moves(current_node.matrix))
        for child_state, _ in current_node.child_nodes:
            new_node = Node(child_state, current_node)
            current_node.child_nodes.append(new_node)
            queue.append(new_node)

    return False  # Final state not found


def check_moves(state):
    valid_moves = []
    zero_row, zero_col = find_zero_position(state)

    # Define all possible moves: 'left', 'right', 'up', 'down'
    moves = [(0, -1), (0, 1), (-1, 0),(1, 0)]

    for (r, c) in moves:
        new_row, new_col = zero_row + r, zero_col + c

        # Check if the move is within bounds
        if 0 <= new_row < 3 and 0 <= new_col < 3:
            new_state = swap_tiles(state, zero_row, zero_col, new_row, new_col)  # swap tiles will make a new state
            valid_moves.append(new_state)

    return valid_moves


def find_zero_position(state):
    # Find the position of the '0' (empty tile) in the state
    for i in range(3):
        for j in range(3):
            if state[i][j] == 0:
                return i, j


def swap_tiles(state, r1, c1, r2, c2):
    new_state = []
    for row in state:
        new_row = row[:]  # copy
        new_state.append(new_row)

    new_state[r1][c1], new_state[r2][c2] = new_state[r2][c2], new_state[r1][c1]  # old,new = new,old without a temp
    return new_state
