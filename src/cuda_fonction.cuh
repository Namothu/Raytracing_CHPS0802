#ifndef CUDA_FONCTION_H
#define CUDA_FONCTION_H

#include "Object.h"
#include "Sphere.h"
#include "Plan.h"
#include "Vue.h"
#include <cuda.h>
#include <curand.h>

__global__ void calculate_intersections_kernel(
    Rayon* rayons, 
    Object** objets_sphere, 
    int num_spheres, 
    Object** objets_plan, 
    int num_plans,
    float* result_t, 
    int* result_num_object,
    int num_rayons
);


#endif // CUDA_FONCTION_H