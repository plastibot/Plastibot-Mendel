
// PLASTIBOT MENDEL
// X-Carriage - Split the Carriage in 3 pieces - Platform, LM8UU Holders and Bracket.
// This file addresses the Platform which uses dovetails to attach the other 2.
// Plastibot <support@plastibot.com>
// Derived from 
//   -http://www.thingiverse.com/thing:18657 by
// Jonas Kühling <mail@jonaskuehling.de> which is a 
// Derivate of:

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

// Gregs configuration file
include <configuration.scad>

// jonaskuehling's slim LM8UU Holder
include <x-lm8uu-dual_holder-slim-vertical.scad>

include <Bracket.scad>


belt_clamp_thickness=2; 
belt_clamp_width=m3_diameter+3*belt_clamp_thickness+2;

for (i=[-1,1])
translate([45,i*25,0])
rotate(90)
belt_clamp();

for (i=[-1,1])
translate([-45,i*25,0])
rotate(90)
belt_clamp_channel();

translate([0,0,0])
rotate(90)
belt_clamp_channel();

mirror() simonkuehling_x_carriage();

base_length = 80;
rod_dist = 50;
plate_thickness = 3;

module simonkuehling_x_carriage() 
{
	render()
	difference()
	{
		union ()
		{			
			// base plate
			translate([0,0,plate_thickness/2])
			cube([rod_dist+body_width,base_length,plate_thickness],center=true);

			//Belt Clamp to body bridge right
			translate([-27-1+20,((-25-body_length/2)-belt_clamp_width/2+3),body_wall_thickness/2+plate_thickness/2])
			rotate([0,0,13])
			cube([53,12,body_wall_thickness+plate_thickness],center=true);

			//Belt Clamp to body bridge left	
			translate([-27-1+20,((25+body_length/2)+belt_clamp_width/2-3),body_wall_thickness/2+plate_thickness/2])
			rotate([0,0,-13])
			cube([53,12,body_wall_thickness+plate_thickness],center=true);

			// base plate supports front & Back
			for(i=[-1,1]){
				translate([i*(rod_dist/2+body_width/2-body_wall_thickness/2),0,body_wall_thickness/2+plate_thickness/2]) cube([2*body_wall_thickness,base_length,body_wall_thickness+plate_thickness], center=true);
			}

			// base plate supports left & right
			for(i=[-1,1]){
				translate([0,i*(base_length/2+body_wall_thickness/2),body_wall_thickness/2+plate_thickness/2]) cube([rod_dist+body_width+body_wall_thickness, body_wall_thickness,body_wall_thickness+plate_thickness], center=true);
			}


		}

		// Clearance for LM8UU holders
		for (i=[1,-1])
		translate([i*(25-body_wall_thickness),0,6+body_wall_thickness])
		cube([body_width-body_wall_thickness,base_length+2,10],center=true);
		
		// Extruder Mounting Holes
		for (i=[0:1])
		rotate(180*i)
		for (hole=[-1:1])
		rotate(hole*22)
		translate([0,25,-1])
		cylinder(r=m3_diameter/2,h=body_wall_thickness+plate_thickness+2,$fs=1);

		rotate(260)
		translate([0,28,-1])
		cylinder(r=m3_diameter/2,h=body_wall_thickness+plate_thickness+2,$fs=1);

		rotate(280)
		translate([0,28,-1])
		cylinder(r=m3_diameter/2,h=body_wall_thickness+plate_thickness+2,$fs=1);

		rotate(80)
		translate([0,28,-1])
		cylinder(r=m3_diameter/2,h=body_wall_thickness+plate_thickness+2,$fs=1);

		rotate(100)
		translate([0,28,-1])
		cylinder(r=m3_diameter/2,h=body_wall_thickness+plate_thickness+2,$fs=1);

		// Hotend Hole	
		translate([0,0,-1])
		cylinder(r=21,h=lm8uu_support_thickness*2+2);

		// Substract Belt Clamp Holes from base plate
		//for (i=[-1,1])
		//translate([-25-13.5-1,i*((28-body_length/2)-belt_clamp_width/2),0])
		//rotate(90*(i+1)+180) 
		//belt_clamp_holes();
		
		translate([-25-13.5-1,((28+body_length/2)+belt_clamp_width/2),0])
		//rotate(90*(i+1)+180) 
		belt_clamp_holes();
		
		translate([-25-13.5-1,((-28-body_length/2)-belt_clamp_width/2),0])
		rotate(180) 
		belt_clamp_holes();

			// base plate support openings to insert LM8UU holders
			for(i=[-1,1]){
				translate([i*(rod_dist/2+body_width/2-body_wall_thickness),0,body_wall_thickness/2+plate_thickness]) cube([body_wall_thickness+0.6,base_length-2*body_length,body_wall_thickness], center=true);
			}


// LM8UU Holders
	for(i=[-1,1])
	{
		translate([0,i*(28+body_wall_thickness/2),plate_thickness])
		//color([0.9,0,0,0.6])
		//render()
		rotate([0,0,i*90+90])
		lm8uu_holder();
	}

	}


// RENDER FORLM8UU Holders & Bracket
/*
	for(i=[-1,1])
	{
		translate([0,i*(28),plate_thickness])
		color([0.9,0,0,0.6])
		render()
		rotate([0,0,i*90+90])
		lm8uu_holder();
	}

translate([0,0,plate_thickness])
		color([0.9,0,0,0.6])
		render()
		lm8uu_holder_bracket();


*/

