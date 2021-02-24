//animation.gml

//===============================================================
//Blade spin animation
if (uhc_has_cd_blade)
{
    var spin_speed = 0.5 * (uhc_current_cd.cd_spin_meter / uhc_cd_spin_max);
    uhc_anim_blade_spin = (3 + uhc_anim_blade_spin - spin_speed) % 3;
}

//Blinker animation
anim_blink_timer = (anim_blink_timer + 2) % anim_blink_timer_max;
//===============================================================

init_shader();

switch (state)
{
    case PS_IDLE:
    {
        
    } break;
    case PS_WALK:
    {
        //walk sound (synced with 8 frames walk, 0.2 anim speed)
        if ((state_timer % 20) == 15)
        {
            sound_play(asset_get("sfx_may_arc_five"), false, noone, 0.2, 3);
        }
    } break;
    case PS_JUMPSQUAT:
    {
        //wheeled sprite when jumping from a dash
        image_index = (prev_state == PS_DASH 
                    || prev_state == PS_DASH_START
                    || prev_state == PS_DASH_TURN) ? 1 : 0;
        
    } break;
    case PS_DOUBLE_JUMP:
    {
        if (state_timer <= 1) 
        { uhc_anim_back_flipping = (hsp * spr_dir) < 0; }
        
        if (uhc_anim_back_flipping)
        { sprite_index = uhc_anim_backflip_spr; }
    }
    case PS_AIR_DODGE:
    {
        if (window == 0)
        {
            //beginning of dodge
            uhc_anim_last_dodge.posx = x;
            uhc_anim_last_dodge.posy = y;
        }
    } break;
    case PS_ATTACK_AIR:
    case PS_ATTACK_GROUND:
    {
        switch (attack)
        {
//===============================================================
             case AT_TAUNT:
             {
                 //Timers
                 if (uhc_taunt_current_video != noone)
                 {
                     if (uhc_taunt_opening_timer < uhc_taunt_opening_timer_max && uhc_taunt_is_opening)
                     { uhc_taunt_opening_timer++; }
                     else if (uhc_taunt_opening_timer > 0 && !uhc_taunt_is_opening)
                     { uhc_taunt_opening_timer--; }
                     else if (uhc_taunt_buffering_timer > 0)
                     { 
                         uhc_taunt_buffering_timer--; 
                         if (uhc_taunt_buffering_timer == 0 && uhc_taunt_is_opening)
                         {
                             sound_play(uhc_taunt_current_video.song, true, noone, 1, 1);
                         }
                     }
                     else
                     { uhc_taunt_timer++; }
                 }
                 
                 if (window_timer == 4)
                 {
                     if (window == 2) //Click to start
                     {
                         var video_number = random_func(0, uhc_taunt_num_videos, true);
                         //Switching channels
                         if (uhc_taunt_current_video != noone)
                         {
                             sound_stop(uhc_taunt_current_video.song);
                             if (uhc_taunt_current_video == uhc_taunt_videos[video_number])
                             { video_number = (video_number + 1) % uhc_taunt_num_videos; }
                         }
                         uhc_taunt_current_video = uhc_taunt_videos[video_number];
                         uhc_taunt_timer = 0;
                         uhc_taunt_is_opening = true;
                         uhc_taunt_buffering_timer = (video_number != 0) ? 20 + random_func(0, 40, true) : 0;
                     }
                     else if (window == 6) //Click to end
                     {
                        sound_stop(uhc_taunt_current_video.song);
                        uhc_taunt_is_opening = false;
                     }
                 }
             } break;
//===============================================================
        }
    } break;
    default: break;
}

//==============================================================
//prevent this from looping if no longer taunting
if (uhc_taunt_current_video != noone && state != PS_ATTACK_GROUND)
{
    sound_stop(uhc_taunt_current_video.song);
    uhc_taunt_is_opening = false;
    uhc_taunt_opening_timer = 0;
    uhc_taunt_current_video = noone;
}

//==============================================================
//collect compat videos
if (uhc_taunt_collect_videos)
{
    uhc_taunt_collect_videos = false; //collect once only
    
    var collected_urls = [];
    collected_urls[0] = url;
    var vid = noone;
    
    with (oPlayer) 
    if ("url" in self) && !array_exists(url, collected_urls)
    && ("uhc_taunt_videos" in self) && is_array(uhc_taunt_videos)
    {
        collected_urls[array_length(collected_urls)] = url;
        for (var i = 0; i < array_length(uhc_taunt_videos); i++)
        {
            vid = uhc_taunt_videos[i];
            with (other) 
            {
                //Send vid to Hypercam
                if (vid != noone) && ("uhc_taunt_videos" in self)
                && ("sprite" in vid) && ("song" in vid) && ("fps" in vid)
                {
                    uhc_taunt_videos[uhc_taunt_num_videos] = vid;
                    uhc_taunt_num_videos++;
                }
            }
        }
    }
}

//==============================================================
#define array_exists(value, array)
{
    for (i = 0; i < array_length(array); i++)
    { if (value == array[i]) return true; }
    return false;
}   