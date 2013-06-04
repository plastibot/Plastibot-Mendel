// PLASTIBOT MENDEL
// Y-belt-clamp
// Took the Carriage clams and made them longer for use on the frog assembly
// added a belt socket piece with Screw to tension the belt.
// Plastibot <support@plastibot.com>
// Derived from: 

// Gregs PRUSA Mendel 
// X-carriage
// Used for sliding on X axis
// GNU GPL v2
// Greg Frost
//https://github.com/GregFrost/PrusaMendel

include <configuration2.scad>

/**
* Slides on the x-axis with extruder.
* @name X carriage
* @category Printed
* @using 4 m3x10
* @using 4 m3washer
* @using 4 m3nut
* @using 4 bushing
*/ 

belt_clamp_thickness=2; 
belt_clamp_width=m3_diameter+3*belt_clamp_thickness+2;

belt_clamp(); 


translate([0,belt_clamp_width+1,0]) belt_clamp_channel();

translate([0,-belt_clamp_width-1,0]) belt_clamp_socket();

belt_clamp_hole_separation=20; 

belt_clamp_height=m3_diameter+2*belt_clamp_thickness;
belt_clamp_length=belt_clamp_hole_separation+m3_diameter+2*belt_clamp_thickness;

module belt_clamp_socket()
{
difference()
{
translate([0,0,belt_clamp_height/2+1.5])
union()
{
cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_height+3],center=true);
for(i=[-1,1])
translate([i*belt_clamp_hole_separation/2,0,0])
cylinder(r=belt_clamp_width/2,h=belt_clamp_height+3,center=true);
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
cylinder(r=m3_diameter/2,h=belt_clamp_height+8,center=true,$fn=8);
rotate([90,0,0])
rotate(360/16)
cylinder(r=m3_diameter/2-0.3 /*tight*/ ,h=belt_clamp_width+2,center=true,$fn=8);

rotate([90,0,0]) 
translate([0,0,belt_clamp_width/2])
cylinder(r=m3_nut_diameter/2,h=4.4,center=true,$fn=6);
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
translate([i*belt_clamp_hole_separation/2,0,3.0])
cylinder(r=belt_clamp_width/2,h=0.4,center=true);

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

for(i=[-1,1])
translate([i*belt_clamp_hole_separation/2,0,-1])
//rotate(360/12)
cylinder(r=m3_nut_diameter/2+0.3,h=4,$fn=6);

for(i=[-2:2])
translate([-belt_width/2,-tooth_spacing/4+i*tooth_spacing,belt_clamp_clamp_height-tooth_height])
cube([belt_width,tooth_spacing/2,tooth_height+1]);
}
}
}