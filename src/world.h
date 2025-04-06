#ifndef WORLD_H
#define WORLD_H

#include <iostream>
#include <vector>
#include "Object.h"
#include "Vue.h"
using namespace std;

/*Cette classe world à pour but de contenir tout les formes 3D de notre monde afin de pouvoir tout les appeler lors
*du calcul de rayon
*Elle contient un vecteur avec des Objects qui est la classe mère de toutes nos formes 3D (je met le vecteur en
*public pour l'instant pour faire mes test)
*/
class World {

    public :
        // Constructeur par default
        World();
        //Flemme de faire un constructeur par copie juste on change la référence de la camera

        //Attribute
        vector<Object> vecteur_all_object;
        Vue camera;

        //Methode
        //je sais pas trop ce que je vais mettre dedans pour l'instant

        //Ne pas oublier ajouter la position de la lumière ici
    
};

#endif // WORLD_H