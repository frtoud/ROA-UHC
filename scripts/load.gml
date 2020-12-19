
//Setup blade sprites mapping
//each sprite that has a blade gets its *_blade sprite registered in there
//use sprite_change_offset_bladed("spr", x, y); as usual 
uhc_blade_spr_map = ds_map_create();

sprite_change_offset_bladed("idle", 38, 54);
sprite_change_offset("hurt", 32, 62);
sprite_change_offset_bladed("crouch", 40, 44);
sprite_change_offset_bladed("walk", 36, 50);
sprite_change_offset_bladed("walkturn", 34, 48);
sprite_change_offset("dash", 32, 62);
sprite_change_offset("dashstart", 32, 62);
sprite_change_offset("dashstop", 32, 62);
sprite_change_offset("dashturn", 32, 62);

sprite_change_offset_bladed("jumpstart", 34, 48);
sprite_change_offset_bladed("jump", 42, 62);
sprite_change_offset("doublejump", 32, 62);
sprite_change_offset("walljump", 32, 62);
sprite_change_offset("pratfall", 32, 62);
sprite_change_offset_bladed("land", 38, 52);
sprite_change_offset("landinglag", 32, 62);

sprite_change_offset("parry", 32, 62);
sprite_change_offset("roll_forward", 32, 62);
sprite_change_offset("roll_backward", 32, 62);
sprite_change_offset_bladed("airdodge", 44, 52);
sprite_change_offset_bladed("waveland", 38, 52);
sprite_change_offset("tech", 32, 62);

sprite_change_offset("jab", 64, 94);
sprite_change_offset("dattack", 64, 94);
sprite_change_offset("ftilt", 32, 62);
sprite_change_offset("dtilt", 64, 94);
sprite_change_offset("utilt", 64, 94);
sprite_change_offset("nair", 64, 94);
sprite_change_offset("fair", 64, 94);
sprite_change_offset("bair", 64, 94);
sprite_change_offset("uair", 64, 94);
sprite_change_offset("dair", 64, 94);
sprite_change_offset("fstrong", 34, 48);
sprite_change_offset("ustrong", 64, 158);
sprite_change_offset("dstrong", 64, 94);
sprite_change_offset("nspecial", 64, 94);
sprite_change_offset("fspecial", 64, 94);
sprite_change_offset("uspecial", 64, 94);
sprite_change_offset("dspecial", 64, 94);
sprite_change_offset("taunt", 32, 62);

sprite_change_offset("plat", 64, 94);

sprite_change_offset("nspecial_proj", 64, 94);

sprite_change_offset("article_cd_idle", 19, 19);
sprite_change_offset("article_cd_shoot", 19, 19);
sprite_change_offset("article_cd_mask", 19, 19);
sprite_change_collision_mask("article_cd_mask", false, 0, noone, noone, noone, noone, 1);

sprite_change_offset("vfx_buffering", 12, 12);
set_victory_theme(sound_get("victory"));

//=================================================
// DEFINES
#define sprite_change_offset_bladed(_spr_name, _offset_x, _offset_y)
var _bladed_name = _spr_name + "_blade";
sprite_change_offset(_spr_name, _offset_x, _offset_y);
if ("uhc_blade_spr_map" in self)
{
   ds_map_set(uhc_blade_spr_map, sprite_get(_spr_name), sprite_get(_bladed_name));
   sprite_change_offset(_bladed_name, _offset_x, _offset_y);
}

