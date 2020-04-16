
/*
  DRAW BASIC STAT UI (TESTING)
*/

// Draw fps and ship position + spd
draw_set_halign(fa_left);
draw_text(4,8, "fps: " + string(floor(fps_real)));
draw_text(4,24, "x: " + string(x));
draw_text(4,40, "y: " + string(y));
draw_text(4,56,"mx: " + string(x - xprevious));
draw_text(4,72,"my: " + string(y - yprevious));

// bottom left origin of UI 
var ox, oy,
ox = 16;
oy = window_get_height() - 32;

// Draw testLaser energy bar
var width, height, amount;
width = 16;
height = width * 6;
amount = (w_testLaser_charge / w_testLaser_chargeReq) * 100;

draw_healthbar(ox, oy, ox + width, oy - height, amount, c_dkgray, c_white, c_white, 2, true, true);

// draw gun energy stats
var enBase, enUp;
enBase = stat_gunEnergy_base;
enUp = stat_gunEnergy_upgrade;

draw_set_halign(fa_center);
draw_text(ox + 8, oy, string(enBase) + "+" + string(enUp));

// draw engine energy stats
var enAcc;
enAcc = stat_engine_acc;

enBase = stat_engine_spd;
enUp = stat_engine_upgrade;

draw_set_halign(fa_left);
draw_rectangle(ox, oy - 104, ox + 76, oy - 142, true);
draw_text(ox + 4, oy - 140, "spd:" + string(enBase) + "+" + string(enUp))
draw_text(ox + 4, oy - 124, "acc:" + string(enAcc))

// draw booster circles
for (var ii = 0; ii < 5; ++ii) 
{	
	// find colours for each booster type
	var colLight, colDark, colBorder;
	colBorder = c_gray;	
	switch (ii) 
	{
	    case bst_type.blue:
	        colLight = c_blue;
			colDark = c_navy;
	        break;
		case bst_type.red:
	        colLight = c_red;
			colDark = c_maroon;
	        break;
		case bst_type.yellow:
	        colLight = c_yellow;
			colDark = c_orange;
	        break;
		case bst_type.green:
	        colLight = c_lime;
			colDark = c_green;
			break;
		case bst_type.purple:
	        colLight = c_fuchsia;
			colDark = c_purple;
	        break;
	}
		
	// find booster circle position, size and booster charge 
	var r, ds_bst, boostLvl, boostLimit, rr , cx, cy; 
	r = 24;
	ds_bst = ds_boosters;
	boostLvl = ds_bst[# ii,bst_stat.pool];
	boostLimit = bst_constant.poolLimit;
	rr = ((boostLvl / ((boostLimit / r) * 100)) * 100);

	cx = 64 + (50 * ii);
	cy = oy - 24;
	
	// adjust border colour if max combo
	if boostLvl == boostLimit 
	{
		colBorder = colLight;	
	}
	
	// draw booster circles
	draw_circle_color(cx, cy, rr, colLight, colDark, false);
	draw_circle_color(cx, cy, r, colBorder, colBorder, true);
}

// draw booster collection stats:
var len, bt, bc;
bt = 0;
bc = 0;
len = ds_grid_width(ds_bst)
for (var ii = 0; ii < len; ++ii) 
{
	bt += ds_bst[# ii,1]
	bc += ds_bst[# ii,3]
}

var tx, ty;
tx = 42;
ty = cy - 76;

draw_set_halign(fa_left);
draw_text(tx, ty, "Trinkets:" + string(bt))
draw_text(tx, ty + 16, "Cocktail:" + string(bc))
draw_text(tx, ty + 32, "Multiplier:" + string(cocktail_bonus))






