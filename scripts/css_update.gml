//css_update.gml

if ("button_anim_timer" not in self) exit;
if !instance_exists(cursor_id) exit; //giik pls

var curpos = { x:get_instance_x(cursor_id), y:get_instance_y(cursor_id) };

var real_button_x = x + button_x;
var real_button_y = y + button_y;
if (get_match_setting(SET_RUNES) || get_match_setting(SET_TEAMS) )
{
    real_button_y -= rune_size;
}

var new_highlighted = (curpos.x > real_button_x) && (curpos.x < real_button_x + 32)
                   && (curpos.y > real_button_y) && (curpos.y < real_button_y + 32);

if (!button_highlighted && new_highlighted)
{
    //just entered button zone
    if (button_anim_timer == 0) && !uhc_uspecial_music_fix
        sound_play(sound_get("sfx_popup"));
}

if (new_highlighted)
{
    suppress_cursor = true;
    
    if (button_anim_timer == 0) && (menu_a_pressed) //clicked
    {
        sound_play(sound_get("sfx_click"));
        uhc_uspecial_music_fix = !uhc_uspecial_music_fix;
        button_anim_timer = 24;
    }
}

button_highlighted = new_highlighted; //saved for next frame

//animation timers
if (button_anim_timer > 0)
{
    button_anim_timer--;
    if (button_anim_timer == 0)
        sound_play(uhc_uspecial_music_fix ? asset_get("mfx_star") : sound_get("sfx_warn") );
}

if instance_exists(playlist_persistence) && (array_length(playlist_persistence.playlist) > 0)
{
    var real_playlist_x = floor(x + playlist_x);
    var real_playlist_y = floor(y + playlist_y);

    var new_highlighted = (curpos.x > real_playlist_x) && (curpos.x < real_playlist_x + 24)
                       && (curpos.y > real_playlist_y) && (curpos.y < real_playlist_y + 16);
    
    if (playlist_highlighted != new_highlighted)
    {
        sound_play(sound_get("sfx_popup"), false, noone, 1, new_highlighted ? 1.1 : 0.8);
    }

    playlist_highlighted = new_highlighted; //saved for next frame

    if (playlist_highlighted)
    {
        suppress_cursor = true;
        
        if (menu_a_pressed) //clicked
        {
            sound_play(sound_get("sfx_click"));
            //changes page
            var num_vids = array_length(playlist_persistence.playlist);
            playlist_page++;
            if (playlist_page >= ceil(num_vids / playlist_perpage))
            {
                playlist_page = 0;
            }
        }
    }
}

//update synced variable
//bit structure: 00000000 00000000 00000000 00000000
//USPECIAL buffer audio                            X
//Playlist unlocks                 XXXXXXXX XXXX    
var v = 0;
v |= (uhc_uspecial_music_fix ? 1 : 0);
if instance_exists(playlist_persistence) 
    v |= (playlist_persistence.playlist_bits << 4);

set_synced_var(player, v);