//init_shader.gml
//Update this if color.gml changes
#macro ALT_AIR      1
#macro ALT_GAMEBOY  7
#macro ALT_R2       9
#macro ALT_ROB      10
#macro ALT_WALLE    13
#macro ALT_EVIL     14
#macro ALT_TANK     15

var current_color = get_player_color(player);

//===================================================
//Registered Hypercam 2 gets dark colors & no label
if (current_color == ALT_EVIL) 
{ 
    set_character_color_shading( 0, 0.5 ); 
    set_character_color_shading( 3, 0.0 );
}
//===================================================
// More pronounced shadings
if (current_color == ALT_AIR) 
|| (current_color == ALT_R2) 
|| (current_color == ALT_ROB) 
|| (current_color == ALT_WALLE) 
{ 
    set_character_color_shading( 0, 2.0 );
}
if (current_color == ALT_AIR) 
{ 
    set_character_color_shading( 1, 2.0 );
}

//===================================================
// Monochrome aesthetics
if (current_color == ALT_TANK) || (current_color == ALT_GAMEBOY)
{
    set_character_color_shading( 0, 0.0 );  
    set_character_color_shading( 3, 0.0 );
    
    //Body/Paper ranges adjusted to overlap & only consider value
    set_color_profile_slot_range(0,  25, 15, 40);
    set_color_profile_slot_range(3,  25, 50, 40);
}
else
{
    //need to restore ranges
    set_color_profile_slot_range(0,  2,  2, 36); //Body
    set_color_profile_slot_range(3,  5, 10, 25); //Paper
}

//===================================================
//CD Spinning shenanigans
if ("uhc_anim_blade_spin" in self)
{
    var tempR = get_color_profile_slot_r(current_color, 2);
    var tempG = get_color_profile_slot_g(current_color, 2);
    var tempB = get_color_profile_slot_b(current_color, 2);
    
    var flashing_sector = (floor(uhc_anim_blade_spin % 3)) + 5;
    
    for (var i = 5; i < 8; i++)
    {
        set_character_color_shading( i, (i == flashing_sector ? 1.0 : 0.0));
        set_character_color_slot( i, tempR, tempG, tempB);
        set_article_color_slot( i, tempR, tempG, tempB);
    }
}
//===================================================
//Blinker light
if ("uhc_anim_blinker_shading" in self)
{
    var black_color = c_dkgray;
    var blink_color = make_color_rgb(get_color_profile_slot_r(current_color, 4),
                                     get_color_profile_slot_g(current_color, 4),
                                     get_color_profile_slot_b(current_color, 4));

    var final_color = merge_color(black_color, blink_color, uhc_anim_blinker_shading);
    //must only affect shading of Hypercam's main sprite
    set_character_color_slot( 4, color_get_red(final_color), 
                                 color_get_green(final_color), 
                                 color_get_blue(final_color));
}

