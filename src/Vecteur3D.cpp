#include "Vecteur3D.h"

// Constructeur par défaut (initialise les coordonnées à 0)
Vecteur3D::Vecteur3D() : x(0), y(0), z(0) {}

Vecteur3D::Vecteur3D(const Vecteur3D& v) : x(v.x), y(v.y), z(v.z) {}

// Constructeur avec paramètres (permet de définir les composantes)
Vecteur3D::Vecteur3D(float x_val, float y_val, float z_val) : x(x_val), y(y_val), z(z_val) {}

// Méthode pour afficher le vecteur
void Vecteur3D::afficher() const {
    std::cout << "Vecteur3D(" << x << ", " << y << ", " << z << ")\n";
}

// Méthode pour additionner deux vecteurs
Vecteur3D Vecteur3D::additionner(const Vecteur3D& v2) const {
    return Vecteur3D(x + v2.x, y + v2.y, z + v2.z);
}

float Vecteur3D::getX() {
    return this->x;
}

float Vecteur3D::getY() {
    return this->y;
}

float Vecteur3D::getZ() {
    return this->z;
}