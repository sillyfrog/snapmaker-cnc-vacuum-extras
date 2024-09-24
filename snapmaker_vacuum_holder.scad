
// INSERT_DIA_MAX = 37.5;
// INSERT_DIA_MIN = 33.5;
INSERT_DIA_MAX = 33.5;
INSERT_DIA_MIN = 32.5;
INSERT_HEIGHT = 25;
INSERT_END_HEIGHT = 5;

BASE_HEIGHT_1 = 20;
BASE_HEIGHT_2 = 5;
BASE_EDGE_THICK = 3;
BASE_UNDERLAP = 5;

BASE_EDGE_2_ANGLE = 30;
BASE_EDGE_2_CORNER_RADIUS = 100;


EDGE_WALL = 10;

HOLDER_DIA = INSERT_DIA_MAX + 2*EDGE_WALL;

COPPER_SPACING_DIA = 6.3;
COPPER_SPIRAL_SPACING = 8.5;
DUCT_INNER_DIA = 32;

DESK_HOLE_DIA = 42;
DESK_HOLE_SQUARE_BORDER = 7;
SQUARE_CORNER_RADIUS = 2;
DESK_HOLE_SCREW_DIA = 3;

SOCKET_DIA1 = 34.5;
SOCKET_DIA2 = 32.0;
SOCKET_INSERT_LEN = 24;

WALL = 2.5;
AIR_INNER_DIA = DUCT_INNER_DIA - 2*WALL;

ANGLE = 45;

JOINER_DIA = DUCT_INNER_DIA+COPPER_SPACING_DIA;

BASE_SIZE = DESK_HOLE_DIA + DESK_HOLE_SQUARE_BORDER*2;

$fn=300;

module pipe_end() {
    difference() {
        cylinder(d=HOLDER_DIA, h=INSERT_HEIGHT+INSERT_END_HEIGHT);
        translate([0,0,INSERT_END_HEIGHT+0.01]) cylinder(d2=INSERT_DIA_MAX, d1=INSERT_DIA_MIN, h=INSERT_HEIGHT);
        translate([0,0,-1]) cylinder(d=INSERT_DIA_MIN, h=INSERT_HEIGHT);
    }
}

module desk_end() {
    SCREW_EDGE_POSITION = BASE_SIZE-DESK_HOLE_SCREW_DIA-5;
    translate([0,0,-WALL])
    difference() {
        hull() {
            for (x=[-1,1]) {
                for (y=[-1,1]) {
                    translate([x*(BASE_SIZE-SQUARE_CORNER_RADIUS)/2, y*(BASE_SIZE-SQUARE_CORNER_RADIUS)/2, 0]) cylinder(r=SQUARE_CORNER_RADIUS, h=WALL);
                }
            }
        }
        for (x=[-1,1]) {
            for (y=[-1,1]) {
                translate([x*SCREW_EDGE_POSITION/2, y*SCREW_EDGE_POSITION/2, -1]) cylinder(d=DESK_HOLE_SCREW_DIA, h=WALL+2);
            }
        }
    }
}

desk_end();
pipe_end();