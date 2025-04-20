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

void launch_calculate_intersections(
    Rayon* h_rayons,
    int num_rayons,
    Object** h_spheres,
    int num_spheres,
    Object** h_plans,
    int num_plans,
    float* h_result_t,
    int* h_result_num_object
);


#endif // CUDA_FONCTION_H