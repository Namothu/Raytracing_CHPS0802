#ifndef MATERIEL_H
#define MATERIEL_H


class Materiel
{
public:
    // Constructeur
    Materiel(); //default constructor
    Materiel(int r, int g, int b); //constructor with parameters
    Materiel(const Materiel& m); //copy constructor

    // Methodes
    void setColor(int r, int g, int b);
    void afficher() const; //print the color of the material

    //Variables
    int r; //rouge
    int g; //vert
    int b; //bleu
};

#endif //MATERIEL_H