#ifndef CUDA_STRUCT
#define CUDA_STRUCT

struct CudaPoint3D {
    float x, y, z;

    __host__ __device__
    CudaPoint3D() : x(0), y(0), z(0) {}

    __host__ __device__
    CudaPoint3D(float x, float y, float z) : x(x), y(y), z(z) {}
};

struct CudaVecteur3D {
    float x, y, z;

    __host__ __device__
    CudaVecteur3D() : x(0), y(0), z(0) {}

    __host__ __device__
    CudaVecteur3D(float x, float y, float z) : x(x), y(y), z(z) {}

    __host__ __device__
    CudaVecteur3D(const CudaPoint3D& from, const CudaPoint3D& to)
        : x(to.x - from.x), y(to.y - from.y), z(to.z - from.z) {}

    __host__ __device__
    float produitScalaire(const CudaVecteur3D& v) const {
        return x * v.x + y * v.y + z * v.z;
    }

    __host__ __device__
    CudaVecteur3D operator*(float f) const {
        return CudaVecteur3D(x * f, y * f, z * f);
    }

    __host__ __device__
    CudaVecteur3D operator+(const CudaVecteur3D& v) const {
        return CudaVecteur3D(x + v.x, y + v.y, z + v.z);
    }
};

struct CudaRayon {
    CudaPoint3D origine;
    CudaVecteur3D direction;

    __host__ __device__
    CudaRayon() {}

    __host__ __device__
    CudaRayon(CudaPoint3D o, CudaVecteur3D d) : origine(o), direction(d) {}

    __host__ __device__
    CudaPoint3D point_at_t(float t) const {
        return CudaPoint3D(
            origine.x + t * direction.x,
            origine.y + t * direction.y,
            origine.z + t * direction.z
        );
    }
};

#endif //CUDA_STRUCT