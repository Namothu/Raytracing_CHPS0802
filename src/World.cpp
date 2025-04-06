#include "World.h"

//Constructeur par default
World::World() {
    camera = Vue();
};

void World::generate_img(const string& nomFichier) {
    camera.calculate_matrice_pixel(this->vecteur_all_object);
    camera.enregistrer_matrice_pixel(nomFichier);
}