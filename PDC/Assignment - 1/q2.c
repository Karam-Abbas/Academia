#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

struct ThreadArgs {
    int (*matrix1)[];
    int (*matrix2)[];
    int (*result)[];
    int r1;
    int c1;
    int r2;
    int c2;
    int assigned_row;
};

void *multiply(void *arg) {
    struct ThreadArgs *args = (struct ThreadArgs *)arg;

    int (*matrix1)[args->c1] = args->matrix1;
    int (*matrix2)[args->c2] = args->matrix2;
    int (*result)[args->c2] = args->result;
    int r1 = args->r1;
    int c1 = args->c1;
    int r2 = args->r2;
    int c2 = args->c2;
    int current_row = args->assigned_row;
    int i, j;

    for (i = 0; i < c2; i++) {
        result[current_row][i] = 0;
        for (j = 0; j < c1; j++) {
            result[current_row][i] += matrix1[current_row][j] * matrix2[j][i];
        }
    }
    pthread_exit(NULL);
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

int main() {

    int rows_1,cols_1,rows_2,cols_2;

    printf("Enter Number of rows for arr1:     ");
    scanf("%d",&rows_1);

    printf("Enter Number of columns for arr1:  ");
    scanf("%d",&cols_1);

    printf("Enter Number of rows for arr2:     ");
    scanf("%d",&rows_2);

    printf("Enter Number of columns for arr2:  ");
    scanf("%d",&cols_2);

    if(rows_2!=cols_1)
    {
        printf("Wrong matrix dimensions. Operation can't be performed!\n");
        return 0;
    }
    
    int arr1[rows_1][cols_1];
    int arr2[rows_2][cols_2];
    int result[rows_1][cols_2];

    srand(time(NULL));

    printf("Matrix 1:-\n");
    arr_generator(rows_1,cols_1,arr1);
    arr_printer(rows_1,cols_1,arr1);
    printf("\n");

    printf("Matrix 2:-\n");
    arr_generator(rows_2,cols_2,arr2);
    arr_printer(rows_2,cols_2,arr2);
    printf("\n");


    pthread_t threads[rows_1];
    struct ThreadArgs args[rows_1];
    int i,j;
    for (i = 0; i < rows_1; i++) {
        args[i].matrix1 = arr1;
        args[i].matrix2 = arr2;
        args[i].result = result;
        args[i].r1 = rows_1;
        args[i].c1 = cols_1;
        args[i].r2 = rows_2;
        args[i].c2 = cols_2;
        args[i].assigned_row=i;
        pthread_create(&threads[i], NULL, multiply, (void *)&args[i]);
    }

    for (i = 0; i < rows_1; i++) {
        pthread_join(threads[i], NULL);
    }

    printf("Result Matrix:\n");
    arr_printer(rows_1,cols_2,result);
    return 0;
}
