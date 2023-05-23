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

var num_vids = array_length(playlist_persistence.playlist);
if instance_exists(playlist_persistence) && (num_vids > 0)
{
    var real_playlist_x = floor(x + playlist_x);
    var real_playlist_y = floor(y + playlist_y);
    draw_sprite_ext(sprite_get("vfx_playlist_icon"), 0, real_playlist_x, real_playlist_y, 2, 2, 0, c_white, 1);
    draw_debug_text(real_playlist_x+24, real_playlist_y+6, string(array_length(playlist_persistence.playlist))); 

    if (playlist_highlighted)
    {
        real_playlist_x += 48;
        real_playlist_y -= 193;

        //bg
        draw_sprite(sprite_get("vfx_playlist_bg"), 0, real_playlist_x - 58, real_playlist_y - 20);

        for (var i = 0; i < playlist_perpage && (i + playlist_page * playlist_perpage) < num_vids; i++)
        {
            var yoffset = i * 36 - 4;
            var viddata = playlist_persistence.playlist[(i + playlist_page * playlist_perpage)];
            //inconsistent issues because sprite offset is set in load.gml, but draw_sprite_part_ext does not care >:]
            draw_sprite_part_ext(sprite_get(viddata.spritename), 4, 0, 0, 22, 16,
                        real_playlist_x - 52, real_playlist_y + yoffset - 10, 2, 2, c_white, 1);
            var substr = string(viddata.title);
            if (string_length(substr) > 22)
            {
                substr = string_copy(substr, 0, 19) + "...";
            }
            draw_debug_text(real_playlist_x, real_playlist_y + yoffset, substr); 
        }
        
        draw_debug_text(real_playlist_x - 38, real_playlist_y + 135, "my playlst"); 
        draw_debug_text(real_playlist_x + 88, real_playlist_y + 135, 
                        "Page "+string(playlist_page+1)+"/"+ string(ceil(num_vids / playlist_perpage))); 
    }
}

exit;
{
    var i = 0;
    {
        repeat 0 //(array_length(playlist_persistence.playlist)) 
        {
            
            draw_sprite_ext(sprite_get(playlist_persistence.playlist[i].spritename), 0, real_playlist_x - 30, real_playlist_y+i*16, 2, 2, 0, c_white, 1);
            i++;
        }
    }
    
}
