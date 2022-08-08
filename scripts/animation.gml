//animation.gml

//===============================================================
//Precalculated effects for buffering 
uhc_anim_rand_x = random_func(0, 100, true) / 100.0;
uhc_anim_rand_y = random_func(1, 100, true) / 100.0;
vfx_glitch = vfx_glitches_array[random_func(2, array_length(vfx_glitches_array), true)];

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

init_shader();

//===============================================================
//Flash animation
if (uhc_anim_fspecial_flash_timer > 0) { uhc_anim_fspecial_flash_timer--; }
else { uhc_anim_fspecial_flash_spr = noone; }

//==========================================================================
// Rewind effect
if (state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND)
 && (attack == AT_DSPECIAL && window == 4)
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
// HUD blade respawn buffer effect
if (uhc_cd_can_respawn || random_func(3, 60, true) == 0)
{
    uhc_anim_buffer_timer = uhc_cd_respawn_timer;
}

//similar pattern for Hypercam's own respawn
if (state == PS_RESPAWN && state_timer == 1)
{
    uhc_anim_platform_timer = 1;
    uhc_anim_platform_buffer_timer = uhc_anim_platform_timer_min;
}
else if (random_func(4, 20, true) == 0)
{
    uhc_anim_platform_buffer_timer = clamp(uhc_anim_platform_timer - uhc_anim_platform_timer_min, 
                                           0, uhc_anim_platform_timer_max);
}
uhc_anim_platform_timer++;

//===============================================================
// Reset at the beginning of each move/state
// Used by Strongs so that throws can show smears
if (uhc_anim_blade_force_draw && (state_timer == 0 
                              || !(state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND)) )
{ uhc_anim_blade_force_draw = false; }

