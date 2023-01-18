//death.gml

uhc_pickup_cooldown = 0;
uhc_throw_cooldown_override = 0;

//move flags
uhc_nspecial_charges = 0;
uhc_nspecial_is_charging = false;
uhc_fspecial_charge_current = 0;

if (instance_exists(uhc_uspecial_hitbox)) 
{ uhc_uspecial_hitbox.destroyed = true; }
with (oPlayer) if (self != other && uhc_being_buffered_by == other)
{
    uhc_being_buffered_by = noone;
}

if (uhc_has_cd_blade)
{ 
    //could be holding anyone's CD... restore as your own
    uhc_current_cd.player_id = self;
    uhc_current_cd.cd_anim_color = uhc_anim_current_color;
    uhc_current_cd.cd_spin_meter = uhc_cd_spin_max;
}

if (get_match_setting(SET_SEASON) == 4) uhc_has_hat = true; //christmas