# Nom de l'exécutable
EXEC = main_test

# Répertoires
SRC_DIR = src
OBJ_DIR = obj

# Compiler et flags
CXX = g++
CXXFLAGS = -Wall -std=c++17 -I$(SRC_DIR)  # Ajouter src comme répertoire d'en-têtes

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