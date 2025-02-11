#ifndef OBJECT_H
#define OBJECT_H

#include <string>
#include "color.h"
using namespace std;

/** 
 *Cette classe Object à pour but d'être la classe mère de tout les objets qui seront contenue dans un world
 *Les objets doivent être capable d'être appeller pour savoir si il sont en intersection avec un Rayon
 */
class Object {
    public:
        //Méthode virtuelle pour savoir si il y a une intersection avec un rayon
        virtual float intersection();
        //La méthode est virtuelle pour qu'elle soit redéfinie par chaque object c'est différent la méthode de calcul selon l'objet

        // Pour avoir un affichage de l'objet
        virtual string toString();

};

#endif // OBJECT_H