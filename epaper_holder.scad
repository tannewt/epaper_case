/*
 * Two-piece desk case for the Good Display GDEP0565D90 and Seeed EE05.
 * The display and electronics load into the wedge base first. The
 * top/back then slides down behind the panel and grips the base on two keys.
 * Dimensions are in millimetres.
 */

/* [Display dimensions] */
display_width = 125.40;
display_height = 99.50;
display_thickness = 0.95; // Nominal with protective film

/* [Active area] */
active_width = 114.90; // Set width or height to 0 to disable active-area checks
active_height = 85.79;
active_left = 5.25;
active_bottom = 9.11;

/* [Ribbon outlet] */
ribbon_base_center_from_left = 62.50; // Centre of the wide end from the left edge of the glass
ribbon_base_width = 23.00;
ribbon_tail_offset = -0.78; // Tail centre relative to the wide end; 55.47 mm left edge + half-width = 61.72 mm
ribbon_length = 24.01;
ribbon_width = 12.50;
ribbon_side_clearance = 1.00;
ribbon_loading_width = 32.47; // Minimum opening width for loading the ribbon from above
ribbon_rear_clearance = 4.00;

/* [Fit and structure] */
fit_clearance_xy = 0.50; // Clearance at each locating edge
fit_clearance_z = 0.40; // Total extra thickness in the display slot
minimum_thickness = 1.60;
wall = 2.40;
border = 5.00;
lip_overlap = 3.00; // Upper lip overlap, unchanged
bottom_lip_overlap = 8.25; // From the seated glass edge; nominal active area starts at 9.11 mm
side_bezel_overlap = 4.00; // Overlap onto the glass at the left and right edges
lip_thickness = 2.00;
backrest_thickness = 2.00;
split_height = 20.00; // Seam height from the bottom of the inclined cradle

/* [EE05 development board mount -- V1.11] */
add_board_studs = true;
board_width = 25.00; // PCB rotated to put its FPC connector towards the display
board_height = 52.16;
board_pcb_thickness = 1.60;
board_hole_diameter = 2.50;
board_pin_diameter = 2.20;
board_support_diameter = 6.00;
board_pin_extra = 1.20;
board_plate_margin = 3.00;
board_side_clearance = 3.00; // Gap from each PCB edge to the side wall, for buttons
board_horizontal_offset = 0.00;
board_vertical_offset = -6.00; // Negative moves the EE05 away from the display along the base
board_foot_angle = 115.00; // 180 minus the display's angle above the desk

/* [Friction fit] */
joint_interference = 0.08; // Per flank at the very end of travel; negative is looser

/* [Output] */
part = "base"; // [base, top, assembly]
print_orientation = true; // Lay each part on its flat printing face
show_display = false; // Assembly reference only
show_dev_board = false; // Assembly reference only
top_separation = 0; // Slide the top up by this much in the assembly view

/* [Hidden] */
epsilon = 0.01;
slot_thickness = display_thickness + fit_clearance_z;
backrest_front = ribbon_rear_clearance + backrest_thickness;
lip_bottom = backrest_front + slot_thickness;
overall_depth = lip_bottom + lip_thickness;
overall_width = 2 * wall + display_width + 2 * fit_clearance_xy;
overall_height = display_height + 2 * border + 2 * fit_clearance_xy;
display_x = wall + fit_clearance_xy;
display_seat_y = border;
display_y = display_seat_y + fit_clearance_xy;
bottom_rail_height = display_seat_y + bottom_lip_overlap;
top_rail_y = display_y + display_height - lip_overlap;
ribbon_base_x = display_x + ribbon_base_center_from_left;
ribbon_tip_x = ribbon_base_x + ribbon_tail_offset;
ribbon_tip_y = display_y - ribbon_length;

// EE05 coordinates after rotating the PCB 90 degrees. From the V1.11 KiCad PCB.
board_connector_x = 12.50;
board_connector_y = 45.6654; // FPC footprint origin, along the PCB
board_connector_entry = 5.00; // Insertion-side face from the footprint origin
board_connector_height = 2.00;
board_stud_points = [[2.00, 23.07], [23.00, 23.00], [2.00, 50.16], [23.00, 50.16]];
board_origin_x = ribbon_tip_x - board_connector_x + board_horizontal_offset;
board_origin_y = ribbon_tip_y - board_connector_y + board_vertical_offset;
board_clear_left = board_origin_x - board_side_clearance;
board_clear_right = board_origin_x + board_width + board_side_clearance;
board_rail_xs = [board_clear_left - wall, board_clear_right];
board_pin_tip = -board_pcb_thickness - board_pin_extra;

