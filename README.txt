Axisymmetric Simulation of a Parachute in OpenFOAM

Commands:
gmsh mesh/main.geo -3 -o test.msh
gmshToFoam test.msh -case case
changeDictionary -case case
simpleFoam -case case

