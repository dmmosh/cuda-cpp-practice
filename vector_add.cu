#include <cudnn.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <math.h>
#include <assert.h>

// VECTOR ADDITION ON CUDA CORES
/*
__global__ keyword:
CUDA kernel
functions that are called from host but executed in the device, MUST BE VOID

*/
__global__ void vectorAdd(int* a, int* b, int* c, int n){
    // 1 thread PER ELEMENT that gets added

    /*
    BLOCKID:
    block number 
    start at 0

    BLOCKDIM:
    block size (constant, 256)

    THREADID:
    which thred in the thread block were in 
    starts at 0

    all are in x, y, z dimensions 
    
    */
    int tid = (blockIdx.x* blockDim.x) + threadIdx.x;

    if (tid<n){
        c[tid] = a[tid] + b[tid];
    }

}

void rand_0_99(int* arr, int n){
    for(int i=0; i<n; i++){
      arr[i] = (rand() % (99 - 1)) + 0;
    }
}

typedef struct arr{
    int* a;
    int* b;
    int* c;
} arr;

int main(){
    srand(time(NULL));
    int n = 1<<16; // 2^16 , number of elements
    
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
    rand_0_99(host.a, n);
    rand_0_99(host.b, n);


    // memcpy
    // cudaMemcpyaTob (a to b )
    cudaMemcpy(device.a, host.a, bytes, cudaMemcpyHostToDevice); // a, b, annd where to memcpy   
    cudaMemcpy(device.b, host.b, bytes, cudaMemcpyHostToDevice); // a, b, annd where to memcpy   
    cudaMemcpy(device.c, host.c, bytes, cudaMemcpyHostToDevice); // a, b, annd where to memcpy   

    int NUM_THREADS = 256; // amt of threads, multiple of 32
    int NUM_WARPS = NUM_THREADS/32;  // 8
    int NUM_BLOCKS  = n / NUM_THREADS;
    vectorAdd<<<NUM_BLOCKS,NUM_THREADS>>>(device.a,device.b,device.c,n);

    cudaMemcpy(host.c, device.c,bytes, cudaMemcpyDeviceToHost); // device: gpu, host: cpu


    for(int i = 0; i<n; i++){
        printf("%i ", host.c[i]);
    }

    cudaFree(device.a);
    cudaFree(device.b);
    cudaFree(device.c);


    // VALGRIND TO CHECK MEM
    free(host.a);
    free(host.b);
    free(host.c);

    return 0;
}