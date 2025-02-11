#ifndef VUE_H
#define VUE_H

#include <iostream>
#include <vector>
using namespace std;

#include "rayon.h"

/**
 * La classe Vue représente notre vision de la caméra
 * La vision de cette caméra est définie par un matrice de Rayon qui vont devoir être parcouru pour actualiser la 
 * couleur d'un matrice de pixel
 */
class Vue {
    public :
        Vue();

        ~Vue();

    private :
        vector<vector<Rayon>> matrice_rayon;
        vector<vector<int>> matrice_pixel;
};


#endif // VUE_H