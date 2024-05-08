#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

double serial_func()
{
    int key = 111, x, y, z, win, i, j, k, SIZE = 1000;
    double start = omp_get_wtime();
    for (i = 0; i < SIZE; i++)
    {
        for (j = 0; j < SIZE; j++)
        {
            for (k = 0; k < SIZE; k++)
            {
                x = (i * i * 1000 / 35) % 1000;
                y = (j * j * 1000 / 36) % 1000;
                z = (k * k * 1000 / 37) % 1000;
                if (key == (x + y + z))
                {
                    win = win + 1;
                }
            }
        }
    }
    double end = omp_get_wtime();
    double total = end - start;
    return total;
}

void parallel_func(int num_of_threads)
{
    int key = 111, x, y, z, win = 0, i, j, k, SIZE = 1000;
    double start = omp_get_wtime();
#pragma omp parallel for private(x, y, z, i, j, k) reduction(+ : win) num_threads(num_of_threads)
    for (i = 0; i < SIZE; i++)
    {
        for (j = 0; j < SIZE; j++)
        {
            for (k = 0; k < SIZE; k++)
            {
                x = (i * i * 1000 / 35) % 1000;
                y = (j * j * 1000 / 36) % 1000;
                z = (k * k * 1000 / 37) % 1000;
                if (key == (x + y + z))
                {
                    win = win + 1;
                }
            }
        }
    }
    double end = omp_get_wtime();
    double Total_Time = end - start;
    printf("total wins=%d\n", win);
    printf("Time with %d threads:%f\n", num_of_threads, Total_Time);
    double sequential_time = serial_func();
    double speedup = sequential_time / Total_Time;
    printf("Speedup with %d threads: %f\n", num_of_threads, speedup);
}

int main(int argc, char *argv[])
{
    int i;
    printf("Time by serial execution:%f\n", serial_func());
    for (i = 2; i < 5; i++)
    {
        parallel_func(i);
    }

    return 0;
}