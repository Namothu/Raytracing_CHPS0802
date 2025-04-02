#include "Sphere.h"

//Constructeur par default
Sphere::Sphere() : C() {
    this->R = 1.0;
}

//Constructeur par paramètre
Sphere::Sphere(const Point3D& C_ar, float Rayon) : C(C_ar), R(Rayon) {}

// Méthode pour afficher les informations sur la sphère
void Sphere::afficher() const {
    std::cout << "Point Centre : ";
    C.afficher();
    std::cout << "Rayon : ";
    std::cout << R;
}