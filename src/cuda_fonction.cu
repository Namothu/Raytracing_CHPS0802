#include "cuda_fonction.cuh"

// Fonction device d'intersection pour les sphères
__device__ float intersect_sphere(const CudaRayon& ray, const SphereData& sphere) {
    CudaVecteur3D oc(ray.origine, sphere.center);

    float a = ray.direction.produitScalaire(ray.direction);
    float b = 2.0f * oc.produitScalaire(ray.direction);
    float c = oc.produitScalaire(oc) - sphere.radius * sphere.radius;

    float discriminant = b * b - 4.0f * a * c;
    if (discriminant < 0.0f) return -1.0f;

    float t1 = (-b + sqrtf(discriminant)) / (2.0f * a);
    float t2 = (-b - sqrtf(discriminant)) / (2.0f * a);

    if (t1 >= 0.0f) return (t2 >= 0.0f && t2 < t1) ? t2 : t1;
    return -1.0f;
}

// Fonction device d'intersection pour les plans
__device__ float intersect_plan(const CudaRayon& ray, const PlanData& plan) {
    CudaVecteur3D AO(ray.origine, plan.A);  // vecteur de A vers O
    float denom = ray.direction.produitScalaire(plan.normal);

    if (fabs(denom) < 1e-6) return -1.0f;  // parallèle au plan

    float t = AO.produitScalaire(plan.normal) / denom;
    return (t >= 0.0f) ? t : -1.0f;
}

__global__ void calculate_intersections_kernel(
    CudaRayon* rays, int num_rays,
    SphereData* spheres, int num_spheres,
    PlanData* plans, int num_plans,
    float* t_results, int* object_ids)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx >= num_rays) return;

    CudaRayon ray = rays[idx];
    float closest_t = 1e30f;
    int closest_id = -1;
    int object_counter = 0;

    // Test les sphères
    for (int i = 0; i < num_spheres; ++i) {
        float t = intersect_sphere(ray, spheres[i]);
        if (t >= 0.0f && t < closest_t) {
            closest_t = t;
            closest_id = object_counter + i; // offset total des objets
        }
    }
    object_counter += num_spheres;

    // Test les plans
    for (int i = 0; i < num_plans; ++i) {
        float t = intersect_plan(ray, plans[i]);
        if (t >= 0.0f && t < closest_t) {
            closest_t = t;
            closest_id = object_counter + i; // offset global
        }
    }

    t_results[idx] = closest_t;
    object_ids[idx] = closest_id;
}


void launch_calculate_intersections(
    std::vector<Rayon>& rays_cpu,
    std::vector<Object*>& objects,
    float* t_results_host, int* object_ids_host)
{
    int num_rays = rays_cpu.size();
    int num_spheres = 0;
    int num_plans = 0;

    // 🔹 Séparer et compter les objets
    std::vector<Sphere*> spheres_cpu;
    std::vector<Plan*> plans_cpu;

    for (auto obj : objects) {
        if (auto* s = dynamic_cast<Sphere*>(obj)) {
            spheres_cpu.push_back(s);
        } else if (auto* p = dynamic_cast<Plan*>(obj)) {
            plans_cpu.push_back(p);
        }
    }

    num_spheres = spheres_cpu.size();
    num_plans = plans_cpu.size();

    // 🔸 Allouer et remplir les versions CUDA
    std::vector<CudaRayon> rays_host(num_rays);
    for (int i = 0; i < num_rays; ++i) {
        rays_host[i].origine = CudaPoint3D(
            rays_cpu[i].origine.getX(),
            rays_cpu[i].origine.getY(),
            rays_cpu[i].origine.getZ());
        rays_host[i].direction = CudaVecteur3D(
            rays_cpu[i].direction.getX(),
            rays_cpu[i].direction.getY(),
            rays_cpu[i].direction.getZ());
    }

    std::vector<SphereData> spheres_host(num_spheres);
    for (int i = 0; i < num_spheres; ++i) {
        Point3D c = spheres_cpu[i]->C;
        spheres_host[i].center = CudaPoint3D(c.getX(), c.getY(), c.getZ());
        spheres_host[i].radius = spheres_cpu[i]->R;
    }

    

    std::vector<PlanData> plans_host(num_plans);
    for (int i = 0; i < num_plans; ++i) {
        Point3D A = plans_cpu[i]->A;
        Vecteur3D N = plans_cpu[i]->normal;
        plans_host[i].A = CudaPoint3D(A.getX(), A.getY(), A.getZ());
        plans_host[i].normal = CudaVecteur3D(N.getX(), N.getY(), N.getZ());
    }

    // 🔹 Pointeurs device
    CudaRayon* rays_dev;
    SphereData* spheres_dev;
    PlanData* plans_dev;
    float* t_results_dev;
    int* object_ids_dev;

    size_t ray_size = num_rays * sizeof(CudaRayon);
    size_t sphere_size = num_spheres * sizeof(SphereData);
    size_t plan_size = num_plans * sizeof(PlanData);
    size_t result_size = num_rays * sizeof(float);
    size_t id_size = num_rays * sizeof(int);

    printf("Coucou interieur fonction 1\n");

    // 🔸 Allocation sur le GPU
    cudaMalloc(&rays_dev, ray_size);
    cudaMalloc(&spheres_dev, sphere_size);
    cudaMalloc(&plans_dev, plan_size);
    cudaMalloc(&t_results_dev, result_size);
    cudaMalloc(&object_ids_dev, id_size);

    printf("Coucou interieur fonction 2\n");

    // 🔸 Transfert CPU → GPU
    cudaMemcpy(rays_dev, rays_host.data(), ray_size, cudaMemcpyHostToDevice);
    cudaMemcpy(spheres_dev, spheres_host.data(), sphere_size, cudaMemcpyHostToDevice);
    cudaMemcpy(plans_dev, plans_host.data(), plan_size, cudaMemcpyHostToDevice);

    // 🔹 Lancer le kernel
    int threads = 256;
    int blocks = (num_rays + threads - 1) / threads;

    printf("On lance le calculate");

    calculate_intersections_kernel<<<blocks, threads>>>(
        rays_dev, num_rays,
        spheres_dev, num_spheres,
        plans_dev, num_plans,
        t_results_dev, object_ids_dev);

    cudaDeviceSynchronize();

    // 🔸 Copie des résultats GPU → CPU
    cudaMemcpy(t_results_host, t_results_dev, result_size, cudaMemcpyDeviceToHost);
    cudaMemcpy(object_ids_host, object_ids_dev, id_size, cudaMemcpyDeviceToHost);

    // 🔹 Libération GPU
    cudaFree(rays_dev);
    cudaFree(spheres_dev);
    cudaFree(plans_dev);
    cudaFree(t_results_dev);
    cudaFree(object_ids_dev);
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