/// @description

// Testing Laser
w_testLaser_charge = 0;
w_testLaser_chargeReq = 100;

/*
  BOOSTERS
*/
cocktail_bonus = 0; // holds number of unuiqe booster trinket types collected within cocktailTimer limit 
enum bst_type 
{ 
   blue,
   red,
   yellow,
   green,
   purple,
   t = 5
} 
enum bst_constant 
{ 
   poolLimit = 500, // boost pool needed to reach max combo
   trinketValue = 10, // base boost given by each booster trinket
   cocktailTime = 60 // how long (steps) each trinket type is considered part of the cocktail bonus after being collected
}   
enum bst_stat 
{
   pool, // pool of collected boost, shrinks over time
   trinkets, // number of booster trinkets collected in total
   cocktail, // timer since last trinket collected. Adds booster type to cocktail bonus while !0
   bonus, // number of bonus trinkets gotten due to cocktail bonus, in total
   t = 4,
}   
  
// DS_Grid of booster types and their statistics [bst_type,bst_stat]
ds_boosters = ds_grid_create(bst_type.t,bst_stat.t); // [type,stats]
ds_grid_clear(ds_boosters, 0)

// Ship speed stats
shipspd_top = 3;
shipspd_maxtop = 8;
shipspd_acceleration = 1;
shipspd_friction = 1;
shipspd_current_x = 0;
shipspd_current_y = 0;

// bullet speed stats
bulletspeed = 5;
bulletspeed_max = 12;

// gun positions
gun0_x = 0;
gun0_y = -20;
gun1_x = -9;
gun1_y = -14;
gun2_x = 8;
gun2_y = -14;
gun3_x = -29;
gun3_y = 4;
gun4_x = 28;
gun4_y = 4;

// flags & Alarms
flag_mouseControl = false;
alarm_spriteAnim_delay = spriteAnim.delayTime; 

// Ship Sprite Animation
image_speed = 0; // Disable animation of sprite
image_index = 4; // Set starting subimage
enum spriteAnim 
{
	stripLen = 4,
	spdTreshold = 1,
	delayTime = 2
}

/*
  LOCAL PARTICLES
*/
// Particle pt_bstSparks
pt_bstSparks_c1 = part_type_create();
part_type_shape(pt_bstSparks_c1, pt_shape_disk);
part_type_size(pt_bstSparks_c1, 0.06, 0.06, 0, 0.03);
part_type_scale(pt_bstSparks_c1, 1, 1);
part_type_orientation(pt_bstSparks_c1, 0, 0, 0, 0, 0);
part_type_color3(pt_bstSparks_c1, 16744448, 16711680, 8388608);
part_type_alpha3(pt_bstSparks_c1, 0.3, 0.15, 0);
part_type_blend(pt_bstSparks_c1, 1);
part_type_life(pt_bstSparks_c1, 60, 90);
part_type_speed(pt_bstSparks_c1, 1.20, 1.40, 0, 0);
part_type_direction(pt_bstSparks_c1, 260, 280, 0, 1);
part_type_gravity(pt_bstSparks_c1, 0, 13);

pt_bstSparks_c2 = part_type_create();
part_type_shape(pt_bstSparks_c2, pt_shape_disk);
part_type_size(pt_bstSparks_c2, 0.06, 0.06, 0, 0.03);
part_type_scale(pt_bstSparks_c2, 1, 1);
part_type_orientation(pt_bstSparks_c2, 0, 0, 0, 0, 0);
part_type_color3(pt_bstSparks_c2, 65280, 32768, 16384);
part_type_color3(pt_bstSparks_c2, 8421631, 255, 128);
part_type_alpha3(pt_bstSparks_c2, 0.3, 0.15, 0);
part_type_blend(pt_bstSparks_c2, 1);
part_type_life(pt_bstSparks_c2, 60, 90);
part_type_speed(pt_bstSparks_c2, 1.20, 1.40, 0, 0);
part_type_direction(pt_bstSparks_c2, 260, 280, 0, 1);
part_type_gravity(pt_bstSparks_c2, 0, 13);

pt_bstSparks_c3 = part_type_create();
part_type_shape(pt_bstSparks_c3, pt_shape_disk);
part_type_size(pt_bstSparks_c3, 0.06, 0.06, 0, 0.03);
part_type_scale(pt_bstSparks_c3, 1, 1);
part_type_orientation(pt_bstSparks_c3, 0, 0, 0, 0, 0);
part_type_color3(pt_bstSparks_c3, 8454143, 65535, 16777215);
part_type_alpha3(pt_bstSparks_c3, 0.3, 0.15, 0);
part_type_blend(pt_bstSparks_c3, 1);
part_type_life(pt_bstSparks_c3, 60, 90);
part_type_speed(pt_bstSparks_c3, 1.20, 1.40, 0, 0);
part_type_direction(pt_bstSparks_c3, 260, 280, 0, 1);
part_type_gravity(pt_bstSparks_c3, 0, 13);

pt_bstSparks_c4 = part_type_create();
part_type_shape(pt_bstSparks_c4, pt_shape_disk);
part_type_size(pt_bstSparks_c4, 0.06, 0.06, 0, 0.03);
part_type_scale(pt_bstSparks_c4, 1, 1);
part_type_orientation(pt_bstSparks_c4, 0, 0, 0, 0, 0);
part_type_color3(pt_bstSparks_c4, 65280, 32768, 16384);
part_type_alpha3(pt_bstSparks_c4, 0.3, 0.15, 0);
part_type_blend(pt_bstSparks_c4, 1);
part_type_life(pt_bstSparks_c4, 60, 90);
part_type_speed(pt_bstSparks_c4, 1.20, 1.40, 0, 0);
part_type_direction(pt_bstSparks_c4, 260, 280, 0, 1);
part_type_gravity(pt_bstSparks_c4, 0, 13);

pt_bstSparks_c5 = part_type_create();
part_type_shape(pt_bstSparks_c5, pt_shape_disk);
part_type_size(pt_bstSparks_c5, 0.06, 0.06, 0, 0.03);
part_type_scale(pt_bstSparks_c5, 1, 1);
part_type_orientation(pt_bstSparks_c5, 0, 0, 0, 0, 0);
part_type_color3(pt_bstSparks_c5, 16711808, 16711935, 16711808);
part_type_alpha3(pt_bstSparks_c5, 0.30, 0.15, 0);
part_type_blend(pt_bstSparks_c5, 1);
part_type_life(pt_bstSparks_c5, 60, 90);
part_type_speed(pt_bstSparks_c5, 1.20, 1.40, 0, 0);
part_type_direction(pt_bstSparks_c5, 260, 280, 0, 1);
part_type_gravity(pt_bstSparks_c5, 0, 13);




