tuple1 = (('a', 23), ('b', 37), ('c', 11), ('d',29))
output=sorted(tuple1,key=lambda x:x[1])
#lambda x:x[1] will give the iterable 1
print(output)