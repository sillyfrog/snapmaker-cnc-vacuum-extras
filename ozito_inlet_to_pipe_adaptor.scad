use <Spiral_extrude.scad>;

$fn=100;
fn_spiral = $fn;

COPPER_SPACING_DIA = 6.3;
COPPER_SPIRAL_SPACING = 8.5;
DUCT_INNER_DIA = 32;

OZITO_INSERT_DIA1 = 33.5;
OZITO_INSERT_DIA2 = 36;
OZITO_INSERT_LEN = 35;

SOCKET_INSERT_LEN = 24;

WALL = 1.6;
AIR_INNER_DIA = DUCT_INNER_DIA - 2*WALL;

ANGLE = 45;

JOINER_DIA = DUCT_INNER_DIA+COPPER_SPACING_DIA;

module pipe_end() {
    taper_size = JOINER_DIA - DUCT_INNER_DIA;
    working_twists = 2.5;
    twist_height = (working_twists+0.5) * COPPER_SPIRAL_SPACING;
    rotation = working_twists % 1 * 360;
    // translate([-(DUCT_INNER_DIA+COPPER_SPACING_DIA)/2,0,0])
    difference() {
        union() {
            translate([0,0,-COPPER_SPACING_DIA/2]) mirror([1,0,0]) {
                rotate([0, 0, rotation]) translate([0,0,COPPER_SPIRAL_SPACING*working_twists])
                    extrude_spiral(StartRadius=DUCT_INNER_DIA/2, Angle=360*0.5, ZPitch=COPPER_SPIRAL_SPACING, RPitch=-COPPER_SPACING_DIA, StepsPerRev=fn_spiral){circle(d=COPPER_SPACING_DIA);}
                extrude_spiral(StartRadius=DUCT_INNER_DIA/2, Angle=360*working_twists, ZPitch=COPPER_SPIRAL_SPACING, StepsPerRev=fn_spiral){circle(d=COPPER_SPACING_DIA);}
            }
            cylinder(d=DUCT_INNER_DIA, h=twist_height);
            cylinder(d1=JOINER_DIA, d2=DUCT_INNER_DIA, h=taper_size);
        }
        translate([0,0,-1]) cylinder(d=AIR_INNER_DIA, h=twist_height+2);
        translate([0,0,-COPPER_SPIRAL_SPACING]) cube([50, 50, COPPER_SPIRAL_SPACING*2], center=true);
    }
}

module ozito_end() {
    R_DIFF = (JOINER_DIA - OZITO_INSERT_DIA2)/2;
    difference() {
        union() {
            translate([0,0,-OZITO_INSERT_LEN-R_DIFF])
                cylinder(d2=OZITO_INSERT_DIA2, d1=OZITO_INSERT_DIA1, h=OZITO_INSERT_LEN);
            translate([0,0,-R_DIFF])
                cylinder(d1=OZITO_INSERT_DIA2, d2=JOINER_DIA, h=R_DIFF);
        }
        translate([0,0,-OZITO_INSERT_LEN-R_DIFF-0.01]) cylinder(d1=OZITO_INSERT_DIA1-WALL*2, d2=OZITO_INSERT_DIA2-WALL*2, h=OZITO_INSERT_LEN+R_DIFF+0.02);
    }
}

// Flip the lot for printing
rotate([0,180,0]) {
    pipe_end();
    ozito_end();
}