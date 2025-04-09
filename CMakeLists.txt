# CMake version minimale requise
cmake_minimum_required(VERSION 3.10)

# Nom du projet
project(MyRaytracing)

# Définir les options de compilation
set(CMAKE_CXX_STANDARD 11)

# Ajouter des fichiers sources de src avec un chemin relatif
file(GLOB SOURCES "${CMAKE_SOURCE_DIR}/src/*.cpp")

# Définir le dossier de sortie pour l'exécutable avec un chemin relatif
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")

# Ajouter des entêtes du dossier src avec un chemin relatif
include_directories("${CMAKE_SOURCE_DIR}/src")

# Ajouter l'exécutable en spécifiant les sources principales et supplémentaires
add_executable(MyRaytracing "${CMAKE_SOURCE_DIR}/src/main_test.cpp" ${SOURCES})

# Configurer différentes options en fonction des scénarios
# Exemple de scénario de compilation de débogage
set(DEBUG_BUILD_FLAGS "-g")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${DEBUG_BUILD_FLAGS}")

# Exemple de scénario de compilation de production
set(PROD_BUILD_FLAGS "-O3")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} ${PROD_BUILD_FLAGS}")