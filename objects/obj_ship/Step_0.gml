
/*////////////////////////////////////////////
  INPUT CHECK
*/////////////////////////////////////////////

var action_up, action_down, action_left, action_right;
action_up = keyboard_check(input_key_up);
action_down = keyboard_check(input_key_down);
action_left = keyboard_check(input_key_left);
action_right = keyboard_check(input_key_right);

var k, m, action_fire;
k = keyboard_check(input_key_fire);
m = mouse_check_button(input_mouse_fire);
action_fire = k + m;

var k, m, toggle_mouse;
k = keyboard_check_pressed(input_key_mouseToggle);
m = mouse_check_button_pressed(inut_mouse_mouseToggle);
toggle_mouse = k + m;

// Toggle mouse controls
if toggle_mouse 
	{
	if flag_mouseControl 
		{
		flag_mouseControl = false;}
		else 
			{
			flag_mouseControl = true;
			}	
	}

/*////////////////////////////////////////////
  SHIP MOVEMENT
*/////////////////////////////////////////////

var ss, sx, sy;
ss = shipspd_top; // current top-speed of ship
sx = shipspd_current_x; // current speed x
sy = shipspd_current_y; // current speed y

var a, f;
a = shipspd_acceleration; // Acceleration to apply
f = shipspd_friction; // Friction to apply

// Keyboard input, apply acceleration (a)
if (action_up) 
	{
	sy -= a;
	}
if (action_left) 
	{
	sx -= a;
	}
if (action_right)
	{
	sx += a;
	}
if (action_down) 
	{
	sy += a;
	}
// Mouse input
if flag_mouseControl == true 
	{	
	x = lerp(x, mouse_x,0.03)
	y = lerp(y, mouse_y,0.03)
	}
// FRICTION: apply (f) value opposite of accelertion direction, if no movement input was detected this step
if sx == shipspd_current_x 
	{
	sx -= (sign(sx) * f);
	if abs(sx) <= f 
		{
		sx = 0;
		}
	}
if sy == shipspd_current_y 
	{
	sy -= (sign(sy) * f);
	if abs(sy) <= f 
		{
		sy = 0;
		}
	}
// keep current speed within current ship speed
sx = clamp(sx,-ss,ss);
sy = clamp(sy,-ss,ss);

// update current speed and ship x/y position
shipspd_current_x = sx;
shipspd_current_y = sy;
x += shipspd_current_x;
y += shipspd_current_y;

