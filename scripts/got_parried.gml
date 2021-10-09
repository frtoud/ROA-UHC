//got_parried.gml


//=====================================================
// CD hitboxes that might cost charge
if ("uhc_has_paid_spin_cost" not in my_hitboxID 
  || !my_hitboxID.uhc_has_paid_spin_cost)
{
    var spin_cost = get_hitbox_value(my_hitboxID.attack, my_hitboxID.hbox_num, HG_SPIN_COST);
    if (spin_cost > 0)
    {
        var cd_id = ("uhc_parent_cd" in my_hitboxID) ? my_hitboxID.uhc_parent_cd : uhc_current_cd;
        cd_id.cd_spin_meter = clamp(cd_id.cd_spin_meter - spin_cost, 0, uhc_cd_spin_max);
    }
    uhc_has_paid_spin_cost = true;
}

if ("uhc_parent_cd" in my_hitboxID)
{
    var cd = my_hitboxID.uhc_parent_cd;
    cd.was_parried = true;
    cd.last_parried_by_player = hit_player_obj.player;
}
else if (my_hitboxID.orig_player_id == self)
     && (my_hitboxID.attack == AT_NSPECIAL)
{
    with (pHitBox) if (orig_player_id == other && attack == AT_NSPECIAL)
    {
        star_was_parried = true;
        player = other.hit_player_obj.player;
    }

    //this specific star has already bounced back
    my_hitboxID.star_already_reflected = true;
}
