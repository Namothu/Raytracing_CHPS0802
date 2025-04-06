# CMake version minimale requise
cmake_minimum_required(VERSION 3.10)

# Nom du projet
project(MyRaytracing)

# Définir les options de compilation
set(CMAKE_CXX_STANDARD 11)

# Ajouter des fichier sources de src
file(GLOB SOURCES "src/*.cpp")

# Définir le dossier de sortie pour l'exécutable
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Ajouter des entêtes du fichier src
include_directories(${PROJECT_SOURCE_DIR}/src)

# Ajouter l'exécutable avec sur le fichier main.cpp
add_executable(MyRaytracing src/main.cpp ${SOURCES})

#Faire en sorte qu'il ai 3 scenario