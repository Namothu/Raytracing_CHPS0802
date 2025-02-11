#ifndef RAYON_H
#define RAYON_H

#include <string>
using namespace std;

/**
 * La classe rayon définie une droite dans un espace 3D
 * Un Rayon est définie par point et 
 */
class Rayon {
public:
    //Methode de creation
    Rayon();

    //To string
    string toString();

    // Destructeur
    virtual ~Rayon();

private :


};

#endif // OBJECT_H