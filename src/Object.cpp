#include "Object.h"

Object::Object() : material() {}

Object::Object(const Materiel& mat) : material(mat) {}

float Object::intersection(Rayon Ray) {
    std::cout << "Je suis l'Intersection pas senser être appeler :( \n";
    return -1;
}

Materiel Object::calculerCouleur(const Point3D& point, Light* light) {
    std::cout << "Je suis le CalculerCouleur pas senser être appeler :( ";
    return Materiel(0,0,0);
}