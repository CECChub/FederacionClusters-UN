#define N 20 // Size of the matrix
// Number of rows of the matrix to be processed by each rank
#define NUM_ROWS_PER_RANK 5

void matrixMultiply(int *A, int *B, int *C, int rowsToProcess);
