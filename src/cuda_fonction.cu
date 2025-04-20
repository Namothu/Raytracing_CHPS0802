#include "cuda_fonction.cuh"

struct SphereData {
    Point3D center;
    float radius;
};

struct PlanData {
    Point3D A;
    Vecteur3D normal;
};

// Fonction device d'intersection pour les sphères
__device__ float intersection_sphere(const Rayon& ray, const SphereData& sphere) {
    Vecteur3D oc = Vecteur3D(sphere.center, ray.origine);
    float a = ray.direction.produitScalaire(ray.direction);
    float b = 2.0f * oc.produitScalaire(ray.direction);
    float c = oc.produitScalaire(oc) - (sphere.radius * sphere.radius);
    float discriminant = b * b - 4 * a * c;

    if (discriminant < 0.0f) return -1.0f;

    float t1 = (-b + sqrtf(discriminant)) / (2.0f * a);
    float t2 = (-b - sqrtf(discriminant)) / (2.0f * a);

    if (t1 >= 0.0f) {
        return (t2 >= 0.0f && t2 < t1) ? t2 : t1;
    }

    return -1.0f;
}

// Fonction device d'intersection pour les plans
__device__ float intersection_plan(const Rayon& ray, const PlanData& plan) {
    Vecteur3D AO = Vecteur3D(ray.origine, plan.A);
    float denom = ray.direction.produitScalaire(plan.normal);
    if (fabs(denom) < 1e-6f) return -1.0f;
    return AO.produitScalaire(plan.normal) / denom;
}

__global__ void calculate_intersections_kernel(
    Rayon* rayons,
    SphereData* spheres,
    int num_spheres,
    PlanData* plans,
    int num_plans,
    float* result_t,
    int* result_object_id,
    int num_rayons
) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx >= num_rayons) return;

    Rayon ray = rayons[idx];
    float t_min = 1e30f;
    int obj_id = -1;

    for (int i = 0; i < num_spheres; i++) {
        float t = intersect_sphere(ray, spheres[i]);
        if (t >= 0.0f && t < t_min) {
            t_min = t;
            obj_id = i; // sphères en premier
        }
    }

    for (int i = 0; i < num_plans; i++) {
        float t = intersect_plan(ray, plans[i]);
        if (t >= 0.0f && t < t_min) {
            t_min = t;
            obj_id = num_spheres + i;
        }
    }

    result_t[idx] = t_min;
    result_object_id[idx] = obj_id;
}

void launch_calculate_intersections(
    Rayon* h_rayons,
    int num_rayons,
    Sphere** h_spheres,
    int num_spheres,
    Plan** h_plans,
    int num_plans,
    float* h_result_t,
    int* h_result_object_id
) {
    // === 1. Convertir vers SphereData et PlanData ===
    std::vector<SphereData> spheres_data(num_spheres);
    for (int i = 0; i < num_spheres; ++i) {
        spheres_data[i].center = h_spheres[i]->C;
        spheres_data[i].radius = h_spheres[i]->R;
    }

    std::vector<PlanData> plans_data(num_plans);
    for (int i = 0; i < num_plans; ++i) {
        plans_data[i].A = h_plans[i]->A;
        plans_data[i].normal = h_plans[i]->normal;
    }

    // === 2. Allocation device ===
    Rayon* d_rayons;
    SphereData* d_spheres;
    PlanData* d_plans;
    float* d_result_t;
    int* d_result_object_id;

    cudaMalloc(&d_rayons, num_rayons * sizeof(Rayon));
    cudaMalloc(&d_spheres, num_spheres * sizeof(SphereData));
    cudaMalloc(&d_plans, num_plans * sizeof(PlanData));
    cudaMalloc(&d_result_t, num_rayons * sizeof(float));
    cudaMalloc(&d_result_object_id, num_rayons * sizeof(int));

    // === 3. Copier les données vers le GPU ===
    cudaMemcpy(d_rayons, h_rayons, num_rayons * sizeof(Rayon), cudaMemcpyHostToDevice);
    cudaMemcpy(d_spheres, spheres_data.data(), num_spheres * sizeof(SphereData), cudaMemcpyHostToDevice);
    cudaMemcpy(d_plans, plans_data.data(), num_plans * sizeof(PlanData), cudaMemcpyHostToDevice);

    // === 4. Lancer le kernel ===
    int threadsPerBlock = 256;
    int blocks = (num_rayons + threadsPerBlock - 1) / threadsPerBlock;

    calculate_intersections_kernel<<<blocks, threadsPerBlock>>>(
        d_rayons, d_spheres, num_spheres,
        d_plans, num_plans,
        d_result_t, d_result_object_id,
        num_rayons
    );

    cudaDeviceSynchronize(); // Attendre la fin du kernel

    // === 5. Copier les résultats vers le host ===
    cudaMemcpy(h_result_t, d_result_t, num_rayons * sizeof(float), cudaMemcpyDeviceToHost);
    cudaMemcpy(h_result_object_id, d_result_object_id, num_rayons * sizeof(int), cudaMemcpyDeviceToHost);

    // === 6. Libération de la mémoire ===
    cudaFree(d_rayons);
    cudaFree(d_spheres);
    cudaFree(d_plans);
    cudaFree(d_result_t);
    cudaFree(d_result_object_id);
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
}*/