#include "Object.h"

Object::Object() : material() {}

Object::Object(const Materiel& mat) : material(mat) {}

float Object::intersection(Rayon Ray) {
    std::cout << "Je suis pas senser être appeler :( \n";
    return -1;
}