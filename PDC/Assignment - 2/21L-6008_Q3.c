#include <stdio.h>
#include <omp.h>

int search(int arr[], int n, int key) {
    int i,count=0;
    #pragma omp parallel for reduction(+:count)
    for (i = 0; i < n; i++) {
        if (arr[i] == key) {
            count++; 
        }
    }
    return count; 
}

int main() {
    double st = omp_get_wtime();
    int arr[] = {5, 7, 9, 1, 7, 4, 7};
    int n = sizeof(arr) / sizeof(arr[0]); 
    int key = 3; 

    int index = search(arr, n, key);

    if (index != 0) {
        printf("Element count: %d\n", index);
    } else {
        printf("Element not found\n");
    }
    double end = omp_get_wtime();
    printf("Total time: %f",end-st);
    return 0;
}