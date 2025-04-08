#include "Plan.h"

//Constructeur
Plan::Plan(): Object(), A(0,0,0), normal(0,1,0){} //Default
Plan::Plan(const Point3D& a, const Vecteur3D& norm): Object(), A(a), normal(norm){}//Paramètre avec point et une norme

// Methodes
float Plan::intersection(Rayon Ray) {
    //Calcul de la valeur de (A - O)
    Vecteur3D distance_A_O = Vecteur3D(Ray.origine,this->A);

    //Un fois qu'on a tout nos element nous allons reproduire avec nos methode la formule :
    //t = (A-O)*n / d*n
    float t = (distance_A_O.produitScalaire(this->normal)) / (Ray.direction.produitScalaire(this->normal));

    return t;
}

void Plan::afficher() const {
    std::cout << "Plan qui pour element :\n";
    this->A.afficher();
    this->normal.afficher();
}

Materiel Plan::calculerCouleur(const Point3D& point, Light * light, float lumiere_ambiante) {
    //On calcule le vecteur depuis la lumière (direction de la lumière vers le point)
    Vecteur3D directionLumiere = Vecteur3D(point, light->position);  // Lumière - Point
    directionLumiere = directionLumiere * (1.0f / directionLumiere.produitScalaire(directionLumiere));  // Normalisation

    //On calcule l'intensité lumineuse en fonction de l'angle entre la normale du plan et la lumière
    float intensite_angle = std::max(normal.produitScalaire(directionLumiere), 0.0f);  // Produit scalaire normalisé

    //On calcule l'intensite_physique
    float intensite_physique = light->getLightIntensityAtPoint(point);

    //On calcule notre intensité lumineuse
    float intensite_mul = intensite_physique * intensite_angle;
    
    //On ajoute l'illumination ambiante à l'intensité lumineuse
    float intensiteFinale = intensite_mul + lumiere_ambiante;
    intensiteFinale = std::min(intensiteFinale, 1.0f);  // Limiter l'intensité à 1 (maximum)

    // 4. Calculer la couleur en fonction de l'intensité lumineuse et de la couleur du matériau du plan
    int r = static_cast<int>(material.r * intensiteFinale);
    int g = static_cast<int>(material.g * intensiteFinale);
    int b = static_cast<int>(material.b * intensiteFinale);

    // 5. Retourner un nouveau matériau avec la couleur calculée
    return Materiel(r, g, b);
}