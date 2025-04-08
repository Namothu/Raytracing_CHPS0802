#include <iostream>
#include "World.h"
#include "Sphere.h"
#include "Plan.h"

int main() {
    // Afficher un message à l'écran
    std::cout << "Bonjour, tout le monde !" << std::endl;

    World mybeautifulworld = World();
    mybeautifulworld.camera = Vue(2048,Point3D(10,10,-5),Point3D(-10,10,-5),Point3D(-10,-10,-5));
    Sphere s1 = Sphere(Point3D(-10,-7,10), 2);
    s1.material.setColor(0,250,0);
    Sphere s2 = Sphere(Point3D(-10,-10,10), 4);
    Sphere s3 = Sphere(Point3D(-8,-10,10), 3);
    s3.material.setColor(0,0,250);
    
    mybeautifulworld.vecteur_all_object.push_back(&s1);
    mybeautifulworld.vecteur_all_object.push_back(&s2);
    mybeautifulworld.vecteur_all_object.push_back(&s3);

    Plan p1 = Plan(Point3D(-12,-20,10),Vecteur3D(4,0,-0.5));
    p1.material.setColor(250,0,250);

    mybeautifulworld.vecteur_all_object.push_back(&p1);

    //std::cout << s1.intersection(Rayon(Point3D(-10,0.5,0.5),Vecteur3D(1,0,0))) << std::endl;

    mybeautifulworld.generate_img("test_img.ppm");
    
    // Retourner 0 pour indiquer que le programme s'est exécuté correctement
    return 0;
}