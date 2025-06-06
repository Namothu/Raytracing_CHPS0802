#include <iostream>
#include "World.h"
#include "Sphere.h"
#include "Plan.h"

int main() {
    // Afficher un message à l'écran
    std::cout << "Bonjour, tout le monde !" << std::endl;

    //Configuration de la scène
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

    //Partie Squentiel
    std::cout << "Debut Calcul Version normal" << std::endl;
    mybeautifulworld.generate_img("test_img.ppm");
    std::cout << "Top Fin" << std::endl;

    //Partie GPU
    std::cout << "Debut Calcul Version GPU" << std::endl;
    mybeautifulworld.generate_img_gpu("test_img_gpu.ppm");
    std::cout << "Top Fin" << std::endl;
    
    return 0;
}