//===============================================================
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
            if (get_player_color(player) == 3)
            {
                var step_sfx = sound_get((state_timer % 40 < 20) ? 
                                         "sfx_nice_step1" : "sfx_nice_step2");
                sound_play(step_sfx, false, noone, 0.4, 1);
            }
            else 
            {
                sound_play(asset_get("sfx_may_arc_five"), false, noone, 0.2, 3);
            }
        }
    } break;
    case PS_JUMPSQUAT:
    {
        //wheeled sprite when jumping from a dash
        image_index = (prev_state == PS_DASH 
                    || prev_state == PS_DASH_START
                    || prev_state == PS_DASH_TURN
                    || (prev_state == PS_ATTACK_GROUND && attack == AT_DATTACK)) ? 0 : 1;
        
    } break;
    case PS_DOUBLE_JUMP:
    {
        if (state_timer <= 1) 
        { uhc_anim_back_flipping = (hsp * spr_dir) < 0; }
        
        if (uhc_anim_back_flipping)
        { sprite_index = uhc_anim_backflip_spr; }
    } break;
    case PS_AIR_DODGE:
    {
        if (window == 0) //beginning of dodge
        {
            uhc_anim_last_dodge.posx = x;
            uhc_anim_last_dodge.posy = y;
        }
        else if (window == 1) //dodge active
        {
            spawn_twinkle(vfx_glitch, x, y - (char_height/2), 15);
        }
    } break;
    case PS_WALL_JUMP:
    {
        if (state_timer < 4)
        { 
            image_index = 0;
        }
    } break;
    case PS_PRATLAND:
    {
        if (!was_parried)
        {
            sprite_index = uhc_pratland_spr;
            image_index = floor(image_number * (state_timer/prat_land_time));
        }
    } break;
    case PS_ATTACK_AIR:
    case PS_ATTACK_GROUND:
    {
        play_lastframe_sfx();

        switch (attack)
        {
//===============================================================
            case AT_JAB:
            {
                if (window == 1 && window_timer == 1)
                { uhc_looping_attack_can_exit = false; }
                else if (window >= 7)
                {
                    if (left_down xor right_down)
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
//==========================================================
            case AT_UTILT:
            {
                hud_offset = uhc_has_cd_blade ? 80 : 45;
            } break;
//===============================================================
            case AT_FSTRONG:
            case AT_USTRONG:
            case AT_DSTRONG:
            case AT_DSTRONG_2:
            {
                if (window == 1 && window_timer == 1)
                {
                    //strongs need smears after having thrown the disc.
                    uhc_anim_blade_force_draw = uhc_has_cd_blade;
                }
            } break;
//===============================================================
            case AT_NSPECIAL:
            {
                if (window == 2)
                {
                    image_index = uhc_nspecial_charges
                                + get_window_value(AT_NSPECIAL, 2, AG_WINDOW_ANIM_FRAME_START);
                }
                else if (window == 4 && window_timer == 0)
                {
                    var k = spawn_hit_fx(x + spr_dir*-30, y -16, vfx_star_destroy);
                    k.depth = depth - 1;
                    
                }
            } break;
//===============================================================
            case AT_FSPECIAL:
            {
                if (window == 1 && window_timer == 3)
                {
                    uhc_anim_fspecial_flash_timer = uhc_anim_fspecial_flash_pre_time;
                    uhc_anim_fspecial_flash_spr = vfx_flash_charge;
                }
                else if (window >= 2 && window <= 4) && (window_timer == 0)
                {
                    uhc_anim_fspecial_flash_timer = uhc_anim_fspecial_flash_time;
                     
                    uhc_anim_fspecial_flash_spr = (window == 2 ? vfx_flash_small
                                                : (window == 3 ? vfx_flash_medium
                                                               : vfx_flash_large ));
                }
            } break;
//===============================================================
            case AT_DSPECIAL:
            {
                if (image_index == 0 && !uhc_has_cd_blade)
                { 
                    image_index = 1; //Pre-recall frame
                }
                else if (window == 2 && window_timer == 1)
                {
                    //Tha¬KS !n 4d>@n¢£ ~M'
                    reset_window_value(AT_DSPECIAL, 2, AG_WINDOW_HAS_SFX);
                }
                else if (window == 4)
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
                    get_window_value(AT_DSPECIAL, 4, AG_WINDOW_ANIM_FRAME_START);

                    if (uhc_anim_dspecial_image_timer % 4 < 0.75)
                    {
                        var hfx = spawn_hit_fx(x + 26 * spr_dir, y - 33, vfx_spinning);
                        hfx.draw_angle = random_func( 7, 180, true);
                        hfx.player_id = uhc_current_cd.player_id;
                    }
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
                else if (window > 3 && uhc_has_extended_pratland)
                {
                    image_index = 7;
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
                            //==============================================================
                            // RUNE: Rickroll earrape
                            // I'm almost sorry
                            if (uhc_rune_flags.deadly_rickroll) && (uhc_taunt_current_video.special == 2)
                            {
                                //not providing the pitch argument does allow >1 volume. Dan pls
                                sound_play(uhc_taunt_current_video.song, true, noone, 5);
                            }
                            //==============================================================

                        }
                    }
                    else
                    { 
                        uhc_taunt_timer++;
                        //==============================================================
                        // RUNE: Rickroll
                        if (uhc_rune_flags.deadly_rickroll) && (uhc_taunt_current_video.special == 2)
                        && (uhc_taunt_timer % 31 == 1)
                        {
                            shake_camera(8, 12);
                        }
                        //==============================================================
                    }
                }

                if (window == 1) && (window_timer == 12) //startup: shuffle
                {
                    uhc_taunt_bufferskip = taunt_down;
                    if (!taunt_down) 
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
                }
                else if (window == 2) && (window_timer == 4) //Click to start
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
                        video_number = uhc_taunt_current_video_index;
                    }

                    uhc_taunt_current_video = uhc_taunt_videos[video_number];
                    uhc_taunt_current_video_index = video_number;
                    uhc_taunt_timer = 0;
                    uhc_taunt_is_opening = true;
                    //special == 1: no buffering
                    uhc_taunt_buffering_timer = (uhc_taunt_current_video.special == 1) ? 0 
                                                : 20 + random_func(0, 40, true);
                    if (uhc_taunt_bufferskip)
                    {
                        uhc_taunt_bufferskip = false;
                        //see sound_play condition in timers section
                        uhc_taunt_buffering_timer = min(uhc_taunt_buffering_timer, 2);
                    }
                }
                else if (window == 6) && (window_timer == 4) //Click to end
                {
                    sound_stop(uhc_taunt_current_video.song);
                    uhc_taunt_is_opening = false;
                }

                //Respawn taunt special behavior
                if (respawn_taunt)
                {
                    if (uhc_taunt_buffering_timer > 1) uhc_taunt_buffering_timer++;
                    switch (image_index)
                    {
                        case 0: case 1: case 2: 
                           image_index = 2; break;
                        case 3: case 4: case 5: case 6:
                           image_index = 4; break;
                        default: 
                           image_index = 10; break;
                    }
                }

            } break;
