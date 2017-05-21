// Customizable Mini Hotend Fan Duct (Makerfarm i3-i3v compatible)
// The default measurements are configured for J-Head MkV
//
// All dimensions are in mm.

// Number of segments per circle. Effects both OpenSCAD display and generated
// STL. Reduce during debugging for faster compilation.
$fn = 20;

// Fan measurements
fan_size = 25; // You can go for a bigger fan here if you want (manually set screw spacing for fans larger than 50mm).
fan_distance_from_hotend = 26; // Increase this if you think the fan is too close to the heating block.
fan_screw_spacing = fan_size*0.8; // This formula is fine for fan sizes up to 50mm, set manually for bigger ones.
screw_diameter = 3; // Increase if screws are too tight.
top_screw_depth = 9; // These screw holes stay hidden. Increase if you have really long screws.
bottom_screw_depth = 20; // These screw holes will most likely go all the way through, lower if you want them to stay hidden.

// Hotend measurements//
hotend_diameter = 19.1; // Works well with at least J-Head MkIV & MkV. Lower if it is too loose on your hotend, and increase if it is too tight.

// Air duct sizes
hotend_duct_size = hotend_diameter-8; // The duct size at the hotend. If the heat sink is small, set this to a value lower than the hotend diameter.
fan_duct_size = fan_size -2 ; // The duct size on the fan end. The default one should be fine.

// Other
corner_radius = 2; // Lower to get sharper corners/edges.
hotend_grip_extra_width = 2; // Increase this to make the mount less prone to breaking.
fan_mount_thickness = 3; // Only increase if you want the mount to get beefier.
distance_behind_hotend = (hotend_diameter/3) -9; // This should be fine, but increase if you want tighter grip on hotend.

height_behind_hotend = 14; // If the plastic is too close to the heating block, lower this.

module fan_mount() {
	translate([-(fan_size/2 - corner_radius),
				  -(fan_size/2 - corner_radius),
				  0]) {
		if (corner_radius > 0) {
			hull() {
				cylinder(r=corner_radius, h=fan_mount_thickness);
				translate([fan_size-2*corner_radius, 0, 0]) {
					cylinder(r=corner_radius, h=fan_mount_thickness);
				}
				translate([0, fan_size - 2*corner_radius, 0]) {
					cylinder(r=corner_radius, h=fan_mount_thickness);
				}
				translate([fan_size - 2*corner_radius, fan_size - 2*corner_radius, 0]) {
					cylinder(r=corner_radius, h=fan_mount_thickness);
				}
			}
		} else {
			cube(size = [fan_size, fan_size, fan_mount_thickness]);
		}
	}
}

module body() {
	hull() {
		// Fan mount
		translate([0, 0, -(fan_distance_from_hotend + fan_mount_thickness)]) {
			fan_mount();
		}
		
		// Rounded corners connecting to fan mount 
		translate([-(fan_size/2 - corner_radius), 
					  -(fan_size/2 - corner_radius), 
					  -(fan_distance_from_hotend)]) {
			if (corner_radius > 0) {
				sphere(r = corner_radius);
				translate([fan_size - 2*corner_radius, 0, 0]) {
					sphere(r = corner_radius);
				}
				translate([0, fan_size - 2*corner_radius, 0]) {
					sphere(r = corner_radius);
				}
				translate([fan_size - 2*corner_radius, fan_size - 2*corner_radius, 0]) {
					sphere(r = corner_radius);
				}
			} else {
				translate([0,0,-1]) {
					cube(size = [fan_size, fan_size, 1]);
				}
			}
		}
		
		// Corners behind hotend
		translate([-(hotend_diameter/2 - corner_radius + hotend_grip_extra_width),
					  fan_size/2 - max(height_behind_hotend - 2*corner_radius, 0) - corner_radius,
					  distance_behind_hotend - corner_radius]) {
			if (corner_radius > 0) {
				sphere(r = corner_radius);
				translate([hotend_diameter - 2*(corner_radius - hotend_grip_extra_width), 0, 0]) {
					sphere(r = corner_radius);
				}
				translate([0, 
							  max(height_behind_hotend - 2*corner_radius, 0), 
							  0]) {
					sphere(r = corner_radius);
				}
				translate([hotend_diameter - 2*(corner_radius - hotend_grip_extra_width), 
							  max(height_behind_hotend - 2*corner_radius, 0), 
							  0]) {
					sphere(r = corner_radius);
				}
			} else {
				translate([0,0,-6]) {
					cube(size = [hotend_diameter + 2*hotend_grip_extra_width, 
									 height_behind_hotend, 
									 6]);
				}
			}
		}
	}
}

difference() {
	union() {
		body();

	}
	union() {
		// Air duct
		translate([0,
					  fan_duct_size/2, 
					  -(fan_distance_from_hotend + fan_mount_thickness + 0.1)]) {
			linear_extrude(height = fan_distance_from_hotend + fan_mount_thickness + 0.1, 
								scale = hotend_duct_size/fan_duct_size) {
				translate([0, -fan_duct_size/2]) {
					circle(d = fan_duct_size);
				}
			}
		}
		
		// Screw holes
		translate([-(fan_screw_spacing/2),
					  -(fan_screw_spacing/2),
					  -(fan_distance_from_hotend + fan_mount_thickness + 0.1)]) {
			cylinder(d = screw_diameter, h = bottom_screw_depth);
			translate([fan_screw_spacing, 0, 0]) {
				cylinder(d = screw_diameter, h = bottom_screw_depth);
			}
			translate([0, fan_screw_spacing, 0]) {
				cylinder(d = screw_diameter, h = top_screw_depth);
			}
			translate([fan_screw_spacing, fan_screw_spacing, 0]) {
				cylinder(d = screw_diameter, h = top_screw_depth);
			}
		}
		
		// Hotend mount
		translate([0, fan_size*0.75, 0]) {
			rotate(a=90, v=[1,0,0]) {
				cylinder(d=hotend_diameter, h=fan_size*1.5);
			}
		}
        
     // removing btop half
        translate([-13,6,-35])
        cube([26,12.5,50]);
	}
    
       
}