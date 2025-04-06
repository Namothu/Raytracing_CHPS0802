#include "Rayon.h"

// Constructeur par default
Rayon::Rayon() : origine(), direction() {}

//Construteur par paramètre (attention on copie nos éléments)
Rayon::Rayon(const Point3D& origine, const Vecteur3D& direction)
    : origine(origine), direction(direction) {}

// Méthode pour obtenir un point sur le rayon à un instant donné (t)
// t est la distance le long du rayon à partir de l'origine
Point3D Rayon::point_at_t(float t) {
    // On obtient le point en ajoutant t * direction à l'origine
    return Point3D(origine.getX() + t * direction.getX(),
                   origine.getY() + t * direction.getY(),
                   origine.getZ() + t * direction.getZ());
}

// Méthode pour afficher les informations sur le rayon
void Rayon::afficher() const {
    std::cout << "Rayon origine: ";
    origine.afficher();
    std::cout << "Direction: ";
    direction.afficher();
}