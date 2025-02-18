#include <cuda.h>
#include "mm_cuda.h"

__global__ void matrixMultiplyKernel(int *A, int *B, int *C, int rowsToProcess) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if (row < rowsToProcess && col < N) {
        int sum = 0;
        for (int k = 0; k < N; ++k) {
            sum += A[row * N + k] * B[k * N + col];
        }
        C[row * N + col] = sum;
    }
}

void matrixMultiply(int *A, int *B, int *C, int rowsToProcess) {
    int *d_A, *d_B, *d_C;

    // Allocate device memory
    cudaMalloc((void **)&d_A, rowsToProcess * N * sizeof(int));
    cudaMalloc((void **)&d_B, N * N * sizeof(int));
    cudaMalloc((void **)&d_C, rowsToProcess * N * sizeof(int));

    // Copy data to device
    cudaMemcpy(d_A, A, rowsToProcess * N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, N * N * sizeof(int), cudaMemcpyHostToDevice);

    // Define block and grid sizes
    dim3 threadsPerBlock(16, 16);
    dim3 blocksPerGrid((N + threadsPerBlock.x - 1) / threadsPerBlock.x,
                       (rowsToProcess + threadsPerBlock.y - 1) / threadsPerBlock.y);

// Define block and grid sizes
dim3 threadsPerBlock(16, 16);
dim3 blocksPerGrid((N + threadsPerBlock.x - 1) / threadsPerBlock.x,
                   (rowsToProcess + threadsPerBlock.y - 1) / threadsPerBlock.y);

// Launch kernel
matrixMultiplyKernel<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, 
                                                         rowsToProcess);

// Copy result back to host
cudaMemcpy(C, d_C, rowsToProcess * N * sizeof(int), cudaMemcpyDeviceToHost);

// Free device memory
cudaFree(d_A);
cudaFree(d_B);
cudaFree(d_C);
}
