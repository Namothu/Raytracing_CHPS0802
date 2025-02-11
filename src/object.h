#ifndef OBJECT_H
#define OBJECT_H

#include <string>
using namespace std;

class Object {
public:
    // Méthode virtuelle
    virtual int intersection();

    // Getter pour le nom de l'animal
    string toString();

    // Destructeur virtuel
    virtual ~Object();

};

#endif // OBJECT_H