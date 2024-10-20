#include <cuda.h>
#include <stdio.h>
#define msg "Hello, World!\n"

__global__ void hello_from_gpu(void) { printf(msg); }

int main() {
  hello_from_gpu<<<1, 32>>>();
  cudaDeviceSynchronize();
  return 0;
}
