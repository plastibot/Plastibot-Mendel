
difference() {

cube([8.8,19,14]);

translate([2,2,2]) cube([4.8,19,14]);

translate([0,0,8]) cube([8.8,2,14]);

translate([4.4,9.8,0]) cylinder(r=1.8, h=15, $fn=20);

translate([4.4,9.8,2]) cylinder(r=3, h=7, $fn=6);

}