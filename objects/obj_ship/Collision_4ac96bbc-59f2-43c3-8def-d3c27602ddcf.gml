
// Find type and apply type effect
switch (other.statUp_type) 
{
    case "gunNum":
        if Legacy_gunNumber < 5
		{
			Legacy_gunNumber++;
		}
        break;
	case "gunEnergy":
        stat_gunEnergy_upgrade++;
        break;
	case "sSpeed":
        stat_engine_upgrade++;
		break;
    default:
		show_message("Error: statUp type not found")
        break;
}

// DESTROY PICKUP
instance_destroy(other);
