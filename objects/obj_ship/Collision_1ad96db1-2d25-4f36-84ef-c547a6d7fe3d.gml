/*
  APPLY BOOSTER OF TYPE
*/

// find booster trinket type
var type;
type = other.booster_type

// get booster info
var ds_bst, val, maxval, cbonus;
ds_bst = ds_boosters;
val = bst_constant.trinketValue;
maxval = bst_constant.poolLimit;
cbonus = cocktail_bonus;

// add booster type to cocktail bonus by giving it cocktail_timer steps, engage cocktail bonus if not already in effect
ds_bst[# type,bst_stat.cocktail] = bst_constant.cocktailTime;
if cbonus == 0 
	{
	cocktail_bonus++; 
	cbonus = cocktail_bonus; 
	} 

// bst trinket pickup value multiplied by cocktail bonus
val = val * cbonus; 

// add to total collected counters of type
ds_bst[# type,bst_stat.trinkets]++; 
ds_bst[# type,bst_stat.bonus] += cbonus - 1; 

// increase booster pool of type by bst trinked value
if ds_bst[# type,0] < maxval 
	{ 
	ds_bst[# type,0] = min(ds_bst[# type,0] + val, maxval); 
	}
/*
  DESTROY PICKUP
*/
instance_destroy(other);

/*
  PARTICLE PICKUP EFFECT
*/
var particle;
switch (type) 
	{
    case bst_type.blue:
        particle = pt_bstSparks_c1;
        break;
	case bst_type.red:
        particle = pt_bstSparks_c2;
        break;
	case bst_type.yellow:
        particle = pt_bstSparks_c3;
        break;
	case bst_type.green:
        particle = pt_bstSparks_c4;
        break;
	case bst_type.purple:
        particle = pt_bstSparks_c5;
        break;
    default:
        show_debug_message("Error: Cocktail Bonus invalid when looking for particle effect")
        break;
	}
var amount;
amount = 10 * cocktail_bonus;

repeat(amount)
	{
	var xp, yp;
	xp = other.x + irandom(15);
	yp = other.y + irandom(15);
	part_particles_create(global.ps_midground, xp, yp, particle,1)
	}