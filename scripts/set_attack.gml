//set_attack.gml

//===============================================
//Strongs to Tilts conversions
if !(uhc_has_cd_blade 
   || (uhc_rune_flags.remote_throws && instance_exists(uhc_current_cd)) )
{
    if (attack == AT_FSTRONG) { attack = AT_FTILT; }
    else if (attack == AT_USTRONG) { attack = AT_UTILT; }
    else if (attack == AT_DSTRONG) { attack = AT_DTILT; }
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
    if (free && !uhc_rune_flags.aircharge_strongs)
    {
        set_attack_value(AT_FSTRONG, AG_STRONG_CHARGE_WINDOW, 0);
        set_attack_value(AT_USTRONG, AG_STRONG_CHARGE_WINDOW, 0);
        reset_attack_value(AT_DSTRONG_2, AG_STRONG_CHARGE_WINDOW);
    }
    else
    {
        reset_attack_value(AT_FSTRONG, AG_STRONG_CHARGE_WINDOW);
        reset_attack_value(AT_USTRONG, AG_STRONG_CHARGE_WINDOW);
        set_attack_value(AT_DSTRONG_2, AG_STRONG_CHARGE_WINDOW, 1);
    }
}

//detect if using cstick tilt or special inputs
uhc_do_cstick_tilt_check = (is_attack_pressed(DIR_ANY) && !attack_pressed);
uhc_do_cstick_special_check = (is_special_pressed(DIR_ANY) && !special_pressed);

// Forces an update to the attack grid
// Moved to attack_update in case of catching the blade midmove 
uhc_update_blade_status = true;

//RUNE: combo counter
uhc_combo_prehit_flag = false;