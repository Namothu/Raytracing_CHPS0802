#ifndef OBJECT_H
#define OBJECT_H

#include "Rayon.h"
#include "Materiel.h"
#include "Light.h"
#include <iostream>
#include <cmath>

enum ObjectType {
    SPHERE,
    PLAN,
};

/** 
 *Cette classe Object à pour but d'être la classe mère de tout les objets qui seront contenue dans un world
 *Les objets doivent être capable d'être appeller pour savoir si il sont en intersection avec un Rayon
 */
class Object {
    public:
        Object();
        Object(const Materiel& mat);

        //Méthode virtuelle pour savoir si il y a une intersection avec un rayon
        virtual float intersection(Rayon Ray);
        virtual Materiel calculerCouleur(const Point3D& point, Light* light, float lumiere_ambiante);
        //La méthode est virtuelle pour qu'elle soit redéfinie par chaque object c'est différent la méthode de calcul selon l'objet

        Materiel material;
        ObjectType type;
};

#endif // OBJECT_H