//animation.gml

//===============================================================
//Precalculated effects for buffering 
uhc_anim_rand_x = random_func(0, 100, true) / 100.0;
uhc_anim_rand_y = random_func(1, 100, true) / 100.0;
vfx_glitch = vfx_glitches_array[random_func(2, array_length(vfx_glitches_array), true)];

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

if (move_cooldown[AT_FSPECIAL] == uhc_fspecial_cooldown) 
{ must_blink = true; }
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

uhc_anim_blinker_shading = ease_cubeInOut(0, 100, floor(uhc_anim_blink_timer), 
                                        uhc_anim_blink_timer_max) / 100.0;

if (uhc_anim_blink_timer > 0) { uhc_anim_blink_timer--; }

//===============================================================
//Flash animation

if (uhc_anim_fspecial_flash_timer > 0) { uhc_anim_fspecial_flash_timer--; }
else { uhc_anim_fspecial_flash_spr = noone; }

//==========================================================================
// Rewind effect
if (state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND)
 && (attack == AT_DSPECIAL && window == 2)
{
    var spr_height = sprite_get_height(uhc_anim_rewind.sprite);
    var intensity = 0.01 * ease_cubeIn(0, 10, floor(uhc_current_cd.cd_spin_meter), uhc_cd_spin_max);
    
    uhc_anim_rewind.active = true;
    uhc_anim_rewind.top_split = random_func(0, floor(spr_height/2), true) + 5;
    uhc_anim_rewind.bot_split = random_func(1, floor(spr_height/3), true) + uhc_anim_rewind.top_split;
    uhc_anim_rewind.top_offset = intensity * (random_func(2, 100, true) - 50);
    uhc_anim_rewind.mid_offset = intensity * (random_func(3, 100, true) - 50);
    uhc_anim_rewind.bot_offset = intensity * (random_func(4, 100, true) - 50);
}
else
{
    uhc_anim_rewind.active = false;
}
//===============================================================
init_shader();

//needs to be reset if not in Jab
draw_y = 0;

