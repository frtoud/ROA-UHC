//draw_hud.gml

if ("vfx_label" not in self) exit;

//===================================================
//Hypercam is filming >:]
if (get_player_color(player) != 14) //Except Unrestrained Alt
{
    draw_sprite(vfx_label, 0, 0, 0);
}
//===================================================
//debug information -- to be made into meters
draw_debug_text(temp_x, temp_y, "cd charge %" + string(uhc_current_cd.cd_spin_meter));
draw_debug_text(temp_x, temp_y - 20, "flash charge %" + string(100*uhc_fspecial_charge_current/uhc_fspecial_charge_max));


if (uhc_unsafe_screenshot_time > 0 && current_time - uhc_unsafe_screenshot_time < 2000)
{
    draw_debug_text(x, y, "screenshot saved");
}