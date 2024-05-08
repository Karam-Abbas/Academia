#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <time.h>

void arr_generator(int r, int c, int arr[][c])
{
    int i, j;
    for (i = 0; i < r; i++)
    {
        for (j = 0; j < c; j++)
        {
            arr[i][j] = rand() % 10;
        }
    }
}

void arr_printer(int r, int c, int arr[][c])
{
    int i, j;
    for (i = 0; i < r; i++)
    {
        for (j = 0; j < c; j++)
        {
            printf("%d", arr[i][j]);
            printf(" ");
        }
        printf("\n");
    }
}

void arr_init(int r, int c, int arr[][c])
{
    int i, j;
    for (i = 0; i < r; i++)
    {
        for (j = 0; j < c; j++)
        {
            arr[i][j] = 0;
        }
    }
}

void default_mult(int r, int c, int arr1[][c], int arr2[][c])
{
    double st = omp_get_wtime();
    int i, j, k;
    int result[r][c];

    arr_init(100, 100, result);
    #pragma omp parallel for
    for (int i = 0; i < 100; i++)
    {
        for (int j = 0; j < 100; j++)
        {
            for (int k = 0; k < 100; k++)
            {
                result[i][j] += arr1[i][k] * arr2[k][j];
            }
        }
    }
    
    double end = omp_get_wtime();
    printf("Total time for default schd: %f\n",end-st);
}

void default_schd_custom_threads_mult(int r, int c, int arr1[][c], int arr2[][c],int t_nums)
{
    double st = omp_get_wtime();
    int i, j, k;
    int result[r][c];
    arr_init(100, 100, result);
    #pragma omp parallel for num_threads(t_nums)
    for (int i = 0; i < 100; i++)
    {
        for (int j = 0; j < 100; j++)
        {
            for (int k = 0; k < 100; k++)
            {
                result[i][j] += arr1[i][k] * arr2[k][j];
            }
        }
    }
   
    double end = omp_get_wtime();
    printf("Total time for default schd with custom threads: %f\n",end-st);
}

void static_schd_mult(int r, int c, int arr1[][c], int arr2[][c])
{
    double st = omp_get_wtime();
    int i, j, k;
    int result[r][c];
    arr_init(100, 100, result);
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < 100; i++)
    {
        for (int j = 0; j < 100; j++)
        {
            for (int k = 0; k < 100; k++)
            {
                result[i][j] += arr1[i][k] * arr2[k][j];
            }
        }
    }
    
    double end = omp_get_wtime();
    printf("Total time for static schd : %f\n",end-st);
}

void static_schd_custom_threads_mult(int r, int c, int arr1[][c], int arr2[][c],int t_nums)
{
    double st = omp_get_wtime();
    int i, j, k;
    int result[r][c];
    arr_init(100, 100, result);
    #pragma omp parallel for schedule(static) num_threads(t_nums)
    for (int i = 0; i < 100; i++)
    {
        for (int j = 0; j < 100; j++)
        {
            for (int k = 0; k < 100; k++)
            {
                result[i][j] += arr1[i][k] * arr2[k][j];
            }
        }
    }

    double end = omp_get_wtime();
    printf("Total time for static schd with custom threads: %f\n",end-st);
}

void dynamic_schd_mult(int r, int c, int arr1[][c], int arr2[][c])
{
    double st = omp_get_wtime();
    int i, j, k;
    int result[r][c];
    arr_init(100, 100, result);
    #pragma omp parallel for schedule(dynamic)
    for (int i = 0; i < 100; i++)
    {
        for (int j = 0; j < 100; j++)
        {
            for (int k = 0; k < 100; k++)
            {
                result[i][j] += arr1[i][k] * arr2[k][j];
            }
        }
    }
    double end = omp_get_wtime();
    printf("Total time for dynamic schd: %f\n",end-st);
}

void dynamic_schd_custom_threads_mult(int r, int c, int arr1[][c], int arr2[][c],int t_nums)
{
    double st = omp_get_wtime();
    int i, j, k;
    int result[r][c];
    arr_init(100, 100, result);
    #pragma omp parallel for schedule(dynamic) num_threads(t_nums)
    for (int i = 0; i < 100; i++)
    {
        for (int j = 0; j < 100; j++)
        {
            for (int k = 0; k < 100; k++)
            {
                result[i][j] += arr1[i][k] * arr2[k][j];
            }
        }
    }
    double end = omp_get_wtime();
    printf("Total time for dynamic schd with custom threads: %f\n",end-st);
}



int main()
{
    int rows = 100, cols = 100;
    int arr1[rows][cols];
    int arr2[rows][cols];
    srand(time(NULL));
    arr_generator(rows, cols, arr1);
    arr_generator(rows, cols, arr2);
    default_mult(rows, cols, arr1, arr2);
    static_schd_mult(rows, cols, arr1, arr2);
    dynamic_schd_mult(rows, cols, arr1, arr2);
    default_schd_custom_threads_mult(rows, cols, arr1, arr2,rows*cols);
    static_schd_custom_threads_mult(rows, cols, arr1, arr2,rows*cols);
    dynamic_schd_custom_threads_mult(rows, cols, arr1, arr2,rows*cols);

    return 0;
}