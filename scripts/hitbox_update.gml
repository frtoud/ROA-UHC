//hitbox_update

//=====================================================
// NSPECIAL broken on landing
if (attack == AT_NSPECIAL)
{
    proj_angle -= 15;
    if (!free) { destroyed = true; }
    else 
    {
        var hfx = spawn_hit_fx(x, y, orig_player_id.vfx_star_trail);
        hfx.draw_angle = proj_angle;
    }
}

//=====================================================
// CD Article hitboxes only
if ("uhc_parent_cd" in self)
{
    if !instance_exists(uhc_parent_cd)
    {
        destroyed = true; exit;
    }
    
    //set hitbox at the correct position for next frame's disc position
    x = uhc_parent_cd.x + uhc_parent_cd.hsp;
    y = uhc_parent_cd.y + uhc_parent_cd.vsp;
    
    in_hitpause = uhc_parent_cd.hitstop;
    
    if (attack == AT_DSTRONG_2 && uhc_parent_cd.state == AT_DSTRONG_2)
    {
        //force hitbox active as long as the article is falling
        hitbox_timer = 0;
        
        //stops being a spike after some time
        if (hbox_num == 1) && (uhc_parent_cd.state_timer > 
                               uhc_parent_cd.cd_dstrong_air_spiking_time)
        {
            // causes the CD to spawn the second hitbox
            uhc_parent_cd.has_dstrong_hitbox = false;
            destroyed = true;
        }
    }
}