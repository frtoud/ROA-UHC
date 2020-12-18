//hit_player.gml
if (my_hitboxID.orig_player != player) exit; //Only check your own hitboxes.


//=====================================================
// CD Article hitboxes only
if ("uhc_parent_cd" in my_hitboxID)
{
    if (my_hitboxID.uhc_parent_cd.hitstop < my_hitboxID.hitpause)
    { my_hitboxID.uhc_parent_cd.hitstop = my_hitboxID.hitpause; }
}
