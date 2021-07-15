//death.gml

uhc_pickup_cooldown = 0;

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
    uhc_current_cd.player_id = self; //could be holding anyone's CD...
    uhc_current_cd.cd_anim_color = get_player_color(player);
    uhc_current_cd.cd_spin_meter = floor(uhc_cd_spin_max / 2);
}