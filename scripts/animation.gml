//animation.gml

//===============================================================
//Blade spin animation
if (uhc_has_cd_blade)
{
    var spin_speed = 0.5 * (uhc_current_cd.cd_spin_meter / uhc_cd_spin_max);
    uhc_anim_blade_spin = (3 + uhc_anim_blade_spin - spin_speed) % 3;
}

//===============================================================
//Blinker light animation

var must_blink = false;
uhc_anim_blinker_shading = 8.0; //higher values mean faded towards black

if (move_cooldown[AT_FSPECIAL] == uhc_fspecial_cooldown) { must_blink = true; }
else if (move_cooldown[AT_FSPECIAL] == 0)
{
    if (uhc_fspecial_charge_current >= uhc_fspecial_charge_max)
    {
        must_blink = (get_gameplay_time() % 15) == 0;
    }
    else if (uhc_fspecial_charge_current >= uhc_fspecial_charge_half)
    {
        must_blink = (get_gameplay_time() % 60) == 0;
    }
}

if (must_blink) { uhc_anim_blink_timer = uhc_anim_blink_timer_max; }
var blink_pulse = ease_sineOut(80, 0, floor(uhc_anim_blink_timer), 
                                      uhc_anim_blink_timer_max) / 10.0;

uhc_anim_blinker_shading = min(uhc_anim_blinker_shading, blink_pulse);

if (uhc_anim_blink_timer > 0) { uhc_anim_blink_timer--; }

//===============================================================
//Flash animation

if (uhc_anim_fspecial_flash_timer > 0) { uhc_anim_fspecial_flash_timer--; }
else { uhc_anim_fspecial_flash_spr = noone; }

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
            case AT_FSPECIAL:
            {
                if (window == 1 && window_timer == 7)
                {
                    uhc_anim_fspecial_flash_timer = 8;
                    uhc_anim_fspecial_flash_spr = vfx_flash_charge;
                }
                else if (window >= 2 && window <= 4) && (window_timer == 0)
                {
                    uhc_anim_fspecial_flash_timer = 8;
                     
                    uhc_anim_fspecial_flash_spr = (window == 2 ? vfx_flash_small
                                                : (window == 3 ? vfx_flash_medium
                                                               : vfx_flash_large ));
                }
            } break;
//===============================================================
            case AT_DSPECIAL:
            {
                if (image_index == 1 && !uhc_has_cd_blade)
                { 
                    image_index = 0; //bladeless frame
                }
                else if (window == 2)
                {
                    //sfx & animspeed control based on charge here
                    if (window_timer == 5)
                    {
                        var pitch = 0.01 * 
                            ease_linear(80, 200, floor(uhc_current_cd.cd_spin_meter), uhc_cd_spin_max);
                        sound_play(sfx_dspecial_reload, false, noone, 1, pitch);
                    }
                    
                    var animspeed = 0.01 *
                        ease_linear(10, 50, floor(uhc_current_cd.cd_spin_meter), uhc_cd_spin_max);
                    uhc_anim_dspecial_image_timer += animspeed;
                    
                    image_index = floor(uhc_anim_dspecial_image_timer % 4) +
                    get_window_value(AT_DSPECIAL, 2, AG_WINDOW_ANIM_FRAME_START);
                }
            } break;
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
                        var video_number = 0;
                        //Switching channels
                        if (uhc_taunt_current_video != noone)
                        {
                            sound_stop(uhc_taunt_current_video.song);
                            video_number = (uhc_taunt_current_video.num + 1) % uhc_taunt_num_videos;
                        }
                        else
                        {
                            video_number = random_func(0, uhc_taunt_num_videos, true);
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
            default: break;
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