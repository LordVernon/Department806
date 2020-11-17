#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <ctime>
#include<stdio.h>
#include "iostream"

using namespace std;
#define N 900

__global__ void armNumbWithCuda(int* a)
{
    int idx = threadIdx.x;
    int hund, dec, ones;
    hund = a[idx] / 100;
    dec = a[idx] / 10 % 10;
    ones = a[idx] % 10;
    int r = hund * hund * hund + dec * dec * dec + ones * ones * ones;
    if (r == a[idx])
    {
        printf("%d  ", a[idx]);
    }
}

void createArr(int* a)
{
    int j = 100;
    for (int i = 0; i < N; i++)
    {
        a[i] = j;
        j++;
    }
}

int main()
{
    int* a = new int[N];
    int* dev_a;
    float gpuTime = 0.0;
    cudaEvent_t start, end;
    cudaEventCreate(&start);
    cudaEventCreate(&end);
    cudaError_t cudaStatus;
    createArr(a);

    cudaStatus = cudaSetDevice(0);
    cudaStatus = cudaMalloc((void**)&dev_a, N * sizeof(int));
    cudaStatus = cudaMemcpy(dev_a, a, N * sizeof(int), cudaMemcpyHostToDevice);

    cout << "Armstrong numbers on GPU: ";
    cudaEventRecord(start, 0);
    armNumbWithCuda <<<1, N>>> (dev_a);
    cudaEventRecord(end, 0);
    cudaEventSynchronize(end);
    cudaEventElapsedTime(&gpuTime, start, end);
    cout << "\nGPU compute time: "<< gpuTime << " ms\n";

    cudaEventDestroy(start);
    cudaEventDestroy(end);
    cudaFree(dev_a);

	cout << "Armstrong numbers on CPU: ";
    clock_t begin = clock();
    int hund, dec, ones;
	for (int i = 0; i < N; i++)
	{
        hund = a[i] / 100;
        dec = a[i] / 10 % 10;
        ones = a[i] % 10;
        //int r = hund * hund * hund + dec * dec * dec + ones * ones * ones;
        int r = pow(hund, 3) + pow(dec, 3) + pow(ones, 3);
		if (r == a[i])
        {
            printf("%d  ", a[i]);
        }
	}
    clock_t cend1 = clock();
    double cpuTime = (double)(cend1 - begin) / CLOCKS_PER_SEC * 1000;

    printf("\nCPU compute time: %.4f ms\n", cpuTime);
    return 0;
}
