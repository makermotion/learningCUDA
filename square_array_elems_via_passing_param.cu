#include <cuda.h>  // Include the CUDA runtime API
#include <stdio.h> // Include the standard I/O library for printf
#define N 100      // Define a constant N with value 100

// Kernel function to square the index of the thread
__global__ void square(int *a) {
  int idx = threadIdx.x;
  a[idx] = idx * idx;
}

int main() {
  int a[N], *dev_a; // Declare an array 'a' of size N and a pointer 'dev_a' for
                    // device memory
  int i;            // Declare an integer 'i' for loop iteration
  cudaError_t err;  // Declare a variable to hold CUDA error codes

  // Allocate memory on the device for 'dev_a' of size N integers
  err = cudaMalloc(&dev_a, N * sizeof(int));
  if (err != cudaSuccess) {
    fprintf(stderr, "Failed to allocate device memory: %s\n",
            cudaGetErrorString(err));
    return 1;
  }

  // Launch the kernel with 1 block and N threads
  square<<<1, N>>>(dev_a);
  err = cudaGetLastError();
  if (err != cudaSuccess) {
    fprintf(stderr, "Failed to launch kernel: %s\n", cudaGetErrorString(err));
    cudaFree(dev_a);
    return 1;
  }

  // Copy the data from device memory to host memory
  err = cudaMemcpy(a, dev_a, N * sizeof(int), cudaMemcpyDeviceToHost);
  if (err != cudaSuccess) {
    fprintf(stderr, "Failed to copy data from device to host: %s\n",
            cudaGetErrorString(err));
    cudaFree(dev_a);
    return 1;
  }

  // Loop through the array 'a' and print each element
  for (i = 0; i < N; i++) {
    printf("%d\n", a[i]);
  }

  // Free the allocated device memory
  cudaFree(dev_a);

  return 0; // Return 0 to indicate successful completion
}
