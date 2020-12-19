//post_draw.gml

//===================================================
// Drawing bladed sprites
if (uhc_has_cd_blade && ds_map_exists(uhc_blade_spr_map, sprite_index))
{
   shader_start();
   draw_sprite_ext(ds_map_find_value(uhc_blade_spr_map, sprite_index),
                   image_index, x, y, spr_dir, 1, spr_angle, c_white, 1);
   shader_end();
}
//===================================================
//Buffering
if (state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR)
  && (window == get_attack_value(attack, AG_STRONG_CHARGE_WINDOW))
  && (strong_charge > 0)
{
    draw_buffering(x, y);
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
