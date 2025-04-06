#ifndef POINT3D_H
#define POINT3D_H

#include <iostream>
#include <cmath> 

/**
 * Classe pour définir un Point dans un espace 3D
 * Est définie par une position avec un float x,y,z
 */
class Point3D {
    public :
        //Constructeurs
        Point3D(); //default
        Point3D(float x_val, float y_val, float z_val); //par paramètre
        Point3D::Point3D(const Point3D& p); //par copie

        //Getter
        float getX() const;
        float getY() const;
        float getZ() const;

        //Methodes
        void afficher() const; //Affiche
        void deplacer(float dx, float dy, float dz);  // Déplace le point
        float distance(const Point3D& autre) const; //Calcule sa distance entre lui et un autre point

    private :
        float x;
        float y;
        float z;
};

#endif // POINT3D_H