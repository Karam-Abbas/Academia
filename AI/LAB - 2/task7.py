def info(u, v, w, x, y):
    return (u, v, w, x, y)

def calc(tup):
    net = 0
    for i in tup:
        a,b,c,d,e = i
        net += (e - b) * c
    return net

a = info('25 jan 2001', 43.50, 25, 'CAT', 92.45)
b = info('25 jan 2001', 42.80, 50, 'DD', 51.19)
c = info('25 jan 2001', 42.10, 25, 'EK', 92.45)
d = info('25 jan 2001', 37.58, 25, 'GM', 92.45)

new_tuple = (a, b, c, d)

total_gain_loss = calc(new_tuple)
print("Total gain or loss:", total_gain_loss)
