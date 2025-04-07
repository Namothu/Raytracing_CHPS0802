#ifndef LIGHT_H
#define LIGHT_H

#include "Point3D.h"

class Light {
public:
    Point3D position;  // Position de la lumière
    float intensity;   // Intensité de la lumière

    // Constructeur
    Light(const Point3D& pos, float intensity);

    // Méthode pour récupérer l'intensité lumineuse à un point donné (simplifiée ici)
    float getLightIntensityAtPoint(const Point3D& point) const;
};

#endif // LIGHT_H