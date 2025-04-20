#ifndef PLAN_H
#define PLAN_H

#include "Object.h"
#include "Point3D.h"
#include "Vecteur3D.h"
#include "Rayon.h"
#include "Materiel.h"

/**
 * Hérite de Object défnie un plan dans un espace 3D
 * Le plan sera définis par un point A et une normale N
 * 
 */

class Plan : public Object {
    public :
        // Constructeur
        Plan(); //Default
        Plan(const Point3D& a,const Vecteur3D& norm); //Paramètre avec point

        // Methode
        float intersection(Rayon Ray) override;
        void afficher() const; //affichage
        Materiel calculerCouleur(const Point3D& point, Light * light, float lumiere_ambiante) override;

        //Attribute
        Point3D A;
        Vecteur3D normal;
};

#endif // PLAN_H