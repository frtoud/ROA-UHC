//update.gml

//=====================================================
// if holding a CD; restore if its missing.
if (uhc_has_cd_blade && !instance_exists(uhc_current_cd))
{
    print("hey dude not cool i was hodling tht >:[")
    uhc_current_cd = instance_create(x, y, "obj_article1"); 
}

//=====================================================
//All states that don't count for charges
uhc_no_charging = (state == PS_RESPAWN) || (state == PS_SPAWN) || (state == PS_DEAD)
               || (state == PS_ATTACK_GROUND && attack == AT_TAUNT);

//=====================================================
//FSPECIAL recharge
if (uhc_fspecial_charge_current < uhc_fspecial_charge_max)
    && !uhc_no_charging
{
    uhc_fspecial_charge_current++;
}

//=====================================================
// Blade respawn cooldown
uhc_cd_can_respawn = uhc_cd_respawn_timer >= uhc_cd_respawn_timer_max;
if (!uhc_cd_can_respawn && !uhc_no_charging) && !instance_exists(uhc_current_cd)
{
    uhc_cd_respawn_timer++;
    if (uhc_cd_respawn_timer >= uhc_cd_respawn_timer_max)
    {
        sound_play(sfx_cd_respawn);
    }
}

//=====================================================
//Blade pickup cooldown
if (uhc_pickup_cooldown > 0)
{ uhc_pickup_cooldown--; }

//=====================================================
// Recalling logic
if (uhc_dspecial_is_recalling) 
{
    //prevent move spam during recall
    move_cooldown[AT_DSPECIAL] = 2;
    
    //Todo: other cases where recalling CD needs to be stopped midmove
    //parried?
    
    if (state_cat == SC_HITSTUN) || (uhc_has_cd_blade)
    || !instance_exists(uhc_recalling_cd)
    || (state == PS_DEAD || state == PS_RESPAWN)
    {
        if (instance_exists(uhc_recalling_cd) 
        && uhc_recalling_cd.state == AT_DSPECIAL)
        {
            uhc_recalling_cd.buffered_state = 1;  //Idle 
        }
        uhc_recalling_cd = noone; 
        uhc_dspecial_is_recalling = false;
    }
}

//=====================================================
// If this was true (from previous frame) and you were sent to hitstun, lose charge
if (uhc_nspecial_is_charging) && (state_cat == SC_HITSTUN)
{
    uhc_nspecial_charges = 0;
}
uhc_nspecial_is_charging = (state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND)
                            && ((attack == AT_NSPECIAL) && window < 3);