/// @description

spawn_clock -= 1;

if spawn_clock < 1 {

	spawn_clock = spawn_frequency;
	
	// Powerups (individual)
	if irandom(spawn_chance) == 1 {
	
		var otype;
		otype = choose(obj_bst_wEnergy, obj_bst_Engines, obj_bst_Shield, obj_bst_wPower, obj_bst_Shield);
		
		var sp, sp_height, sp_width;
		sp = object_get_sprite(otype);
		sp_height = sprite_get_height(sp)
		sp_width = sprite_get_width(sp)
		
		var spawn_xx = irandom_range(spawn_x1, spawn_x2 - sp_width);
		var spawn_yy = irandom_range(spawn_y1, spawn_y2) - sp_height;
		
		instance_create_layer(spawn_xx,spawn_yy,layer,otype);
	}
	
	// powerups clusters
	if irandom(spawn_chance * 2) == 1 {
	
		var otype1, otype2;
		otype1 = choose(obj_bst_wEnergy, obj_bst_Engines, obj_bst_Shield, obj_bst_wPower);
		otype2 = choose(obj_bst_wEnergy, obj_bst_Engines, obj_bst_Shield, obj_bst_wPower);
		
		var spawn_xx = irandom_range(spawn_x1, spawn_x2 - 16);
		var spawn_yy = irandom_range(spawn_y1, spawn_y2) - 16;
		
		var r1, r2;
		r1 = irandom_range(2,6);
		r2 = irandom_range(2,6);
	
		var ts;
		ts = otype1;
		
		for (var i1 = r1; i1 > 0; --i1) {					
		    for (var i2 = r2; i2 > 0; --i2) {			
				if ts == otype1 
					{ts = otype2} else if ts == otype2
											{ts = otype1}			
	instance_create_layer(spawn_xx - (16 * i1),spawn_yy - (16 * i2),layer,ts);
			}
		}	
	}
	
	// Bounceables
	if irandom(spawn_chance * 3) == 1 {
	
		var otype;
		otype = choose(Bounceable_64);
		
		var sp, sp_height, sp_width;
		sp = object_get_sprite(otype);
		sp_height = sprite_get_height(sp)
		sp_width = sprite_get_width(sp)
		
		var spawn_xx = irandom_range(spawn_x1, spawn_x2- sp_width);
		var spawn_yy = irandom_range(spawn_y1, spawn_y2) - sp_height;
		
		instance_create_layer(spawn_xx,spawn_yy,layer,otype);
	}
	
	// Statups
	if irandom(spawn_chance * 3) == 1 {
	
		var otype;
		otype = choose(obj_statUp_gunNum, obj_statUp_gunEnergy, obj_statUp_sSpeed);
		
		var sp, sp_height, sp_width;
		sp = object_get_sprite(otype);
		sp_height = sprite_get_height(sp)
		sp_width = sprite_get_width(sp)
		
		var spawn_xx = irandom_range(spawn_x1, spawn_x2- sp_width);
		var spawn_yy = irandom_range(spawn_y1, spawn_y2) - sp_height;
		
		instance_create_layer(spawn_xx,spawn_yy,layer,otype);
	}
}

