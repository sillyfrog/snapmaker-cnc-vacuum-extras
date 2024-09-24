$fn = 150;

WALL = 2;
SMALL_INNER_R = (49)/2;
OVERLAP = 20;

INSERT_DIA1 = 33.5;
INSERT_DIA2 = 36;
INSERT_LEN = 35;

CENTER_HOLE = false;

X_OFFSET = INSERT_DIA2/2 - SMALL_INNER_R;
R_DIFF = (SMALL_INNER_R+WALL) - INSERT_DIA2/2;

difference() {
    union() {
        translate([0,0,0]) cylinder(r = SMALL_INNER_R + WALL, h = OVERLAP);
        translate([0,0,OVERLAP+R_DIFF]) cylinder(d2 = INSERT_DIA1, d1=INSERT_DIA2, h = INSERT_LEN);
        translate([0,0,OVERLAP]) cylinder(d2 = INSERT_DIA2, d1=(SMALL_INNER_R+WALL)*2, h = R_DIFF);
    }
    union() {
        translate([0,0,-0.1/2]) cylinder(r = SMALL_INNER_R, h = OVERLAP + .1);
        translate([0,0,OVERLAP+R_DIFF]) cylinder(d2 = INSERT_DIA1-WALL*2, d1=INSERT_DIA2-WALL*2, h = INSERT_LEN);
        translate([0,0,OVERLAP]) cylinder(d2 = INSERT_DIA2-WALL*2, d1=(SMALL_INNER_R)*2, h = R_DIFF);
    }
}