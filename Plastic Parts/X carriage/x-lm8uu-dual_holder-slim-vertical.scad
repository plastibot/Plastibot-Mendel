
// PLASTIBOT MENDEL
// X-Carriage - Split the Carriage in 3 pieces - Platform, LM8UU Holders and Bracket.
// This file addresses the LM8UU Holder which uses dovetails to attach to the platform.
// Plastibot <support@plastibot.com>
// Derived from: 

// LM8UU Vertical holder slim
// *********************************************
// Jonas Kühling
// http://www.jonaskuehling.de
// http://www.thingiverse.com/jonaskuehling
// *********************************************
// derived from:
// http://www.thingiverse.com/thing:14942

use <jonaskuehling-default.scad>
include <configuration.scad>

// LM8UU/rod dimensions
LM8UU_dia = 15.4;
LM8UU_length = 24;
rod_dia = 8;

//screw/nut dimensions (M3) - hexagon socket head cap screw ISO 4762, hexagon nut ISO 4032
screw_thread_dia_iso = 3;
screw_head_dia_iso = 6; //was 5.5
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
// rotate([90,0,0]) translate([0,body_length/2,0]) lm8uu_holder();

module lm8uu_holder()
{
difference()
{
union()
{
mount_plate();

for(i=[-1,1])
{
	translate([i*(25),-i*body_length/2,body_width/2])
	//render()
	rotate([90,0,i*90+90])
	lm8uu_holder_slim_double_vertical();
}


}


//DOVETAILS
translate([0,-body_length/2-0.6,1.5])
rotate([-45,0,0]) color([0.9,0,0,0.6]) render() cube([30,3,4], center=true);

//Previous values
//translate([0,-body_length/2,1.5])
//rotate([-45,0,0]) color([0.9,0,0,0.6]) render() cube([30,3,4], center=true);

translate([0,body_length/2+3,2])
rotate([45,0,0]) color([0.9,0,0,0.6]) render() cube([70,3,4], center=true);

translate([15+body_width,0,2])
rotate([0,45,0]) color([0.9,0,0,0.6]) render() cube([4,body_length+10,4], center=true);

// Previous values
//translate([15+body_width,0,2.5])
//rotate([0,45,0]) color([0.9,0,0,0.6]) render() cube([3,body_length+10,4], center=true);

translate([-15-body_width,0,2])
rotate([0,-45,0]) color([0.9,0,0,0.6]) render() cube([4,body_length+10,4], center=true);


translate([0,16+body_length/2,-0.5])
cylinder(r=21,h=body_wall_thickness+1);

		// Extruder Mounting Holes
		translate([0,16+body_length/2,-0.5])
		rotate(180)
		for (hole=[-1:1])
		rotate(hole*22)
		translate([0,25,-1])
		cylinder(r=m3_diameter/2,h=body_wall_thickness*2+2,$fs=1);


}
}

//lm8uu_holder_slim_double_vertical(1);		


module mount_plate()
{
	difference()
	{
		translate([0,1.5,1])
		cube([25+body_width+2*screw_head_dia+4*nut_surround_thickness,body_length+3,body_wall_thickness], center=true);

		//for(i=[-1,1])
		//	translate([i*(body_width/2+nut_surround_thickness+screw_head_dia/2),0,-1.5])
		//		cylinder(r=screw_thread_dia/2, h=6, $fn=20);
		//for(i=[-1,1])
		//	translate([i*(body_width/2+nut_surround_thickness+screw_head_dia/2),0,1.5])
		//		cylinder(r=nut_dia/2, h=body_width/2-gap_width/2-body_wall_thickness+1,$fn=6);
		//echo("distance between holes",body_width/2+nut_surround_thickness+screw_head_dia/2);

	}
}

// main body
module lm8uu_holder_slim_double_vertical(with_mountplate=false)
{
	// rotate vertical and center bearing around z-axis
	translate([0,-(LM8UU_dia/2+body_wall_thickness),body_length/2])
	rotate([-90,0,0])
	difference()
	{
		union()
		{	
			if (with_mountplate) 
			mount_plate();

			// body
			translate([-body_width/2,-body_length/2,body_height/2])
				cube([body_width,body_length,(LM8UU_dia/2)+screw_bushing_space+(screw_thread_dia/2)+extra_height_varticalprint]);
			translate([0,0,(LM8UU_dia/2)+body_wall_thickness])		
				rotate([90,0,0])
					cylinder(r=(LM8UU_dia/2)+body_wall_thickness, h=body_length, center=true);
	
			// gap support
			translate([-(gap_width/2)-body_wall_thickness,-(body_length/2),body_height/2])
				cube([body_wall_thickness,LM8UU_length,(LM8UU_dia/2)+screw_bushing_space+(screw_thread_dia/2)]);
			translate([gap_width/2,-(body_length/2),body_height/2])
				cube([body_wall_thickness,LM8UU_length,(LM8UU_dia/2)+screw_bushing_space+(screw_thread_dia/2)]);
	
			//for(i=[-(body_length/2-LM8UU_length/2),(body_length/2-LM8UU_length/2)])
			//{
				// nut trap surround
				translate([gap_width/2,0,screw_elevation])
					rotate([0,90,0])
						cylinder(r=(((nut_wrench_size+nut_surround_thickness*2)/cos(30))/2), h=(body_width-gap_width)/2, $fn=20);
	
				// Screw hole surround
				translate([-gap_width/2,0,screw_elevation])
					rotate([0,-90,0])
						cylinder(r=(screw_head_dia/2)+nut_surround_thickness, h=(body_width-gap_width)/2, $fn=20);
			//}
		}
	
		// bushing hole
		translate([0,0,LM8UU_dia/2+2])
			rotate([90,0,0])
				polyhole(d=LM8UU_dia, h=body_length+1, center=true);
	
		// top gap
		translate([-(gap_width/2),-(body_length/2)-1,body_height/2])
			cube([gap_width,body_length+2,(LM8UU_dia/2)+screw_bushing_space+(screw_thread_dia/2)+(nut_dia/2)+nut_surround_thickness+1]);
	
		//for(i=[-(body_length/2-LM8UU_length/2),(body_length/2-LM8UU_length/2)])
		//{
			// screw hole (one all the way through)
			translate([0,0,screw_elevation])
				rotate([0,90,0])
					polyhole(d=screw_thread_dia, h=body_width+3, center=true);
		
			// nut trap
			translate([gap_width/2+body_wall_thickness,0,screw_elevation])
				rotate([0,90,0])
					cylinder(r=nut_dia/2, h=body_width/2-gap_width/2-body_wall_thickness+1,$fn=6);
		
			// screw head hole
			translate([-(gap_width)/2-body_wall_thickness,0,screw_elevation])
				rotate([0,-90,0])
					cylinder(r=screw_head_dia/2, h=body_width/2-gap_width/2-body_wall_thickness+1,$fn=20);

		//}	
	}
}

/*
// Based on nophead research
module polyhole(d,h,center=false) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), center=center, $fn = n);
}
*/
