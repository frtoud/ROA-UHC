//hitbox_update

//=====================================================
if (attack == AT_NSPECIAL)
{
    // NSPECIAL broken on landing
    if (!free) { destroyed = true; }
    else 
    {
        proj_angle -= 15;

        var hfx = spawn_hit_fx(x, y, orig_player_id.vfx_star_trail);
        hfx.draw_angle = proj_angle;

        if (star_was_parried)
        {
            can_hit_self = true;
            hitbox_timer = 0;

            if (!star_already_reflected)
            {
                hsp *= -1;
                vsp *= -1;
            }
            
            star_already_reflected = false;
            star_was_parried = false;
        }
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
            uhc_parent_cd.cd_has_hitbox = false;
            destroyed = true;
        }
    }
}