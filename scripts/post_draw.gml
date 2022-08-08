//post_draw.gml

var scale = 1 + small_sprites;
//===================================================
//force-show parry frame without shading
if (state == PS_PARRY && image_index == dodge_startup_frames)
{
    shader_start();
    draw_sprite_ext(sprite_index, image_index, x, y, spr_dir*scale, scale, 0, c_white, 1);
    shader_end();
}

//===================================================
// Drawing bladed sprites
draw_blade(sprite_index, image_index, x, y);

//===================================================
// Jab-walk
if (state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR)
  && (window >= 7 && (left_down xor right_down))
{
    shader_start();
    draw_sprite_ext(uhc_anim_jabwalk_legs_spr, uhc_anim_jabwalk_frame, 
                    x, y, spr_dir * scale, scale, 0, c_white, 1);
    shader_end();
}

//===================================================
// Strong buffering
if ((state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR)
  && (window == get_attack_value(attack, AG_STRONG_CHARGE_WINDOW))
  && (strong_charge > 0))
//same for the extra pratland hitpause
|| (state == PS_PRATLAND && hitpause)
|| (uhc_has_extended_pratland)
{
    draw_buffering(x, y);
}

//===================================================
//Dodge effects
if (state == PS_AIR_DODGE && window == 1)
|| (state == PS_ATTACK_AIR && attack == AT_USPECIAL && window == 3)
{
    var img_index = (state == PS_AIR_DODGE) ? 1 : (random_func(5, 2, true) + 3);
    shader_start();
    draw_sprite_ext(sprite_index, img_index, uhc_anim_last_dodge.posx, uhc_anim_last_dodge.posy, 
                    spr_dir * scale, scale, spr_angle, c_white, 1);
    shader_end();
    draw_blade(sprite_index, img_index, uhc_anim_last_dodge.posx, uhc_anim_last_dodge.posy);
    draw_buffering(uhc_anim_last_dodge.posx, uhc_anim_last_dodge.posy);
}
else if (uhc_uspecial_soft_cooldown > 0)
{
    draw_buffering(uhc_anim_last_dodge.posx, uhc_anim_last_dodge.posy);
}

//===================================================
//NSPECIAL: charge, arm and smear
if (state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND) && (attack == AT_NSPECIAL)
{
    shader_start();
    if (!uhc_has_cd_blade)
    {
        draw_sprite_ext(uhc_anim_nspecial_arm, image_index, x, y, 
                        spr_dir * scale, scale, spr_angle, c_white, 1);
    }
    if (window == 2)
    {
        var staroffset_x = x - (spr_dir * 28);
        var staroffset_y = y - 20;
        var starx = 0;
        var stary = 0;
        var star_sprite = sprite_get("vfx_star_trail");
        var star_angle = (get_gameplay_time() * 10) % 360;
        var star_spin_length = 10;
        switch (uhc_nspecial_charges)
        {
            case 4:
                starx = staroffset_x + lengthdir_x(star_spin_length, star_angle + 90);
                stary = staroffset_y + lengthdir_y(star_spin_length, star_angle + 90);
                draw_sprite_ext(star_sprite, 2, starx, stary, 
                                1, 1, 0, c_white, 1);
            case 3:
                starx = staroffset_x + lengthdir_y(star_spin_length, star_angle - 90);
                stary = staroffset_y + lengthdir_x(star_spin_length, star_angle - 90);
                draw_sprite_ext(star_sprite, 2, starx, stary, 
                                1, 1, 0, c_white, 1);
            case 2:
                starx = staroffset_x + lengthdir_y(star_spin_length, star_angle + 180);
                stary = staroffset_y + lengthdir_y(star_spin_length, star_angle + 180);
                draw_sprite_ext(star_sprite, 2, starx, stary, 
                                1, 1, 0, c_white, 1);
            case 1:
                starx = staroffset_x - lengthdir_x(star_spin_length, star_angle);
                stary = staroffset_y + lengthdir_x(star_spin_length, star_angle);
                draw_sprite_ext(star_sprite, 2, starx, stary, 
                                1, 1, 0, c_white, 1);
            case 0:
            default:
                starx = staroffset_x;
                stary = staroffset_y;
                draw_sprite_ext(star_sprite, 0, starx, stary, 
                                1, 1, star_angle, c_white, 1);
            break;
        }
    }
    else if (window == 3)
    {
        var spr_index = free ? uhc_anim_nspecial_smear_air : uhc_anim_nspecial_smear;
        draw_sprite_ext(spr_index, image_index, x, y, spr_dir * scale, scale, spr_angle, c_white, 1);
    }
    shader_end();
}

