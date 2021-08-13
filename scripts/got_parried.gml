//got_parried.gml

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
