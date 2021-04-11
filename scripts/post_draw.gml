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
//Buffering
if (state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR)
  && (window == get_attack_value(attack, AG_STRONG_CHARGE_WINDOW))
  && (strong_charge > 0)
{
    draw_buffering(x, y);
}
//===================================================
//Dodge effects
if (state == PS_AIR_DODGE && window == 1)
{
    shader_start();
    draw_sprite_ext(sprite_index, 1, uhc_anim_last_dodge.posx, uhc_anim_last_dodge.posy, 
                    spr_dir * scale, scale, spr_angle, c_white, 1);
    shader_end();
    draw_blade(sprite_index, 1, uhc_anim_last_dodge.posx, uhc_anim_last_dodge.posy);
    draw_buffering(uhc_anim_last_dodge.posx, uhc_anim_last_dodge.posy);
}
//===================================================
// FSPECIAL Flash
if (uhc_anim_fspecial_flash_spr != noone)
{
    var frame = 4 - min(4, (uhc_anim_fspecial_flash_timer) / 2);
    shader_start();
    draw_sprite_ext(uhc_anim_fspecial_flash_spr, frame, 
                    x + (spr_dir * 18), y - 28, spr_dir * 2, 2, 0, c_white, 1);
    shader_end();
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
    draw_sprite_ext(uhc_taunt_current_video.sprite, subimg, vid_x, vid_y, -2, y_scale, 0, c_white, alpha);
    //mini-bufferring
    if (uhc_taunt_buffering_timer > 0)
    { draw_sprite_ext(vfx_mini_buffering, (floor(get_gameplay_time()/4) % 16), vid_x, vid_y, 1, y_scale/2, 0, c_white, alpha); }
}

//===================================================
#define draw_blade(spr_id, img_id, posx, posy)
{
    if (uhc_has_cd_blade && ds_map_exists(uhc_blade_spr_map, spr_id))
    {
       shader_start();
       var scale = 1 + small_sprites;
       draw_sprite_ext(ds_map_find_value(uhc_blade_spr_map, spr_id),
                       img_id, posx, posy, spr_dir * scale, scale, spr_angle, c_white, 1);
       shader_end(); 
    }
}
#define draw_buffering(posx, posy)
{
    draw_sprite(vfx_buffering, (floor(get_gameplay_time()/4) % 8), posx, posy-20);
}
