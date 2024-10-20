#include <cuda.h>
#include <stdio.h>
#define N 1000

__global__ void square() { printf("%d\n", threadIdx.x * threadIdx.x); }

int main() {
  square<<<1, N>>>();
  cudaDeviceSynchronize();
  return 0;
}