	// Belt Clamp Sockets
	difference()
	{
		union() {
		//for (i=[-1,1])
		//translate([-25-13.5-1,i*((-28-body_length/2)-belt_clamp_width/2),0])
		//rotate(90*(i+1)+180) 
		//belt_clamp_socket ();

		//belt clamp right
		translate([-25-13.5-1,((-28-body_length/2)-belt_clamp_width/2),0])
		rotate(180) 
		belt_clamp_socket ();

		//belt clamp left
		translate([-25-13.5-1,((28+body_length/2)+belt_clamp_width/2),0])
		//rotate(90*(-1)+180) 
		belt_clamp_socket ();
		}	

		// BeltClamp Socket Rod Clearance
		translate([-25,0,LM8UU_dia/2+body_wall_thickness])
		rotate([90,0,0])
		cylinder(h=100,r=5,$fs=1,center=true);
	}

	// Fan mount
//	translate([0,-(base_length/2+5),0])
//			fan_mount();
	for(i=[-1,1]){
		difference(){
			translate([i*(body_length/2+28.5),0,5]) rotate([0,0,90]) cube([15,10,10], center=true);
			//translate([i*(body_length/2+28),0,5]) rotate([0,90,90]) cylinder(r=5,h=15, center=true, $fn=20);
			translate([i*(body_length/2+28.5),0,5]) rotate([0,90,90]) cylinder(r=m3_diameter/2,h=17, center=true, $fn=8);
		}
	}
}


clearance=0.7;
lm8uu_diameter=15+clearance;
lm8uu_length=24+clearance;
lm8uu_support_thickness=3.2; 
lm8uu_end_diameter=m8_diameter+1.5;

lm8uu_holder_width=lm8uu_diameter+2*lm8uu_support_thickness;
lm8uu_holder_length=lm8uu_length+2*lm8uu_support_thickness;
lm8uu_holder_height=lm8uu_diameter*0.75+lm8uu_support_thickness;

lm8uu_holder_gap=(lm8uu_holder_length-6*lm8uu_support_thickness)/2;

screw_hole_r=4/2;

belt_clamp_hole_separation=10;

belt_clamp_height=m3_diameter+2*belt_clamp_thickness;
belt_clamp_length=belt_clamp_hole_separation+m3_diameter+2*belt_clamp_thickness;

module belt_clamp_socket()
{
	difference()
	{
		translate([0,0,belt_clamp_height/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_height],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=belt_clamp_height,center=true);
		}
		belt_clamp_holes();
	}
}

