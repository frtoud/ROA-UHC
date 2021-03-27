//hitbox_update


//=====================================================
// CD Article hitboxes only
if ("uhc_parent_cd" in self)
{
    x = uhc_parent_cd.x + uhc_parent_cd.hsp;
    y = uhc_parent_cd.y + uhc_parent_cd.vsp;
    
    in_hitpause = uhc_parent_cd.hitstop;
    
    if (attack == AT_DSTRONG_2 && uhc_parent_cd.state == AT_DSTRONG_2)
    {
        //force hitbox active as long as the article is falling
        hitbox_timer = 0;
    }
}