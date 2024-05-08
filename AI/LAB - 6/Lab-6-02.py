import random as r
a = [0, 0, 0, 0]
b = [0, 0, 0, 0]
c = [0, 0, 0, 0]
d = [0, 0, 0, 0]


def fitness_value(chromosome):
    n = len(chromosome)
    non_attacking_pairs = 0
    for i in range(n):
        for j in range(i + 1, n):
            if chromosome[i] != chromosome[j] and abs(i - j) != abs(chromosome[i] - chromosome[j]):
                non_attacking_pairs += 1
    return non_attacking_pairs


# random value initializer
def rand_init(a, b, c, d):
    for i in range(4):
        a[i] = r.randint(1, 4)
        b[i] = r.randint(1, 4)
        c[i] = r.randint(1, 4)
        d[i] = r.randint(1, 4)


def crossover(a, b):
    rand_num = r.randint(1, len(a) - 1)  # Choosing a random crossover point
    c = a[:]
    d = b[:]
    a = c[:rand_num] + d[rand_num:]
    b = d[:rand_num] + c[rand_num:]
    return a, b


def mutation(a):
    b = r.randint(0,3)
    a[b] = r.randint(1,4)


def genetic_algo(a,b,c,d):
    f_a = fitness_value(a)
    f_b = fitness_value(b)
    f_c = fitness_value(c)
    f_d = fitness_value(d)

    overall_fitness = f_a + f_b + f_c + f_d

    prob_a = 4 * f_a / overall_fitness
    prob_b = 4 * f_b / overall_fitness
    prob_c = 4 * f_c / overall_fitness
    prob_d = 4 * f_d / overall_fitness

    # Pair arrays with their probabilities
    array_prob_pairs = [(a, prob_a), (b, prob_b), (c, prob_c), (d, prob_d)]

    # Sort pairs based on probabilities
    sorted_pairs = sorted(array_prob_pairs, key=lambda x: x[1], reverse=True)

    selected = [sorted_pairs[0][0], sorted_pairs[1][0], sorted_pairs[2][0]]
    rand_selection = r.randint(0, 2)
    a = selected[rand_selection]
    selected.append(a)
    r.shuffle(selected)
    # Selection is done now doing the crossover
    a = crossover(selected[0], selected[1])
    b = crossover(selected[2], selected[3])
    selected = [a[0],a[1],b[0],b[1]]
    for i in range(len(selected)):
        mutation(selected[i])
    return selected


rand_init(a,b,c,d)
print("Initial boards: ",a,b,c,d)
a = genetic_algo(a,b,c,d)
print("After first iteration",a)

# Now as per the condition running the genetic algorithm 50 times without worrying about the result

for i in range(50):
    a = genetic_algo(a[0],a[1],a[2],a[3])
    print("Iteration no.",i,"  ",a)