// Display coordinates: +Y along the screen, +Z towards the front.
// Desk coordinates: +Y up, +Z forwards. The flat rear/underside of the
// base is desk Y=0; this face goes on the printer's bed.
tilt = board_foot_angle - 90;
board_desk_shift = backrest_front * sin(board_foot_angle) / (1 - cos(board_foot_angle));
board_rear = board_origin_y + board_desk_shift - board_plate_margin;
board_front = board_origin_y + board_desk_shift + board_height;
base_drop = overall_depth * sin(tilt) * cos(tilt);
base_front_z = overall_depth * cos(tilt) * cos(tilt);

// The ribbon opening stays put if the EE05 shifts. The wedge cheeks
// separately clear both the opening and the board's side buttons.
port_left = min(ribbon_base_x - ribbon_base_width / 2,
    ribbon_tip_x - ribbon_width / 2) - ribbon_side_clearance;
port_right = max(ribbon_base_x + ribbon_base_width / 2 + ribbon_side_clearance,
    ribbon_tip_x + ribbon_width / 2 + ribbon_side_clearance, port_left + ribbon_loading_width);
tray_left = min(port_left, board_clear_left);
tray_right = max(port_right, board_clear_right);
wedge_width = max(6, 2 * wall);
wedge_xs = [tray_left - wedge_width, tray_right];

// Keys are in the plane of the top plate, clear of the display slot. They
// are fixed to the case edges so moving the ribbon does not change the top.
// The back side of each key is wider for front-to-back retention.
joint_half_width = backrest_thickness + 2.90;
joint_depth = 9.00;
joint_end_clearance = 0.30;
joint_back_clearance = 0.20;
joint_running_clearance = 0.18;
joint_lock_length = 2.00;
joint_lead_in = 1.50;
joint_socket_half_width = joint_half_width + joint_back_clearance + wall;
joint_centers = [joint_socket_half_width, overall_width - joint_socket_half_width];
joint_edge_zone = 2 * joint_socket_half_width;

module validate_parameters() {
    assert(display_width > 0 && display_height > 0 && display_thickness > 0,
        "Display dimensions must be positive");
    assert(fit_clearance_xy >= 0 && fit_clearance_z >= 0, "Clearances cannot be negative");
    assert(wall >= minimum_thickness && backrest_thickness >= minimum_thickness &&
        lip_thickness >= minimum_thickness && minimum_thickness > 0 && border >= minimum_thickness,
        "Structural walls and borders must meet minimum_thickness");
    assert(lip_overlap > 0 && lip_overlap < display_height / 2 &&
        bottom_lip_overlap > 0 && bottom_lip_overlap < display_height / 2, "Invalid lip overlap");
    assert(side_bezel_overlap >= 0 && side_bezel_overlap < display_width / 2,
        "Invalid side bezel overlap");
    assert(split_height > max(bottom_rail_height, joint_depth + wall) && split_height < top_rail_y,
        "Place the split above the bottom lip and below the top lip");
    assert(ribbon_base_width > 0 && ribbon_width > 0 && ribbon_length > 0 &&
        ribbon_rear_clearance > 0 && ribbon_side_clearance > 0 && ribbon_loading_width >= 0,
        "Invalid ribbon dimensions");
    assert(tray_left >= joint_edge_zone + wall &&
        tray_right <= overall_width - joint_edge_zone - wall,
        "The loading notch and board tray must clear the fixed edge sockets");
    assert(board_foot_angle >= 90 && board_foot_angle <= 140,
        "Board foot angle must be between 90 and 140 degrees");
    assert(board_side_clearance >= 0, "Board side clearance cannot be negative");
    assert(board_plate_margin >= wall && board_front < 0,
        "The board must fit behind the screen; adjust the board margin or vertical offset");
    assert(joint_interference >= -joint_running_clearance && joint_interference <= 0.30,
        "Joint interference range is -0.18 to 0.30 mm per side");
    if (add_board_studs) {
        assert(board_width > 0 && board_height > 0 && board_pcb_thickness > 0 &&
            board_pin_diameter >= minimum_thickness && board_pin_diameter < board_hole_diameter &&
            board_support_diameter > board_hole_diameter && board_pin_extra >= 0,
            "Check the PCB and pin dimensions");
        for (point = board_stud_points)
            assert(point[0] - board_support_diameter / 2 >= -board_plate_margin &&
                point[0] + board_support_diameter / 2 <= board_width + board_plate_margin &&
                point[1] - board_support_diameter / 2 >= -board_plate_margin &&
                point[1] + board_support_diameter / 2 <= board_height + board_plate_margin,
                "A board shoulder misses the mounting rails");
    }
    if (active_width > 0 && active_height > 0) {
        assert(active_left >= 0 && active_bottom >= 0 &&
            active_left + active_width <= display_width && active_bottom + active_height <= display_height,
            "Active area must lie within the display outline");
        assert(bottom_lip_overlap <= active_bottom &&
            lip_overlap <= display_height - active_bottom - active_height,
            "Lips would cover the active area");
        assert(side_bezel_overlap == 0 ||
            side_bezel_overlap + fit_clearance_xy <= min(active_left, display_width - active_left - active_width),
            "Side bezel would cover the active area at the limits of the glass fit");
    }
}

