//pre_draw.gml

var scale = 1 + small_sprites;

//==========================================================================
// Rewind effect
if (uhc_anim_rewind.active)
{
    var effect_x = x -24;
    var effect_y = y -64;
    var alpha = 0.01 * ease_linear(25, 100, floor(uhc_current_cd.cd_spin_meter), uhc_cd_spin_max);
    var spr_width = sprite_get_width(uhc_anim_rewind.sprite);
    var spr_height = sprite_get_height(uhc_anim_rewind.sprite);
    shader_start();
    draw_sprite_part_ext(uhc_anim_rewind.sprite, 0, 0, 
                         0, spr_width, uhc_anim_rewind.top_split,
                         effect_x + uhc_anim_rewind.top_offset, effect_y, 
                         scale, scale, c_white, alpha);
    draw_sprite_part_ext(uhc_anim_rewind.sprite, 0, 0, 
                         uhc_anim_rewind.top_split, spr_width, uhc_anim_rewind.bot_split - uhc_anim_rewind.top_split,
                         effect_x + uhc_anim_rewind.mid_offset, effect_y + uhc_anim_rewind.top_split * scale, 
                         scale, scale, c_white, alpha);
    draw_sprite_part_ext(uhc_anim_rewind.sprite, 0, 0, 
                         uhc_anim_rewind.bot_split, spr_width, spr_height - uhc_anim_rewind.bot_split,
                         effect_x + uhc_anim_rewind.bot_offset, effect_y + uhc_anim_rewind.bot_split * scale, 
                         scale, scale, c_white, alpha);
    shader_end();
}


//==========================================================================
// Music suppression (needs to be here so that pausing still works)
if (state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND)
{
    if (attack == AT_USPECIAL && window == 3)
    { suppress_stage_music(0, 1); }
    else if (attack == AT_TAUNT && window >= 2 && window <= 6)
    { suppress_stage_music(0, 0.01); }
}