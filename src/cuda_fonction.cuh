#ifndef CUDA_FONCTION_H
#define CUDA_FONCTION_H

#include "Object.h"
#include "Sphere.h"
#include "Plan.h"
#include "Vue.h"
#include <cuda.h>
#include <curand.h>

__global__ void calculate_intersections_kernel(
    CudaRayon* rays, int num_rays,
    SphereData* spheres, int num_spheres,
    PlanData* plans, int num_plans,
    float* t_results, int* object_ids);

void launch_calculate_intersections(
    std::vector<Rayon>& rays_cpu,
    std::vector<Object*>& objects,
    float* t_results_host, int* object_ids_host);


#endif // CUDA_FONCTION_H