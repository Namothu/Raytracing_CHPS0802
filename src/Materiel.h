#ifndef Materiel_H
#define Materiel_H


class Materiel
{
public:
    // Constructeur
    Materiel(); //default constructor
    Materiel(float r, float g, float b); //constructor with parameters
    Materiel(const Materiel& m); //copy constructor

    // Methodes
    void afficher() const; //print the color of the material

    //Variables
    float r; //rouge
    float g; //vert
    float b; //bleu
};





#endif