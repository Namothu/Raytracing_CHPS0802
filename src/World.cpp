#include "World.h"

//Constructeur par default
World::World() : lumiere_divine(Point3D(0,7,0),10000.0), camera(), lumiere_ambiante(0.1) {}

void World::generate_img(const string& nomFichier) {
    camera.calculate_matrice_pixel(this->vecteur_all_object,&this->lumiere_divine,lumiere_ambiante);
    camera.enregistrer_matrice_pixel(nomFichier);
}