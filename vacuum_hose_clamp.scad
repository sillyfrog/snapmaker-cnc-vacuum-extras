EXTERNAL_DIA = 38;

WALL = 2;
HEIGHT = 15;
FOOT_LEN = 35;

OUTER_DIA = EXTERNAL_DIA + 2*WALL;

$fn=300;

rotate([0,-90,90])
difference() {
    union() {
        translate([0,0,EXTERNAL_DIA/2]) rotate([0,90,0]) cylinder(d=OUTER_DIA, h=HEIGHT);
        translate([HEIGHT/2,0,EXTERNAL_DIA/2/2]) cube([HEIGHT, OUTER_DIA, EXTERNAL_DIA/2], center=true);
        hull(){
            translate([HEIGHT/2,-(FOOT_LEN-HEIGHT/2+OUTER_DIA/2),0]) cylinder(d=HEIGHT, h=WALL);
            translate([HEIGHT/2,(FOOT_LEN-HEIGHT/2+OUTER_DIA/2),0]) cylinder(d=HEIGHT, h=WALL);
        }
    }
    translate([-1,0,EXTERNAL_DIA/2]) rotate([0,90,0]) cylinder(d=EXTERNAL_DIA, h=HEIGHT+2);
    translate([0,0,0]) cube([HEIGHT*2+2, EXTERNAL_DIA, EXTERNAL_DIA], center=true);
}

// #cube([10, OUTER_DIA+FOOT_LEN*2, 4], center=true);