//draw_hud.gml
if ("vfx_label" not in self) exit;

//===================================================
//Hypercam is filming >:]
if (get_player_color(player) != 14) //Except Unrestrained Alt
{
    draw_sprite(vfx_label, 0, 0, 0);
}
//===================================================
// HUD meters
#macro ICON_BAR     0
#macro ICON_MARKER  1
// Red variants: +1
#macro ICON_BACK    2
#macro ICON_PAUSE   4
#macro ICON_PLAY    6
#macro ICON_STAR    8
// Base, +1, +2
#macro ICON_SOUND  10
// Base, up to +7
#macro ICON_BUFFER 13

// uspecial buffering gag
var uspecial_bufferring = (state == PS_ATTACK_AIR && attack == AT_USPECIAL && window == 3)
                       || (uhc_uspecial_soft_cooldown > 0);

// uhc_recalling_cd takes precedence if it exists
var tracked_cd = uhc_dspecial_is_recalling ? uhc_recalling_cd : uhc_current_cd;
// Main bar
var bar_x = -8;
var bar_y = -24;
draw_sprite_ext(vfx_hud_bar, 0, temp_x + bar_x, temp_y + bar_y, 2, 2, 0, c_white, 1);
shader_start();

// Charge status
//note: video plays forwards as CD unwinds, uncharged = fully red
var bar_width = 164;
var bar_start_x = 22;
if (uhc_has_cd_blade || instance_exists(tracked_cd))
{
    var displayed_meter = tracked_cd.cd_spin_meter;
    if (uspecial_bufferring) { displayed_meter = uhc_anim_frozen_meter; }
    else                     { uhc_anim_frozen_meter = displayed_meter; }

    var marker_pos = max(0, 1.0 - displayed_meter/uhc_cd_spin_max) * (bar_width - 10);
    draw_sprite_stretched(vfx_hud_icons, ICON_BAR, temp_x + bar_start_x, temp_y + bar_y + 2, marker_pos, 18);
    draw_sprite_ext(vfx_hud_ad, 0, temp_x + bar_start_x + (bar_width*(1 - uhc_cd_spin_effective_max)), temp_y + bar_y, 2, 2, 0, c_white, 1);
    draw_sprite_ext(vfx_hud_icons, ICON_MARKER, temp_x + bar_start_x + 2 + marker_pos, temp_y + bar_y, 2, 2, 0, c_white, 1);
}
else
{
    var marker_pos = ((uhc_anim_buffer_timer/uhc_cd_respawn_timer_max) ) * (bar_width);
    draw_sprite_stretched_ext(vfx_hud_icons, ICON_BAR, temp_x + bar_start_x, temp_y + bar_y + 2, marker_pos, 18, c_gray, 1);
    draw_sprite_ext(vfx_hud_icons, ICON_MARKER, temp_x + bar_start_x + 2, temp_y + bar_y, 2, 2, 0, c_white, 1);
}

// Rating status
var star_x = 128;
var star_y = -10;
for (var i = 0; i <= uhc_nspecial_charges_max; i++)
{
    draw_sprite_ext(vfx_hud_icons, ICON_STAR + (uhc_nspecial_charges >= i), 
                    temp_x + star_x + i*18, temp_y + star_y, 2, 2, 0, c_white, 1);
}

// Blade status
var play_pos_x = 2;
var play_icon = ICON_PLAY;
if (uspecial_bufferring)
{
    play_icon = ICON_BUFFER + floor(get_gameplay_time() / 12) % 8;
}
else if (uhc_has_cd_blade)
{
   if (uhc_anim_rewind.active) { play_icon = ICON_BACK; }
   else if (uhc_no_charging) { play_icon = ICON_PAUSE; }
   else { play_icon = ICON_PLAY; }
}
else if (instance_exists(tracked_cd))
{
   if (tracked_cd.state == AT_DSPECIAL) { play_icon = ICON_BACK + 1; }
   else if (tracked_cd.state == 1) { play_icon = ICON_PAUSE + 1; } //idle
   else if (tracked_cd.state != 0) { play_icon = ICON_PLAY + 1; } //attacking
   else if (tracked_cd.buffered_state != -1) { play_icon = ICON_PLAY + 1; } //about to attack
   else { play_icon = ICON_PAUSE; } //dead
}
else if (!uhc_cd_can_respawn)
{
    play_icon = ICON_BUFFER + floor(get_gameplay_time() / 4) % 8;
}
draw_sprite_ext(vfx_hud_icons, play_icon, temp_x + play_pos_x, temp_y + bar_y, 2, 2, 0, c_white, 1);

// Flash status
var sound_pos_x = bar_width + bar_start_x + 12;
var sound_icon = ICON_SOUND;
if (uhc_fspecial_charge_current >= uhc_fspecial_charge_max) 
{ sound_icon += 2;}
else if (uhc_fspecial_charge_current >= uhc_fspecial_charge_half) 
{ sound_icon += 1;}
draw_sprite_ext(vfx_hud_icons, sound_icon, temp_x + sound_pos_x, temp_y + bar_y, 2, 2, 0, c_white, 1);

shader_end();

//Video title
if (uhc_taunt_current_video != noone)
{
    var valign = draw_get_valign();
    draw_set_valign(fa_bottom);
    textDraw(temp_x - 4, temp_y - 24, "fName", c_white, 18, 220, fa_left, fa_bottom, 1, true, 1, uhc_taunt_current_video.title)
}
//Spin % display
else if (get_match_setting(SET_HITBOX_VIS)) && instance_exists(tracked_cd)
{
    var charge_percent = (tracked_cd.cd_spin_meter / uhc_cd_spin_max);
    charge_percent = min(1, charge_percent / uhc_cd_spin_effective_max);
        
    draw_debug_text(temp_x + 8, temp_y - 32, "Spin Bonuses: " + string(floor(charge_percent * 100)) + "%");
}

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




//=====================================================================
#define textDraw(x1, y1, font, color, line_sep, line_max, halign, valign, scale, outlined, alpha, text)
// Draw text at position x1, y1, using scale, alpha, align, font and color.
// line_sep is the vertical separation between text.
// line_max is the maximum length for a line of text.
// if outlined is TRUE, draws a 2px black contour.
//=====================================================================
{
    x1 = round(x1);
    y1 = round(y1);

    old_font = draw_get_font();
    old_hal = draw_get_halign();
    old_val = draw_get_valign();

    draw_set_font(asset_get(font));
    draw_set_halign(halign);
    draw_set_valign(valign);

    if (outlined)
    {
        for (var i = -1; i < 2; i++) 
        {
            for (var j = -1; j < 2; j++) 
            {
                draw_text_ext_transformed_color(x1 + i * 2, y1 + j * 2, text, 
                    line_sep, line_max, scale, scale, 0, c_black, c_black, c_black, c_black, alpha);
            }
        }
    }

    if (alpha > 0.01) 
        draw_text_ext_transformed_color(x1, y1, text, line_sep, line_max, 
                    scale, scale, 0, color, color, color, color, alpha);

     draw_set_font(old_font);
     draw_set_halign(old_hal);
     draw_set_valign(old_val);
}
//=====================================================================