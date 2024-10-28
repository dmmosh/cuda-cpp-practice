#include <cudnn.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <assert.h>

// VECTOR ADDITION ON CUDA CORES
/*
__global__ keyword:

functions that are called from host but executed in the device, MUST BE VOID

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

    arr host{    // host 
        (int*)malloc(bytes),
        (int*)malloc(bytes),
        (int*)malloc(bytes)
    };

    arr device;
    // device has its own memory 
    // allocated to vram
    // remember to do cudaFree
    cudaMalloc(&device.a,bytes); // mallocs space on the device
    cudaMalloc(&device.b,bytes);        
    cudaMalloc(&device.c,bytes);     

    /*
    DEVICE: gpu
    HOST: cpu
    */



    cudaMemcpy(device.a, host.a, bytes, cudaMemcpyHostToDevice); // a, b, annd where to memcpy   
    cudaMemcpy(device.b, host.b, bytes, cudaMemcpyHostToDevice); // a, b, annd where to memcpy   
    cudaMemcpy(device.c, host.c, bytes, cudaMemcpyHostToDevice); // a, b, annd where to memcpy   




    return 0;
}