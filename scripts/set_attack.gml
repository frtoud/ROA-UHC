//set_attack.gml

//===============================================
//Strongs to Tilts conversions
if (!uhc_has_cd_blade)
{
    if (attack == AT_FSTRONG) { attack = AT_FTILT; }
    else if (attack == AT_USTRONG) { attack = AT_UTILT; }
    else if (attack == AT_DSTRONG) { attack = AT_DTILT; }
    
    //Rewind-Recall variant
    else if (attack == AT_DSPECIAL && uhc_current_cd.state != 0) //AR_STATE_DEAD
    { 
        uhc_current_cd.pre_dspecial_immunity = 3;
        attack = AT_DSPECIAL_2; 
    }
}
//Aerials to Strongs conversions
else if (up_strong_pressed || down_strong_pressed
    || left_strong_pressed || right_strong_pressed)
{
    if (attack == AT_BAIR) { attack = AT_FSTRONG; spr_dir *= -1; }
    else if (attack == AT_FAIR || attack == AT_NAIR) { attack = AT_FSTRONG; }
    else if (attack == AT_UAIR) { attack = AT_USTRONG; }
    else if (attack == AT_DAIR) { attack = AT_DSTRONG_2; }
    
    //Prevent strong charge when in the air
    if (free)
    {
        set_attack_value(AT_FSTRONG, AG_STRONG_CHARGE_WINDOW, 0);
        set_attack_value(AT_USTRONG, AG_STRONG_CHARGE_WINDOW, 0);
    }
    else
    {
        reset_attack_value(AT_FSTRONG, AG_STRONG_CHARGE_WINDOW);
        reset_attack_value(AT_USTRONG, AG_STRONG_CHARGE_WINDOW);
    }
}

// Forces an update to the attack grid
// Moved to attack_update in case of catching the blade midmove 
uhc_update_blade_status = true;