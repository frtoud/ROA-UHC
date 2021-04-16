//hitbox_update

//=====================================================
// NSPECIAL broken on landing
if (!free && attack == AT_NSPECIAL)
{
    destroyed = true;
}

//=====================================================
// CD Article hitboxes only
if ("uhc_parent_cd" in self)
{
    //set hitbox at the correct position for next frame's disc position
    x = uhc_parent_cd.x + uhc_parent_cd.hsp;
    y = uhc_parent_cd.y + uhc_parent_cd.vsp;
    
    in_hitpause = uhc_parent_cd.hitstop;
    
    if (attack == AT_DSTRONG_2 && uhc_parent_cd.state == AT_DSTRONG_2)
    {
        //force hitbox active as long as the article is falling
        hitbox_timer = 0;
    }
}