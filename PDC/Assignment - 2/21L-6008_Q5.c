#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

struct req
{
    int sum;
    int t_id;
};

void swap(int *a, int *b)
{
    int temp = *a;
    *a = *b;
    *b = temp;
}

int partition(int arr[], int low, int high)
{
    int pivot = arr[high];
    int i = low - 1;
    int j;
    for (j = low; j < high; j++)
    {
        if (arr[j] >= pivot)
        { // changed the operator to sort in desc order.
            i++;
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return (i + 1);
}

void quicksort(int arr[], int low, int high)
{
    if (low < high)
    {
        int pivot = partition(arr, low, high);
        quicksort(arr, low, pivot - 1);
        quicksort(arr, pivot + 1, high);
    }
}

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

struct req Row_Sort(int row, int col, int current_row, int mat[][col])
{
    int new_arr[col];
    int i, sum = 0;
    for (i = 0; i < col; i++)
    {
        new_arr[i] = mat[current_row][i];
    }

    quicksort(new_arr, 0, col - 1);

    for (i = 0; i < col; i++)
    {
        sum += new_arr[i];
        mat[current_row][i] = new_arr[i];
    }
    struct req a;
    a.sum=sum;
    a.t_id=current_row;
    return a;
}


int main()
{
    int rows, cols;

    printf("Enter Number of rows for arr1:     ");
    scanf("%d", &rows);

    printf("Enter Number of columns for arr1:  ");
    scanf("%d", &cols);

    int arr[rows][cols];

    srand(time(NULL));

    printf("\nMatrix Before Sort:-\n\n");
    arr_generator(rows, cols, arr);
    arr_printer(rows, cols, arr);
    printf("\n");
    int i, sum = 0;
    struct req b[rows];

#pragma omp parallel for num_threads(rows) reduction(+ : sum)
    for (i = 0; i < rows; i++)
    {
        b[i] = Row_Sort(rows, cols, i, arr);

    }

    printf("\nMatrix After Sort:-\n\n");
    arr_printer(rows, cols, arr);
    printf("\n");
    for (i = 0; i < rows; i++)
    {
        printf("Row[%d] SUM:%d\n",b[i].t_id,b[i].sum);
        sum+=b[i].sum;
    }

    printf("Matrix Addition: %d\n", sum);
    return 0;
}