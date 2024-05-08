def transpose_function(matrix):
    return [[i[x] for i in matrix]for x in range(3)]
# x will give 0 in iteration 1 then the i will give matrix[0] and combined the i[x] will give
# i[x]=[matrix[0][0],matrix[1][0],matrix[2][0]]
mat_a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
print(mat_a)
output = transpose_function(mat_a)
print(output)