//===============================================================
            default: break;
        }
    } break;
    case PS_RESPAWN:
    {
        image_index = 0;
    }break;
    case PS_SPAWN:
    {
        if (state_timer < (56 + 36))
        {
            sprite_index = sprite_get("spawn");
            image_index = 0;
            if (state_timer > 56)
            {
                image_index = 1 + (state_timer - 56)/6;
            }
            else if (state_timer == 55) && !hitpause
            {
                uhc_anim_blink_timer = uhc_anim_blink_timer_max;
                sound_play(sfx_cd_respawn);
            }
            else
            {
                uhc_current_cd.cd_anim_blade_spin = 0;
                draw_indicator = false;
            }
        }
    }break;
    default: break;
}

if (uhc_uspecial_soft_cooldown)
{
    image_index = 2 * floor(image_index/2);
}

//===================================================
// Host hat
if (uhc_has_hat) 
&& !(sprite_index == sprite_get("idle") || sprite_index == sprite_get("spawn"))
{
    uhc_has_hat = false;
    uhc_lost_hat_pos.x = x;
    uhc_lost_hat_pos.y = y;
    uhc_lost_hat_timer = 0;
}
if (uhc_lost_hat_timer < uhc_lost_hat_timer_max)
{
    uhc_lost_hat_timer++;
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
if (uhc_taunt_collect_videos && state == PS_ATTACK_GROUND && attack == AT_TAUNT)
{
    uhc_taunt_collect_videos = false; //collect once, only when starting to taunt
    
    var collected_urls = [];
    collected_urls[0] = url;
    var vid = noone;

    //check buddy
    var buddy_replaces_playlist = false;
    if ("uhc_taunt_videos" in my_pet && is_array(my_pet.uhc_taunt_videos))
    {
        buddy_replaces_playlist = ("uhc_replace_videos" in my_pet && my_pet.uhc_replace_videos);
        if (buddy_replaces_playlist)
        {
            uhc_taunt_num_videos = 1; //flushes all videos
        }

        //grab from buddy
        for (var i = 0; i < array_length(my_pet.uhc_taunt_videos); i++)
        {
            vid = my_pet.uhc_taunt_videos[i];
            if (vid != noone) && ("uhc_taunt_videos" in self)
            && ("sprite" in vid) && ("song" in vid) && ("fps" in vid)
            {
                if ("special" not in vid) { vid.special = 0; }
                if ("title" not in vid) { vid.title = "Private video"; }
                uhc_taunt_videos[uhc_taunt_num_videos] = vid;
                uhc_taunt_num_videos++;
            }
        }
    }

    if (!buddy_replaces_playlist) //continue collecting if buddy did not override
    {
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
                            if ("title" not in vid) { vid.title = "Private video"; }
                            uhc_taunt_videos[uhc_taunt_num_videos] = vid;
                            uhc_taunt_num_videos++;
                        }
                    }
                }
            }
        }
    }
}

