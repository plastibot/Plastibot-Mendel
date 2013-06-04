// PLASTIBOT MENDEL
// Fan holder
// Added nut trap to pivot screw hole
// Plastibot <support@plastibot.com>
// Derived from: 

// Fan holder for Jonas Kuehlings X carriage
// Made by Fredrik Hubinette 2012
// GPL

render_moving_parts = true;

include <fan.scad>

rotate([0,180,0]) {
  translate([0,0,5]) {
    if (render_moving_parts) {
      translate([0,0,0.1]) fan();

      // This represents the part we're mounting the fan to.
      translate([20- 5, 0, -5 - 7]) {
	color([0.2,0.5,1.0]) {
	  rotate([0,-15,0]) {
	    difference() {
	      cube([10,15,10], center=true);
	      rotate([90,0,0]) {
		cylinder(r=1.5, h=30, center=true, $fn=20);
	      }
	    }
	  }
	}
      }
    }

    fanholder();
  }
}


module shroud() {
  cylinder(r2=20, r1=19, h=12, $fn=64);
}


module fanholder() {
  difference() {
    union() {
      difference() {
	union() {
	  translate([0, 0,-17]) {
	    shroud();
	  }
	  translate([0,0,-6.5]) {
	    cube([40,40,3], center=true);
	  }
	}

	translate([0, 0,-17.1]) {
	  scale([19/20, 19/20, 1.2]) {
	    shroud();
	  }
	}
	translate([0,0,-6.6]) {
	  for (x=[-16, 16]) {
	    for (y=[-16, 16]) {
	      translate([x, y, 0]) {
		cylinder(r=1.75, h=15, center=true, $fn=20);
	      }
	    }
	  }
	}
      }

      translate([20- 5, 0, -5 - 7]) {
	translate([-5,-7.5-3,-5]) {
	  cube([10,15+3*2,12]);
	}
      }
    }
    // This represents the part we're mounting the fan to.
    translate([20- 5, 0, -5 - 7]) {
      rotate([90,0,0]) {
	cylinder(r=1.5, h=30, center=true, $fn=20);
//	cylinder(r=3, h=2, center=true, $fn=6); //nut trap
	for (x=[-20,20]) {
	  translate([0,0,x]) {
	    translate([0,-5]) {
	      cube([6,10,20], center=true);
	    }
	    cylinder(r=3, h=20, center=true, $fn=20);
	  }
	}
      }
    }
    translate([20- 5, 0, 0]) {
      cube([20,15,50], center=true);
    }

    translate([20- 5, 0, -5 - 7]) {
      for (r = [-80:10:80]) {
	rotate([0,r,0]) {
	  translate([0,0,-9.9]) {
	    cube([10,15+3.1*2,10], center=true);
	  }
	}
      }
    }
  }
}
