//init_shader.gml

var current_color = get_player_color(player);

//Colors.gml dependent on set_character_color_shading
//===================================================
if (current_color == 2) 
{ 
    set_character_color_shading( 0, 0.5 ); 
    set_character_color_shading( 1, 2.0 );
    set_character_color_shading( 3, 0.0 );
}

//===================================================
//CD Spinning shenanigans
if ("anim_blade_spin" in self)
{
    var tempR = get_color_profile_slot_r(current_color, 2);
    var tempG = get_color_profile_slot_g(current_color, 2);
    var tempB = get_color_profile_slot_b(current_color, 2);
    
    var flashing_sector = (floor(anim_blade_spin % 3)) + 5;
    
    for (var i = 5; i < 8; i++)
    {
        set_character_color_shading( i, (i == flashing_sector ? 1.0 : 0.0));
        set_character_color_slot( i, tempR, tempG, tempB);
        set_article_color_slot( i, tempR, tempG, tempB);
    }
}
//===================================================
//Blinker light
if ("anim_blink_timer" in self)
{
    set_character_color_shading( 4, 
           ease_sineOut(0, 8, floor(anim_blink_timer), anim_blink_timer_max));
}

//===================================================
// Result Screen drawing
// Note: draws behind portrait and result boxes.
if (object_index == asset_get("draw_result_screen"))
{
    //Must check if Hypercam is in front of the portraits
    //Must check if result boxes are open
    //Must track animation timers
    if ("uhc_victory_quote" not in self)
    {
        //Must recover text and clip it
        var end_pos = string_pos("¸", keyboard_string)
        uhc_victory_quote = string_copy(keyboard_string, 1, end_pos);
        
    }
    
    draw_sprite(sprite_get("victory_quote_bg"), 0, -20, 50);
    draw_win_quote(115, 65, uhc_victory_quote);
}
//====================================================

#define draw_win_quote(posx, posy, quote)
{
    var text_scale = 3; //3x3 pixels
    var half_scale = text_scale/2; //font is already 2x2
    var max_line_length = floor(600 / text_scale);
    var line_spacing = 20;
    draw_set_font(asset_get("fName"));
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    //black contour
    for (var i = 0; i < 9; i++)
    {
        if (i != 4) //ignore middle
        {
            var t_x = floor(i/3 - 1) * text_scale;
            var t_y = floor(i%3 - 1) * text_scale;
            draw_text_ext_transformed_color
            (posx + t_x, posy + t_y, quote, line_spacing, max_line_length, 
             half_scale, half_scale, 0, c_black, c_black, c_black, c_black, 1);
        }
    }
    //white text
    draw_text_ext_transformed_color
    (posx, posy, quote, line_spacing, max_line_length, 
     half_scale, half_scale, 0, c_white, c_white, c_white, c_white, 1);
}