//===================================================
// Result Screen drawing
// Note: draws behind portrait and result boxes.
if (object_index == asset_get("draw_result_screen") 
&& (winner == player)) //...only do this when Hypercam's the one in front
{
    //Determine quote
    if ("uhc_victory_quote" not in self)
    {
        var quotes_array = [];
        var quotes_priority = [];
        var quotes_order = [];
        var quotes_teams = [];
        for (var p = 1; p <= 4; p++)
        { 
            //defaults for a player not present
            quotes_priority[p] = 0; 
            quotes_array[p] = "";
        }  
        with asset_get("result_screen_box")
        {
            quotes_order[player] = y;
            quotes_teams[player] = get_player_team(player);
        }
        //Must recover array of text and select best target
        var data_pos = string_pos("uhc{", keyboard_string) + 4; //size of "uhc{"
        
        //crop out anything before the point of interest
        var temp_string = string_copy(keyboard_string, data_pos, 
                                       string_length(keyboard_string) - data_pos);
                                       
        var end_pos = string_pos("}", temp_string); //end of data "}"
        //crop out string of interest
        temp_string = string_copy(temp_string, 0, end_pos);
        
        end_pos = string_pos("¤", temp_string);
        while (end_pos != 0)
        {
            var pl = real(string_char_at(temp_string, 1));
            var pr = real(string_char_at(temp_string, 2));
            quotes_array[pl] = string_copy(temp_string, 3, end_pos - 3);
            quotes_priority[pl] = pr;
            
            //shift to next position
            temp_string = string_delete(temp_string, 1, end_pos);
            end_pos = string_pos("¤", temp_string);
        } //repeat
        
        // Best match:
        // - Self if priority >= 2
        // - not on your team
        // - highest priority
        // - highest ranking
        var best_player = player;
        if !(quotes_priority[player] >= 2)
        {
            for (var p = 1; p <= 4; p++) if is_player_on(p)
            {
                var best_is_on_team = (quotes_teams[best_player] == quotes_teams[player]);
                var not_on_team = (quotes_teams[p] != quotes_teams[player]);
                var higher_ranking = (quotes_order[p] < quotes_order[best_player]);
                var higher_priority = (quotes_priority[p] > quotes_priority[best_player]);
                var same_priority = (quotes_priority[p] == quotes_priority[best_player]);
                
                if (best_is_on_team && not_on_team)
                || (not_on_team && higher_priority)
                || (not_on_team && same_priority && higher_ranking)
                {
                    best_player = p;
                }
            }
        }
        
        uhc_victory_quote = quotes_array[best_player];
        if (string_length(uhc_victory_quote) < 1)
           uhc_victory_quote = get_random_quote();
    }
    
    var quote_pos_y =  50;
    var quote_pos_x = -20;
    var hide_pos_x = -1200;
    var quote_time = 240;
    
    //Animate panel
    if ("quote_current_pos_x" not in self) 
    { quote_current_pos_x = hide_pos_x; }
    else
    {
        //Must check with timing or if result boxes are open
        var diff = ((results_timer > quote_time && !someone_pressed) ? 
                     quote_pos_x : hide_pos_x) - quote_current_pos_x;
        
        quote_current_pos_x += sign(diff) 
                             * max(min(abs(diff), 5), abs(diff) * 0.15);
    }
    
    //Draw panel
    if (quote_current_pos_x > hide_pos_x)
    {
        draw_sprite(sprite_get("victory_quote_bg"), 0, 
                    quote_current_pos_x, quote_pos_y);
        draw_win_quote(quote_current_pos_x+135, quote_pos_y+15, 
                       uhc_victory_quote);
    }
}

//debug version
/*
    {
        draw_sprite(sprite_get("victory_quote_bg"), 0, 
                    200, 200);
        draw_win_quote(200+135, 200+15, 
             //quote = "https://www.latlmes.com/ opinion/free-snes-emulator -no-survey-1"; 
                       "lmaoooooo haahahhashahh he said it he said tit im piickle woodmaaaan!!!!11!!");
    }
    */
//=================================================
// Runs inconditionally; but only once per box
// deletes the smuggled ds_list and sends the contents to the winner display object
// See unload.gml: why doesnt this work?
/*
else if (object_index == asset_get("result_screen_box"))
{
    //var list = get_color_profile_slot_r(0, 8);
    if (ds_list_valid(list))
    {
        with (asset_get("draw_result_screen"))
        {
            uhc_victory_quotes = ds_list_to_array(list);
        }
        ds_list_clear(list);
        ds_list_destroy(list); //Memory leak prevented
    }
}
*/

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

//====================================================
#define get_random_quote()
{
    var quotes = [];
    quotes[3] = "sorry for bad english '^^";
    quotes[2] = "suscribe 4 more fightign combo vids";
    quotes[1] = "Helo yutube an welcome 2 my battle tuotrial";
    quotes[0] = "Thx 4 watchign dont forget to rate 5 stars :)";
    return quotes[(current_time) % array_length(quotes)];
}
