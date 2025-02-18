#include <iostream>
#include <mpi.h> // Ensure MPI library is installed and include path is set

#include "mm_cuda.h"

int main(int argc, char *argv[]) {
    MPI_Init(&argc, &argv);

    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    int rowsPerProcess = N / size;
    int remainingRows = N % size;

    int A[N * N];
    int B[N * N];
    int C[N * N];
    int localA[rowsPerProcess * N];
    int localC[rowsPerProcess * N];

    // Initialize matrices A and B
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            A[i * N + j] = 1;
            B[i * N + j] = 1;
            C[i * N + j] = 0;
        }
    }

// Scatter rows of matrix A to all ranks
MPI_Scatter(A, rowsPerProcess * N, MPI_INT, localA, rowsPerProcess * N, 
            MPI_INT, 0, MPI_COMM_WORLD);

// Broadcast matrix B to all ranks
MPI_Bcast(B, N * N, MPI_INT, 0, MPI_COMM_WORLD);

matrixMultiply(localA, B, localC, rowsPerProcess);

// Gather the localC matrices from all ranks to form the final matrix C in rank 0
MPI_Gather(localC, rowsPerProcess * N, MPI_INT, C, rowsPerProcess * N, 
           MPI_INT, 0, MPI_COMM_WORLD);

// Handle remaining rows in rank 0
if (rank == 0 && remainingRows > 0) {
    matrixMultiply(&A[rowsPerProcess * size * N], B, 
                   &C[rowsPerProcess * size * N], remainingRows);
}

if (rank == 0) {
    std::cout << "Result matrix C:" << std::endl;
    for (int i = 0; i < N; ++i) {
        for (int j = 0; j < N; ++j) {
            std::cout << C[i * N + j] << " ";
        }
        std::cout << std::endl;
    }
}

MPI_Finalize();
return 0;
}
