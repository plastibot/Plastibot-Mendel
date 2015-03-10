

card_bracket_10();
//card_bracket_15();


module card_bracket_10(){

difference() {

cube([9.8,10,14]);

translate([2.4,-0.5,2]) cube([5,11,14]);

//translate([0,0,8]) cube([8.8,2,14]);

translate([4.9,5,0]) cylinder(r=1.9, h=15, $fn=20);

translate([4.9,5,2]) cylinder(r=3.5, h=7, $fn=6);

}

}

module card_bracket_15(){

difference() {

cube([9.8,15,14]);

translate([2.4,-0.5,2]) cube([5,16,14]);

//translate([0,0,8]) cube([8.8,2,14]);

translate([4.9,7.5,0]) cylinder(r=1.9, h=15, $fn=20);

translate([4.9,7.5,2]) cylinder(r=3.5, h=7, $fn=6);

}

}