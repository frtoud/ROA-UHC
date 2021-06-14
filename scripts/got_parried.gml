//got_parried.gml

if ("uhc_parent_cd" in my_hitboxID)
{
    var cd = my_hitboxID.uhc_parent_cd;
    cd.was_parried = true;
    cd.last_parried_by_player = hit_player_obj.player;
}