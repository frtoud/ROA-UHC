//post_draw.gml

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
    draw_sprite_ext(sprite_index, 1, anim_last_dodge.posx, anim_last_dodge.posy, 
                    spr_dir, 1, spr_angle, c_white, 1);
    shader_end();
    draw_blade(sprite_index, 1, anim_last_dodge.posx, anim_last_dodge.posy);
    draw_buffering(anim_last_dodge.posx, anim_last_dodge.posy);
}
//===================================================


#define draw_blade(spr_id, img_id, posx, posy)
{
    if (uhc_has_cd_blade && ds_map_exists(uhc_blade_spr_map, spr_id))
    {
       shader_start();
       draw_sprite_ext(ds_map_find_value(uhc_blade_spr_map, spr_id),
                       img_id, posx, posy, spr_dir, 1, spr_angle, c_white, 1);
       shader_end(); 
    }
}
#define draw_buffering(posx, posy)
{
    draw_sprite(vfx_buffering, (floor(get_gameplay_time()/4) % 8), posx, posy-20);
}
