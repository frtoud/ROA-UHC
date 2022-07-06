//other_post_draw.gml
if (results_timer < 5) exit; //giik pls

// Note: draws behind portrait and result boxes.
if ("uhc_initialized_victory_screen" not in self)
{
    uhc_initialized_victory_screen = true;
    //defaults to prevent errors
    uhc_held_cd_color_array = [-1, -1, -1, -1, -1];
    uhc_victory_quote = "win qoute machine broke :(";
    
    //magic happens in there
    get_victory_screen_data();
}

//...only do the following with the frontmost Hypercam
if (winner == player && uhc_batteries)
{
    //held CD could be different than your own; adjusts color of portrait!
    win_cd_color = uhc_held_cd_color_array[player];

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
                                * max(min(abs(diff), 5), abs(diff) * 0.25);
    
    //Draw panel
    if (uhc_quote_current_pos_x > hide_pos_x)
    {
        draw_sprite(sprite_get("victory_quote_bg"), 0, 
                    uhc_quote_current_pos_x, quote_pos_y);
        draw_win_quote(uhc_quote_current_pos_x+135, quote_pos_y+15, 
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

