#include "Materiel.h"

#include <iostream>

//Default
Materiel::Materiel() : r(250), g(0), b(0) {}

//par Paramètre
Materiel::Materiel(int r, int g, int b) : r(r), g(g), b(b) {}

//Par copie Copy constructor
Materiel::Materiel(const Materiel& m) : r(m.r), g(m.g), b(m.b) {}

void Materiel::setColor(int red, int green, int blue) {
    r = red;
    g = green;
    b = blue;
}

void Materiel::afficher() const {
    std::cout << "Materiel Color: (" << r << ", " << g << ", " << b << ")" << std::endl;
}
