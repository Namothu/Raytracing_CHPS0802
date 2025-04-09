# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Default target executed when no arguments are given to make.
default_target: all
.PHONY : default_target

# Allow only one "make -f Makefile2" at a time, but pass parallelism.
.NOTPARALLEL:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/wimartinez/Raytracing_CHPS0802

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/wimartinez/Raytracing_CHPS0802

#=============================================================================
# Targets provided globally by CMake.

# Special rule for the target edit_cache
edit_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "No interactive CMake dialog available..."
	/usr/bin/cmake -E echo No\ interactive\ CMake\ dialog\ available.
.PHONY : edit_cache

# Special rule for the target edit_cache
edit_cache/fast: edit_cache
.PHONY : edit_cache/fast

# Special rule for the target rebuild_cache
rebuild_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake to regenerate build system..."
	/usr/bin/cmake --regenerate-during-build -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : rebuild_cache

# Special rule for the target rebuild_cache
rebuild_cache/fast: rebuild_cache
.PHONY : rebuild_cache/fast

# The main all target
all: cmake_check_build_system
	$(CMAKE_COMMAND) -E cmake_progress_start /mnt/c/Users/William/Desktop/Info/Cours_annee_2024-2025/CHPS0802/Raytracing_CHPS0802/CMakeFiles /mnt/c/Users/William/Desktop/Info/Cours_annee_2024-2025/CHPS0802/Raytracing_CHPS0802//CMakeFiles/progress.marks
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 all
	$(CMAKE_COMMAND) -E cmake_progress_start /mnt/c/Users/William/Desktop/Info/Cours_annee_2024-2025/CHPS0802/Raytracing_CHPS0802/CMakeFiles 0
.PHONY : all

# The main clean target
clean:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 clean
.PHONY : clean

# The main clean target
clean/fast: clean
.PHONY : clean/fast

# Prepare targets for installation.
preinstall: all
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall

# Prepare targets for installation.
preinstall/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall/fast

# clear depends
depend:
	$(CMAKE_COMMAND) -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 1
.PHONY : depend

#=============================================================================
# Target rules for targets named MyRaytracing

# Build rule for target.
MyRaytracing: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 MyRaytracing
.PHONY : MyRaytracing

# fast build rule for target.
MyRaytracing/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/build
.PHONY : MyRaytracing/fast

src/Light.o: src/Light.cpp.o
.PHONY : src/Light.o

# target to build an object file
src/Light.cpp.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Light.cpp.o
.PHONY : src/Light.cpp.o

src/Light.i: src/Light.cpp.i
.PHONY : src/Light.i

# target to preprocess a source file
src/Light.cpp.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Light.cpp.i
.PHONY : src/Light.cpp.i

src/Light.s: src/Light.cpp.s
.PHONY : src/Light.s

# target to generate assembly for a file
src/Light.cpp.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Light.cpp.s
.PHONY : src/Light.cpp.s

src/Materiel.o: src/Materiel.cpp.o
.PHONY : src/Materiel.o

# target to build an object file
src/Materiel.cpp.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Materiel.cpp.o
.PHONY : src/Materiel.cpp.o

src/Materiel.i: src/Materiel.cpp.i
.PHONY : src/Materiel.i

# target to preprocess a source file
src/Materiel.cpp.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Materiel.cpp.i
.PHONY : src/Materiel.cpp.i

src/Materiel.s: src/Materiel.cpp.s
.PHONY : src/Materiel.s

# target to generate assembly for a file
src/Materiel.cpp.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Materiel.cpp.s
.PHONY : src/Materiel.cpp.s

src/Object.o: src/Object.cpp.o
.PHONY : src/Object.o

# target to build an object file
src/Object.cpp.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Object.cpp.o
.PHONY : src/Object.cpp.o

src/Object.i: src/Object.cpp.i
.PHONY : src/Object.i

# target to preprocess a source file
src/Object.cpp.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Object.cpp.i
.PHONY : src/Object.cpp.i

src/Object.s: src/Object.cpp.s
.PHONY : src/Object.s

# target to generate assembly for a file
src/Object.cpp.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Object.cpp.s
.PHONY : src/Object.cpp.s

src/Plan.o: src/Plan.cpp.o
.PHONY : src/Plan.o

# target to build an object file
src/Plan.cpp.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Plan.cpp.o
.PHONY : src/Plan.cpp.o

src/Plan.i: src/Plan.cpp.i
.PHONY : src/Plan.i

# target to preprocess a source file
src/Plan.cpp.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Plan.cpp.i
.PHONY : src/Plan.cpp.i

src/Plan.s: src/Plan.cpp.s
.PHONY : src/Plan.s

# target to generate assembly for a file
src/Plan.cpp.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Plan.cpp.s
.PHONY : src/Plan.cpp.s

src/Point3D.o: src/Point3D.cpp.o
.PHONY : src/Point3D.o

# target to build an object file
src/Point3D.cpp.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Point3D.cpp.o
.PHONY : src/Point3D.cpp.o

src/Point3D.i: src/Point3D.cpp.i
.PHONY : src/Point3D.i

# target to preprocess a source file
src/Point3D.cpp.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Point3D.cpp.i
.PHONY : src/Point3D.cpp.i

src/Point3D.s: src/Point3D.cpp.s
.PHONY : src/Point3D.s

# target to generate assembly for a file
src/Point3D.cpp.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Point3D.cpp.s
.PHONY : src/Point3D.cpp.s

src/Rayon.o: src/Rayon.cpp.o
.PHONY : src/Rayon.o

# target to build an object file
src/Rayon.cpp.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Rayon.cpp.o
.PHONY : src/Rayon.cpp.o

