def tuple_mul(tuple1):
    return tuple(tuple1[i]*tuple1[i+1] for i in range (len(tuple1)-1))

mytup=(1, 5, 7, 8, 10)
newtup=tuple_mul(mytup)
print(mytup)
print(newtup)