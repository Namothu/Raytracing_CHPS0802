#include "Vue.h"

#include "cuda_fonction.cuh"

Vue::Vue() {
    resolution[0] = 1024;
    resolution[1] = 1024;

    matrice_rayon.resize(resolution[0], std::vector<Rayon>(resolution[1]));
    matrice_pixel.resize(resolution[0], std::vector<std::array<int, 3>>(resolution[1]));

    //On définie la position de notre cadre de camera
    position_cadre[0] = Point3D(0,1,-1);
    position_cadre[1] = Point3D(-1,1,0);
    position_cadre[2] = Point3D(-1,0,1);
    position_cadre[3] = Point3D(0,0,-1);

    //On définie le vecteur normale de ce cadre
    vecteur_normal_cadre = Vecteur3D::calcul_normale_3point(position_cadre[0],position_cadre[1],position_cadre[2]);

    //On va calculer les écart que nous allons mettre entre nos rayon
    //Ecart des X diviser par le nombre de rayon en resolution[0]
    ecart_rayon[0] = (position_cadre[2].getX() - position_cadre[0].getX())/resolution[0];
    ecart_rayon[1] = (position_cadre[2].getY() - position_cadre[0].getY())/resolution[1];
    ecart_rayon[2] = (position_cadre[2].getZ() - position_cadre[0].getZ())/(resolution[0]*resolution[1]);

    //On commence la création de tout les Rayons de notre matrice
    for (int i = 0; i < matrice_rayon.size(); i++) {
        for (int j = 0; j < matrice_rayon[i].size(); j++) {
            matrice_rayon[i][j] = Rayon(Point3D(ecart_rayon[0]*i,ecart_rayon[1]*j,ecart_rayon[2]*(i+j)),Vecteur3D(vecteur_normal_cadre));
        }
    }

    //On rempli par default notre vecteur de pixel par du noir (0,0,0)
    for (int i = 0; i < matrice_pixel.size(); i++) {
        for (int j = 0; j < matrice_pixel[i].size(); j++) {
            matrice_pixel[i][j][0] = 0;
            matrice_pixel[i][j][1] = 0;
            matrice_pixel[i][j][2] = 0;
        }
    }
}

Vue::Vue(int reso,const Point3D& point1,const Point3D& point2,const Point3D& point3) {
    resolution[0] = reso;
    resolution[1] = reso;

    matrice_rayon.resize(resolution[0], std::vector<Rayon>(resolution[1]));
    matrice_pixel.resize(resolution[0], std::vector<std::array<int, 3>>(resolution[1]));

    //On définie la position de notre cadre de camera
    position_cadre[0] = Point3D(point1);
    position_cadre[1] = Point3D(point2);
    position_cadre[2] = Point3D(point3);
    //Le quatrième point est calculer par les 3 autres
    //pour formé un quadrilatère : D = B + BA + BC (B = point2, A = point1, C = point3)
    int x4= point2.getX() + point1.getX() - point2.getX() + point3.getX() - point2.getX();
    int y4= point2.getY() + point1.getY() - point2.getY() + point3.getY() - point2.getY();
    int z4= point2.getZ() + point1.getZ() - point2.getZ() + point3.getZ() - point2.getZ();
    position_cadre[3] = Point3D(x4,y4,z4);

    position_cadre[3].afficher();

    //On définie le vecteur normale de ce cadre
    vecteur_normal_cadre = Vecteur3D::calcul_normale_3point(position_cadre[0],position_cadre[1],position_cadre[2]);

    vecteur_normal_cadre.afficher();

    //On va calculer les écart que nous allons mettre entre nos rayon
    //Ecart des X diviser par le nombre de rayon en resolution[0]
    ecart_rayon[0] = (position_cadre[2].getX() - position_cadre[0].getX())/resolution[0];
    ecart_rayon[1] = (position_cadre[2].getY() - position_cadre[0].getY())/resolution[1];
    ecart_rayon[2] = (position_cadre[2].getZ() - position_cadre[0].getZ())/(resolution[0]*resolution[1]);

    //On commence la création de tout les Rayons de notre matrice
    for (int i = 0; i < matrice_rayon.size(); i++) {
        for (int j = 0; j < matrice_rayon[i].size(); j++) {
            matrice_rayon[i][j] = Rayon(Point3D(ecart_rayon[0]*i,ecart_rayon[1]*j,ecart_rayon[2]*(i+j)),Vecteur3D(vecteur_normal_cadre));
        }
    }

    //On rempli par default notre vecteur de pixel par du noir (0,0,0)
    for (int i = 0; i < matrice_pixel.size(); i++) {
        for (int j = 0; j < matrice_pixel[i].size(); j++) {
            matrice_pixel[i][j][0] = 0;
            matrice_pixel[i][j][1] = 0;
            matrice_pixel[i][j][2] = 0;
        }
    }
}