src/Rayon.i: src/Rayon.cpp.i
.PHONY : src/Rayon.i

# target to preprocess a source file
src/Rayon.cpp.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Rayon.cpp.i
.PHONY : src/Rayon.cpp.i

src/Rayon.s: src/Rayon.cpp.s
.PHONY : src/Rayon.s

# target to generate assembly for a file
src/Rayon.cpp.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Rayon.cpp.s
.PHONY : src/Rayon.cpp.s

src/Sphere.o: src/Sphere.cpp.o
.PHONY : src/Sphere.o

# target to build an object file
src/Sphere.cpp.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Sphere.cpp.o
.PHONY : src/Sphere.cpp.o

src/Sphere.i: src/Sphere.cpp.i
.PHONY : src/Sphere.i

# target to preprocess a source file
src/Sphere.cpp.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Sphere.cpp.i
.PHONY : src/Sphere.cpp.i

src/Sphere.s: src/Sphere.cpp.s
.PHONY : src/Sphere.s

# target to generate assembly for a file
src/Sphere.cpp.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Sphere.cpp.s
.PHONY : src/Sphere.cpp.s

src/Vecteur3D.o: src/Vecteur3D.cpp.o
.PHONY : src/Vecteur3D.o

# target to build an object file
src/Vecteur3D.cpp.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Vecteur3D.cpp.o
.PHONY : src/Vecteur3D.cpp.o

src/Vecteur3D.i: src/Vecteur3D.cpp.i
.PHONY : src/Vecteur3D.i

# target to preprocess a source file
src/Vecteur3D.cpp.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Vecteur3D.cpp.i
.PHONY : src/Vecteur3D.cpp.i

src/Vecteur3D.s: src/Vecteur3D.cpp.s
.PHONY : src/Vecteur3D.s

# target to generate assembly for a file
src/Vecteur3D.cpp.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Vecteur3D.cpp.s
.PHONY : src/Vecteur3D.cpp.s

src/Vue.o: src/Vue.cpp.o
.PHONY : src/Vue.o

# target to build an object file
src/Vue.cpp.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Vue.cpp.o
.PHONY : src/Vue.cpp.o

src/Vue.i: src/Vue.cpp.i
.PHONY : src/Vue.i

# target to preprocess a source file
src/Vue.cpp.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Vue.cpp.i
.PHONY : src/Vue.cpp.i

src/Vue.s: src/Vue.cpp.s
.PHONY : src/Vue.s

# target to generate assembly for a file
src/Vue.cpp.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/Vue.cpp.s
.PHONY : src/Vue.cpp.s

src/World.o: src/World.cpp.o
.PHONY : src/World.o

# target to build an object file
src/World.cpp.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/World.cpp.o
.PHONY : src/World.cpp.o

src/World.i: src/World.cpp.i
.PHONY : src/World.i

# target to preprocess a source file
src/World.cpp.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/World.cpp.i
.PHONY : src/World.cpp.i

src/World.s: src/World.cpp.s
.PHONY : src/World.s

# target to generate assembly for a file
src/World.cpp.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/World.cpp.s
.PHONY : src/World.cpp.s

src/main_test.o: src/main_test.cpp.o
.PHONY : src/main_test.o

# target to build an object file
src/main_test.cpp.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/main_test.cpp.o
.PHONY : src/main_test.cpp.o

src/main_test.i: src/main_test.cpp.i
.PHONY : src/main_test.i

# target to preprocess a source file
src/main_test.cpp.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/main_test.cpp.i
.PHONY : src/main_test.cpp.i

src/main_test.s: src/main_test.cpp.s
.PHONY : src/main_test.s

# target to generate assembly for a file
src/main_test.cpp.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/MyRaytracing.dir/build.make CMakeFiles/MyRaytracing.dir/src/main_test.cpp.s
.PHONY : src/main_test.cpp.s

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... depend"
	@echo "... edit_cache"
	@echo "... rebuild_cache"
	@echo "... MyRaytracing"
	@echo "... src/Light.o"
	@echo "... src/Light.i"
	@echo "... src/Light.s"
	@echo "... src/Materiel.o"
	@echo "... src/Materiel.i"
	@echo "... src/Materiel.s"
	@echo "... src/Object.o"
	@echo "... src/Object.i"
	@echo "... src/Object.s"
	@echo "... src/Plan.o"
	@echo "... src/Plan.i"
	@echo "... src/Plan.s"
	@echo "... src/Point3D.o"
	@echo "... src/Point3D.i"
	@echo "... src/Point3D.s"
	@echo "... src/Rayon.o"
	@echo "... src/Rayon.i"
	@echo "... src/Rayon.s"
	@echo "... src/Sphere.o"
	@echo "... src/Sphere.i"
	@echo "... src/Sphere.s"
	@echo "... src/Vecteur3D.o"
	@echo "... src/Vecteur3D.i"
	@echo "... src/Vecteur3D.s"
	@echo "... src/Vue.o"
	@echo "... src/Vue.i"
	@echo "... src/Vue.s"
	@echo "... src/World.o"
	@echo "... src/World.i"
	@echo "... src/World.s"
	@echo "... src/main_test.o"
	@echo "... src/main_test.i"
	@echo "... src/main_test.s"
.PHONY : help



#=============================================================================
# Special targets to cleanup operation of make.

# Special rule to run CMake to check the build system integrity.
# No rule that depends on this can have commands that come from listfiles
# because they might be regenerated.
cmake_check_build_system:
	$(CMAKE_COMMAND) -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 0
.PHONY : cmake_check_build_system

