/*
  APPLY MOVEMENT
*/

// VERTICAL PUSHBACK
var pp;
pp = vspeed_pushback_pool;
if (pp > 0) 
	{// apply friction to pushback pool		
	var pf;
	pf = vspeed_pushback_friction;		
	pp = max(0, pp - pf);
	vspeed_pushback_pool = pp;
	} 
	
// HORIZONTAL GLIDE
var gp;
gp = hspeed_glide_pool;
if (gp != 0) 
	{ // apply friction to horizontal glide	
	var gf;
	gf = hspeed_glide_friction * sign(gp);	
	gp -= gf; 
	if abs(gp) < abs(gf) {gp = 0}
	hspeed_glide_pool = gp;
	}
	
// APPLY MOVEMENT
self.x += hspeed_constant + gp;
self.y += vspeed_constant - pp;

/*
  ANIMATION GLIDE SPIN
*/
if (anim_glideSpin_pool) != 1 
	{
	var gSp, gSf, gSd;
	gSp = anim_glideSpin_pool
	gSf = anim_glideSpin_friction;
	gSd = anim_glideSpin_dir;
	
	anim_glideSpin_pool = max(1, gSp - gSf); //apply friction to spin
	image_speed = (anim_glideSpin_pool * gSd); // apply spin speed to image animation
	}

