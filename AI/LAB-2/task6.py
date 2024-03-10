def factor_count_dict(lst):
    factor_dict = {}
    for num in lst:
        for i in range(1, num + 1):
            if num % i == 0:
                factor_dict[i] = factor_dict.get(i, 0) + 1
    return factor_dict

# Example usage:
elements = [2,4,6,8]
result_dict = factor_count_dict(elements)
print(result_dict)
