// PLASTIBOT MENDEL
// Herringbone gears.
// Added droplet shape holes to big gear.
// Plastibot <support@plastibot.com>
// Derived from: 

// Wade's Extruder Gears using Parametric Involute Bevel and Spur Gears by GregFrost
// by Nicholas C. Lewis (A RepRap Breeding Program)
//
// It is licensed under the Creative Commons - GNU GPL license.
// © 2010 by Nicholas C. Lewis
// http://www.thingiverse.com/thing:4305

use <mendel_misc.inc>
use <parametric_involute_gear_v5.0.scad>

translate([0,0,5.5])
//WadesL(); //this module call will make the large gear
//WadesS();  //this module call will make the small gear
WadeL_double_helix();
//WadesS_double_helix();

module WadeL_double_helix(){
	//Large WADE's Gear - Double Helix
	//rotate([0,0,-2])translate([0,0,0])color([ 100/255, 255/255, 200/255])import_stl("39t17p.stl");

	circles=7;
	teeth=47;
	pitch=268;
	twist=200;
	height=11;
	pressure_angle=30;

	difference(){
		union(){
		gear (number_of_teeth=teeth,
			circular_pitch=pitch,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness =0,// height/2*0.5,
			rim_thickness = height/2,
			rim_width = 5,
			hub_thickness = height/2*1.3,
			hub_diameter = 25,
			bore_diameter = 8,
			circles=circles,
			twist = twist/teeth);
		mirror([0,0,1])
		gear (number_of_teeth=teeth,
			circular_pitch=pitch,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness = height/2,
			rim_thickness = height/2,
			rim_width = 5,
			hub_thickness = height/2,
			hub_diameter=25,
			bore_diameter=8,
			circles=circles,
			twist=twist/teeth);
		}
		translate([0,0,1])rotate([180,0,0])m8_hole_vert_with_hex(100);
	}
}
module WadesL(){
	//Large WADE's Gear
	//rotate([0,0,-2])translate([0,0,0])color([ 100/255, 255/255, 200/255])import_stl("39t17p.stl");
	difference(){
		gear (number_of_teeth=39,
			circular_pitch=268,
			gear_thickness = 5,
			rim_thickness = 7,
			rim_width = 3,
			hub_thickness = 13,
			hub_diameter = 25,
			bore_diameter = 8,
			circles=0,
			twist = 0);
		translate([0,0,6])rotate([180,0,0])m8_hole_vert_with_hex(100);
	}
}

module WadesS(){
	//small WADE's Gear
	//rotate([180,0,-23.5])translate([-10,-10,-18])color([ 100/255, 255/255, 200/255])import_stl("wades_gear.stl");
	difference(){
		gear (number_of_teeth=11,
			circular_pitch=268,
			gear_thickness = 9,
			rim_thickness = 9,
			hub_thickness = 18,
			hub_diameter = 20,
			bore_diameter = 5,
			circles=0,
			twist = 0);
		translate([0,-5,16])cube([5.5,2.3,9],center = true);
		translate([0,0,14])rotate([0,90,-90])cylinder(r=1.7,h=20);
	}
}
module WadesS_double_helix(){
	//small WADE's Gear
	//rotate([180,0,-23.5])translate([-10,-10,-18])color([ 100/255, 255/255, 200/255])import_stl("wades_gear.stl");

	circles=0;
	teeth=9;
	pitch=268;
	twist=200;
	height=25;
	pressure_angle=30;

	difference(){
		union(){
		gear (number_of_teeth=teeth,
			circular_pitch=pitch,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness =  height/4,
			rim_thickness = height/4,
			rim_width = 5,
			hub_thickness = height/2*1.2,
			hub_diameter = 20,
			bore_diameter = 5,
			circles=circles,
			twist = twist/teeth);
		mirror([0,0,1])
		gear (number_of_teeth=teeth,
			circular_pitch=pitch,
			pressure_angle=pressure_angle,
			clearance = 0.2,
			gear_thickness =  height/4*1.2,
			rim_thickness =  height/4,
			rim_width = 5,
			hub_thickness = height/4,
			hub_diameter=20,
			bore_diameter=5,
			circles=circles,
			twist=twist/teeth);
		}
		translate([0,-5,12])cube([5.5,2.3,9],center = true);
		translate([0,0,11])rotate([0,90,-90])cylinder(r=1.7,h=20);
	}
}
