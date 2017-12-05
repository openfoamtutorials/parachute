//Inputs
parachute_radius = 1; // m
parachute_span = 70 * Pi / 180; // rad
parachute_cellsize = 0.01 * parachute_radius; // m
domain_diameter = 10 * parachute_radius; // m
domain_length = 20 * parachute_radius; // m
domain_cellsize = 0.05 * domain_diameter; // m

Point(1) = {0, 0, 0};
Point(2) = {0, parachute_radius, 0, parachute_cellsize};
Point(3) = {0, parachute_radius + parachute_cellsize, 0, parachute_cellsize};
x = Sin(parachute_span) * parachute_radius;
y = Cos(parachute_span) * parachute_radius;
Point(4) = {x, y, 0, parachute_cellsize};
dx = Sin(parachute_span) * parachute_cellsize;
dy = Cos(parachute_span) * parachute_cellsize;
Point(5) = {x + dx, y + dy, 0, parachute_cellsize};

Circle(6) = {2, 1, 4};
Circle(7) = {3, 1, 5};
Line(9) = {4, 5};

Point(10) = {0, -domain_length / 2, 0, domain_cellsize};
Point(11) = {domain_diameter / 2, -domain_length/2, 0, domain_cellsize};
Point(12) = {domain_diameter / 2, domain_length/2, 0, domain_cellsize};
Point(13) = {0, domain_length / 2, 0, domain_cellsize};

Line(14) = {2, 10};
Line(15) = {10, 11};
Line(16) = {11, 12};
Line(17) = {12, 13};
Line(18) = {13, 3};

Line Loop(19) = {14:18, 7, -9, -6};

Plane Surface(20) = {19};

Rotate {{0, 1, 0}, {0, 0, 0}, 2.5 * Pi / 180.0}
{
	Surface{20};
}
new_entities[] = Extrude {{0, 1, 0}, {0, 0, 0}, -5 * Pi / 180.0}
{
	Surface{20};
	Layers{1};
	Recombine;
};

Physical Surface("wedge0") = {20};
Physical Surface("wedge1") = {new_entities[0]};
Physical Surface("inlet") = {new_entities[2]};
Physical Surface("tunnel") = {new_entities[3]};
Physical Surface("outlet") = {new_entities[4]};
Physical Surface("parachute") = {new_entities[{5:7}]};

Physical Volume(1000) = {new_entities[1]};
