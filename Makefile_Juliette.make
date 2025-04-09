# Nom de l'exécutable
EXEC = main_test

# Répertoires
SRC_DIR = src
OBJ_DIR = obj
INCLUDE_DIR = include src # Ajouter le répertoire d'en-têtes

# Compiler et flags
CXX = g++
CXXFLAGS = -Wall -std=c++17 -I$(INCLUDE_DIR)  # Ajouter le répertoire include

# Fichiers sources et objets
SRC_FILES = $(wildcard $(SRC_DIR)/*.cpp)
OBJ_FILES = $(SRC_FILES:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)

# Règle par défaut
all: $(EXEC)

# Créer l'exécutable
$(EXEC): $(OBJ_FILES)
	$(CXX) $(OBJ_FILES) -o $(EXEC)

# Créer les fichiers objets
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(OBJ_DIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Nettoyage des fichiers objets et de l'exécutable
clean:
	rm -rf $(OBJ_DIR) $(EXEC)