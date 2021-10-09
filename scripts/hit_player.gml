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
    
    //Special Flipper: "Projectile Autolink" 
    // Attempts to pull towards center of future hitbox position
    if (my_hitboxID.hit_flipper == ANGLE_FLIPPER_CD_MULTIHIT)
    // No effect on armored enemies
    && (hit_player_obj.state == PS_HITSTUN || hit_player_obj.state == PS_HITSTUN_LAND)
    {
        var grav_bias = 3; //VSP offset to compensate gravity's effect en-route to next hit
        var diff_mult = 0.16; //Multiplier to reduce speed gained from position (enough speed to fix offset in 1/X frames)

        //Vector from PlayerCenter to HitboxCenter
        var diff_x = diff_mult * (hit_player_obj.x - cd_id.x);
        var diff_y = diff_mult * (hit_player_obj.y - hit_player_obj.char_height/2 - cd_id.y);

        //simulate "pull towards center" angle flipper; but considers speed
        //Angle depends on current article speed and offset of victim (vsp adjusted for gravity)
        var pull_angle = point_direction(diff_x, grav_bias + diff_y, cd_id.hsp, cd_id.vsp);
        var cd_speed = point_distance(diff_x, grav_bias + diff_y, cd_id.hsp, cd_id.vsp);
        
        //knockback speed is determined by orig_knock
        //direction is determined by the vector [old_hsp, old_vsp]
        //I blame Dan
        hit_player_obj.orig_knock += cd_speed * cd_id.cd_multihit_speed_bonus;
                                     
        hit_player_obj.old_hsp = lengthdir_x(hit_player_obj.orig_knock, pull_angle);
        hit_player_obj.old_vsp = lengthdir_y(hit_player_obj.orig_knock, pull_angle);
    }
}

//Special Flipper: "Autolink" 
// Adjusts to pull towards wherever curernt knockback is pointing at (relative to the hitbox)
if (my_hitboxID.hit_flipper == ANGLE_FLIPPER_AUTOLINK)
// No effect on armored enemies; only do this for hitstun states
&& (hit_player_obj.state == PS_HITSTUN || hit_player_obj.state == PS_HITSTUN_LAND)
{
    var grav_bias = 3; //VSP offset to compensate gravity's effect en-route to next hit
    var diff_mult = 0.16; //Multiplier to reduce speed gained from position (enough speed to fix offset in 1/X frames)

    //Vector from PlayerCenter to HitboxCenter
    var diff_x = diff_mult * (hit_player_obj.x - my_hitboxID.x);
    var diff_y = diff_mult * (hit_player_obj.y - hit_player_obj.char_height/2 - my_hitboxID.y);

    //simulate "pull towards center" angle flipper; but considers kb direction
    //Angle depends on knockback direction and offset of victim (vsp adjusted for gravity)
    var pull_angle = point_direction(diff_x, grav_bias + diff_y, hit_player_obj.old_hsp, hit_player_obj.old_vsp);
    var new_knockback = point_distance(diff_x, grav_bias + diff_y, hit_player_obj.old_hsp, hit_player_obj.old_vsp);

    //I still blame Dan
    hit_player_obj.orig_knock = new_knockback;

    hit_player_obj.old_hsp = lengthdir_x(hit_player_obj.orig_knock, pull_angle);
    hit_player_obj.old_vsp = lengthdir_y(hit_player_obj.orig_knock, pull_angle);
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
if (my_hitboxID.attack == AT_FSPECIAL) && (my_hitboxID.hbox_num == 1)
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