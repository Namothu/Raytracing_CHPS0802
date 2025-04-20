#include "cuda_fonction.cuh"

//Copie de la fonction intersection qu'on peut trouver dans la Sphere mais version device
__device__ float intersection_sphere(const CudaRayon& ray, const SphereData& sphere) {
    CudaVecteur3D oc(ray.origine, sphere.center);

    float a = ray.direction.produitScalaire(ray.direction);
    float b = 2.0f * oc.produitScalaire(ray.direction);
    float c = oc.produitScalaire(oc) - sphere.radius * sphere.radius;

    float discri = b * b - 4.0f * a * c;
    if (discri < 0.0f) return -1.0f; //Je pense que en revoyant les maths les math le discriminant peut être négatif donc normalment ça veut dire pas de solution

    float t1 = (-b + sqrtf(discri)) / (2.0f * a);
    float t2 = (-b - sqrtf(discri)) / (2.0f * a);

    if (t1 >= 0.0f){
        return (t2 >= 0.0f && t2 < t1) ? t2 : t1;
    }
    return -1.0f;
}

//Copie de la fonction intersection qu'on peut trouver dans la Plan mais version device
__device__ float intersection_plan(const CudaRayon& ray, const PlanData& plan) {
    CudaVecteur3D AO(ray.origine, plan.A);  // vecteur de A vers O
    float denom = ray.direction.produitScalaire(plan.normal);

    if (fabs(denom) < 1e-6) {
        return -1.0f; // Presque entièrement parallèle au plan
    } 

    float t = AO.produitScalaire(plan.normal) / denom;
    return (t >= 0.0f) ? t : -1.0f;
}

//Kernel qui permet de calculer notre matrice de <t,num> qui correspond au élément les plus proche qui a une intersection
__global__ void calculate_intersections_kernel(
    CudaRayon* rays, int num_rays,
    SphereData* spheres, int num_spheres,
    PlanData* plans, int num_plans,
    float* t_results, int* object_ids)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx >= num_rays) return;

    CudaRayon ray = rays[idx];
    float proche_t = 1e30f;
    int proche_id = -1;
    int object_counter = 0;

    // Test sur les sphère
    for (int i = 0; i < num_spheres; ++i) {
        float t = intersection_sphere(ray, spheres[i]);
        if (t >= 0.0f && t < proche_t) {
            proche_t = t;
            proche_id = object_counter + i; //offset total des objets
        }
    }
    object_counter += num_spheres;

    // Test sur les plans
    for (int i = 0; i < num_plans; ++i) {
        float t = intersection_plan(ray, plans[i]);
        if (t >= 0.0f && t < proche_t) {
            proche_t = t;
            proche_id = object_counter + i; // offset global
        }
    }

    t_results[idx] = proche_t;
    object_ids[idx] = proche_id;
}

//Launcheur qui transforme nos objet en élément qu'un cuda peut prendre et lance accessoirement un kernel
void launch_calculate_intersections(
    std::vector<Rayon>& rays_host,
    std::vector<Object*>& objects,
    float* t_results_host, int* object_ids_host)
{
    int num_rays = rays_host.size();
    int num_spheres = 0;
    int num_plans = 0;

    // Partie séparation des objet en sphère et plan
    std::vector<Sphere*> spheres_host;
    std::vector<Plan*> plans_host;

    for (auto obj : objects) {
        if (auto* s = dynamic_cast<Sphere*>(obj)) {
            spheres_host.push_back(s);
        } else if (auto* p = dynamic_cast<Plan*>(obj)) {
            plans_host.push_back(p);
        }
    }

    num_spheres = spheres_host.size();
    num_plans = plans_host.size();

    // Partie allocation host et remplissage de nos élément dans notre cuda
    std::vector<CudaRayon> rays_host(num_rays);
    for (int i = 0; i < num_rays; ++i) {
        rays_host[i].origine = CudaPoint3D(
            rays_host[i].origine.getX(),
            rays_host[i].origine.getY(),
            rays_host[i].origine.getZ());
        rays_host[i].direction = CudaVecteur3D(
            rays_host[i].direction.getX(),
            rays_host[i].direction.getY(),
            rays_host[i].direction.getZ());
    }

    std::vector<SphereData> spheres_host(num_spheres);
    for (int i = 0; i < num_spheres; ++i) {
        Point3D c = spheres_host[i]->C;
        spheres_host[i].center = CudaPoint3D(c.getX(), c.getY(), c.getZ());
        spheres_host[i].radius = spheres_host[i]->R;
    }

    std::vector<PlanData> plans_host(num_plans);
    for (int i = 0; i < num_plans; ++i) {
        Point3D A = plans_host[i]->A;
        Vecteur3D N = plans_host[i]->normal;
        plans_host[i].A = CudaPoint3D(A.getX(), A.getY(), A.getZ());
        plans_host[i].normal = CudaVecteur3D(N.getX(), N.getY(), N.getZ());
    }

    //On délcare nos 60000000 de pointeur pour pouvoir balancer sur le cpu tranquille
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

    // Allocation sur le GPU
    cudaMalloc(&rays_dev, ray_size);
    cudaMalloc(&spheres_dev, sphere_size);
    cudaMalloc(&plans_dev, plan_size);
    cudaMalloc(&t_results_dev, result_size);
    cudaMalloc(&object_ids_dev, id_size);

    // Transfert CPU → GPU
    cudaMemcpy(rays_dev, rays_host.data(), ray_size, cudaMemcpyHostToDevice);
    cudaMemcpy(spheres_dev, spheres_host.data(), sphere_size, cudaMemcpyHostToDevice);
    cudaMemcpy(plans_dev, plans_host.data(), plan_size, cudaMemcpyHostToDevice);


    // Lancage du Kernel
    int threads = 256;
    int blocks = (num_rays + threads - 1) / threads;

    calculate_intersections_kernel<<<blocks, threads>>>(
        rays_dev, num_rays,
        spheres_dev, num_spheres,
        plans_dev, num_plans,
        t_results_dev, object_ids_dev);


    cudaDeviceSynchronize();

    // Copie des résultats GPU → CPU
    cudaMemcpy(t_results_host, t_results_dev, result_size, cudaMemcpyDeviceToHost);
    cudaMemcpy(object_ids_host, object_ids_dev, id_size, cudaMemcpyDeviceToHost);

    // On free tout le gpu
    cudaFree(rays_dev);
    cudaFree(spheres_dev);
    cudaFree(plans_dev);
    cudaFree(t_results_dev);
    cudaFree(object_ids_dev);
}