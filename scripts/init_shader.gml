//init_shader.gml
//Update this if color.gml changes
#macro ALT_AIR      1
#macro ALT_WALLE    5
#macro ALT_GAMEBOY  7
#macro ALT_R2       9
#macro ALT_ROB      10
#macro ALT_JSR      11
#macro ALT_NICO     12
#macro ALT_PAI      13
#macro ALT_EVIL     14
#macro ALT_TANK     15

var current_color = get_player_color(player);

//===================================================
//Registered Hypercam 2 gets dark colors & no label
if (current_color == ALT_EVIL) 
{ 
    set_character_color_shading( 0, 0.5 ); 
    set_character_color_shading( 3, 0.0 );
}
//===================================================
// More pronounced shadings
if (current_color == ALT_AIR) 
|| (current_color == ALT_R2) 
|| (current_color == ALT_ROB) 
|| (current_color == ALT_WALLE) 
|| (current_color == ALT_NICO) 
|| (current_color == ALT_PAI) 
{ 
    set_character_color_shading( 0, 2.0 );
}
if (current_color == ALT_AIR) 
|| (current_color == ALT_JSR) 
|| (current_color == ALT_PAI) 
{ 
    set_character_color_shading( 1, 2.0 );
}
if (current_color == ALT_R2) && (0x62501C7 == scromble(get_player_name(player)))
{
    if ("uhc_anim_current_color" in self) uhc_anim_current_color = 16;
    apply_color_slot(0, ALT_R2, 3);
    apply_color_slot(2, ALT_R2, 0);
    apply_color_slot(3, ALT_R2, 0);
}

//===================================================
// Monochrome aesthetics
if (current_color == ALT_TANK) 
|| (current_color == ALT_GAMEBOY)
{
    set_character_color_shading( 0, 0.0 );  
    set_character_color_shading( 3, 0.0 );
    
    //Body/Paper ranges adjusted to overlap & only consider value
    set_color_profile_slot_range(0,  25, 15, 40);
    set_color_profile_slot_range(3,  25, 50, 40);
}
else
{
    //need to restore ranges
    set_color_profile_slot_range(0,  2,  2, 36); //Body
    set_color_profile_slot_range(3,  5, 10, 25); //Paper
}

//===================================================
//CD Spinning shenanigans
if ("uhc_anim_blade_spin" in self)
{
    //can be holding a CD from another player
    var tempR = get_color_profile_slot_r(uhc_anim_blade_color, 2);
    var tempG = get_color_profile_slot_g(uhc_anim_blade_color, 2);
    var tempB = get_color_profile_slot_b(uhc_anim_blade_color, 2);
    set_article_color_slot( 2, tempR, tempG, tempB);
    
    var flashing_sector = (floor(uhc_anim_blade_spin % 3)) + 5;
    
    for (var i = 5; i < 8; i++)
    {
        set_character_color_shading( i, (i == flashing_sector ? 1.0 : 0.0));
        set_article_color_slot( i, tempR, tempG, tempB);
    }
}
//===================================================
//Blinker light
if ("uhc_anim_blinker_shading" in self)
{
    var black_color = c_dkgray;
    var blink_color = make_color_rgb(get_color_profile_slot_r(current_color, 4),
                                     get_color_profile_slot_g(current_color, 4),
                                     get_color_profile_slot_b(current_color, 4));

    var final_color = merge_color(black_color, blink_color, uhc_anim_blinker_shading);
    //must only affect shading of Hypercam's main sprite
    set_character_color_slot( 4, color_get_red(final_color), 
                                 color_get_green(final_color), 
                                 color_get_blue(final_color));
}

//===================================================
// Win screen alternate CD
if ("win_cd_color" in self) && (win_cd_color != -1)
{
    var tempR = get_color_profile_slot_r(win_cd_color, 2);
    var tempG = get_color_profile_slot_g(win_cd_color, 2);
    var tempB = get_color_profile_slot_b(win_cd_color, 2);
    set_character_color_slot( 2, tempR, tempG, tempB);
}

//===================================================
#define apply_color_slot(target_shade, source_color, source_shade)
{
   set_character_color_slot(target_shade,  
        get_color_profile_slot_r(source_color, source_shade),  
        get_color_profile_slot_g(source_color, source_shade),
        get_color_profile_slot_b(source_color, source_shade), 1);
   set_article_color_slot(target_shade,  
        get_color_profile_slot_r(source_color, source_shade),  
        get_color_profile_slot_g(source_color, source_shade),
        get_color_profile_slot_b(source_color, source_shade), 1);
}

//===================================================
#define scromble(text)
{
    //thx adlr
    var A = 1; var B = 0;
    for (var i = 0; i < string_length(text); i++) 
    {
        A += string_ord_at(text, i+1); A %= 0xFFF1;
        B += A;                        B %= 0xFFF1;

    }
    return A + (B << 16);
}