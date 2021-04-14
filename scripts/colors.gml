//DEFAULT COLOR (R,G,B)

//RGB - HSV
//121:132:159 - 222: 23: 62
// 93:102:122 - 221: 23: 47
// 55: 60: 72 - 222: 23: 28 - Main color
// 37: 40: 48 - 223: 22: 18
// 22: 24: 29 - 222: 24: 11
set_color_profile_slot(0, 0,  55,  60,  72); //Body
set_color_profile_slot_range(0,  2,  2, 36);

//RGB - HSV
//195:195:219 - 240: 10: 85
//118:118:158 - 240: 25: 61
// 86: 86:127 - 240: 32: 49
// 60: 60:109 - 240: 44: 42 - Main color
// 45: 45: 86 - 240: 47: 33
// 28: 28: 68 - 240: 58: 26
// 17: 17: 38 - 240: 55: 14
set_color_profile_slot(0, 1,  60,  60, 109); //Lens
set_color_profile_slot_range(1,  1, 36, 44);

//RGB - HSV
//209:199:192 -  24:  8: 81
//199:178:133 -  40: 33: 78
//160:145:130 -  30: 18: 62 - Main color
//117:106: 75 -  44: 35: 45
set_color_profile_slot(0, 2, 160, 145, 130); //CD
set_color_profile_slot_range(2, 15, 20, 20);

//RGB - HSV
//232:237:239 - 197:  2: 93
//158:171:178 - 201: 11: 69 - Main color
set_color_profile_slot(0, 3, 158, 171, 178); //Paper
set_color_profile_slot_range(3,  5, 10, 25);

//RGB - HSV
//255: 25: 25 -   0: 90:100 - Main color
//232: 34: 34 -   0: 85: 90
//211:  0:  0 -   0:100: 82
set_color_profile_slot(0, 4, 255,  25,  25); //Blinker light (Red)
set_color_profile_slot_range(4,  1, 12, 50);

//==============================================================
//Technical shades
// For use by shaders only to create spin effect
// No visible influence for alts

//RGB - HSV
//117:255: 63 - 103: 75:100
//  8:242:  0 - 118:100: 94
// 68:204: 30 - 107: 85: 80 - "Main" color
set_color_profile_slot(0, 5,  68, 204,  30); //CD Spin 1 (Green)
set_color_profile_slot_range(5, 16, 16, 22);

//RGB - HSV
//207: 63:255 - 285: 75:100
//239:  0:239 - 300:100: 94
//169: 30:204 - 289: 85: 80 - "Main" color
set_color_profile_slot(0, 6, 169,  30, 204); //CD Spin 2 (Pink)
set_color_profile_slot_range(6, 16, 16, 22);

//RGB - HSV
// 63:111:255 - 225: 75:100
//  0:  0:239 - 240:100: 94
// 30: 62:204 - 229: 85: 80 - "Main" color
set_color_profile_slot(0, 7,  30,  62, 204); //CD Spin 3 (Blue)
set_color_profile_slot_range(7, 16, 16, 22);
//==============================================================

set_num_palettes(16);

// Unbeatable
set_color_profile_slot(1, 0,  45,  64, 190); //Body -- needs shading x2.0
set_color_profile_slot(1, 1, 235, 210,  64); //Lens -- needs shading x2.0
set_color_profile_slot(1, 2,  75, 205, 230); //CD
set_color_profile_slot(1, 3, 210, 170,  10); //Paper
set_color_profile_slot(1, 4, 255,  25,  25); //Blinker

// Nice
set_color_profile_slot(3, 0, 110,  50,  35); //Body
set_color_profile_slot(3, 1, 120, 150, 115); //Lens
set_color_profile_slot(3, 2,  25,  90,  25); //CD
set_color_profile_slot(3, 3, 200, 150,   0); //Paper
set_color_profile_slot(3, 4, 255,  25,  25); //Blinker

// Terebii Chan
set_color_profile_slot(4, 0, 190, 190, 190); //Body
set_color_profile_slot(4, 1, 140, 140, 140); //Lens
set_color_profile_slot(4, 2, 230, 170, 170); //CD
set_color_profile_slot(4, 3, 230, 170, 170); //Paper
set_color_profile_slot(4, 4, 255,  25,  25); //Blinker

// Abyss
set_color_profile_slot(6, 0,  80,  48,  75); //Body
set_color_profile_slot(6, 1, 201,  63, 193); //Lens
set_color_profile_slot(6, 2,  78,  23, 141); //CD
set_color_profile_slot(6, 3, 201,  63, 193); //Paper
set_color_profile_slot(6, 4, 201,  63, 193); //Blinker 

// Gameboy -- needs Monochrome shading
set_color_profile_slot(7, 0,  83, 122,  62); //Body
set_color_profile_slot(7, 1, 211, 226, 154); //Lens
set_color_profile_slot(7, 2,  96, 122,  82); //CD
set_color_profile_slot(7, 3, 211, 226, 154); //Paper
set_color_profile_slot(7, 4, 211, 226, 154); //Blinker 

// Astrodroid
set_color_profile_slot(9, 0, 200, 200, 200); //Body -- needs shading x2.0
set_color_profile_slot(9, 1,  45,  45,  45); //Lens
set_color_profile_slot(9, 2,  50,  64, 150); //CD
set_color_profile_slot(9, 3,  45,  35, 145); //Paper
set_color_profile_slot(9, 4, 255,  25,  25); //Blinker

// Famicom
set_color_profile_slot(10, 0, 165, 160, 140); //Body -- needs shading x2.0
set_color_profile_slot(10, 1,  77,  77, 140); //Lens
set_color_profile_slot(10, 2, 153,  70,  66); //CD
set_color_profile_slot(10, 3, 122,  45,  45); //Paper
set_color_profile_slot(10, 4,  25, 255, 255); //Blinker 

// Motherload/Halo
set_color_profile_slot(12, 0,  88,  94,  75); //Body
set_color_profile_slot(12, 1, 196, 175,  96); //Lens
set_color_profile_slot(12, 2,  45,  45,  45); //CD
set_color_profile_slot(12, 3,   0,   0,   0); //Paper
set_color_profile_slot(12, 4, 255,  25,  25); //Blinker 

// Wall-E
set_color_profile_slot(13, 0, 173, 120,  30); //Body -- needs shading x2.0
set_color_profile_slot(13, 1,  88,  96,  96); //Lens
set_color_profile_slot(13, 2, 150, 148, 128); //CD
set_color_profile_slot(13, 3,  82,  80,  72); //Paper
set_color_profile_slot(13, 4, 255,  25,  25); //Blinker 

// Unrestrained
set_color_profile_slot(14, 0,  40,  40,  40); //Body -- needs shading x0.5
set_color_profile_slot(14, 1, 255,  25,  35); //Lens
set_color_profile_slot(14, 2,  45,  45,  45); //CD
set_color_profile_slot(14, 3,  65,  65,  65); //Paper -- needs shading x0.0
set_color_profile_slot(14, 4, 255,  25,  25); //Blinker

// Tankmen -- needs Monochrome shading
set_color_profile_slot(15, 0,   0,   0,   0); //Body
set_color_profile_slot(15, 1, 255, 255, 255); //Lens
set_color_profile_slot(15, 2, 250, 180,  10); //CD
set_color_profile_slot(15, 3, 255, 255, 255); //Paper
set_color_profile_slot(15, 4, 255, 255, 255); //Blinker 
