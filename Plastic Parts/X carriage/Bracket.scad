// PLASTIBOT MENDEL
// X-Carriage - Split the Carriage in 3 pieces - Platform, LM8UU Holders and Bracket.
// This file addresses the Bracket which locks the other 2 parts in position.
// Plastibot <support@plastibot.com>
// Derived from:

// - LM8UU holder slim
// *********************************************
// Jonas Kühling
// http://www.jonaskuehling.de
// http://www.thingiverse.com/jonaskuehling
// *********************************************
// derived from:
// http://www.thingiverse.com/thing:14942

// - LM8UU-Bearing X-Carriage
// Jonas Kühling <mail@jonaskuehling.de>
// Derivate of http://www.thingiverse.com/thing:16208
// - Reinforced frame
// - Added two fan/equipment mounts
// ********************************************

// PRUSA Mendel
// LM8UU-Bearing X-Carriage
// Used for sliding on X axis
// GNU GPL v2
// Simon Kühling <mail@simonkuehling.de>
// Derived from
//	- "Lm8uu X Carriage with Fan Mount for Prusa Mendel" by Greg Frost
//	  http://www.thingiverse.com/thing:9869
//	- "Slim LM8UU Holder Parametric" by Jonas Kühling
//	  http://www.thingiverse.com/thing:16158


use <jonaskuehling-default.scad>
include <configuration.scad>

// LM8UU/rod dimensions
LM8UU_dia = 15.4;
LM8UU_length = 24;
rod_dia = 8;

//screw/nut dimensions (M3) - hexagon socket head cap screw ISO 4762, hexagon nut ISO 4032
screw_thread_dia_iso = 3;
screw_head_dia_iso = 5.5;
nut_wrench_size_iso = 5.5;


// screw/nut dimensions for use (plus clearance for fitting purpose)
clearance_dia = 0.5;
screw_thread_dia = screw_thread_dia_iso + clearance_dia;
screw_head_dia = screw_head_dia_iso + clearance_dia;
nut_wrench_size = nut_wrench_size_iso + clearance_dia;
nut_dia_perimeter = (nut_wrench_size/cos(30));
nut_dia = nut_dia_perimeter;
nut_surround_thickness = 3;

// main body dimensions
body_wall_thickness = 2;
body_width = LM8UU_dia + (2*body_wall_thickness);
body_height = body_width;
body_length = LM8UU_length;
gap_width = rod_dia + 2;
screw_bushing_space = 1;
screw_elevation = LM8UU_dia + body_wall_thickness + (screw_thread_dia/2) +screw_bushing_space-1;

overhang_angle = 60;
r = nut_dia_perimeter/2+nut_surround_thickness;
extra_height_varticalprint = r*sin(90-overhang_angle);

// TEST - uncomment to render in openscad:
//lm8uu_holder_bracket();



module lm8uu_holder_bracket()
{
	difference()
	{
		union()
		{
			plate();

		}


		//DOVETAILS

		translate([0,body_length/2+3,0])
		rotate([-45,0,0]) color([0.9,0,0,0.6]) render() cube([70,3,4], center=true);

		translate([0,-body_length/2-3,0])
		rotate([45,0,0]) color([0.9,0,0,0.6]) render() cube([70,3,4], center=true);

		translate([0,0,-0.5])
		cylinder(r=21,h=body_wall_thickness+4);

		// bracket mounting holes

		rotate(260)
		translate([0,28,-1])
		cylinder(r=m3_diameter/2,h=body_wall_thickness*2+2,$fs=1);

		rotate(280)
		translate([0,28,-1])
		cylinder(r=m3_diameter/2,h=body_wall_thickness*2+2,$fs=1);

		rotate(80)
		translate([0,28,-1])
		cylinder(r=m3_diameter/2,h=body_wall_thickness*2+2,$fs=1);

		rotate(100)
		translate([0,28,-1])
		cylinder(r=m3_diameter/2,h=body_wall_thickness*2+2,$fs=1);


		//nut traps for mounting holes

		rotate(260)
		translate([0,28,body_wall_thickness])
		cylinder(r=m3_nut_diameter/2,h=body_wall_thickness*2+2,$fn=6);

		rotate(280)
		translate([0,28,body_wall_thickness])
		cylinder(r=m3_nut_diameter/2,h=body_wall_thickness*2+2,$fn=6);

		rotate(80)
		translate([0,28,body_wall_thickness])
		cylinder(r=m3_nut_diameter/2,h=body_wall_thickness*2+2,$fn=6);

		rotate(100)
		translate([0,28,body_wall_thickness])
		cylinder(r=m3_nut_diameter/2,h=body_wall_thickness*2+2,$fn=6);


	}
}



module plate()
{
	difference()
	{
		translate([0,0,2.5])
		cube([24+body_width+2*screw_head_dia+4*nut_surround_thickness,body_length+6,body_wall_thickness+3], center=true);

	}
}

