/*
  WHETER TO TAKE HIT
*/
var take_hit;
take_hit = true;

// ignore hit if during pushback
if hit_ignore_onPushback and vspeed_pushback_pool > 0 
	{ 
	take_hit = false;
	}
// ignore hit if collition with same bullet as last hit
if hit_ignore_lastbullet and collision_lastbullet_id == other.id 
	{
	take_hit = false;
	}
/*
  IMPACT OF HIT
*/
if take_hit 
	{					
	// Assign force of hit
	var hf_min, hf_max, hit_force;
	hf_min = hit_force_min;
	hf_max = hit_force_max;
	hit_force = random_range(hf_min,hf_max) 
	
	var Rp, Rg, hdir;
	Rp = vspeed_pushback_resistance;
	Rg = hspeed_glide_resistance;
	hdir = 0;
	
	// VERTICAL PUSHBACK
	if vspeed_pushback_allowed 
		{		
		// apply hit force to vertical pushback, divide by resistance
		vspeed_pushback_pool = hit_force / Rp; 
		}
	
	// HORIZONTAL GLIDE
	if hspeed_glide_allowed 
		{	
		var origin, margin, hdir;
		origin = floor(sprite_width / 2)	
		margin = hit_noDirection_zone;
		
		// Find horizontal direction of hit
		hdir = (self.x + origin) - other.x; 
		
		// apply margin for no horizontal direction of hit
		if abs(hdir) < margin 
			{ 
			hdir = 0;
			} 
			else 
			{
			hdir = sign(hdir);
			}			
		
		hspeed_glide_pool = hdir * (hit_force / Rg); // apply hit force to horizontal glide in direction of hit, divide by resistance
		}
		
	// ANIMATION SPEED
	if anim_glideSpin_allowed and hspeed_glide_pool != 0 
		{
		var dir, gS, boost;
		dir = sign(hspeed_glide_pool);
		gS = abs(hspeed_glide_pool);
		boost = anim_glideSpin_multiplier;

		gS = gS * boost; // apply spin multiplier

		anim_glideSpin_pool = gS; // apply new spin if higher than current
		anim_glideSpin_dir = dir; // apply new spin direction
		}
	
	// PARTICLE EFFECT
	if pEffect_pushbackflash 
		{
		var p_pbf;
		p_pbf = global.pt_pushback_flash;
		
		part_type_direction(p_pbf, 90 + ((hit_force*5) * -hdir), 90, 0, 0);
		part_particles_create(global.ps_midground, x + 8, y + 12, p_pbf, 1);
		}
	// CLEANUP
	collision_lastbullet_id = other.id; // Remember the ID of the bullet that hit 	
	}
/*
  DESTROY BULLET ON HIT
*/
if hit_destroy_other 
	{
	instance_destroy(other);
	}