//==============================================================
// purpose: if AG_WINDOW_SFX_FRAME is negative, play SFX on the X-to-last frame of this window
// eg. Set AG_WINDOW_SFX_FRAME to -1 for it to apply to the last frame of a window
// Feel free to "borrow" this as much as you want
// DISCLAIMER: modifying this function void the "call me if it breaks" warrantee.
//==============================================================
#define play_lastframe_sfx()
{
    if (!hitpause) && (0 != get_window_value( attack, window, AG_WINDOW_HAS_SFX))
                   && (0 != get_window_value( attack, window, AG_WINDOW_SFX))
    {
        var window_length = get_window_value( attack, window, AG_WINDOW_LENGTH);
        var sfx_frame = get_window_value( attack, window, AG_WINDOW_SFX_FRAME);
        
        // (sfx_frame < 0) is implied, since (window_timer < window_length)
        if (window_timer == (window_length + sfx_frame))
        {
            sound_play( get_window_value( attack, window, AG_WINDOW_SFX));
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
           videos[0] = { title:"[Karaoke] Fukkireta (Mischievous Function) [off vocal]  Gojimaji-P",
                         sprite:sprite_get("video_fukkireta"),
                         song:sound_get("video_fukkireta"),
                         fps:13 };
           sprite_change_offset("video_caramel", 11, 8);
           videos[1] = { title:"CaramellDansen (Full Version + Lyrics)",
                         sprite:sprite_get("video_caramel"),
                         song:sound_get("video_caramel"),
                         fps:10 };
           sprite_change_offset("video_leek", 11, 8);
           videos[2] = { title:"Leek Spin", 
                         sprite:sprite_get("video_leek"),
                         song:sound_get("video_leek"),
                         fps:7 };
           break;
        //=================================================================
        // Bonus
        //=================================================================
        case "1933111975": // Trummel & Alto
        case "2282173822": // Trummel & Alto 2
           sprite_change_offset("video_sax", 11, 8);
           videos[0] = { title:"HD Epic Sax Gandalf",
                         sprite:sprite_get("video_sax"),
                         song:sound_get("video_sax"),
                         fps:18 };
           break;
        case "1890617624": //Ronald
        case "2154720280": //Nolan
           sprite_change_offset("video_lol", 11, 8);
           videos[0] = { title:"YTMND-lol, internet",
                         sprite:sprite_get("video_lol"),
                         song:sound_get("video_lol"),
                         fps:8 };
           break;
        case "2390163800": //SEGERAK
           sprite_change_offset("video_brody", 11, 8);
           videos[0] = { title:"BRODYQUEST",
                         sprite:sprite_get("video_brody"),
                         song:sound_get("video_brody"),
                         fps:14 };
           break;
        //=================================================================
        // Base cast
        //=================================================================
        case CH_ZETTERBURN:
        case CH_FORSBURN:
        case CH_CLAIREN:
        case CH_MOLLO:
           sprite_change_offset("video_sparta", 11, 8);
           videos[0] = { title:"This is Sparta! Last techno remix",
                         sprite:sprite_get("video_sparta"),
                         song:sound_get("video_sparta"),
                         fps:5 };
           break;
        case CH_WRASTOR:
        case CH_ABSA:
        case CH_ELLIANA:
        case CH_POMME:
           sprite_change_offset("video_numa", 11, 8);
           videos[0] = { title:"Numa Numa",
                         sprite:sprite_get("video_numa"),
                         song:sound_get("video_numa"),
                         fps:7 };
           break;
        case CH_SHOVEL_KNIGHT:
           sprite_change_offset("video_rs", 11, 8);
           videos[0] = { title:"Old RuneScape Soundtrack: Harmony",
                         sprite:sprite_get("video_rs"),
                         song:sound_get("video_rs"),
                         fps:1 };
           break;
        case CH_ETALUS: 
        case CH_RANNO:
        case CH_ORCANE:
        case CH_HODAN:
           sprite_change_offset("video_lime", 11, 8);
           videos[0] = { title:"LOL! LIMEWIRE!",
                         sprite:sprite_get("video_lime"),
                         song:sound_get("video_lime"),
                         fps:12 };
           break;
        case CH_KRAGG: 
        case CH_MAYPUL:
        case CH_SYLVANOS:
        case CH_OLYMPIA:
           sprite_change_offset("video_darude", 11, 8);
           videos[0] = { title:"Darude - Sandstorm",
                         sprite:sprite_get("video_darude"),
                         song:sound_get("video_darude"),
                         fps:1 };
           break;
        case CH_ORI:
           sprite_change_offset("video_cat", 11, 8);
           videos[0] = { title:"Keyboard Cat 10 Hours",
                         sprite:sprite_get("video_cat"),
                         song:sound_get("video_cat"),
                         fps:10 };
        default: break;
    }
    
    return videos;
}