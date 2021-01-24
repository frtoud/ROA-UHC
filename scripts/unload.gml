//==============================================================
//Clean up data structures
if ("uhc_blade_spr_map" in self && ds_map_valid(uhc_blade_spr_map))
{
    ds_map_destroy(uhc_blade_spr_map);
}
//==============================================================
//prevent this from looping in the CSS
if (uhc_taunt_current_video != noone)
{
    sound_stop(uhc_taunt_current_video.song);
}

//==============================================================
//Sending info to result screen
keyboard_string = uhc_victory_quote + "¸";
//==============================================================