module desk_to_display() {
    rotate([tilt, 0, 0]) children();
}

module board_to_desk() {
    translate([0, backrest_front, board_desk_shift]) rotate([90, 0, 0]) children();
}

module board_stud(point) {
    stud_x = board_origin_x + point[0];
    rail_x = board_rail_xs[point[0] < board_width / 2 ? 0 : 1];
    tip_length = min(0.50, -board_pin_tip);
    translate([stud_x, board_origin_y + point[1], 0]) {
        translate([0, 0, ribbon_rear_clearance - epsilon])
            hull() {
                cylinder(d=board_support_diameter, h=backrest_thickness + epsilon, $fn=48);
                translate([rail_x - stud_x, -wall / 2, 0])
                    cube([wall, wall, backrest_thickness + epsilon]);
            }
        // Leave room around populated components and the ribbon at PCB height.
        cylinder(d1=min(board_support_diameter, board_hole_diameter + 1.00),
            d2=board_support_diameter, h=ribbon_rear_clearance, $fn=48);
        translate([0, 0, board_pin_tip])
            cylinder(d1=0.70 * board_pin_diameter, d2=board_pin_diameter, h=tip_length, $fn=36);
        translate([0, 0, board_pin_tip + tip_length])
            cylinder(d=board_pin_diameter, h=-board_pin_tip - tip_length + 0.20, $fn=36);
    }
}

// Locate the glass in X and cover its inactive sides without narrowing
// the slot. Matching strips on both prints carry the bezel across the seam.
module side_guides(y0, height) {
    for (x = [0, overall_width - wall])
        translate([x, y0, ribbon_rear_clearance])
            cube([wall, height, overall_depth - ribbon_rear_clearance]);
    if (side_bezel_overlap > 0) {
        bezel_width = display_x + side_bezel_overlap;
        for (x = [0, overall_width - bezel_width])
            translate([x, y0, lip_bottom])
                cube([bezel_width, height, lip_thickness]);
    }
}

module panel_plate(y0, height) {
    translate([0, y0, ribbon_rear_clearance])
        cube([overall_width, height, backrest_thickness]);
    side_guides(y0, height);
}

module panel_slot() {
    translate([wall, display_seat_y, backrest_front])
        cube([overall_width - 2 * wall, display_height + 2 * fit_clearance_xy, slot_thickness]);
}

module cradle_back(x, width, seam_rear_z) {
    // Drop the rear edge of the seam straight to the bed in desk/print
    // orientation. The front still follows the inclined glass plane.
    desk_rear = seam_rear_z * cos(tilt) - split_height * sin(tilt);
    translate([x + width, 0, 0])
        rotate([0, -90, 0])
            linear_extrude(width)
                polygon([[desk_rear * cos(tilt), -desk_rear * sin(tilt)],
                    [backrest_front, -backrest_front * tan(tilt)],
                    [backrest_front, split_height], [seam_rear_z, split_height]]);
}

