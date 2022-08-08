//css_draw.gml
shader_end();
init_shader();

//drawing button
var real_button_x = floor(x + button_x);
var real_button_y = floor(y + button_y);
if (get_match_setting(SET_RUNES) || get_match_setting(SET_TEAMS) )
{
    real_button_y -= rune_size;
}

//music note icon
draw_sprite_ext(sprite_get("css_icons"), button_highlighted && (button_anim_timer == 0), 
                real_button_x, real_button_y, 2, 2, 0, c_white, 1);

if (uhc_uspecial_music_fix)
{
    if (button_anim_timer > 0)
    {
        //check
        draw_sprite_ext(sprite_get("css_icons"), 5 + ((button_anim_timer/2) % 8), 
                        real_button_x, real_button_y, 2, 2, 0, c_white, 1);
    }
    else //loading
        draw_sprite_ext(sprite_get("css_icons"), 3, real_button_x, real_button_y, 2, 2, 0, c_white, 1);
}
else 
{
    if (button_anim_timer > 0)
    {
        //red error
        var offset = 2 * (0x41A3 >> (current_time % 8) & 0x03) - 4;
        draw_sprite_ext(sprite_get("css_icons"), 4, real_button_x + offset, real_button_y, 2, 2, 0, c_white, 1);
    } 
    else if (current_second % 2 == 0)
        //yellow error
        draw_sprite_ext(sprite_get("css_icons"), 2, real_button_x, real_button_y, 2, 2, 0, c_white, 1);
}


if (button_highlighted && !uhc_uspecial_music_fix && (button_anim_timer == 0))
{
    //text bubble
    var text_x = real_button_x + 10;
    var text_y = real_button_y - 40;
    draw_sprite_ext(sprite_get("css_textbubble"), 0, text_x -10, text_y - 8, 2, 2, 0, c_white, 1);
    draw_debug_text(text_x, text_y, "Error in audio buffering");
    draw_debug_text(text_x, text_y + 18, "codec! Click to reload.");
}
