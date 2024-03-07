# all the functions and classes are defined in the separate file linked below
import functions_classes as func

# input and then ->convert string into int arr
input_arr = input("Enter the initial:")
input_lst = [int(x) for x in input_arr]

goal_arr = input("Enter the goal:")
goal_lst = [int(x) for x in goal_arr]

# to make the arr into 2d array
in_matrix = [input_lst[i:i+3]for i in range(0, len(input_lst), 3)]
goal_matrix = [goal_lst[i:i+3]for i in range(0, len(goal_lst), 3)]

root = func.Node(in_matrix)
goal = func.Node(goal_matrix)

func.generate_tree(root.matrix, goal.matrix)

cost = func.bfs(root, goal.matrix)
print("Via Bfs:", cost)

cost = func.dfs(root, goal.matrix)
print("Via Dfs:", cost)

limit = func.max_depth(root)
cost = func.ids(root, goal.matrix,limit)
print("Via Ids:", cost)