module loading_notch() {
    // Stop the opening behind the front lip. At the bed, leave a full
    // lip-thickness footprint rather than a thin edge under the fascia.
    foot_depth = min(lip_thickness, overall_depth * cos(tilt) - epsilon);
    foot_back_z = base_front_z - foot_depth * cos(tilt);
    foot_back_y = -base_drop + foot_depth * sin(tilt);
    foot_cut = base_drop > 0 ?
        [[foot_back_z, -base_drop - epsilon], [foot_back_z, foot_back_y]] :
        [[lip_bottom, -epsilon]];
    translate([port_right, 0, 0])
        rotate([0, -90, 0])
            linear_extrude(port_right - port_left)
                polygon(concat([[-epsilon, -base_drop - epsilon]], foot_cut,
                    [[lip_bottom, 0], [lip_bottom, split_height + epsilon],
                    [-epsilon, split_height + epsilon]]));
}

module display_cradle() {
    difference() {
        union() {
            side_guides(0, split_height);
            translate([0, 0, backrest_front - epsilon])
                cube([overall_width, bottom_rail_height, overall_depth - backrest_front + epsilon]);
            if (base_drop > 0)
                translate([overall_width, 0, 0])
                    rotate([0, -90, 0])
                        linear_extrude(overall_width)
                            polygon([[0, 0], [overall_depth, 0], [base_front_z, -base_drop]]);
        }
        panel_slot();
        loading_notch();
    }
    // Keep the same notch through the vertical rear walls.
    cradle_back(0, port_left, ribbon_rear_clearance);
    cradle_back(port_right, overall_width - port_right, ribbon_rear_clearance);
}

module wedge_and_carrier() {
    anchor_y = split_height - wall;
    anchor_z = backrest_front - backrest_thickness / 2;
    // Each cheek is a tapered web with two points on the same bed-facing
    // plane. Tall end reaches the lower display backrest, outside the notch.
    for (x = wedge_xs)
        translate([x + wedge_width, 0, 0])
            rotate([0, -90, 0])
                linear_extrude(wedge_width)
                    polygon([[board_rear, 0], [backrest_front * cos(tilt), 0],
                        [anchor_z * cos(tilt) - anchor_y * sin(tilt),
                            anchor_y * cos(tilt) + anchor_z * sin(tilt)],
                        [board_rear, wall]]);

    tie_left = min(wedge_xs[0], board_rail_xs[0]);
    tie_right = max(wedge_xs[1] + wedge_width, board_rail_xs[1] + wall);
    translate([tie_left, 0, board_rear])
        cube([tie_right - tie_left, wall, wall]);

    if (add_board_studs) {
        rail_length = board_front - board_rear + wall / 2;
        for (i = [0:1]) {
            x = board_rail_xs[i];
            flange_left = min(x, wedge_xs[i]);
            flange_right = max(x + wall, wedge_xs[i] + wedge_width);
            translate([x, 0, board_rear]) cube([wall, backrest_front, rail_length]);
            // Tie each rail into its cheek along the flat underside without
            // covering the open space under the middle of the PCB.
            translate([flange_left, 0, board_rear])
                cube([flange_right - flange_left, wall, rail_length]);
        }
        board_to_desk()
            for (point = board_stud_points) board_stud(point);
    }
}

// +Z of the profile extrusion points down the screen (-Y), in the same
// direction as insertion. +Y of the profile is the display's front (+Z).
module joint_transform(x) {
    translate([x, split_height, ribbon_rear_clearance]) rotate([90, 0, 0]) children();
}

module joint_profile(z_min, z_max, offset=0) {
    half_width = joint_half_width + offset;
    polygon([[-half_width + z_min, z_min], [half_width - z_min, z_min],
        [half_width - z_max, z_max], [-half_width + z_max, z_max]]);
}

module cut_socket(x) {
    joint_transform(x)
        translate([0, 0, -epsilon])
            linear_extrude(joint_depth + epsilon)
                joint_profile(-joint_back_clearance, backrest_thickness + epsilon);
}

module top_key(x) {
    length = joint_depth - joint_end_clearance;
    stations = [[-epsilon, joint_interference], [0, joint_interference],
        [joint_lock_length, -joint_running_clearance],
        [length - joint_lead_in, -joint_running_clearance],
        [length, -joint_running_clearance - 0.45]];
    joint_transform(x)
        for (i = [0 : len(stations) - 2])
            hull()
                for (j = [i, i + 1])
                    translate([0, 0, stations[j][0] - (j == len(stations) - 1 ? epsilon : 0)])
                        linear_extrude(epsilon)
                            joint_profile(0, backrest_thickness, stations[j][1]);
}

