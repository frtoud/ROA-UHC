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

