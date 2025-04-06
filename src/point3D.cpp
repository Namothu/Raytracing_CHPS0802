#include "point3D.h"

// Constructeur par défaut
Point3D::Point3D() : x(0), y(0), z(0) {}

//Constructeur par copie
Point3D::Point3D(const Point3D& p) : x(p.x), y(p.y), z(p.z) {}
    
// Constructeur par paramètre
Point3D::Point3D(float x_val, float y_val, float z_val) : x(x_val), y(y_val), z(z_val) {}
    
// Affichage
void Point3D::afficher() const {
    std::cout << "Point3D(" << x << ", " << y << ", " << z << ")\n";
}
    
// Au cas ou on a besoin de déplacer nos point (pour des tests)
void Point3D::deplacer(float dx, float dy, float dz) {
    x += dx;
    y += dy;
    z += dz;
}
    
// Méthode pour calculer la distance entre deux points
float Point3D::distance(const Point3D& p2) const {
    return sqrt((x - p2.x) * (x - p2.x) + (y - p2.y) * (y - p2.y) + (z - p2.z) * (z - p2.z));
}

float Point3D::getX() const {
    return this->x;
}

float Point3D::getY() const {
    return this->y;
}

float Point3D::getZ() const {
    return this->z;
}