module base() {
    difference() {
        union() {
            display_cradle();
            desk_to_display() wedge_and_carrier();
            // The socket backs also go all the way to the bed, rather than
            // starting partway up the cradle as cantilevered blocks.
            for (x = joint_centers)
                cradle_back(x - joint_socket_half_width, joint_edge_zone, ribbon_rear_clearance - wall);
        }
        for (x = joint_centers) cut_socket(x);
    }
}

module top_back() {
    union() {
        difference() {
            union() {
                panel_plate(split_height, overall_height - split_height);
                translate([0, top_rail_y, backrest_front - epsilon])
                    cube([overall_width, overall_height - top_rail_y, overall_depth - backrest_front + epsilon]);
            }
            // Open below so the cap can slide down behind the installed glass.
            translate([wall, split_height - epsilon, backrest_front])
                cube([overall_width - 2 * wall,
                    display_y + display_height + fit_clearance_xy - split_height + epsilon, slot_thickness]);
        }
        for (x = joint_centers) top_key(x);
    }
}

module reference_display() {
    translate([display_x, display_seat_y, backrest_front + fit_clearance_z / 2]) {
        color([0.82, 0.84, 0.80]) cube([display_width, display_height, display_thickness]);
        if (active_width > 0 && active_height > 0)
            color([0.20, 0.23, 0.25])
                translate([active_left, active_bottom, display_thickness]) cube([active_width, active_height, 0.02]);
    }
}

module ribbon_segment(a, b, a_width, b_width) {
    hull() {
        translate([a[0] - a_width / 2, a[1], a[2]]) cube([a_width, epsilon, 0.12]);
        translate([b[0] - b_width / 2, b[1], b[2]]) cube([b_width, epsilon, 0.12]);
    }
}

module reference_ribbon() {
    connector_z = board_origin_y + board_connector_y + board_connector_entry + board_desk_shift;
    mouth_height = backrest_front - board_connector_height / 2;
    connector = [board_origin_x + board_connector_x,
        mouth_height * cos(tilt) - connector_z * sin(tilt),
        mouth_height * sin(tilt) + connector_z * cos(tilt)];
    z = backrest_front + slot_thickness / 2 - 0.06;
    start = [ribbon_base_x, display_seat_y, z];
    bend = [ribbon_base_x, display_seat_y - min(3, ribbon_length * 0.15), z];
    wide_end = bend + (connector - bend) * 0.40;
    neck = bend + (connector - bend) * 0.56;
    color([0.75, 0.45, 0.12]) {
        ribbon_segment(start, bend, ribbon_base_width, ribbon_base_width);
        ribbon_segment(bend, wide_end, ribbon_base_width, ribbon_base_width);
        ribbon_segment(wide_end, neck, ribbon_base_width, ribbon_width);
        ribbon_segment(neck, connector, ribbon_width, ribbon_width);
    }
}

module reference_dev_board() {
    translate([board_origin_x, board_origin_y, 0]) {
        color([0.12, 0.38, 0.25])
            difference() {
                translate([0, 0, -board_pcb_thickness]) cube([board_width, board_height, board_pcb_thickness]);
                for (point = board_stud_points)
                    translate([point[0], point[1], -board_pcb_thickness - epsilon])
                        cylinder(d=board_hole_diameter, h=board_pcb_thickness + 2 * epsilon, $fn=36);
            }
        color([0.12, 0.12, 0.13])
            translate([board_connector_x - 15.50 / 2,
                board_connector_y + board_connector_entry - 4.90, 0])
                cube([15.50, 4.90, board_connector_height]);
        color([0.35, 0.37, 0.39])
            translate([3.50, 3.00, 0]) cube([18.00, 18.50, 1.00]);
    }
}

validate_parameters();
assert(part == "base" || part == "top" || part == "assembly", "Select base, top or assembly");
if (part == "base") {
    rotate([print_orientation ? 90 - tilt : 0, 0, 0]) base();
} else if (part == "top") {
    translate([0, 0, print_orientation ? -ribbon_rear_clearance : 0]) top_back();
} else {
    color([0.90, 0.55, 0.25]) base();
    color([0.45, 0.62, 0.74]) translate([0, top_separation, 0]) top_back();
    if (show_display) reference_display();
    if (show_display && show_dev_board) reference_ribbon();
    if (show_dev_board) desk_to_display() board_to_desk() reference_dev_board();
}