void Vue::calculate_matrice_pixel(vector<Object*> listes_des_objects, Light * light, float lumiere_ambiante) {
    //On commence la boucle principal qui va parcourir chaque rayon pour trouver la couleur de notre pixel
    // indice de l'objet le plus proche
    int object_plus_proche;
    // distance de l'objet le plus proche
    float t_min;
    // distance de l'objet courant
    float t_tmp;

    //On parcour les rayons
    for (int i = 0; i < matrice_rayon.size(); i++) {
        for (int j = 0; j < matrice_rayon[i].size(); j++) {
            object_plus_proche = -1;
            t_min = distance_max_vision;

            //Une fois que nous avons un rayon nous allons définir la couleur qu'il est senser renvoyer
            //Pour cela il faut trouver quel objet il percute en premier
            for (int obj_curr = 0; obj_curr < listes_des_objects.size(); obj_curr++)  {
                t_tmp = listes_des_objects[obj_curr]->intersection(matrice_rayon[i][j]);
                //std::cout << "test" << t_tmp << t_min << "\n";
                if ((t_tmp >= 0.0) && (t_tmp < t_min)) {
                    t_min = t_tmp;
                    object_plus_proche = obj_curr;
                }
            }

            //Une fois que l'intersection a été calculer on affecte la couleur
            if (object_plus_proche >= 0) {
                //Un objet à été trouved on récupère sa couleur

                //Pour calculer la couleur il nous faut une lumière et le point d'intersection de l'objet
                Point3D P = matrice_rayon[i][j].point_at_t(t_min);

                //une fois qu'on a tout on lance le calcul et affecte la couleur
                Materiel M = listes_des_objects[object_plus_proche]->calculerCouleur(P,light,lumiere_ambiante);
                matrice_pixel[i][j][0] = M.r;
                matrice_pixel[i][j][1] = M.g;
                matrice_pixel[i][j][2] = M.b;
            } else {
                //On a rien trouver donc on met tout à noir
                matrice_pixel[i][j][0] = 0;
                matrice_pixel[i][j][1] = 0;
                matrice_pixel[i][j][2] = 0;
            }
        }
    }

}

void Vue::enregistrer_matrice_pixel(const string& nomFichier) {
    // Vérifier que la matrice de pixels n'est pas vide
    if (matrice_pixel.empty() || matrice_pixel[0].empty()) {
        cerr << "Erreur : la matrice de pixels est vide." << endl;
        return;
    }
    
    int hauteur = resolution[0];
    int largeur = resolution[0];

    // Ouvrerture le fichier en mode écriture
    ofstream fichier(nomFichier, ios::out);
    if (!fichier.is_open()) {
        cerr << "Erreur : impossible d'ouvrir le fichier " << nomFichier << " pour l'écriture." << endl;
        return;
    }

    // Écrire l'en-tête PPM
    fichier << "P3" << endl; // Format PPM
    fichier << largeur << " " << hauteur << endl; // Dimensions de l'image
    fichier << "255" << endl; // Valeurs de couleur de 0 à 255

    // Écrire les données des pixels (R, G, B pour chaque pixel)
    for (int i = 0; i < hauteur; ++i) {
        for (int j = 0; j < largeur; ++j) {
            // Chaque pixel est un tableau de trois entiers (R, G, B)
            fichier << matrice_pixel[i][j][0] << " " // Rouge
                    << matrice_pixel[i][j][1] << " " // Vert
                    << matrice_pixel[i][j][2];       // Bleu

            if (j < largeur - 1) {
                fichier << " "; // Séparer les pixels sur la même ligne
            }
        }
        fichier << endl; // Passer à la ligne suivante pour la ligne suivante de pixels
    }

    // Fermer le fichier
    fichier.close();
    cout << "Image enregistrée dans " << nomFichier << endl;
}

void Vue::calculate_matrice_pixel_gpu(std::vector<Object*> listes_des_objects, Light* light, float lumiere_ambiante) {
    int height = matrice_rayon.size();
    int width = matrice_rayon[0].size();
    int num_rayons = height * width;

    printf("Calculate_matrice_pixel \n");

    // 1. Aplatir la matrice de rayons
    std::vector<Rayon> flat_rayons;
    flat_rayons.reserve(num_rayons);
    for (const auto& ligne : matrice_rayon) {
        for (const auto& r : ligne) {
            flat_rayons.push_back(r);
        }
    }

    // 2. Allouer la mémoire pour les résultats
    float* result_t = new float[num_rayons];
    int* result_num_object = new int[num_rayons];

    // 3. Appeler le launcher CUDA
    launch_calculate_intersections(flat_rayons, listes_des_objects, result_t, result_num_object);

    // 4. Interpréter les résultats
    int idx = 0;
    for (int i = 0; i < height; ++i) {
        for (int j = 0; j < width; ++j) {
            int obj_index = result_num_object[idx];
            float t_min = result_t[idx];

            if (obj_index >= 0) {
                Point3D P = matrice_rayon[i][j].point_at_t(t_min);
                Materiel M = listes_des_objects[obj_index]->calculerCouleur(P, light, lumiere_ambiante);
                matrice_pixel[i][j][0] = M.r;
                matrice_pixel[i][j][1] = M.g;
                matrice_pixel[i][j][2] = M.b;
            } else {
                matrice_pixel[i][j][0] = 0;
                matrice_pixel[i][j][1] = 0;
                matrice_pixel[i][j][2] = 0;
            }

            ++idx;
        }
    }

    // 5. Libération mémoire
    delete[] result_t;
    delete[] result_num_object;
}