/*////////////////////////////////////////////
  BOOSTERS
*/////////////////////////////////////////////
var cb = 0;
var ds_bst = ds_boosters; // iterate through booster info
for (var i = 0; i < bst_type.t; ++i) 
	{			
	if cocktail_bonus == 0 
		{ // recede booster pools at [i,0]
		ds_bst[# i,bst_stat.pool] = max(0, ds_bst[# i,bst_stat.pool] - 1); 
		} 
		else 
			{
			// iterate through ds_b[i,2], recede cocktail_timer and count type towards Cocktail Bonus if timer > 0
			if ds_bst[# i,bst_stat.cocktail] != 0 
				{
				cb++;
				ds_bst[# i,bst_stat.cocktail]--;
				} 
			}	
	}
cocktail_bonus = cb;

/*////////////////////////////////////////////
  DEFINE GUNS
*/////////////////////////////////////////////

//Active gun positions based on gun number
switch (Legacy_gunNumber) 
	{
    case 1:
        aguns = [true,false,false,false,false];
        break;
    case 2:
        aguns = [false,false,false,true,true];
        break;
	case 3:
        aguns = [true,false,false,true,true];
        break;
	case 4:
        aguns = [false,true,true,true,true];
        break;
	case 5:
        aguns = [true,true,true,true,true];
        break;
	default:
		aguns = [false,false,false,false,false,];
		break;
	}

/*////////////////////////////////////////////
  FIRE GUNS
*/////////////////////////////////////////////

var G, oBullet, b_spd;
G = aguns; // array keeping track of which guns are active
oBullet = par_bullet; // object to spawn when guns are fired
b_spd = bulletspeed; // speed to apply to fired projectiles

// Charge Test Laser
w_testLaser_charge += stat_gunEnergy_base + stat_gunEnergy_upgrade;
w_testLaser_charge = min(w_testLaser_charge, w_testLaser_chargeReq);


// Fire gun
if action_fire 
	{
	if w_testLaser_charge == w_testLaser_chargeReq 
		{ 	
		if G[0] = true 
			{
			with instance_create_layer(x + gun0_x, y + gun0_y + choose(0,1), layer, oBullet) 
				{b_speed = b_spd;}
			}
	
		if G[1] = true 
			{
			with instance_create_layer(x + gun1_x, y + gun1_y, layer, oBullet) 
				{b_speed = b_spd;}
			}	
		if G[2] = true 
			{
			with instance_create_layer(x + gun2_x,y + gun2_y, layer, oBullet) 
				{b_speed = b_spd;}
			}
		if G[3] = true 
			{
			with instance_create_layer(x + gun3_x,y + gun3_y, layer, oBullet) 
				{b_speed = b_spd;}
			}	
		if G[4] = true 
			{
			with instance_create_layer(x + gun4_x,y + gun4_y, layer, oBullet) 
				{b_speed = b_spd;}
			}	
		w_testLaser_charge = 0; //reset charge
		}
	}
/*////////////////////////////////////////////
  ANIMATE SHIP by shuffeling sprite subimages
  
  - Makes ship animate as tilting left and right when player moves left and right, and back and forth when player moves up and down
  - Sprite must be divided into "strips" of the ship tilting from a middle left and to the right, one "strip" of horizontal tilt for each possible vertical tilt
  - Each "strip" is a series of subimages stored in the sprite, they must all be equally long for the same sprite, their lengh must be defined in the create event as 'spriteAnim_StripLenght' (sub_len)
  - Total number of "strips" in the sprite must be at least 3 and an odd number, for vertical shuffeling to work. 
  - Sprite subimage format: [strip: forward, middle to left] [strip: middle, middle to left] [strip: back, middle to left]
  - The code will then divide the sprite by the lengh of it's strips, interperting the strips horizontally and stacking them vertically
  - As the player changes ship speed/direction the code will move through the subimages accordingly
  - The code will flip the horizontal axis, but not the vertical, sprites must be animated middle to right and up to down (not middle to left).
*/////////////////////////////////////////////

var sLen, sNum, sCur, sCur_s;
sLen = spriteAnim.stripLen; // Lenght of each strip of subimages in sprite that makes up the ship on same level of tilt (horizontal) FORMAT: 1,2,3,4...
sNum = floor(image_number / sLen); // number of subimage "strips" in sprite (vertical) FORMAT: 1,2,3,4...
sCur = floor(image_index / sLen)+1; // Current strip image_index is located in (vertical) FORMAT: 1,2,3,4...
sCur_s = image_index - ((sCur-1) * sLen) + 1; // Current subimage of strip image_index is located in (horizontal) FORMAT: 1,2,3,4...

var mt, aa; 
mt = spriteAnim.spdTreshold; // FOR FLUID ACCELERATION MOVEMENT: minimum speed for animation to occur
aa = alarm_spriteAnim_delay; // Alarm for when next subimage transition should happen

var xspd, yspd, xdir, ydir; 
xspd = x - xprevious; // Current horizontal speed (actual) 
yspd = y - yprevious; // Current vertical speed (actual)
xdir = sign(xspd); // direction of x movement (-1 left, 0 none, 1 right)
ydir = sign(yspd); // direction of x movement (-1 up, 0 none, 1 down)

// Consider movement direction to be 0 if speed does not reach treshold
if abs(xspd) < mt 
	{xdir = 0;}
if abs(yspd) < mt 
	{ydir = 0;}

if aa <= 0 {
	// ANIMATE THROUGH SUBIMAGE STRIPS
	if xdir != 0 { 		
		/*
		HORIZONTAL ANIMATION - Movement in X
		When ship is moving horizontally animate through subimages on the current horizontal strip		
		Flip xscale if moving past the first subimage of strip (left to right / vice versa)
		Strip is animated forwards or backwards depending on movement direction relative to the current flip (xscale) of sprite
		*/			
		if sCur_s == 1 // when moving past 1st subimage of strip: set image_xscale (flip) according to horizontal movement direction
			{image_xscale = xdir} 
		
		if image_xscale == xdir and sCur_s < sLen 
			{image_index ++;} // animate current strip forward if movement direction is the same as xscale
			
		if image_xscale == (xdir * -1) and sCur_s > 1
			{image_index--;} // animate current strip backwards if movement direction is opposite of xscale		
	} 
	
	// HORIZONTAL ANIMATION - At rest
	if xdir == 0 and sCur_s > 1
		{image_index--;} 

	// VERTICAL ANIMATION - Movement in Y
	if ydir < 0 { 		
		if sCur > 1 
			{image_index -= sLen}
	}
	if ydir > 0 { 
		if sCur < sNum 
			{image_index += sLen}
	}
	// VERTICAL ANIMATION - At rest
	// Return towards middle strip of the vertical strip-stack if there is no y movement
	var m; 
	m = floor(sNum / 2) + 1;
	if ydir == 0 {
		if sCur > m
			{image_index -= sLen}
		if sCur < m 
			{image_index += sLen}
	}
alarm_spriteAnim_delay = spriteAnim.delayTime; // Reset animation clock
}
alarm_spriteAnim_delay--;







