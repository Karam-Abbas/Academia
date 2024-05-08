#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

int partition(int arr[], int low, int high) {
    int pivot = arr[high]; 
    int i = low - 1;  
    int j;
    for (j = low; j < high; j++) {
        if (arr[j] >= pivot) {     // changed the operator to sort in desc order.
            i++;
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return (i + 1);
}

void quicksort(int arr[], int low, int high) {
    if (low < high) {
        int pivot = partition(arr, low, high);
        quicksort(arr, low, pivot - 1);
        quicksort(arr, pivot + 1, high);
    }
}

void arr_generator(int r, int c,int arr[][c])
{
    int i,j;
    for (i=0;i<r;i++)
    {
        for(j=0;j<c;j++)
        {
            arr[i][j]=rand()%10;
        }
    }
}

void arr_printer(int r, int c,int arr[][c])
{
    int i,j;
    for (i=0;i<r;i++)
    {
        for(j=0;j<c;j++)
        {
            printf("%d",arr[i][j]);
            printf(" ");
        }
        printf("\n");
    }
}

struct ThreadArgs {
    int (*matrix)[];
    int r;
    int c;
    int assigned_row;
};

void *Row_Sort(void *arg) {
    struct ThreadArgs *args = (struct ThreadArgs *)arg;

    int (*matrix)[args->c] = args->matrix;
    int row = args->r;
    int col = args->c;
    int current_row = args->assigned_row;
    int new_arr[col];
    int i,sum=0;
    for ( i = 0; i < col; i++)
    {
        new_arr[i]=matrix[current_row][i];
    }

    quicksort(new_arr,0,col-1); 

    for ( i = 0; i < col; i++)
    {
        sum+=new_arr[i];
        matrix[current_row][i]=new_arr[i];
    }

    printf("Row[%d] SUM:%d\n",current_row,sum);
    pthread_exit((void*)sum);
}

int main() {
    int rows,cols;

    printf("Enter Number of rows for arr1:     ");
    scanf("%d",&rows);

    printf("Enter Number of columns for arr1:  ");
    scanf("%d",&cols);

    int arr[rows][cols];

    srand(time(NULL));

    printf("\nMatrix Before Sort:-\n\n");
    arr_generator(rows,cols,arr);
    arr_printer(rows,cols,arr);
    printf("\n");

    pthread_t threads[rows];           // As my roll no = 21L-6008 so quicksort->desc  and No. of threads = rows
    int threadValues[rows];
    struct ThreadArgs args[rows];
    int i,j,Matrix_addition;
    for (i = 0; i < rows; i++) {
        args[i].matrix = arr;
        args[i].r = rows;
        args[i].c = cols;
        args[i].assigned_row=i;
        pthread_create(&threads[i], NULL, Row_Sort, (void *)&args[i]);
    }

    for (i = 0; i < rows; i++) {
        pthread_join(threads[i], (void**)&threadValues[i]);
    }

    for (i = 0; i < rows; i++)
    {
        Matrix_addition += threadValues[i];
    }
    
    
    printf("\nMatrix After Sort:-\n\n");
    arr_printer(rows,cols,arr);
    printf("\n");

    printf("Matrix addition:  %d\n",Matrix_addition);
    
    return 0;
}
