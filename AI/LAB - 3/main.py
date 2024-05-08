import func as f

x = f.file_handler("input.txt")
# x --> 2D binary matrix of map

# binary matrix saved in a separate file just for the sake of checking
f.write_matrix_to_file(x, "new_file.txt")

root = f.construct_tree_from_map(x)
goal = 'S'
cost_dfs = f.dfs(root, goal)
cost_bfs = f.bfs(root, goal)
print("Cost of BFS:", cost_bfs, " Cost of DFS:", cost_dfs)
