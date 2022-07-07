//css_update.gml

if ("button_anim_timer" not in self) exit;

var curpos = { x:get_instance_x(cursor_id), y:get_instance_y(cursor_id) };

var real_button_x = x + button_x;
var real_button_y = y + button_y + (get_match_setting(SET_RUNES) ? -rune_size : 0);

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
        set_synced_var(player, uhc_uspecial_music_fix);
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