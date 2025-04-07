#ifndef VUE_H
#define VUE_H

#include <iostream>
#include <vector>
using namespace std;

#include "Rayon.h"
#include "Object.h"

/**
 * La classe Vue représente notre vision de la caméra
 * La vision de cette caméra est définie par un matrice de Rayon qui vont devoir être parcouru pour actualiser la 
 * couleur d'un matrice de pixel
 */
class Vue {
    public :
        // Constructeur
        Vue(); //par default
        Vue(int reso,const Point3D& point1,const Point3D& point2,const Point3D& point3); //par paramètre

        // Methode
        void calculate_matrice_pixel(vector<Object*> listes_des_objects, Light * light,float lumiere_ambiante); //permet de calculer la couleur que chaque rayon retourne
        //void calculate_matrice_pixel_gpu(vector<Object>); //permet de calculer la couleur que chaque rayon retourne mais en gpu
        void enregistrer_matrice_pixel(const string& nomFichier); //enregistre la matrice de pixel en image ppm

    private :
        vector<vector<Rayon>> matrice_rayon; //Matrice qui va contenir tout les capteur de notre vue
        vector<vector<std::array<int, 3>>> matrice_pixel; //Matrice de pixel qui va contenir nos couleur final
        //On estime que la personne est suffisament intelligente pour pas faire son cadre n'importe comment
        std::array<Point3D, 4> position_cadre; //Position des 4 point qui définisse le cadre
        Vecteur3D vecteur_normal_cadre; //vecteur 3d qui represente la normal du cadre (pour pouvoir orienté nos rayon)
        std::array<int, 2> resolution; //[Hauteur,Largeur] pixel | Rayon
        //Attention a utiliser par ajout de X*i, Y*j et Z*(i+j)
        std::array<float, 3> ecart_rayon; //calcul de l'ecart entre A et C le tout diviser par le nombre de rayon en largeur et longueur (X,Y)
        float distance_max_vision = 100000.0; //Distance après laquelle on affiche plus le pixel
};


#endif // VUE_H