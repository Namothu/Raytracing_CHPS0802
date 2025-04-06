#ifndef SPHERE_H
#define SPHERE_H

#include "object.h"
#include "Point3D.h"

/** 
 * Classe qui hérite de Object qui représente une sphère
 * La sphère est définie par un centre C et un rayon R
 */
class Sphere : public Object {
    public :
        // Constructeur
        Sphere(); //Default
        Sphere(const Point3D& C_ar, float Rayon); //Paramètre avec point

        // Methode
        float Sphere::intersection(Rayon R) override;
        void afficher() const; //affichage

    private :
        Point3D C; //Point d'origne
        float R; //Rayon de la sphère
};

#endif // SPHERE_H