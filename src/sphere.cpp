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