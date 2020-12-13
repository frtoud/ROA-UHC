//article1_init.gml -- CD
//=====================================================
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
sprite_index = player_id.spr_article_cd_idle;
image_index = 0;
mask_index = player_id.spr_article_cd_mask;
spr_dir = 1;
uses_shader = true;

//Physics
hitstop = 0;
hsp = 0;
vsp = 0;
can_be_grounded = true;
//free = true;
ignores_walls = false;
hit_wall = false;
through_platforms = false;

//start in the invisible state
state = AR_STATE_DEAD;
visible = false;
temp_timer = 0;