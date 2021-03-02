//hit_player.gml
if (my_hitboxID.orig_player != player) exit; //Only check your own hitboxes.


//=====================================================
// CD Article hitboxes only
if ("uhc_parent_cd" in my_hitboxID)
{
    my_hitboxID.uhc_parent_cd.has_hit = true;
    if (my_hitboxID.uhc_parent_cd.hitstop < my_hitboxID.hitpause)
    { my_hitboxID.uhc_parent_cd.hitstop = my_hitboxID.hitpause; }
}

//=====================================================
// FSPECIAL bonus screenshot effect >:]
if (my_hitboxID.attack == AT_FSPECIAL && my_hitboxID.hbox_num == 1)
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