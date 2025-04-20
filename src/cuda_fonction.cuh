#ifndef CUDA_FONCTION_H
#define CUDA_FONCTION_H

#include "Object.h"
#include "Sphere.h"
#include "Plan.h"
#include "Vue.h"
#include <cmath>
#include <cuda.h>
#include <curand.h>

#include "cuda_struct.cuh"

//Kernel qui va nous servir a faire nos calcul d'intersections de tout nos objets
__global__ void calculate_intersections_kernel(
    CudaRayon* rays, int num_rays,
    SphereData* spheres, int num_spheres,
    PlanData* plans, int num_plans,
    float* t_results, int* object_ids);

//Pour lancer le kernel (et pour éviter les problèmes de compilation cpp & cu)
void launch_calculate_intersections(
    std::vector<Rayon>& rays_host,
    std::vector<Object*>& objects,
    float* t_results_host, int* object_ids_host);


#endif // CUDA_FONCTION_H