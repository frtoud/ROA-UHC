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
    draw_set_colour(c_white);
    draw_rectangle_color(0, 60, 300, 180, c_white, c_white, c_white, c_white, false);
    draw_debug_text(40, 80, "'lol gottem gg'");
}


