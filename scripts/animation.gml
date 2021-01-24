//animation.gml

//===============================================================
//Blade spin animation
if (uhc_has_cd_blade)
{
    var spin_speed = 0.5 * (uhc_current_cd.cd_spin_meter / uhc_cd_spin_max);
    anim_blade_spin = (3 + anim_blade_spin - spin_speed) % 3;
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
    case PS_AIR_DODGE:
    {
        if (window == 0)
        {
            //beginning of dodge
            anim_last_dodge.posx = x;
            anim_last_dodge.posy = y;
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
                         var num_videos = array_length(uhc_taunt_videos);
                         var video_number = random_func(0, num_videos, true);
                         //Switching channels
                         if (uhc_taunt_current_video != noone)
                         {
                             sound_stop(uhc_taunt_current_video.song);
                             if (uhc_taunt_current_video == uhc_taunt_videos[video_number])
                             { video_number = (video_number + 1) % num_videos; }
                         }
                         uhc_taunt_current_video = uhc_taunt_videos[video_number];
                         uhc_taunt_timer = 0;
                         uhc_taunt_is_opening = true;
                         uhc_taunt_buffering_timer = 
                            uhc_taunt_current_video.buffers ? 20 + random_func(0, 40, true) : 0;
                            
                        //sound_play(sound_get("click"));
                     }
                     else if (window == 6) //Click to end
                     {
                        sound_stop(uhc_taunt_current_video.song);
                        uhc_taunt_is_opening = false;
                        
                        //sound_play(sound_get("click"));
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