belt_width=7;
belt_thickness=1.5; 
tooth_height=1.5;
tooth_spacing=2;

belt_clamp_channel_height=belt_thickness+tooth_height+belt_clamp_thickness*2;

module belt_clamp_channel()
{
	difference()
	{
		translate([0,0,belt_clamp_channel_height/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_channel_height],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=belt_clamp_channel_height,center=true);
		}

		for(i=[-1,1])
		translate([i*belt_clamp_hole_separation/2,0,-1])
		rotate(360/16)
		cylinder(r=m3_diameter/2,h=belt_clamp_channel_height+2,$fn=8);

		translate([-belt_width/2,-belt_clamp_width/2-1,belt_clamp_channel_height-belt_thickness-tooth_height])
		cube([belt_width,belt_clamp_width+2,belt_thickness+tooth_height+1]);
	}
}

module belt_clamp_holes()
{
	translate([0,0,belt_clamp_height/2])
	{
		for(i=[-1,1])
		translate([i*belt_clamp_hole_separation/2,0,0])
		cylinder(r=m3_diameter/2,h=belt_clamp_height+2,center=true,$fn=8);
	
		rotate([90,0,0])
		rotate(360/16)
		cylinder(r=m3_diameter/2-0.3 /*tight*/ ,h=belt_clamp_width+2,center=true,$fn=8);

		rotate([90,0,0]) 
		translate([0,0,belt_clamp_width/2])
		cylinder(r=m3_nut_diameter/2-0.3 /*tight*/ ,h=3.4,center=true,$fn=6);
	}
}

belt_clamp_clamp_height=tooth_height+belt_clamp_thickness*2;

module belt_clamp() 
{

union()
{
translate([0,0,3.0])
cube([belt_clamp_hole_separation,belt_clamp_width,0.4],center=true);

for(i=[-1,1])
translate([i*(belt_clamp_hole_separation/2-1),0,3.0])
cylinder(r=belt_clamp_width/2,h=0.4,center=true);

difference()
{
translate([0,0,belt_clamp_clamp_height/2])
union()
{
cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_clamp_height],center=true);

for(i=[-1,1])
translate([i*(belt_clamp_hole_separation/2-1),0,0])
cylinder(r=belt_clamp_width/2,h=belt_clamp_clamp_height,center=true);
}

for(i=[-1,1])
translate([i*belt_clamp_hole_separation/2,0,-1])
rotate(360/16)
cylinder(r=m3_diameter/2,h=belt_clamp_clamp_height+2,$fn=8);

for(i=[-1,1])
translate([i*belt_clamp_hole_separation/2,0,-1])
//rotate(360/12)
cylinder(r=m3_nut_diameter/2,h=4,$fn=6);

for(i=[-3:3])
translate([-belt_width/2,-tooth_spacing/4+i*tooth_spacing,belt_clamp_clamp_height-tooth_height])
cube([belt_width,tooth_spacing/2,tooth_height+1]);
}
}
}


/**
module belt_clamp()
{
	difference()
	{
		translate([0,0,belt_clamp_clamp_height/2])
		union()
		{
			cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_clamp_height],center=true);
			for(i=[-1,1])
			translate([i*belt_clamp_hole_separation/2,0,0])
			cylinder(r=belt_clamp_width/2,h=belt_clamp_clamp_height,center=true);
		}


		for(i=[-1,1])
		translate([i*belt_clamp_hole_separation/2,0,-1])
		rotate(360/16)
		cylinder(r=m3_diameter/2,h=belt_clamp_clamp_height+2,$fn=8);

		for(i=[-1:1])
		translate([-belt_width/2,-tooth_spacing/4+i*tooth_spacing,belt_clamp_clamp_height-tooth_height])
		cube([belt_width,tooth_spacing/2,tooth_height+1]);
	}
}
**/

