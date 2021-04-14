//pre_draw.gml

var scale = 1 + small_sprites;

//==========================================================================
// Rewind effect
if (uhc_anim_rewind.active)
{
    var effect_x = x -24;
    var effect_y = y -64;
    var spr_width = sprite_get_width(uhc_anim_rewind.sprite);
    var spr_height = sprite_get_height(uhc_anim_rewind.sprite);
    shader_start();
    draw_sprite_part_ext(uhc_anim_rewind.sprite, 0, 0, 
                         0, spr_width, uhc_anim_rewind.top_split,
                         effect_x + uhc_anim_rewind.top_offset, effect_y, 
                         scale, scale, c_white, 0.75);
    draw_sprite_part_ext(uhc_anim_rewind.sprite, 0, 0, 
                         uhc_anim_rewind.top_split, spr_width, uhc_anim_rewind.bot_split - uhc_anim_rewind.top_split,
                         effect_x + uhc_anim_rewind.mid_offset, effect_y + uhc_anim_rewind.top_split * scale, 
                         scale, scale, c_white, 0.75);
    draw_sprite_part_ext(uhc_anim_rewind.sprite, 0, 0, 
                         uhc_anim_rewind.bot_split, spr_width, spr_height - uhc_anim_rewind.bot_split,
                         effect_x + uhc_anim_rewind.bot_offset, effect_y + uhc_anim_rewind.bot_split * scale, 
                         scale, scale, c_white, 0.75);
    shader_end();
}
