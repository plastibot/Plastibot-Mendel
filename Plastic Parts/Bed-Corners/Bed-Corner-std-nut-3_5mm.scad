
M3_dia = 3.8;
M3_insert_dia = 5.6;
M3_screw_head_dia = 7;
M3_screw_head_height = 3;
M3_nut_dia = 6.9;

//glass corners
//glass_corner();
//translate([2,2,0]) glass_corner();
//translate([-2,-2,0]) rotate([0,0,180]) glass_corner();
//translate([-2,2,0]) mirror() glass_corner();
//translate([2,-2,0]) rotate([0,0,180]) mirror() glass_corner();

//bed corners
//bed_corner();
translate([2,-10,0]) rotate([180,0,0]) bed_corner();
translate([-2,10,0]) rotate([180,0,180]) bed_corner();
translate([-2,-10,0]) rotate([180,0,0]) mirror() bed_corner();
translate([2,10,0]) rotate([180,0,180]) mirror() bed_corner();



module bed_corner(){
    difference(){
        union() {
            translate([0,-8,0]) cube([24,24.3,3.5]);
            translate([0,-8,-4]) cube([2,24.3,4]);
            translate([0,24-9.7,-4]) cube([24,2,4]);
        }
            
        //holes for screws
        translate([5.5,4.5,-5]) cylinder(r=M3_dia/2, h=12, $fn=20);
        //translate([5.5,18.5,-5]) cylinder(r=M3_dia/2, h=12, $fn=20);
        //translate([19.5,18.5,-5]) cylinder(r=M3_dia/2, h=12, $fn=20);
        
        //pockets for M3 nut traps
        translate([5.5,4.5,1.5]) cylinder(r=M3_nut_dia/2, h=4, $fn=6);
        //translate([19.5,18.5,-4]) cylinder(r=M3_nut_dia/2, h=4, $fn=6);
        
        //cones to print inserts w/o support
        translate([5.5,4.5,0.5]) cylinder(r1=M3_dia/2, r2=M3_nut_dia/2, h=1, $fn=6);
        //translate([19.5,18.5,1]) cylinder(r1=M3_dia/2, r2=M3_nut_dia/2, h=1, $fn=20);
        
                //cut corners
        translate([24,24,1]) rotate([0,0,45]) cube([5,5,12], center=true);
        translate([24,0,1]) rotate([0,0,45]) cube([50,20,12], center=true);
        translate([0,24,1]) rotate([0,0,45]) cube([5,5,12], center=true);
        //translate([0,0,1]) rotate([0,0,45]) cube([5,5,12], center=true);
    }
}

module glass_corner(){
        difference(){
        union() {
            cube([24,24,4]);
            translate([0,9,4]) cube([10,15,3]);
            translate([0,24-10,4]) cube([24,10,3]);
           
        }
            
        //holes for screws
        translate([5.5,4.5,-4]) cylinder(r=M3_dia/2, h=12, $fn=20);
        translate([5.5,18.5,-4]) cylinder(r=M3_dia/2, h=12, $fn=20);
        translate([19.5,18.5,-4]) cylinder(r=M3_dia/2, h=12, $fn=20);
        
        //pockets for M3 inserts
        translate([5.5,18.5,0]) cylinder(r=M3_insert_dia/2, h=4, $fn=20);
        //cone to print insert with no support
        translate([5.5,18.5,4]) cylinder(r1=M3_insert_dia/2, r2=M3_dia/2, h=1, $fn=20);
        
        //pockets for screw heads
        translate([19.5,18.5,4]) cylinder(r=M3_screw_head_dia/2, h=M3_screw_head_height, $fn=20);
        
        //cut corners
        translate([24,24,4]) rotate([0,0,45]) cube([5,5,10], center=true);
        translate([24,0,4]) rotate([0,0,45]) cube([20,20,10], center=true);
        translate([0,24,4]) rotate([0,0,45]) cube([5,5,10], center=true);
        translate([0,0,4]) rotate([0,0,45]) cube([5,5,10], center=true);
        
       
        //clearance for glass corner
        translate([10.5,13.5,4]) cylinder(r=M3_dia/2, h=12, $fn=20);
    
        
    }
}