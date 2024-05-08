#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <omp.h>

void arr_init(int *arr, int length)
{
    int i, count = 1;
    for (i = 0; i < length; i++)
    {
        arr[i] = count;
        count += 2;
    }
}

int num_prime(int num)
{
    if (num <= 1)
    {
        printf("%d is not a prime\n", num);
        return 0;
    }
    if (num <= 3)
    {
        printf("%d is a prime\n", num);
        return 1;
    }
    for (int i = 2; i <= round(sqrt(num)); i++)
    {
        if (num % i == 0)
        {
            printf("%d is not a prime\n", num);
            return 0;
        }
    }
    printf("%d is a prime\n", num);
    return 1;
}

void print_arr(int *arr, int length)
{
    int i;
    printf("[ ");
    for (i = 0; i < length; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("]\n");
}

int main(int argc, char *argv[])
{
    clock_t a = clock();
    if (argc < 3)
    {
        printf("Usage: %s num_of_proc size\n", argv[0]);
        return 1;
    }

    int num_of_proc = atoi(argv[1]);
    int size = atoi(argv[2]);
    int i;
    int *arr = malloc(size * sizeof(int));
    arr_init(arr, size);
    omp_set_dynamic(0);
    print_arr(arr, size);

#pragma omp parallel for num_threads(num_of_proc)
    for (i = 0; i < size; i++)
    {
#pragma omp critical
        num_prime(arr[i]);
    }
    free(arr);
    clock_t b = clock();
    double c = ((double)(b - a));
    printf("\nTime:%f\n", c);
    return 0;
}