#include "Sphere.h"

//Constructeur par default
Sphere::Sphere() : Object(), C() {
    this->R = 1.0;
}

//Constructeur par paramètre
Sphere::Sphere(const Point3D& C_ar, float Rayon) : Object(), C(C_ar), R(Rayon) {}

// Méthode pour afficher les informations sur la sphère
void Sphere::afficher() const {
    std::cout << "Sphere : \n";
    std::cout << "  Point Centre : ";
    C.afficher();
    std::cout << "  Rayon : ";
    std::cout << R;
    std::cout << "\n";
}

//Calcul t d'intersection entre la Sphère et un Rayon | Renvois -1 si pas trouver
float Sphere::intersection(Rayon Ray) {
    Vecteur3D distanceCO = Vecteur3D(this->C,Ray.origine);

    //Calcul des valeur de a, b, c de notre equation du second degres
    //a = d*d
    float a = Ray.direction.produitScalaire(Ray.direction);

    //b = 2*(O-C)*d
    float b = (distanceCO*2).produitScalaire(Ray.direction);

    //c = (O-C)*(O-C)-R²
    float c = distanceCO.produitScalaire(distanceCO) - (this->R*this->R);

    //maintenant que l'on a définit nos élément on va essayer d'en calculer les deux possibilité et trouver notre t
    //cas ou on ajoute notre discriminant
    float t1 = (-b+sqrt((b*b)-(4*a*c)))/(2*a);
    //cas ou on retire notre discriminant
    float t2 = (-b-sqrt((b*b)-(4*a*c)))/(2*a);

    //Affichage de debug
    //std::cout << "T1 et T2 : " << t1 << t2 << std::endl;

    float t = -1.0;
    if (t1 >= 0.0) {
        if ((t2 < t1) && (t2 >= 0.0)) {
            t = t2;
        } else {
            t = t1;
        }
    }

    return t;
}

Materiel Sphere::calculerCouleur(const Point3D& point, Light* light, float lumiere_ambiante) {
    //On calcule la normale à la sphère en ce point
    Vecteur3D normale = Vecteur3D(C, point);  // Normal = point - centre de la sphère
    normale = normale * (1.0f / normale.produitScalaire(normale));  // Normalisation
    //normale.afficher();

    //On calcule le vecteur lumière (direction de la lumière vers le point)
    Vecteur3D directionLumiere = Vecteur3D(point, light->position);  // Lumière - Point
    directionLumiere = directionLumiere * (1.0f / directionLumiere.produitScalaire(directionLumiere));  // Normalisation
    //directionLumiere.afficher();

    //on calcule l'intensité lumineuse en fonction de l'angle entre la normale et la lumière
    float intensite_angle = std::max(normale.produitScalaire(directionLumiere), 0.0f);  // Produit scalaire normalisé

    float intensite_physique = light->getLightIntensityAtPoint(point);

    // On calcule la couleur du point
    int r = std::min(static_cast<int>((material.r * intensite_physique * intensite_angle)+(material.r*lumiere_ambiante)),250);
    int g = std::min(static_cast<int>((material.g * intensite_physique * intensite_angle)+(material.g*lumiere_ambiante)),250);
    int b = std::min(static_cast<int>((material.b * intensite_physique * intensite_angle)+(material.b*lumiere_ambiante)),250);

    //std::cout << intensite_physique << intensite_angle << intensite_physique * intensite_angle << "\n";

    return Materiel(r, g, b);
}