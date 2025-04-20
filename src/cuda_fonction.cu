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
) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;

    if (idx < num_rayons) {
        float t_min = 1e30f;  // Distance maximum initiale
        int object_plus_proche = -1;

        // Calcul de l'intersection pour les sphères
        for (int i = 0; i < num_spheres; i++) {
            float t = objets_sphere[i]->intersection(rayons[idx]);
            if (t >= 0.0f && t < t_min) {
                t_min = t;
                object_plus_proche = i;  // Indice de l'objet sphère
            }
        }

        // Calcul de l'intersection pour les plans
        for (int i = 0; i < num_plans; i++) {
            float t = objets_plan[i]->intersection(rayons[idx]);
            if (t >= 0.0f && t < t_min) {
                t_min = t;
                object_plus_proche = num_spheres + i;  // Indice de l'objet plan
            }
        }

        // Stocker les résultats pour ce rayon
        result_t[idx] = t_min;
        result_num_object[idx] = object_plus_proche;
    }
}


/*

__device__ void calculate_matrice_pixel_kernel_sphere( Object** d_listes_des_objects, Light* d_light, float lumiere_ambiante,
    Rayon* d_matrice_rayon, float* d_matrice_pixel, int width, int height, float distance_max_vision) {

    int i = blockIdx.x * blockDim.x + threadIdx.x;  // Coordonnée x du pixel
    int j = blockIdx.y * blockDim.y + threadIdx.y;  // Coordonnée y du pixel

    if (i >= width || j >= height) return;

    int object_plus_proche;
    float t_min;
    float t_tmp;

    object_plus_proche = -1;
    t_min = distance_max_vision;

    // Calcul de l'intersection avec tous les objets
    for (int obj_curr = 0; obj_curr < num_objects; obj_curr++) {
        t_tmp = d_listes_des_objects[obj_curr]->intersection(d_matrice_rayon[i * width + j]);

        if (t_tmp >= 0.0 && t_tmp < t_min) {
            t_min = t_tmp;
            object_plus_proche = obj_curr;
        }
    }

    // Calcul de la couleur si un objet a été trouvé
    if (object_plus_proche >= 0) {
        Point3D P = d_matrice_rayon[i * width + j].point_at_t(t_min);
        Materiel M = d_listes_des_objects[object_plus_proche]->calculerCouleur(P, d_light, lumiere_ambiante);

        // Stockage des valeurs de couleur dans la matrice_pixel
        int pixel_index = (i * width + j) * 3;
        d_matrice_pixel[pixel_index] = M.r;
        d_matrice_pixel[pixel_index + 1] = M.g;
        d_matrice_pixel[pixel_index + 2] = M.b;
    } else {
        // Sinon, on met tout à noir
        int pixel_index = (i * width + j) * 3;
        d_matrice_pixel[pixel_index] = 0.0f;
        d_matrice_pixel[pixel_index + 1] = 0.0f;
        d_matrice_pixel[pixel_index + 2] = 0.0f;
    }
}


__host__ void Vue::calculate_matrice_pixel_gpu(vector<Object*> listes_des_objects, Light * light,float lumiere_ambiante) {
    int width = matrice_rayon.size();
    int height = matrice_rayon[0].size();

    // Allocation de la mémoire sur le GPU
    Object** d_listes_des_objects;
    cudaMalloc(&d_listes_des_objects, listes_des_objects.size() * sizeof(Object*));
    cudaMemcpy(d_listes_des_objects, listes_des_objects.data(), listes_des_objects.size() * sizeof(Object*), cudaMemcpyHostToDevice);

    Light* d_light;
    cudaMalloc(&d_light, sizeof(Light));
    cudaMemcpy(d_light, light, sizeof(Light), cudaMemcpyHostToDevice);

    // Allocation de la mémoire pour la matrice_rayons et matrice_pixel
    Ray* d_matrice_rayon;
    cudaMalloc(&d_matrice_rayon, width * height * sizeof(Ray));
    cudaMemcpy(d_matrice_rayon, matrice_rayon.data(), width * height * sizeof(Ray), cudaMemcpyHostToDevice);

    float* d_matrice_pixel;
    cudaMalloc(&d_matrice_pixel, width * height * 3 * sizeof(float));

    // Définir les dimensions de la grille et des blocs
    dim3 threadsPerBlock(16, 16);
    dim3 numBlocks((width + threadsPerBlock.x - 1) / threadsPerBlock.x, (height + threadsPerBlock.y - 1) / threadsPerBlock.y);

    // Lancer le kernel CUDA
    calculate_matrice_pixel_kernel_sphere<<<numBlocks, threadsPerBlock>>>(d_listes_des_objects, d_light, lumiere_ambiante, d_matrice_rayon, d_matrice_pixel, width, height, distance_max_vision);

    // Vérification des erreurs CUDA
    cudaDeviceSynchronize();

    // Récupérer les résultats sur le GPU
    cudaMemcpy(matrice_pixel.data(), d_matrice_pixel, width * height * 3 * sizeof(float), cudaMemcpyDeviceToHost);

    // Libérer la mémoire GPU
    cudaFree(d_listes_des_objects);
    cudaFree(d_light);
    cudaFree(d_matrice_rayon);
    cudaFree(d_matrice_pixel);
}