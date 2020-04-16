/// @description 

// create particle systems
global.ps_foreground = part_system_create_layer("Particle_foreground",true);
global.ps_midground = part_system_create_layer("Particle_midground",true);
ps_background = part_system_create_layer("Particle_background",true);

/*
  DEFINE PARTICLES
*/
// Particle lasertrail
global.pt_lasertrail = part_type_create();
part_type_sprite(global.pt_lasertrail, sp_bullet, true, true, true); 
part_type_size(global.pt_lasertrail, 1, 1, 0, 0); 
part_type_color3(global.pt_lasertrail, c_white, c_red, c_blue); 
part_type_alpha2(global.pt_lasertrail, 1, 0.5); 
part_type_speed(global.pt_lasertrail, 0, 0, 0, 0); 
part_type_direction(global.pt_lasertrail, 90, 90, 0, 0); 
part_type_blend(global.pt_lasertrail, true); 
part_type_life(global.pt_lasertrail, 5, 5); 

//Particle pushback_flash
global.pt_pushback_flash = part_type_create();
part_type_shape(global.pt_pushback_flash, pt_shape_flare);
part_type_size(global.pt_pushback_flash, 0.60, 0.60, 0, 0.10);
part_type_scale(global.pt_pushback_flash, 1, 1);
part_type_orientation(global.pt_pushback_flash, 0, 0, 0, 0, 1);
part_type_color3(global.pt_pushback_flash, 4605695, 4605695, 4605695);
part_type_alpha3(global.pt_pushback_flash, 0.7, 0.5, 0.1);
part_type_blend(global.pt_pushback_flash, true);
part_type_life(global.pt_pushback_flash, 30, 30);
part_type_speed(global.pt_pushback_flash, 3, 3, 0, 0);
part_type_direction(global.pt_pushback_flash, 90, 90, 0, 0);
part_type_gravity(global.pt_pushback_flash, 0, 100);


// Particle firespark
pt_firespark = part_type_create();
part_type_shape(pt_firespark, pt_shape_disk); 
part_type_size(pt_firespark, 0.05, 0.1, 0, 0.04); 
part_type_color3(pt_firespark, c_white, c_yellow, c_red); 
part_type_alpha3(pt_firespark, 0.5, 1, 0); 
part_type_speed(pt_firespark, 1, 8, -0.90, 0); 
part_type_direction(pt_firespark, 0, 359, 0, 0); 
part_type_blend(pt_firespark, true); 
part_type_life(pt_firespark, 20, 40); 

// Particle star dim
pt_star_dim = part_type_create();
part_type_sprite(pt_star_dim, sp_pstar, true, true, true); 
part_type_size(pt_star_dim, 0.1, 0.2, 0, 0); 
part_type_color1(pt_star_dim, c_white); 
part_type_alpha3(pt_star_dim, 0.5, 0.5, 0.5); 
part_type_speed(pt_star_dim, 0.5, 0.6, 0, 0); 
part_type_direction(pt_star_dim, 270, 270, 0, 0); 
part_type_blend(pt_star_dim, true); 
part_type_life(pt_star_dim, 1540, 1540);
part_type_orientation(pt_star_dim, 0, 359, 0, 0, false );

// Particle star white
pt_star_white = part_type_create();
part_type_sprite(pt_star_white, sp_pstar, true, true, true); 
part_type_size(pt_star_white, 0.3, 0.5, 0, 0); 
part_type_color1(pt_star_white, c_white); 
part_type_alpha3(pt_star_white, 1, 1, 1); 
part_type_speed(pt_star_white, 0.6, 1, 0, 0); 
part_type_direction(pt_star_white, 270, 270, 0, 0); 
part_type_blend(pt_star_white, true); 
part_type_life(pt_star_white, 1290, 1290);
part_type_orientation(pt_star_white, 0, 359, 0, 0, false );

// Particle star blue
pt_star_blue = part_type_create();
part_type_sprite(pt_star_blue, sp_pstar, true, true, true); 
part_type_size(pt_star_blue, 0.4, 0.5, 0, 0.1); 
part_type_color_mix(pt_star_blue, c_blue, c_aqua); 
part_type_alpha3(pt_star_blue, 1, 1, 1); 
part_type_speed(pt_star_blue, 0.7, 0.9, 0, 0); 
part_type_direction(pt_star_blue, 270, 270, 0, 0); 
part_type_blend(pt_star_blue, true); 
part_type_life(pt_star_blue, 1100, 1100);
part_type_orientation(pt_star_blue, 0, 359, 0, 0, false );

// Particle star red
pt_star_red = part_type_create();
part_type_sprite(pt_star_red, sp_pstar, true, true, true); 
part_type_size(pt_star_red, 0.5, 1.5, 0, 0.2); 
part_type_color_mix(pt_star_red, c_white, c_red); 
part_type_alpha3(pt_star_red, 1, 1, 1); 
part_type_speed(pt_star_red, 0.6, 0.6, 0, 0); 
part_type_direction(pt_star_red, 270, 270, 0, 0); 
part_type_blend(pt_star_red, true); 
part_type_life(pt_star_red, 1290, 1290);
part_type_orientation(pt_star_red, 0, 359, -2, 0, false );

/*
  STARFIELD
*/
var ci, cy, cw;
ci = view_camera[0];
cw = camera_get_view_width(ci);
cy = camera_get_view_y(ci);

pe_star_dim = part_emitter_create(ps_background); 
pe_star_white = part_emitter_create(ps_background);
pe_star_blue = part_emitter_create(ps_background);
pe_star_red = part_emitter_create(ps_background);

part_emitter_region(ps_background, pe_star_dim, 0, cw, cy-10, cy-10, ps_shape_line, ps_distr_linear); 
part_emitter_region(ps_background, pe_star_white, 0, cw, cy-10, cy-10, ps_shape_line, ps_distr_linear);
part_emitter_region(ps_background, pe_star_blue, 0, cw, cy-10, cy-10, ps_shape_line, ps_distr_linear);
part_emitter_region(ps_background, pe_star_red, 0, cw, cy-10, cy-10, ps_shape_line, ps_distr_linear); 

part_emitter_stream(ps_background, pe_star_dim, pt_star_dim, -2);
part_emitter_stream(ps_background, pe_star_white, pt_star_white, -32);
part_emitter_stream(ps_background, pe_star_blue, pt_star_blue, -128);
part_emitter_stream(ps_background, pe_star_red, pt_star_red, -256);

// simulate system to allow stars to develop
repeat (room_speed * 30)
    {
    part_system_update(ps_background);
    }


