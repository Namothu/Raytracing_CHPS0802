#ifndef VECTEUR3D_H
#define VECTEUR3D_H

#include "Point3D.h"
#include <iostream>
#include <array>
#include <cmath>

/**
 * Classe pour définir un Vecteur dans un espace 3D
 * Qui est représenter par un mouvement x,y,z
 */
class Vecteur3D {
public:
    // Constructeur
    Vecteur3D(); //par défaut
    Vecteur3D(float x_val, float y_val, float z_val); //avec paramètres x,y,z
    Vecteur3D(const Vecteur3D& v); // Par copie
    Vecteur3D(const Point3D& point1, const Point3D& point2); //avec la distance entre deux points

    //Getter
    float getX();
    float getY();
    float getZ();

    //Operation
    Vecteur3D operator+(const Vecteur3D& V2) const;  // Surcharge de l'addition
    Vecteur3D operator*(const Vecteur3D& V2) const;  // Surcharge de la multiplication par un autre vecteur
    Vecteur3D operator*(float f) const; //Surcharge de la multiplication par un float
    float produitScalaire(const Vecteur3D& V2);

    // Méthode
    static Vecteur3D calcul_normale_3point(const Point3D& point1, const Point3D& point2, const Point3D& point3);
    void afficher() const; //pour afficher le vecteur

private:
    std::array<float, 3> valeurs; //0 = X, Y = 1, Z = 2
};

#endif // VECTEUR3D_H