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
if (anim_is_buffering)
{
    var animframe = floor(get_gameplay_time()/4) % 8;
    draw_sprite(vfx_buffering, animframe, x, y-20);
}
//===================================================