//===================================================
// FSPECIAL Flash
if (uhc_anim_fspecial_flash_spr != noone)
{
    var frame = 4 - clamp((uhc_anim_fspecial_flash_timer - 1) / 2, 0, 4);
    shader_start();
    draw_sprite_ext(uhc_anim_fspecial_flash_spr, frame, 
                    x + (spr_dir * 18), y - 28, spr_dir * scale, scale, 0, c_white, 1);
    shader_end();
}

//===================================================
//Respawn effects using HUD meters
#macro ICON_BAR     0
#macro ICON_MARKER  1
if (state == PS_RESPAWN || respawn_taunt)
{
    var load_pos = (uhc_anim_platform_buffer_timer)/uhc_anim_platform_timer_max * 100;
    draw_sprite_stretched_ext(vfx_hud_icons, ICON_BAR, x-48, y + 2, load_pos, 18, c_gray, 1);
    draw_sprite_ext(vfx_hud_icons, ICON_MARKER, x-48, y, 2, 2, 0, c_white, 1);

    draw_buffering(x, y);
}

//===================================================
// Taunt Video
if (uhc_taunt_current_video != noone)
{
    var subimg = floor(uhc_taunt_timer/60 * uhc_taunt_current_video.fps);
    var alpha = (image_index % 2 == 0) ? 0.85 : 0.75;
    var y_scale = ease_backOut(0, 20, uhc_taunt_opening_timer, uhc_taunt_opening_timer_max, 3) / 10.0;
    var vid_x = x +(spr_dir*44);
    var vid_y = y-28;

    var vid_sprite = sprite_exists(uhc_taunt_current_video.sprite) ? uhc_taunt_current_video.sprite : sprite_get("video_blocked");
    draw_sprite_ext(vid_sprite, subimg, vid_x, vid_y, +2, y_scale, 0, c_white, alpha);

    //mini-bufferring
    if (uhc_taunt_buffering_timer > 0)
    { draw_sprite_ext(vfx_mini_buffering, (floor(get_gameplay_time()/4) % 16), vid_x, vid_y, 1, y_scale/2, 0, c_white, alpha); }
}


//===================================================
// Host hat
if (uhc_has_hat)
{
    draw_sprite_ext(sprite_index == sprite_get("idle") ? vfx_hat_idle : vfx_hat_spawn,
                    image_index, x, y, 2*spr_dir, 2, 0, c_white, 1);
}
else if (uhc_lost_hat_timer < uhc_lost_hat_timer_max)
{
    draw_sprite_ext(vfx_hat_lost, (uhc_lost_hat_timer/8),
                    uhc_lost_hat_pos.x, uhc_lost_hat_pos.y, 2*spr_dir, 2, 0, c_white, 1);
}

//===================================================
// Batteries
if (!uhc_batteries) && (get_gameplay_time() > 360)
{
    draw_sprite_ext(sprite_get("vfx_batteries"), (get_gameplay_time()%120 > 60),
                    x, y - 60, 2, 2, 0, c_white, 1);
}

//===================================================
#define draw_blade(spr_id, img_id, posx, posy)
{
    if (uhc_has_cd_blade || (uhc_anim_blade_force_draw && instance_exists(uhc_current_cd) ))
    && ds_map_exists(uhc_blade_spr_map, spr_id)
    {
        var cd_id = uhc_current_cd;
        var scale = 1 + small_sprites;
        posx += draw_x;
        posy += draw_y;
        
        //individual CDs animate their spin.
        uhc_anim_blade_spin = (state == PS_RESPAWN || respawn_taunt) ? 1 : uhc_current_cd.cd_anim_blade_spin;
        uhc_anim_blade_color = uhc_current_cd.cd_anim_color;
        init_shader();
        
        shader_start();
        draw_sprite_ext(ds_map_find_value(other.uhc_blade_spr_map, spr_id), img_id, 
                        posx, posy, spr_dir * scale, scale, spr_angle, c_white, 1);
        shader_end(); 
        
        //restore this for the article's own rendering
        uhc_anim_blade_color = uhc_anim_current_color;
        init_shader();
    }
}
#define draw_buffering(posx, posy)
{
    draw_sprite(vfx_buffering, (floor(get_gameplay_time()/4) % 8), posx, posy-20);
}
