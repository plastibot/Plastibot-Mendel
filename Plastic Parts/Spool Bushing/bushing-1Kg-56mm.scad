// PLASTIBOT MENDEL
// Spool Bushing
// Added settings for 1Kg Ultimachine spool.
// Plastibot <support@plastibot.com>
// Derived from: 

// Parametric Bushing
// by Generic
// http://www.thingiverse.com/thing:8697




module bushing(height, radius, hole_r, border,recess,num_support) {
	translate([0,0,height])
	mirror([0,0,1])
	difference() {
		union() {
			// Outer rings
			difference() {
				union() {
					cylinder(r=radius+border,h=1);
					translate([0,0,1]) {
						cylinder(h=2,r1=radius+border,r2=radius);
					}
					translate([0,0,3]) {
						cylinder(r=radius,h=height-6);
					}
					translate([0,0,height-3]) {
						cylinder(h=3,r1=radius,r2=radius-border);
					}
				}
				translate([0,0,-1]) {
					cylinder(r=radius-(border*2),h=height+border);
				}
			}
			// shafts
			for ( i=[0:num_support-1]) {
				rotate(a=[0,0,i*180/num_support]) {
					translate([-radius+border+0.4,-border,0]) {
						cube(size=[(radius-border)*2-0.6,border*2,height]);
					}
				}
			}
			// Central ring
			cylinder(r=hole_r+border*2,h=height);
		}
		translate([0,0,-1]) {
			// Central hole
			cylinder(r=hole_r,h=height+2,$fs=0.1);
			// Recess
			cylinder(r=radius-2*border, h=recess);
		}
	}
}


// Bushing BfB
//bushing(16, 75/2, 4.5, 1.56,5,3);

// Bushing orbitech
//bushing(16, 26.2, 4.5, 1.56,0,3);

// Bushing 51mm (ultimachine 1Kg)
bushing(8, 28, 4.5, 1.56,0,3);