switch (state)
{
    case PS_WALK:
    {
        if (uhc_anim_jabwalk_timer != 0)
        {
            state_timer = uhc_anim_jabwalk_timer;
            uhc_anim_jabwalk_timer = 0;
        }
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
            case AT_JAB:
            {
                if (window == 1 && window_timer == 1)
                { uhc_looping_attack_can_exit = false; }
                else if (window >= 7)
                {
                    if (hsp != 0)
                    {
                        var max_time_for_walk_loop = 8/walk_anim_speed;
                        
                        uhc_anim_jabwalk_timer += (sign(hsp) * spr_dir);
                        if (uhc_anim_jabwalk_timer < 0) 
                        {uhc_anim_jabwalk_timer += max_time_for_walk_loop; }
                        
                        uhc_anim_jabwalk_frame = (uhc_anim_jabwalk_timer * walk_anim_speed) % 8;
                        
                        //walk sound (synced with 8 frames walk, 0.2 anim speed)
                        if ((uhc_anim_jabwalk_timer % 20) == 15)
                        {
                            sound_play(asset_get("sfx_may_arc_five"), false, noone, 0.2, 3);
                        }
        
                        image_index += 10; //use legless sprites
                        
                        //bobbing
                        switch floor(uhc_anim_jabwalk_frame)
                        {
                            case 0: case 4: draw_y = -2;
                            break;
                            case 2: case 6: draw_y = +2;
                            break;
                            default: draw_y = 0;
                            break;
                        }
                    }
                    else
                    {
                        uhc_anim_jabwalk_timer = 0;
                    }
                }
            } break;
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
                            ease_linear(80, 240, floor(uhc_current_cd.cd_spin_meter), uhc_cd_spin_max);
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
            case AT_USPECIAL:
            {
                if (image_index == 0 && free)
                { 
                    image_index = 1; //air frame
                }
                else if (window == 3)
                {
                    spawn_twinkle(vfx_glitch, x, y - (char_height/2), 15);
                    spawn_twinkle(vfx_glitch, uhc_anim_last_dodge.posx, 
                                              uhc_anim_last_dodge.posy - (char_height/2), 80);
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
                    if (window == 1) //startup: shuffle
                    {
                        for (var i = (uhc_taunt_num_videos - 1); i >= 0; i--)
                        {
                            var swapwith = random_func(i % 24, i + 1, true);
                            if (swapwith != i)
                            {
                                var temp = uhc_taunt_videos[i];
                                uhc_taunt_videos[i] = uhc_taunt_videos[swapwith];
                                uhc_taunt_videos[swapwith] = temp;
                            }
                        }
                    }
                    else if (window == 2) //Click to start
                    {
                        var video_number = 0;
                        //Switching channels
                        if (uhc_taunt_current_video != noone)
                        {
                            sound_stop(uhc_taunt_current_video.song);
                            video_number = (uhc_taunt_current_video_index + 1) % uhc_taunt_num_videos;
                        }
                        else
                        {
                            video_number = random_func(0, uhc_taunt_num_videos, true);
                        }

                        uhc_taunt_current_video = uhc_taunt_videos[video_number];
                        uhc_taunt_current_video_index = video_number;
                        uhc_taunt_timer = 0;
                        uhc_taunt_is_opening = true;
                        //special == 1: no buffering
                        uhc_taunt_buffering_timer = (uhc_taunt_current_video.special == 1) ? 0 
                                                    : 20 + random_func(0, 40, true);
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
    {
        collected_urls[array_length(collected_urls)] = url;
        
        var videos_to_collect = noone;
        if ("uhc_taunt_videos" in self && is_array(uhc_taunt_videos))
        { videos_to_collect = uhc_taunt_videos; }
        else with (other) 
        { videos_to_collect = try_get_builtin_video(other.url); }
        
        if (videos_to_collect != noone)
        {
            for (var i = 0; i < array_length(videos_to_collect); i++)
            {
                vid = videos_to_collect[i];
                with (other)
                {
                    //Send vid to Hypercam
                    if (vid != noone) && ("uhc_taunt_videos" in self)
                    && ("sprite" in vid) && ("song" in vid) && ("fps" in vid)
                    {
                        if ("special" not in vid) { vid.special = 0; }
                        uhc_taunt_videos[uhc_taunt_num_videos] = vid;
                        uhc_taunt_num_videos++;
                    }
                }
            }
        }
    }
}

//==============================================================
#define spawn_twinkle(vfx, pos_x, pos_y, radius)
{
    //thank u nozumi :D
    var kx = pos_x - (radius / 2) + uhc_anim_rand_x * radius;
    var ky = pos_y - (radius / 2) + uhc_anim_rand_y * radius;
    var k = spawn_hit_fx(kx, ky, vfx);
    k.depth = depth - 1;
}   
//==============================================================
#define array_exists(value, array)
{
    for (i = 0; i < array_length(array); i++)
    { if (value == array[i]) return true; }
    return false;
}   
//==============================================================
#define try_get_builtin_video(char_url)
{
    var videos = noone;
    switch (char_url)
    {
        //=================================================================
        // Hi!
        // If you see your mod's URL in here, feel free to copy/edit
        // the video files into your own mod!
        // declare an array called "uhc_taunt_videos" in init.gml like so:
        //    uhc_taunt_videos[i] = { sprite:A, song:B, fps:C };
        // This will override the built in behavior!
        //=================================================================
        // KFAD
        //=================================================================
        case "2177081326": // Nico Nico
           sprite_change_offset("video_fukkireta", 11, 8);
           videos[0] = { sprite:sprite_get("video_fukkireta"),   
                         song:sound_get("video_fukkireta"),   
                         fps:13 };
           sprite_change_offset("video_caramel", 11, 8);
           videos[1] = { sprite:sprite_get("video_caramel"),   
                         song:sound_get("video_caramel"),   
                         fps:10 };
           break;
        //=================================================================
        // Bonus
        //=================================================================
        case "1933111975": // Trummel & Alto
        case "2282173822": // Trummel & Alto 2
           sprite_change_offset("video_sax", 11, 8);
           videos[0] = { sprite:sprite_get("video_sax"),   
                         song:sound_get("video_sax"),   
                         fps:18 };
           break;
        //=================================================================
        // Base cast
        //=================================================================
        case CH_ZETTERBURN:
        case CH_FORSBURN:
        case CH_CLAIREN:
           sprite_change_offset("video_sparta", 11, 8);
           videos[0] = { sprite:sprite_get("video_sparta"),   
                         song:sound_get("video_sparta"),   
                         fps:5 };
           break;
        case CH_WRASTOR:
        case CH_ABSA:
        case CH_ELLIANA:
           sprite_change_offset("video_numa", 11, 8);
           videos[0] = { sprite:sprite_get("video_numa"),   
                         song:sound_get("video_numa"),   
                         fps:7 };
           break;
        case CH_SHOVEL_KNIGHT:
           sprite_change_offset("video_rs", 11, 8);
           videos[0] = { sprite:sprite_get("video_rs"),   
                         song:sound_get("video_rs"),   
                         fps:1 };
           break;
        case CH_ETALUS: 
        case CH_RANNO:
        case CH_ORCANE:
        case CH_KRAGG: 
        case CH_MAYPUL:
        case CH_SYLVANOS:
        case CH_ORI:
        default: break;
    }
    
    return videos;
}