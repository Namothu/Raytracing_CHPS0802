#ifndef VECTEUR3D_H
#define VECTEUR3D_H

#include <iostream>
#include <cmath>

/**
 * Classe pour définir un Vecteur dans un espace 3D
 * Qui est représenter par un mouvement x,y,z
 */
class Vecteur3D {
public:
    // Constructeur
    Vecteur3D(); //par défaut
    Vecteur3D(float x_val, float y_val, float z_val); //avec paramètres
    Vecteur3D(const Vecteur3D& v); // Par copie

    //Getter
    float getX();
    float getY();
    float getZ();

    // Méthode 
    void afficher() const; //pour afficher le vecteur
    Vecteur3D additionner(const Vecteur3D& autre) const; //pour additionner deux vecteurs

private:
    float x;
    float y;
    float z;
};

#endif // VECTEUR3D_H