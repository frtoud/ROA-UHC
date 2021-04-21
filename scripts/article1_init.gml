//article1_init.gml -- CD

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
//Standard Physics
hitstop = 0;
hsp = 0;
vsp = 0;
can_be_grounded = true;
//free = true;
ignores_walls = false;
hit_wall = false;
through_platforms = false;

//Constants
cd_grav_force  = 0.35;
cd_frict_force = 0.07;
cd_accel_force = 0.35;
cd_roll_speed = 6;
cd_fall_speed = 9;
cd_dspecial_force = 0.75;
cd_dspecial_speed = 24;
cd_dstrong_air_min_speed_for_hitbox = 5.5;

cd_multihit_speed_bonus = 0.75;

//=====================================================
// gameplay relevant
cd_spin_meter = floor(player_id.uhc_cd_spin_max / 2); //current charge of blade
cd_saved_spin_meter = cd_spin_meter; //charge of blade at the beginning of current move (for hitboxes)
//=====================================================
//start in the invisible state
buffered_state = -1; //AR_STATE_BUFFER
state = 0; //AR_STATE_DEAD
state_timer = 0;
visible = false;

has_hit = false; //if a cd-hitbox connected on this move
pickup_cooldown = 0; //prevents Hypercam from grabbing this CD
pre_dspecial_immunity = 0; //prevents CD from dying while AT_DSPECIAL_2 is in progress
has_dstrong_hitbox = false; //checks if air DSTRONG spawned already
