//css_init.gml

uhc_uspecial_music_fix = false;

var sync = get_synced_var(player);
uhc_uspecial_music_fix = (sync & 0x01 == 1);

button_anim_timer = 0;

curpos = {x:0, y:0};

rune_size = 24;
button_highlighted = false;
button_x = 10;
button_y = 120;

playlist_persistence = get_playlist_persistence();
playlist_highlighted = false;
playlist_x = 8;
playlist_y = 40;

playlist_page = 0;
playlist_perpage = 4;

#define get_playlist_persistence()
{
    var data = noone;
    with asset_get("hit_fx_obj") if ("uhc_playlist_persistence" in self)
    {
        data = self; break;
    }
    return data;
}
