//article1_update.gml -- CD
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

//=====================================================
//applying buffered state
if (buffered_state != AR_STATE_BUFFER)
{
    set_state(buffered_state);
    buffered_state = AR_STATE_BUFFER;
}

visible = (state != AR_STATE_DEAD);
ignore_walls = (state == AR_STATE_DSPECIAL);

switch (state)
{
//=====================================================
    case AR_STATE_DEAD:
    {
        x = 0; y = 0; hsp = 0; vsp = 0;
    } break;
//=====================================================
    case AR_STATE_IDLE:
    {
        //Update
        do_gravity();
        do_friction();
        try_pickup();
        
        //Animation
        sprite_index = spr_article_cd_idle;
        image_index += 0.8;
        
    } break;
//=====================================================
    case AR_STATE_FSTRONG:
    {
        //Update
        if (hsp * spr_dir > 0)
        {
            hsp -= (spr_dir * cd_accel_force);
        }
        else
        {
            set_state(AR_STATE_FSTRONG_ROLL);
        }
        
        //Animation
        sprite_index = spr_article_cd_shoot;
        image_index += 0.5;
        
    } break;
//=====================================================
    case AR_STATE_FSTRONG_ROLL:
    {
        //Update
        if (state_timer > 30)
        {
            set_state(AR_STATE_IDLE);
        }
        else if (-hsp * spr_dir < cd_roll_speed)
        {
            hsp -= (spr_dir * cd_accel_force);
        }
        else
        {
            hsp = -spr_dir * cd_roll_speed;
        }
        do_gravity();
        try_pickup();
        
        //Animation
        sprite_index = spr_article_cd_shoot;
        image_index += 0.25;
        
    } break;
//=====================================================
    case AR_STATE_DSPECIAL:
    {
        
    } break;
//=====================================================
    default: state = AR_STATE_IDLE; 
    break;
}

state_timer++;


#define set_state(new_state)
{
    state = new_state;
    state_timer = 0;
}

#define do_gravity()
{
    if (free) vsp += cd_grav_force;
}

#define do_friction()
{
    if (!free) hsp *= (1 - cd_frict_force);
}

#define try_pickup()
{
    if (pickup_cooldown > 0)
    {
        pickup_cooldown--;
    }
    else if (place_meeting(x, y, player_id))
    {
        state = AR_STATE_DEAD;
        player_id.uhc_has_cd_blade = true;
        sound_play(asset_get("sfx_coin_collect"));
    }
}