#ifndef RAYON_H
#define RAYON_H

#include <string>
using namespace std;

class Rayon {
public:
    // Méthode virtuelle
    Rayon(string name);

    // Getter pour le nom de l'animal
    string toString();

    // Destructeur virtuel
    virtual ~Rayon();

private :


};

#endif // OBJECT_H