include <scad-meta/env.scad>

// Hose Tail
// A ribbed pipe that you can push a hose over.
// Shouldn't leak or come off under moderate pressure.
// Add a Jublee clip or wrap some wire round it to improve the seal.
//
// hose_id = inside diameter of hose
// length = the length of the hose tail, including the 
// wall = the minimum wall thickness of the hose tail
// stretch = the average proportion that the hose will be stretched by

function hose_tail_min_or(hose_id, stretch) = hose_id * (1 + stretch*0.75) / 2;
function hose_tail_ir(hose_id, stretch, wall) = hose_tail_min_or(hose_id, stretch) - wall;
function hose_tail_default_stretch() = 0.25;

module hose_tail(hose_id, length, wall = 3, stretch = hose_tail_default_stretch()) {
	// minimum outside radius
	min_or = hose_tail_min_or(hose_id, stretch);
	// maximum outside radius
	max_or = hose_id * (1 + stretch*1.25) / 2;
	barb_length = stretch * hose_id;
	// inside radius
	ir = hose_tail_ir(hose_id, stretch, wall);
	difference() {
		for( offset = [0 : barb_length : length - barb_length]) {
			translate([0, 0, offset]) cylinder(r1 = max_or, r2 = min_or, h = barb_length);
		}
		translate([0, 0, -eps]) cylinder(r = ir, h = length + eps2);
	}
}

//hose_tail(12, 25);
