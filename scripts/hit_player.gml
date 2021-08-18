//hit_player.gml
if (my_hitboxID.orig_player != player) exit; //Only check your own hitboxes.


//=====================================================
// CD hitboxes that might cost charge
if ("uhc_has_paid_spin_cost" not in my_hitboxID 
  || !my_hitboxID.uhc_has_paid_spin_cost)
{
    var spin_cost = get_hitbox_value(my_hitboxID.attack, my_hitboxID.hbox_num, HG_SPIN_COST);
    if (spin_cost > 0)
    {
        var cd_id = ("uhc_parent_cd" in my_hitboxID) ? my_hitboxID.uhc_parent_cd : uhc_current_cd;
        cd_id.cd_spin_meter = 
            clamp(cd_id.cd_spin_meter - spin_cost, 0, uhc_cd_spin_max);
    }
    uhc_has_paid_spin_cost = true;
}

//=====================================================
// CD Article hitboxes only
if ("uhc_parent_cd" in my_hitboxID)
{
    var cd_id = my_hitboxID.uhc_parent_cd;
    cd_id.has_hit = true;
    if (cd_id.hitstop < my_hitboxID.hitpause)
    { cd_id.hitstop = my_hitboxID.hitpause; }
    
    if (my_hitboxID.hit_flipper == ANGLE_FLIPPER_CD_MULTIHIT)
    { 
        //can't get too much bonus from speed
        var diff_mult = 0.05;
        var diff_x = -diff_mult *(cd_id.x - hit_player_obj.x);
        var diff_y = -diff_mult *(cd_id.y - (hit_player_obj.y - hit_player_obj.char_height/2));
        
        //simulate "pull towards center" angle flipper; but considers speed
        //Angle depends on current article speed (vsp adjusted for gravity)
        var pull_angle = point_direction(diff_x, diff_y, cd_id.hsp, cd_id.vsp);
        var cd_speed = point_distance(diff_x, diff_y, cd_id.hsp, cd_id.vsp);
        
        hit_player_obj.orig_knock += min(8, cd_speed * cd_id.cd_multihit_speed_bonus);
        hit_player_obj.old_hsp = lengthdir_x(hit_player_obj.orig_knock, pull_angle);
        hit_player_obj.old_vsp = lengthdir_y(hit_player_obj.orig_knock, pull_angle) - 2;
    }
}

//=====================================================
// BAIR grablike nudge effect
if (my_hitboxID.attack == AT_BAIR) && (my_hitboxID.hbox_num == 1 || my_hitboxID.hbox_num == 3)
{
    hit_player_obj.uhc_bair_last_pseudograbbed_by = self;
    hit_player_obj.uhc_bair_last_pseudograb_time = get_gameplay_time();
}

//=====================================================
// USPECIAL buffering trap effect
if (my_hitboxID.attack == AT_USPECIAL && my_hitboxID.hbox_num == 2)
{
    hit_player_obj.uhc_being_buffered_by = self;
}

//=====================================================
// FSPECIAL bonus screenshot effect >:]
if (my_hitboxID.attack == AT_FSPECIAL)
{
    if (my_hitboxID.hbox_num == 1)
    {
        //all values in milliseconds
        //todo: allow multiple victims?
        if (uhc_unsafe_screenshot.next_time < current_time)
        {
            uhc_unsafe_screenshot.sfx_time   = current_time +   500;
            uhc_unsafe_screenshot.start_time = current_time +   750;
            uhc_unsafe_screenshot.rise_time  = current_time +  1000;
            uhc_unsafe_screenshot.fall_time  = current_time +  1000 + (uhc_fast_screenshot ? 1000 : 6000);
            uhc_unsafe_screenshot.end_time   = current_time +  1250 + (uhc_fast_screenshot ? 1000 : 6000);
            with (oPlayer) if ("uhc_unsafe_screenshot" in self)
            { uhc_unsafe_screenshot.next_time  = current_time + 10000; }
            
            var scale = 1 + hit_player_obj.small_sprites;
            
            var height_offset = clamp(hit_player_obj.y - y + 8, -24, 24);
            uhc_unsafe_screenshot.target = hit_player_obj;
            uhc_unsafe_screenshot.spr_dir = hit_player_obj.spr_dir;
            if ("uhc_custom_screenshot_sprite" in hit_player_obj
            && hit_player_obj.uhc_custom_screenshot_sprite != noone)
            {
                uhc_unsafe_screenshot.sprite = hit_player_obj.uhc_custom_screenshot_sprite;
                uhc_unsafe_screenshot.image  = 0;
                uhc_unsafe_screenshot.spr_top = 
                    sprite_get_yoffset(uhc_unsafe_screenshot.sprite) - 47/scale - height_offset;
                uhc_unsafe_screenshot.spr_left = 
                    abs(sprite_get_xoffset(uhc_unsafe_screenshot.sprite)) - 43/scale;
            }
            else
            {
                uhc_unsafe_screenshot.sprite = hit_player_obj.sprite_index;
                uhc_unsafe_screenshot.image  = hit_player_obj.image_index;
                uhc_unsafe_screenshot.spr_left = abs(hit_player_obj.sprite_xoffset) - 43/scale;
                uhc_unsafe_screenshot.spr_top = hit_player_obj.sprite_yoffset - (47+height_offset)/scale;
            }
        }
    }
    else
    {
        //Hypercam gets to skip hitpause
        hitstop = 0;
        hitpause = false;
    }
}