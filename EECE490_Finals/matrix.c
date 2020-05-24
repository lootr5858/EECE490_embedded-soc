#include <stdio.h>
#include <stdlib.h>

int main()
{
    // Define length & width of input matrices
    #define dim 3

    
    // Create input matrices
    int matrix_a[dim][dim] = {{0, 1, 2}, {3, 4, 5}, {6, 7, 8}};
    int matrix_b[dim][dim] = {{9, 8, 7}, {6, 5, 4}, {3, 2, 1}};
    
    /* Resultant matrix c
       Length of input matrix a
       Width of input matrix b  */
    int matrix_c[dim][dim];

    printf("Start matrix multiplication ... ...\n");

    // Multiplication operations
    for (int i = 0; i < dim; i++)
    {

        for (int j = 0; j < dim; j++)
        {
            matrix_c[i][j] = 0;

            for (int k = 0; k < dim; k++)
            {
                matrix_c[i][j] += matrix_a[i][k] * matrix_b[k][j];
            }
        }
    }

    // check resultant matrix
    printf("Resutltant matrix =\n");

    for (int i = 0; i < dim; i++)
    {
        for (int j = 0; j < dim; j++)
        {
            printf("%d ", matrix_c[i][j]);
        }

        printf("\n");
    }

    return 0;
}