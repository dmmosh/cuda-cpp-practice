#include <cudnn.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <assert.h>

// VECTOR ADDITION ON CUDA CORES
/*
__global__ keyword:

functions that are called from cpu but executed in the gpu, MUST BE VOID

*/
__global__ void vectorAdd(int* a, int* b, int* c, int n){
}


typedef struct arr{
    int* a;
    int* b;
    int* c;
} arr;

int main(){
    int n = 1<<16; // 2^16 
    
    size_t bytes = sizeof(int)*n; // amt of memory

    arr cpu{    // cpu 
        (int*)malloc(bytes),
        (int*)malloc(bytes),
        (int*)malloc(bytes)
    };

    arr gpu;
    // gpu has its own memory 
    cudaMalloc(&gpu.a,bytes); // mallocs space on the gpu
    cudaMalloc(&gpu.b,bytes);        
    cudaMalloc(&gpu.c,bytes);        

    return 0;
}