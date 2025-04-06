#ifndef RAYON_H
#define RAYON_H

#include "Point3D.h"
#include "Vecteur3D.h"

/**
 * La classe rayon définie une droite dans un espace 3D
 * Un Rayon est définie par point et un vecteur 3D 
 * et peu être un paramètre t a voir si je le rajoute au final plutot que la methode
 */
class Rayon {
public:
    // Constructeur
    Rayon(); // par default
    Rayon(const Point3D& origine, const Vecteur3D& direction); // par paramètre

    //Méthode
    Point3D point_at_t(float t); //pour obtenir le point du rayon à un instant donné (t)
    void afficher() const; //affichage

    Point3D origine;     // Point de départ du rayon
    Vecteur3D direction; // Vecteur directionnel du rayon
};

#endif // RAYON_H