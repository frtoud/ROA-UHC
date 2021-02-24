//draw_hud.gml

if ("vfx_label" not in self) exit;

//===================================================
//Hypercam is filming >:]
if (get_player_color(player) != 14) //Except Unrestrained Alt
{
    draw_sprite(vfx_label, 0, 0, 0);
}
//===================================================
//debug information -- to be made into 
draw_debug_text(temp_x, temp_y, "cd charge %" + string(uhc_current_cd.cd_spin_meter));
draw_debug_text(temp_x, temp_y - 20, "flash charge %" + string(100*uhc_fspecial_charge_current/uhc_fspecial_charge_max));