#include <cuda.h>
#include <stdio.h>
__global__ void helloWorld() { printf("Hello, world!\n"); }

int main() {
  helloWorld<<<1, 1>>>();
  cudaDeviceSynchronize();
  return 0;
}
