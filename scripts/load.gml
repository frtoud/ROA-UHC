
//Setup blade sprites mapping
//each sprite that has a blade gets its *_blade sprite registered in there
//use sprite_change_offset_bladed("spr", x, y); as usual (big hurtbox assumed true)
if ("hsp" in self) //prevents error in workshop menu
{
    uhc_blade_spr_map = ds_map_create();
}

sprite_change_offset_bladed("idle", 19, 27);
sprite_change_offset_bladed("hurt", 15, 23);
sprite_change_offset_bladed("spinhurt", 21, 31);
sprite_change_offset_bladed("crouch", 20, 22);
sprite_change_offset_bladed("walk", 18, 25);
sprite_change_offset_bladed("walkturn", 17, 24);
sprite_change_offset_bladed("dash", 18, 22);
sprite_change_offset_bladed("dashstart", 18, 23);
sprite_change_offset_bladed("dashstop", 18, 24);
sprite_change_offset_bladed("dashturn", 18, 22);

sprite_change_offset_bladed("jumpstart", 17, 24);
sprite_change_offset_bladed("jump", 21, 31);
sprite_change_offset_bladed("doublejump", 19, 30);
sprite_change_offset_bladed("doublejump_back", 19, 31);
 sprite_change_offset("walljump", 16, 31);
sprite_change_offset_bladed("pratfall", 15, 30);
sprite_change_offset_bladed("land", 19, 26);
sprite_change_offset_bladed("landinglag", 19, 26);

sprite_change_offset_bladed("parry", 15, 23);
sprite_change_offset_bladed("roll_forward", 18, 27);
 sprite_change_offset("roll_backward", 16, 31);
sprite_change_offset_bladed("airdodge", 22, 26);
sprite_change_offset_bladed("waveland", 19, 26);
sprite_change_offset_bladed("tech", 18, 25);

sprite_change_offset_bladed("jab", 19, 25);
sprite_change_offset("jab_legs", 19, 25);
sprite_change_offset_bladed("dattack", 20, 24);
sprite_change_offset_bladed("ftilt", 21, 32);
sprite_change_offset_bladed("dtilt", 20, 20);
 sprite_change_offset("utilt", 32, 47, true);
sprite_change_offset_bladed("nair", 21, 31);
 sprite_change_offset("fair", 26, 44, true);
 sprite_change_offset("bair", 44, 25, true);
 sprite_change_offset("uair", 32, 47, true);
 sprite_change_offset("dair", 18, 27, true);

sprite_change_offset_bladed("fstrong", 17, 24);
sprite_change_offset_bladed("ustrong", 16, 64);
sprite_change_offset_bladed("dstrong", 32, 24);
sprite_change_offset_bladed("fstrong_air", 17, 24);
sprite_change_offset_bladed("ustrong_air", 19, 64);
sprite_change_offset_bladed("dstrong_air", 19, 29);

 sprite_change_offset("nspecial", 20, 21, true);
sprite_change_offset_bladed("fspecial", 17, 23);
sprite_change_offset_bladed("fspecial_air", 20, 27);
sprite_change_offset_bladed("uspecial", 19, 30);
sprite_change_offset_bladed("dspecial", 19, 49);
sprite_change_offset_bladed("dspecial_air", 19, 50);
sprite_change_offset_bladed("taunt", 22, 22);

 sprite_change_offset("plat", 32, 47);

sprite_change_offset("proj_star", 9, 11);

sprite_change_offset("article_cd_idle", 19, 18);
sprite_change_offset("article_cd_idle2", 17, 16);
sprite_change_offset("article_cd_idle3", 19, 10);
sprite_change_offset("article_cd_dstrong", 37, 16);
sprite_change_offset("article_cd_shoot", 19, 19);
sprite_change_offset("article_cd_mask", 19, 19);
sprite_change_collision_mask("article_cd_mask", false, 0, noone, noone, noone, noone, 1);

sprite_change_offset("vfx_buffering", 12, 12);
sprite_change_offset("vfx_mini_buffering", 5, 5);
sprite_change_offset("vfx_flash_charge", -1, 21);
sprite_change_offset("vfx_flash_small", 0, 24);
sprite_change_offset("vfx_flash_medium", 0, 53);
sprite_change_offset("vfx_flash_large", 0, 107);

sprite_change_offset("hud_icons", 3, -1);

// See init::add_uhc_video() for the generalized version
// sprite_change_offset("video_blocked", 11, 8);

set_victory_theme(sound_get("victory"));
set_victory_bg(sprite_get("victory"));

//=================================================
// DEFINES
#define sprite_change_offset_bladed(_spr_name, _offset_x, _offset_y)
var _bladed_name = _spr_name + "_blade";
sprite_change_offset(_spr_name, _offset_x, _offset_y, true);
if ("uhc_blade_spr_map" in self)
{
   ds_map_set(uhc_blade_spr_map, sprite_get(_spr_name), sprite_get(_bladed_name));
   sprite_change_offset(_bladed_name, _offset_x, _offset_y);
}

