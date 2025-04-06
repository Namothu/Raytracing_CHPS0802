#include "Materiel.h"

#include <iostream>

//Default
Materiel::Materiel() : r(0), g(0), b(0) {}

//par Paramètre
Materiel::Materiel(float r, float g, float b) : r(r), g(g), b(b) {}

//Par copie Copy constructor
Materiel::Materiel(const Materiel& m) : r(m.r), g(m.g), b(m.b) {}

void Materiel::afficher() const {
    std::cout << "Materiel Color: (" << r << ", " << g << ", " << b << ")" << std::endl;
}
