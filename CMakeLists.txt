# CMake version minimale requise
cmake_minimum_required(VERSION 3.18)

# Nom du projet
project(MyRaytracing)

# Ajouter la prise en charge de CUDA
find_package(CUDA REQUIRED)

# On définit les options de compilation C++
set(CMAKE_CXX_STANDARD 11)

# Recherche tous les fichiers .cpp dans le répertoire src (sauf main_test.cpp)
file(GLOB_RECURSE SOURCES "src/*.cpp" "src/*.cu")

# On exclut main_test.cpp s'il est déjà ajouté manuellement
list(REMOVE_ITEM SOURCES "src/main_test.cpp")

# On définit le dossier de sortie pour l'exécutable
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# On ajoute les répertoires d'en-têtes du fichier src
include_directories(${PROJECT_SOURCE_DIR}/src)

# Ajouter l'exécutable en spécifiant main_test.cpp + tous les autres fichiers sources
add_executable(MyRaytracing src/main_test.cpp ${SOURCES})

# Lier les bibliothèques CUDA nécessaires
target_link_libraries(MyRaytracing ${CUDA_LIBRARIES})

# Option pour utiliser les fichiers CUDA (ajouter ici des options de compilation spécifiques si nécessaire)
set(CUDA_NVCC_FLAGS "${CUDA_NVCC_FLAGS} -O3 -arch=sm_60")  # Exemples d'optimisation, ajustez en fonction de votre GPU

# Lier les répertoires d'inclusion CUDA
include_directories(${CUDA_INCLUDE_DIRS})