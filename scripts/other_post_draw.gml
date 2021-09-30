//other_post_draw.gml
if ("other_player_id" not in self) exit;

//===================================================
// USpecial buffering
if (uhc_being_buffered_by == other_player_id)
{
    draw_sprite(other_player_id.vfx_buffering, 
               (floor(get_gameplay_time()/4) % 8), x, y-char_height/2);
}

//===================================================
// Kirby: Screenshot Flash
//see post_draw
if (uhc_handler_id == other_player_id) && (uhc_has_kirby_ability)
{
    if (uhc_kirby_anim_timer > 0)
    {
        var frame = 4 - clamp((uhc_kirby_anim_timer) / 2, 0, 4);
        
        draw_sprite_ext(( uhc_kirby_anim_charge_level <= 1 ? uhc_handler_id.vfx_flash_small
                        : uhc_kirby_anim_charge_level == 2 ? uhc_handler_id.vfx_flash_medium
                                                           : uhc_handler_id.vfx_flash_large), 
                frame, x + (spr_dir * 10), y - 20, spr_dir * 2, 2, 0, c_white, 1);
    }

    if (draw_indicator)
    {
        var indicator_x = x + 1;
        var indicator_y = y - char_height - hud_offset - 20;

        //charge blinks the indicator
        var indicator_alpha = 0.5;
        var indicator_color = c_black;
        if (uhc_kirby_charge >= uhc_handler_id.uhc_fspecial_charge_max)
        {
            indicator_alpha = 0.1 * max(0, 10 - (get_gameplay_time() % 20));
            indicator_color = c_white;
        }
        else if (uhc_kirby_charge > uhc_handler_id.uhc_fspecial_charge_half)
        {
            indicator_alpha = 0.1 * max(0, 10 + uhc_handler_id.uhc_fspecial_charge_half - uhc_kirby_charge)
            indicator_color = c_white;
        }

        draw_sprite_ext(uhc_handler_id.indicator_spr, 0, indicator_x, indicator_y, 2, 2, 0, indicator_color, indicator_alpha);
    }
}