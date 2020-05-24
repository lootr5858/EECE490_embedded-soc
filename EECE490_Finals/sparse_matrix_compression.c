#include <stdio.h>
#include <stdlib.h>

/* --------------------------------------------
     Transpose Jagged Diagonal Storage (TJDS)
   -------------------------------------------- */
int main()
{
    // define original sparse matrix
    #define width 5
    #define m_size 25
    int AO[m_size] = {4, 1, 0, 2, 0,
                       0, 3, 0, 6, 0,
                       0, 0, 5, 0, 0,
                       0, 0, 1, 1, 0,
                       0, 0, 8, 0, 6};
    int xo[m_size] = {2, 1, 4, 2, 3};
    
    // define compressed vectors
    int m_val[m_size];
    int* x;
    int* row_index;
    int* A;

    // intermediate values
    int nz_size = 0;
    int idx;
    int col_length[width];
    int col_idx [width] = {1, 2, 3, 4, 5};
    int swap[2];
    int nz_row[width][width] = {{0, 0, 0, 0 ,0}, {0, 0, 0, 0 ,0}, {0, 0, 0, 0 ,0}, {0, 0, 0, 0 ,0}, {0, 0, 0, 0 ,0}};
    int ridx;
    int trow[5][1];
    int vidx;

    // extract # non-zero elements (totals and per column)
    for (int i = 0; i < width; i++)
    {
        col_length[i] = 0;
        ridx = 0;

        for (int j = 0; j < width; j++)
        {
            idx = i + j * 5;

            if (AO[idx] != 0)
            {
                nz_row[ridx][i] = j + 1;
                col_length[i] += 1;
                nz_size += 1;
                ridx += 1;             
            }
        }
    }

    // allocate mem for vector x & row_idx & A
    if (nz_size > 0)
    {
        x = malloc(nz_size * sizeof(int));
        row_index = malloc((nz_size + 1) * sizeof(int));
        A = malloc(nz_size * sizeof(int));

        row_index[0] = 0;
    }

    //  sort column & row_idx by decreasing number of non-zero element in column
    for (int i = 0; i < width - 1; i++)
    {
        for (int j = i + 1; j < width - 1; j++)
        {
            if (col_length[i] < col_length[j])
            {              
                swap[0] = col_idx[i];
                swap[1] = col_length[i];

                trow[0][0] = nz_row[0][i];
                trow[1][0] = nz_row[1][i];
                trow[2][0] = nz_row[2][i];
                trow[3][0] = nz_row[3][i];
                trow[4][0] = nz_row[4][i];

                col_idx[i] = col_idx[j];
                col_idx[j] = swap[0];
                
                col_length[i] = col_length[j];
                col_length[j] = swap[1];

                nz_row[0][i] = nz_row[0][j];
                nz_row[1][i] = nz_row[1][j];
                nz_row[2][i] = nz_row[2][j];
                nz_row[3][i] = nz_row[3][j];
                nz_row[4][i] = nz_row[4][j];

                nz_row[0][j] = trow[0][0];
                nz_row[1][j] = trow[1][0];
                nz_row[2][j] = trow[2][0];
                nz_row[3][j] = trow[3][0];
                nz_row[4][j] = trow[4][0];
            }         
        }
    }    

    vidx = 0;

    // extract row_index & A vectors
    for (int i = 0; i < width; i++)
    {
        for (int j = 0; j < width; j++)
        {
            if (nz_row[i][j] != 0)
            {
                idx = (col_idx[j] - 1) + (nz_row[i][j] - 1) * width;
                row_index[vidx + 1] = nz_row[i][j];
                A[vidx] = AO[idx];
                x[vidx] = xo[col_idx[j] - 1];

                vidx += 1;
            }
        }
    }

    /*printf("\nx = ");
    for (int i = 0; i < nz_size; i++)
    {
        printf("%d ", x[i]);
    }

    printf("\nA = ");
    for (int i = 0; i < nz_size; i++)
    {
        printf("%d ", A[i]);
    }

    printf("\nRow index = ");
    for (int i = 0; i < 11; i++)
    {
        printf("%d ", row_index[i]);
    }*/
}