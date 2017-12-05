#!/bin/sh

# Quit script if any step has error:
set -e

# Make mesh
gmsh mesh/main.geo -3 -o test.msh
# Convert the mesh to OpenFOAM format:
gmshToFoam test.msh -case case
# Adjust polyMesh/boundary:
changeDictionary -case case
# Finally, run the simulation:
simpleFoam -case case

