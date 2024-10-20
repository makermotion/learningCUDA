#include <cuda.h>
#include <stdio.h>
__global__ void helloWorld1() { printf("Hello, world 1!\n"); }
__global__ void helloWorld2() { printf("Hello, world 2!\n"); }

int main() {
  helloWorld1<<<1, 1>>>();
  helloWorld2<<<1, 1>>>();
  cudaDeviceSynchronize();
  printf("on CPU");
  return 0;
}
