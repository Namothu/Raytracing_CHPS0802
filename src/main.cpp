#include <iostream>
//#include "world.h"
#include "Sphere.h"

int main() {
    // Afficher un message à l'écran
    std::cout << "Bonjour, monde !" << std::endl;

    Sphere s1 = Sphere(Point3D(1,1,1), 0.5);
    s1.afficher();
    
    // Retourner 0 pour indiquer que le programme s'est exécuté correctement
    return 0;
}