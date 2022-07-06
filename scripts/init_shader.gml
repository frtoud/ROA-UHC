//init_shader.gml
//Update this if color.gml changes
#macro ALT_AIR      1
#macro ALT_WALLE    5
#macro ALT_GAMEBOY  7
#macro ALT_R2       9
#macro ALT_ROB      10
#macro ALT_JSR      11
#macro ALT_NICO     12
#macro ALT_PAI      13
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
|| (current_color == ALT_NICO) 
|| (current_color == ALT_PAI) 
{ 
    set_character_color_shading( 0, 2.0 );
}
if (current_color == ALT_AIR) 
|| (current_color == ALT_JSR) 
|| (current_color == ALT_PAI) 
{ 
    set_character_color_shading( 1, 2.0 );
}
if (current_color == ALT_R2) && (0x62501C7 == scromble(get_player_name(player)))
{
    if ("uhc_anim_current_color" in self) uhc_anim_current_color = 16;
    apply_color_slot(0, ALT_R2, 3);
    apply_color_slot(2, ALT_R2, 0);
    apply_color_slot(3, ALT_R2, 0);
}

//===================================================
// Monochrome aesthetics
if (current_color == ALT_TANK) 
|| (current_color == ALT_GAMEBOY)
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
    //can be holding a CD from another player
    var tempR = get_color_profile_slot_r(uhc_anim_blade_color, 2);
    var tempG = get_color_profile_slot_g(uhc_anim_blade_color, 2);
    var tempB = get_color_profile_slot_b(uhc_anim_blade_color, 2);
    set_article_color_slot( 2, tempR, tempG, tempB);
    
    var flashing_sector = (floor(uhc_anim_blade_spin % 3)) + 5;
    
    for (var i = 5; i < 8; i++)
    {
        set_character_color_shading( i, (i == flashing_sector ? 1.0 : 0.0));
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
if (object_index == asset_get("draw_result_screen"))
{
    if ("uhc_initialized_victory_screen" not in self)
    {
        uhc_initialized_victory_screen = true;
        //defaults to prevent errors
        uhc_held_cd_color_array = [-1, -1, -1, -1, -1];
        uhc_victory_quote = "win qoute machine broke :(";
        
        //magic happens in there
        get_victory_screen_data();
    }
        
    //held CD could be different than your own; adjusts color of portrait!
    var held_cd_color = uhc_held_cd_color_array[player];
    if (held_cd_color != -1)
    {
        var tempR = get_color_profile_slot_r(held_cd_color, 2);
        var tempG = get_color_profile_slot_g(held_cd_color, 2);
        var tempB = get_color_profile_slot_b(held_cd_color, 2);
        set_character_color_slot( 2, tempR, tempG, tempB);
    }
    
    if (winner == player && uhc_batteries) //...only do the following with the frontmost Hypercam
    {
        //panel constants
        var quote_pos_y =    50;
        var quote_pos_x =   -20;
        var hide_pos_x  = -1200;
        var quote_time  =   240;
        //Animate panel
        if ("uhc_quote_current_pos_x" not in self)
        { uhc_quote_current_pos_x = hide_pos_x; }
        
        //Must check with timing or if result boxes are open
        var diff = ((results_timer > quote_time && !someone_pressed) ? 
                     quote_pos_x : hide_pos_x) - uhc_quote_current_pos_x;
        
        uhc_quote_current_pos_x += sign(diff) 
                                 * max(min(abs(diff), 5), abs(diff) * 0.15);
        
        //Draw panel
        if (uhc_quote_current_pos_x > hide_pos_x)
        {
            draw_sprite(sprite_get("victory_quote_bg"), 0, 
                        uhc_quote_current_pos_x, quote_pos_y);
            draw_win_quote(uhc_quote_current_pos_x+135, quote_pos_y+15, 
                           uhc_victory_quote);
        }
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
            var t_x = floor(i / 3 - 1) * text_scale;
            var t_y = floor(i % 3 - 1) * text_scale;
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
    var i = 0;
    quotes[i++] = "Thx 4 watchign dont forget to rate n subcribe";
    quotes[i++] = "Thx 4 watchign dont forget to rate n subcribe";
    quotes[i++] = "Thx 4 watchign dont forget to rate n subcribe";
    quotes[i++] = "sorry for bad english '^^";
    quotes[i++] = "sorry for bad english '^^";
    quotes[i++] = "suscribe 4 more fightign combo vids";
    quotes[i++] = "suscribe 4 more fightign combo vids";
    quotes[i++] = "Helo yutube an welcome 2 my battle tuotrial";
    quotes[i++] = "come rewatchh da battle with me i hav pop corn";
    quotes[i++] = "wow wut a twist of events vry cool";
    quotes[i++] = "oops w8 ok im recordn now can we remacth";
    quotes[i++] = "omg im so pumpd rite now taht was fun";
    quotes[i++] = "i hope we can collab agian. :)";
    return quotes[(current_time) % array_length(quotes)];
}

//====================================================
#define get_victory_screen_data()
{
    var data_array = noone;
    var data_batteries = true;
    //relies on unload.gml sending over a persistent hitbox with said data
    with (asset_get("pHitBox")) if ("uhc_victory_screen_array" in self)
    {
        data_array = uhc_victory_screen_array;
        data_batteries = uhc_batteries;
        break;
    }
    
    if (data_array == noone) return; // no data :(
    
    uhc_batteries = data_batteries;
    
    //hypercams are maybe holding another blade than their own
    for (var p = 1; p <= 4; p++)
    {
        uhc_held_cd_color_array[p] = data_array[p].held_cd_color;
    }

    //determine who's 2nd, 3rd and 4th by position of their boxes
    with asset_get("result_screen_box")
    {
        data_array[player].order = y;
    }
    
    // Best match:
    // - Self if priority >= 2
    // - not on your team
    // - highest priority
    // - highest ranking
    
    
    if (string_length(data_array[winner].status_quote) > 1)
    {
        //Status messages always take precedence for winner Hypercam
        uhc_victory_quote = data_array[winner].status_quote;
    }
    else
    {
        var best_player = winner;
        var winning_team = data_array[winner].team;
        var best_is_on_team = true;
        
        for (var p = 1; p <= 4; p++) if is_player_on(p)
        {
            var best = data_array[best_player];
            var curr = data_array[p];
            
            var not_on_team = (curr.team != winning_team);
            var higher_ranking = (curr.order < best.order);
            var higher_priority = (curr.priority > best.priority);
            var same_priority = (curr.priority == best.priority);
            
            if (best_is_on_team && not_on_team)
            || (not_on_team && higher_priority)
            || (not_on_team && same_priority && higher_ranking)
            {
                best_player = p;
                best_is_on_team = (best.team == winning_team);
            }
        }

        uhc_victory_quote = data_array[best_player].quote;
        if (string_length(uhc_victory_quote) < 1)
        { uhc_victory_quote = get_random_quote(); }
    }
    
}

#define apply_color_slot(target_shade, source_color, source_shade)
{
   set_character_color_slot(target_shade,  
        get_color_profile_slot_r(source_color, source_shade),  
        get_color_profile_slot_g(source_color, source_shade),
        get_color_profile_slot_b(source_color, source_shade), 1);
   set_article_color_slot(target_shade,  
        get_color_profile_slot_r(source_color, source_shade),  
        get_color_profile_slot_g(source_color, source_shade),
        get_color_profile_slot_b(source_color, source_shade), 1);
}

#define scromble(text)
{
    //thx adlr
    var A = 1; var B = 0;
    for (var i = 0; i < string_length(text); i++) 
    {
        A += string_ord_at(text, i+1); A %= 0xFFF1;
        B += A;                        B %= 0xFFF1;

    }
    return A + (B << 16);
}