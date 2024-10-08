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
__global__ void make_arr(int* arr){ // kernel, runs on the GPU and can be run by cpu
    //usually void and do things on the argument
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
    std::cout << "fdsddcscd";
    int* arr = NULL;
    std::cout<<arr;
    
    return 0;
}