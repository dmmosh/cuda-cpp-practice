#include <iostream>
#include <string>
#include <memory>
#include <cudnn_adv.h>
/*
CUDA PRACTICE 

https://youtu.be/86FAWCzIe_4

typical CUDA flow:
1 cpu allocates memory
2 cpu copies data to gpu
3 cpu launched kernel on gpu 
4 cpu copies from gpu back to cpu to do something with it

cpu: host, execuses FUNCTIONS
gpu: device, execuses KERNELS (functions)
*/


/*
naming schemes:
h_A: cpu with variable name A
d_A: gpu with variable name A

*/

/*
hirearchy:
each kernel (gpu function) is a thread

threads -> blocks -> grids 
aka 
kernel executed as a grid of blocks of threads


*/
__global__ void print_pos(void){ // kernel, runs on the GPU and can be run by cpu
    //usually void and do things on the argument
    //std::cout << "THREAD DIMS:\n";
    //std::cout << threadIdx.x << '\t' << threadIdx.y << '\t' << threadIdx.z << '\n';
    printf("THREAD: %i\t%i\t%i\tBLOCK: %i\t%i\t%i\n", threadIdx.x, threadIdx.y, threadIdx.z, blockIdx.x, blockIdx.y, blockIdx.z); //ONLY PRINTF WORKS NOT STD COUT 
    
    
    return;
}

__global__ void free_arr(int* arr){
    return;
}

__device__ void gpu_only(void){ // functions ONLY for the gpu

}

__host__ void hello(void){ // function that runs on the CPU (dont need, implicitly runs on cpu)


}

int main(){
    int t_x = 4, 
        t_y = 4, 
        t_z = 4;

    dim3 thread_dim(t_x, t_y, t_z);

    int b_x = 2,
        b_y = 3,
        b_z = 4;
    
    dim3 block_dim(b_x, b_y, b_z);
    
    int t_per_block = t_x*t_y*t_z; // threads per block
    int b_per_grid = b_x*b_y*b_z; // blocks per grid

    int total_threads = t_per_block*b_per_grid;

    int* arr = NULL;


    print_pos<<<block_dim, thread_dim>>>();
    cudaDeviceSynchronize();
    return 0;
}