/**
fan_hole_separation=32; // check
fan_support_block=11;
fan_trap_width=3;
fan_support_thickness=11;
fan_diameter=36;
fan_hole_height=5.5;

module fan_mount() 
{
	difference()
	{
		union ()
		{
			translate([0,0,fan_support_block/4])
			cube([fan_hole_separation+fan_support_block,fan_support_thickness,fan_support_block/2],center=true);
			
			for (i=[-1,1])
			translate([i*fan_hole_separation/2,0,fan_support_block/2])
			rotate([90,0,0])
			cylinder(r=fan_support_block/2,h=fan_support_block,center=true,$fn=20);
			
			translate([0,0,fan_support_block/2])
			cube([fan_hole_separation,fan_support_thickness,fan_support_block],center=true);
			translate([0,6,lm8uu_support_thickness/2])
			cube([fan_hole_separation+fan_support_block,fan_support_thickness+12,lm8uu_support_thickness],center=true);
		}
		for(i=[-1,1])
		{
			translate([i*fan_hole_separation/2,0,fan_hole_height])
			{
				rotate([90,0,0])
				rotate(180/8)
				cylinder(r=m3_diameter/2,h=fan_support_thickness+2,center=true,$fn=8);
				translate([0,0,0])
				rotate([90,0,0])
				rotate([0,0,180/6])
				cylinder(r=(m3_nut_diameter-0.5)/2,h=fan_trap_width,center=true,$fn=6);
				color([1,0,0])
				translate([0,0,-(fan_hole_height+1)/2])
				cube([(m3_nut_diameter-0.5)*cos(30),fan_trap_width,fan_hole_height+1],center=true);
			}
		}
		translate([0,0,fan_hole_separation/2+fan_hole_height])
		rotate([-90,0,0])
		cylinder(r=fan_diameter/2,h=fan_support_thickness+2,center=true);
	}
}
**/



fan_hole_separation=32; // check
fan_support_block=10;
fan_trap_width=3;
fan_support_thickness=10;
fan_diameter=36;
fan_hole_height=5.5;

module fan_mount() 
{
	difference()
	{
		union ()
		{
			translate([0,0,fan_support_block/4])
			cube([fan_hole_separation+fan_support_block,fan_support_thickness,fan_support_block/2],center=true);
			
			for (i=[-1,1])
			translate([i*fan_hole_separation/2,0,fan_support_block/2])
			rotate([90,0,0])
			cylinder(r=fan_support_block/2,h=fan_support_block,center=true,$fn=20);
			
			translate([0,0,fan_support_block/2])
			cube([fan_hole_separation,fan_support_thickness,fan_support_block],center=true);
		}
		for(i=[-1,1])
		{
			translate([i*fan_hole_separation/2,0,fan_hole_height])
			{
				rotate([90,0,0])
				rotate(180/8)
				cylinder(r=m3_diameter/2,h=fan_support_thickness+2,center=true,$fn=8);
				translate([0,0,0])
				rotate([90,0,0])
				rotate([0,0,180/6])
				cylinder(r=(m3_nut_diameter-0.5)/2,h=fan_trap_width,center=true,$fn=6);
				color([1,0,0])
				translate([0,0,-(fan_hole_height+1)/2])
				cube([(m3_nut_diameter-0.5)*cos(30),fan_trap_width,fan_hole_height+1],center=true);
			}
		}
		translate([0,0,fan_hole_separation/2+fan_hole_height])
		rotate([-90,0,0])
		cylinder(r=fan_diameter/2,h=fan_support_thickness+2,center=true);
	}
}

function triangulate (point1, point2, length1, length2) = 
point1 + 
length1*rotated(
atan2(point2[1]-point1[1],point2[0]-point1[0])+
angle(distance(point1,point2),length1,length2));

function distance(point1,point2)=
sqrt((point1[0]-point2[0])*(point1[0]-point2[0])+
(point1[1]-point2[1])*(point1[1]-point2[1]));

function angle(a,b,c) = acos((a*a+b*b-c*c)/(2*a*b)); 

function rotated(a)=[cos(a),sin(a),0];
