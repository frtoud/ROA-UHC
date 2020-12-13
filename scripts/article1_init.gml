//article1_init.gml -- CD
//=====================================================
#macro AR_STATE_BUFFER      -1 
#macro AR_STATE_DEAD         0 
#macro AR_STATE_IDLE         1
#macro AR_STATE_BOUNCE       2
#macro AR_STATE_FSTRONG      AT_FSTRONG
#macro AR_STATE_FSTRONG_ROLL 4
#macro AR_STATE_USTRONG      AT_USTRONG
#macro AR_STATE_DSTRONG      AT_DSTRONG
#macro AR_STATE_DSTRONG_SPIN AT_DSTRONG_2
#macro AR_STATE_DSPECIAL     AT_DSPECIAL
//=====================================================

//Rendering
spr_article_cd_mask = sprite_get("article_cd_mask");
spr_article_cd_idle = sprite_get("article_cd_idle");
spr_article_cd_roll = sprite_get("article_cd_roll");
spr_article_cd_shoot = sprite_get("article_cd_shoot");

sprite_index = spr_article_cd_idle;
image_index = 0;
mask_index = spr_article_cd_mask;
spr_dir = 1;
uses_shader = true;

//=====================================================
//Physics
hitstop = 0;
hsp = 0;
vsp = 0;
can_be_grounded = true;
//free = true;
ignores_walls = false;
hit_wall = false;
through_platforms = false;

//=====================================================
cd_grav_force  = 0.35;
cd_frict_force = 0.07;
cd_accel_force = 0.35;
cd_roll_speed = 6;
cd_fall_speed = 6;
cd_dspecial_force = 0.75;
cd_dspecial_speed = 24;

//=====================================================
//start in the invisible state
buffered_state = AR_STATE_BUFFER;
state = AR_STATE_DEAD;
state_timer = 0;
visible = false;
pickup_cooldown = 0;