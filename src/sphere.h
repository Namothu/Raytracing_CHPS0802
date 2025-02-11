#ifndef SPHERE_H
#define SPHERE_H

#include "object.h"
#include "point3D.h"

/** 
 * Classe qui hérite de Object qui représente une sphère
 * La sphère est définie par un centre C et un rayon R
 */
class Sphere : public Object {
    public :
        Sphere();

        ~Sphere();

    private :
        Point3D C;
        float R;
        Couleurs colors;
};

#endif // SPHERE_H