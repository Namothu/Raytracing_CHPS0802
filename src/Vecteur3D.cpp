#include "Vecteur3D.h"

// Constructeur par défaut (initialise les coordonnées à 0)
Vecteur3D::Vecteur3D() {
    valeurs = {0.0, 0.0, 0.0};
}

Vecteur3D::Vecteur3D(const Vecteur3D& v) {
    valeurs = {v.valeurs[0], v.valeurs[1], v.valeurs[2]};
}

// Constructeur avec paramètres (permet de définir les composantes)
Vecteur3D::Vecteur3D(float x_val, float y_val, float z_val) {
    valeurs = {x_val,y_val,z_val};
}

// Constructeur par la distance entre deux points
Vecteur3D::Vecteur3D(const Point3D& point1, const Point3D& point2) {
    valeurs = {point2.getX() - point1.getX(), point2.getY() - point1.getY(), point2.getZ() - point1.getZ()};
}

// Méthode pour afficher le vecteur
void Vecteur3D::afficher() const {
    std::cout << "Vecteur3D(" << valeurs[0] << ", " << valeurs[1] << ", " << valeurs[2] << ")\n";
}


//Getteurs
float Vecteur3D::getX() {
    return this->valeurs[0];
}

float Vecteur3D::getY() {
    return this->valeurs[1];
}

float Vecteur3D::getZ() {
    return this->valeurs[2];
}


//Operation
// Addition de deux vecteurs
Vecteur3D Vecteur3D::operator+(const Vecteur3D& V2) const {
    return Vecteur3D(valeurs[0] + V2.valeurs[0], valeurs[1] + V2.valeurs[1], valeurs[2] + V2.valeurs[2]);
}

// Multiplication de deux vecteurs (produit vectoriel) -> retourne un vecteur
Vecteur3D Vecteur3D::operator*(const Vecteur3D& V2) const {
    float resultX = valeurs[1] * V2.valeurs[2] - valeurs[2] * V2.valeurs[1];
    float resultY = valeurs[2] * V2.valeurs[0] - valeurs[0] * V2.valeurs[2];
    float resultZ = valeurs[0] * V2.valeurs[1] - valeurs[1] * V2.valeurs[0];
    return Vecteur3D(resultX, resultY, resultZ);
}

// Multiplication d'un vecteur par un scalaire
Vecteur3D Vecteur3D::operator*(float f) const {
    return Vecteur3D(valeurs[0] * f, valeurs[1] * f, valeurs[2] * f);
}

float Vecteur3D::produitScalaire(const Vecteur3D& V2) {
    return valeurs[0] * V2.valeurs[0] + valeurs[1] * V2.valeurs[1] + valeurs[2] * V2.valeurs[2];
}

Vecteur3D Vecteur3D::calcul_normale_3point(const Point3D& point1, const Point3D& point2, const Point3D& point3) {
    Vecteur3D u = Vecteur3D(point2.getX() - point1.getX(), point2.getY() - point1.getY(), point2.getZ() - point1.getZ());
    Vecteur3D v = Vecteur3D(point3.getX() - point1.getX(), point3.getY() - point1.getY(), point3.getZ() - point1.getZ());
    return Vecteur3D(u.getY() * v.getZ() - u.getZ() * v.getY(), u.getZ() * v.getX() - u.getX() * v.getZ(), u.getX() * v.getY() - u.getY() * v.getX());
}