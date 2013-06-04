// PLASTIBOT MENDEL
// Endstop Holder
// Added nuttrap for clamping screw
// Plastibot <support@plastibot.com>
// Derived from: 


// PRUSA Mendel  
// Endstop holder
// Used to attach endstops to 8mm rods
// GNU GPL v2
// Josef Průša
// josefprusa@me.com
// prusadjs.cz
// http://www.reprap.org/wiki/Prusa_Mendel
// http://github.com/prusajr/PrusaMendel

include <configuration2.scad>

/**
 * @id endstop-holder
 * @name Endstop holder
 * @category Printed
 * @using 1 m3x20
 * @using 1 m3nut
 * @using 2 m3washer
 */
module endstop(){
outer_diameter = m8_diameter/2+3.3;
screw_hole_spacing = 10;
opening_size = m8_diameter-1.5; //openingsize

difference(){
	union(){


		translate([outer_diameter, outer_diameter, 0]) cylinder(h =10, r = outer_diameter, $fn = 20);
		translate([outer_diameter, 0, 0]) cube([15.5,outer_diameter*2,10]);
		translate([-22, 0, 0]) cube([30, 4, 10]);
		//translate([-10, 0, 0]) cube([10, 4, 25]);
	}




	translate([9, outer_diameter-opening_size/2, 0]) cube([18,opening_size,20]);
	translate([outer_diameter, outer_diameter, 0]) cylinder(h =20, r = m8_diameter/2, $fn = 18);
	translate([17, 2, 5]) rotate([90, 0, 0]) cylinder(h =2.5, r = m3_nut_diameter/2, $fn = 6);
	translate([17, 17, 5]) rotate([90, 0, 0]) cylinder(h =20, r = m3_diameter/2, $fn = 10);
	translate([-5, 17, 5]) rotate([90, 0, 0]) cylinder(h =20, r = m3_diameter/2, $fn = 10);
	translate([-(5+screw_hole_spacing), 17, 5]) rotate([90, 0, 0]) cylinder(h =20, r = m3_diameter/2, $fn = 10);
}
}
endstop();

