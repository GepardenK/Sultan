
/*
  BOUNCEABLES, CONCEPTS AND VARIABLES
  
  Constant speeds:
  'vspeed_constant' and 'hspeed_constant'. Will apply selected speed in 
  given direction each step regardless of other factors. 
  
  Hit Force: 
  when a Bouncable is hit by a bullet a Hit Force value will be randomly
  chosen from between 'hit_force_min' and 'hit_force_max'. HF infulences future movement. 
  
  Pushback: 
  applies chosen Hit Force to negative vertical speed for a pushback effect.
  The pushback value is added to a pool and applied to vspeed every step. 
	- 'vspeed_pushback_friction': how much the pushback pool is reduced each step
	- 'vspeed_pushback_resistance': how much Hit Force is divided by before being applied to the pushback pool
  
  Glide: 
  applies chosen Hit Force to horizontal speed for a glide effect. Direction of glide depends on direction of hit. 
  The glide value is added to a pool and applied to hspeed every step. 
	- 'hspeed_glide_friction': how much the glide pool is reduced each step	
    - 'hspeed_glide_resistance': how much Hit Force is divided by before being applied to the glide pool
	- 'hit_noDirection_zone': how many pixels from the middle of the sprite (in each x direction) is considered a direct hit with no direction bias

  Animation GlideSpin: 
  applies extra speed to a Bouncable's (spinning) animation when under glide effect. 
  Direction of spin depends on direction of glide.
  Takes the glide value and applies it to a spin pool, the spin pool value is then added to image_speed every step. 
    - 'anim_glideSpin_friction': how much the spin pool is reduced every step. 
    - 'anim_glideSpin_multiplier': how much the glide value is multiplied by before being applied to the spin pool
	- 'anim_glideSpin_min': lowest possible spin value to be applied to image_speed
  
  Hit Ignore: 
  various ways for a Bounceable to ignore further hits after being affected by a initial hit.
	- 'hit_ignore_onPushback': ignore further hits while under the effect of pushback
	- 'hit_ignore_afterHit_steps': ignore further hits x number of steps after initial hit
	- 'hit_ignore_lastbullet': ignore further hits from bullet causing the initial hit
*/

// Set image_index from start variables
if start_imageIndex_random == true 
	{
	image_index = irandom_range(0, image_number);
	} 
	
// INFORMATION VARIABLES  (used to store data, do not edit)
vspeed_pushback_pool = 0;
hspeed_glide_pool = 0;
anim_glideSpin_pool = 1;

anim_glideSpin_dir = 1; 

collision_lastbullet_id = noone;





