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


//==========================================================
//unsafe update code
//(Should only be involved in rendering)
var screenshot = uhc_unsafe_screenshot;

if (screenshot.sfx_time > 0)
&& (screenshot.sfx_time < current_time)
{
    sound_play(sound_get("sfx_steam_screenshot"));
    screenshot.sfx_time = -1;
}

if (screenshot.target != noone > 0 && instance_exists(screenshot.target))
&& (screenshot.end_time > current_time)
{
    //size of popup: 240x74
    var popup_up = 466;
    var popup_down = 540;
    var popup_x = 720;
    var popup_y = popup_up;
    if (current_time < screenshot.rise_time)
    {
        popup_y = ease_linear(popup_down, popup_up, 
                              current_time - screenshot.start_time, 
                              screenshot.rise_time - screenshot.start_time);
    }
    else if (current_time > screenshot.fall_time)
    {
        popup_y = ease_linear(popup_up, popup_down, 
                              screenshot.fall_time - current_time, 
                              screenshot.fall_time - screenshot.end_time);
    }

    //back of popup
    draw_sprite_ext(vfx_screenshot_tab, 1, popup_x, popup_y, 1, 1, 0, get_player_hud_color(screenshot.target.player), 1);
    
    //size of screenshot area: 85x47
    //position: x+14 y+14
    //redraw target within this box
    with (screenshot.target)
    {
        shader_start();
        var scale = 1 + small_sprites;
        draw_sprite_part_ext(screenshot.sprite, screenshot.image, 
            screenshot.spr_left, screenshot.spr_top, 85/scale, 47/scale, 
            popup_x + (screenshot.spr_dir > 0 ? 14 : 85+14), popup_y + 14, 
            screenshot.spr_dir * scale, scale, c_white, 1.0);
        shader_end();
    }
    
    //front of popup
    draw_sprite(vfx_screenshot_tab, 0, popup_x, popup_y);
}



