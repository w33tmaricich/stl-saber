// Building my own lightsaber to become a true jedi.


HILT_HEIGHT=228;
HILT_WIDTH=46;
EM_HEIGHT = 69;
EM_WIDTH = 57;
PL_HEIGHT = 40;

module tie_fighter() {
    translate([0,2,-18]) import("tie-fighter.stl", convexity=10);
}

module tie_wings() {
    cubesize = 20;
    difference() {
        tie_fighter();
        cube([cubesize,cubesize,cubesize*2], center=true);
    }
}

module emitter_cap() {}

module emitter(height, widthdi) {
    $fn = 100;
    width = widthdi/2;
    
    module emitter_body() {
        rotate_extrude()
        translate([width/2,height/2,0])
        difference() {
            color([0,0,0]) square([width,height], true);
            color([1,0,0])translate([width/1.2,0,0]) square([width,height/1.5], true);
            color([1,1,0])translate([width/1.5,0,0]) square([width,height/8], true);
            color([1,1,0])translate([width/1.5,height/8*2,0]) square([width,height/8], true);
            color([1,1,0])translate([width/1.5,-height/8*2,0]) square([width,height/8], true);
            color([0,1,1])translate([-3,height/2-2.4,0]) square([width,height/8], true);
            color([0,1,1])translate([-3,-height/2-2.4,0]) square([width,height/8], true);
        }
    }
    
    module emitter_holes(diameter, number, translation) {
        //diameter = .8; // Green Wire
        //diameter = 2.4; // Red Wire
        distance = 360/number;
        
        module hole() {
            translate([translation,0,0])
            cylinder(h=height, d=diameter, center=false);
        }
        
        module interior_design() {
            for (i=[0:number]) {
                rotate([0,0,i*distance])
                translate([0,0,0])
                hole();
            }
        }
        
        module holes() {
            for (i=[0:number]) {
                rotate([0,0,i*distance+diameter])
                hole();
            }
        }
        
        interior_design();
        
    }
    
    difference() {
        emitter_body();
        emitter_holes(2.4, 27 ,width/1.1);
    }
    
    
}
module emitter_old(height, widthdi) {
    $fn = 100;
    width = widthdi/2;
    
    module emitter_body() {
        rotate_extrude()
        translate([width/2,height/2,0])
        difference() {
            square([width,height], true);
            color([1,0,0])translate([width/1.2,0,0]) square([width,height/1.5], true);
        }
    }
    
    module emitter_holes(diameter, number, translation) {
        //diameter = .8; // Green Wire
        //diameter = 2.4; // Red Wire
        distance = 360/number;
        
        module hole() {
            translate([translation,0,0])
            cylinder(h=height, d=diameter, center=false);
        }
        
        module interior_design() {
            for (i=[0:number]) {
                rotate([0,0,i*distance])
                translate([0,0,0])
                hole();
            }
        }
        
        module holes() {
            for (i=[0:number]) {
                rotate([0,0,i*distance+diameter])
                hole();
            }
        }
        
        interior_design();
        
    }
    
    difference() {
        
        union() {
            emitter_body();
            //emitter_holes(width/10, 20,width);
            emitter_holes(width/10, 27,width/1.2);
        }
        emitter_holes(width/20, 108,width);
    }
    
    
}
module hilt(height, width) { 
    cylinder(h=height, d=width, center=true);
}
module plug(height, width) {
    hiltwidth = EM_WIDTH + width;
    intersection() {
        translate([0,0,-height/2]) cylinder(h=height, d=hiltwidth, center=true);
        sphere(d=hiltwidth, center=true);
    }
}

module ywing(height, widthdi) {
    $fn = 100;
    width = widthdi/2;
    gap = .5;
    
    module emitter_body() {
        rotate_extrude()
        translate([width/2,height/2,0])
        difference() {
            square([width,height], true);
            color([1,0,0])translate([width/2,0,0]) square([width,height/1.15], true);
        }
    }
    
    module emitter_holes(diameter, number, translation) {
        distance = 360/number;
        
        module hole() {
            translate([translation,0,0])
            cylinder(h=height, d=diameter, center=false);
        }
        
        module interior_design() {
            for (i=[0:number]) {
                rotate([0,0,i*distance])
                translate([0,0,0])
                hole();
            }
        }
        
        module holes() {
            for (i=[0:number]) {
                rotate([0,0,i*distance+diameter])
                hole();
            }
        }
        
        interior_design();
        
    }
    
    difference() {
        
        union() {
            emitter_body();
            //emitter_holes(width/10, 20,width);
            emitter_holes(width/4, 4,width/1.2);
        }
        hilt(HILT_HEIGHT+gap,HILT_WIDTH+gap);
    }
    
    
}

module model_saber() {
    $fn=10;
    cylinder(h=HILT_HEIGHT, d=HILT_WIDTH, center=true);
}

module saber() {
    $fn=100;
    translate([0,0,HILT_HEIGHT/2]) emitter(EM_HEIGHT, EM_WIDTH);
    hilt(HILT_HEIGHT, HILT_WIDTH);
    translate([0,0,-HILT_HEIGHT/2])ywing(HILT_HEIGHT/2, EM_WIDTH);
    translate([0,0,-(HILT_HEIGHT/2)]) plug(PL_HEIGHT,0);
}

translate([100,0,0]) model_saber();
saber();
//ywing(HILT_HEIGHT/2, EM_WIDTH);
//emitter(EM_HEIGHT,EM_WIDTH);
//plug(PL_HEIGHT,0);