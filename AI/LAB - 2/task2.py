def splitter(a):
    len_a = len(a)
    if((len_a%2)==0):
        new_len = int(len_a/2)
        front_a=a[0:new_len]
        back_a=a[new_len:]
    else:
        new_len=int(len_a/2)
        front_a=a[:new_len+1]
        back_a=a[new_len+1:]
    return front_a,back_a

a = "abcde"
b = "gefh"

front_a, back_a = splitter(a)
front_b, back_b = splitter(b)

x = front_a + front_b + back_a + back_b
print(x)

