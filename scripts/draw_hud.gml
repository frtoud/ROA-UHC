//draw_hud.gml

if ("vfx_label" not in self) exit;

//===================================================
//Hypercam is filming >:]
if (get_player_color(player) != 14) //Except Unrestrained Alt
{
    draw_sprite(vfx_label, 0, 0, 0);
}
//===================================================