//article1_update.gml -- CD
//=====================================================
#macro AR_STATE_BUFFER      -1 
#macro AR_STATE_HELD         0 
#macro AR_STATE_IDLE         1
#macro AR_STATE_DYING        2
#macro AR_STATE_ROLL         3
#macro AR_STATE_FSTRONG      AT_FSTRONG
#macro AR_STATE_USTRONG      AT_USTRONG
#macro AR_STATE_DSTRONG      AT_DSTRONG
#macro AR_STATE_DSTRONG_AIR  AT_DSTRONG_2
#macro AR_STATE_DSPECIAL     AT_DSPECIAL_2
//=====================================================

// no logic/timers affected if we're currently in hitstop
if (hitpause) exit;

//=====================================================
//applying buffered state
if (buffered_state != AR_STATE_BUFFER)
{
    set_state(buffered_state);
    cd_saved_spin_meter = cd_spin_meter;
    buffered_state = AR_STATE_BUFFER;
}
//=====================================================

//General logic
visible = (state != AR_STATE_HELD);
ignores_walls = (state == AR_STATE_DSPECIAL);

switch (state)
{
//=====================================================
    case AR_STATE_HELD:
    {
        //Update
        hsp = 0; vsp = 0;
        
        //Animation
        var spin_speed = 0.5 * (cd_spin_meter / uhc_cd_spin_max);
        cd_anim_blade_spin = (3 + cd_anim_blade_spin - spin_speed) % 3;
        
    } break;
//=====================================================
    case AR_STATE_DYING:
    {
        instance_destroy(self); exit;
    } break;
//=====================================================
    case AR_STATE_IDLE:
    {
        //Update
        do_gravity();
        do_friction();
        try_pickup();
        
        //Dying
        if !(pre_dspecial_immunity > 0) && (cd_spin_meter == 0)
        {
            buffered_state = AR_STATE_DYING;
        }
        
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
            if (0 == state_timer % 5)
            {
                spawn_hitbox(AT_FSTRONG, 2, true, false);
            }
        }
        else
        {
            if (has_hit) //finisher
            { spawn_hitbox(AT_FSTRONG, 3, false, false); }
            set_state(AR_STATE_ROLL);
        }
        
        //Animation
        sprite_index = spr_article_cd_shoot;
        image_index += 0.5;
        
    } break;
//=====================================================
    case AR_STATE_ROLL:
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
    case AR_STATE_USTRONG:
    {
        //Update
        if (vsp < 0)
        {
            do_gravity();
            if (0 == state_timer % 5)
            {
                spawn_hitbox(AT_FSTRONG, 2, true, false);
            }
        }
        else
        {
            if (has_hit) //finisher
            { spawn_hitbox(AT_FSTRONG, 3, false, false); }
            set_state(AR_STATE_DSTRONG_AIR);
        }
        
        //Animation
        sprite_index = spr_article_cd_shoot;
        image_index += 0.5;
    } break;
//=====================================================
    case AR_STATE_DSTRONG_AIR:
    {
        //Update
        do_gravity();
        
        if (state_timer <= 1)
        {
            state_timer = 1;
            has_dstrong_hitbox = false;
        }
        if (vsp > cd_dstrong_air_min_speed_for_hitbox) && (!has_dstrong_hitbox)
        {
            spawn_hitbox(AT_DSTRONG_2, (state_timer < cd_dstrong_air_spiking_time) ? 1: 2, false, false);
            has_dstrong_hitbox = true;
        }
        else if (!free || has_hit)
        {
            if (!has_hit) { sound_play(asset_get("sfx_blow_weak1")); }
            set_state(AR_STATE_IDLE);
            vsp = -6;
            hsp = spr_dir * -1;
        }
        
        //Animation
        sprite_index = spr_article_cd_shoot;
        image_index += 0.25;
    } break;
//=====================================================
    case AR_STATE_DSPECIAL:
    {
        //Update
        //Shoot towards player
        var total_speed = point_distance(0, 0, hsp, vsp);
        if (total_speed < cd_dspecial_speed)
        {
            total_speed += cd_dspecial_force;
        }
        else
        {
            total_speed = cd_dspecial_speed;
        }
        var lookat_angle = point_direction(x, y, 
                      current_owner_id.x, current_owner_id.y - 20);
        hsp = lengthdir_x(total_speed, lookat_angle);
        vsp = lengthdir_y(total_speed, lookat_angle);
        
        try_pickup();
        if (state == AR_STATE_HELD)
        {
            //blade was caught!
            //Activate DSPECIAL 2
        }
        else if (0 == state_timer % 5)
        {
            spawn_hitbox(AT_FSTRONG, 2, true, false);
        }
        
        //Animation
        sprite_index = spr_article_cd_shoot;
        //image_angle = lookat_angle;
        image_index += 0.25;
                               
    } break;
//=====================================================
    default: state = AR_STATE_IDLE;
    break;
}

state_timer++;

//=====================================================
// Charge drain
if (cd_spin_meter > 0) && !(state == AR_STATE_HELD && 
                            (current_owner_id.uhc_no_charging || !current_owner_id.uhc_has_cd_blade) )
{
    cd_spin_meter -= (state == AR_STATE_IDLE) ? player_id.uhc_cd_spin_drain_idle
                                              : player_id.uhc_cd_spin_drain_base;
    cd_spin_meter = clamp(cd_spin_meter, 0, player_id.uhc_cd_spin_max);
}

//=====================================================
//immunity to bottom blast zone for a couple of frames 
if (state != AR_STATE_HELD)
{
    if (pre_dspecial_immunity > 0)
    {
       //when activating AT_DSPECIAL_2 while CD is still alive, needs to be allowed to call back
       pre_dspecial_immunity--;
    }
    else if (y > room_height)
    {
        //fell off the stage 
        buffered_state = AR_STATE_DYING;
    }
}

//==============================================================================
#define set_state(new_state)
{
    state = new_state;
    state_timer = 0;
    has_hit = false;
}

//==============================================================================
#define do_gravity()
{
    if (free && vsp < cd_fall_speed) vsp += cd_grav_force;
}
//==============================================================================
#define do_friction()
{
    if (!free) hsp *= (1 - cd_frict_force);
}

//==============================================================================
#define try_pickup()
{   
    var found_player_id = noone;
    
    with (oPlayer) if (other.player_id.url == url)
                   && (!uhc_has_cd_blade)
                   && (state_cat != SC_HITSTUN)
                   //&& (uhc_pickup_cooldown == 0)
                   && place_meeting(x, y, other)
    {
        if (other.current_owner_id == self)
        {
            //priority to most recent thrower
            found_player_id = self;
            break; //can stop looking
        }
        else if (found_player_id == noone)
        {
            //found another Hypercam!
            found_player_id = self;
        }
        else if !(found_player_id != other.player_id) && 
         ( (found_player_id.player > self.player) || (other.player_id == self) )
        {
            //priority to initial owner (or port priority)
            found_player_id = self;
        }
    }
    
    if (found_player_id != noone)
    {
        set_state(AR_STATE_HELD);
        found_player_id.uhc_has_cd_blade = true;
        found_player_id.uhc_update_blade_status = true;
        sound_play(asset_get("sfx_coin_collect"));
        
        if (found_player_id != current_owner_id)
        {
            //unlink from previous owner if needed
            if (current_owner_id.uhc_current_cd == self)
            { current_owner_id.uhc_current_cd = noone; }
            
            found_player_id.uhc_current_cd = self;
            current_owner_id = found_player_id;
        }
    }
}
//==============================================================================
#define spawn_hitbox(atk, hnum, multihits, hit_self)
{
    var hb = noone;
    with (current_owner_id) { hb = create_hitbox(atk, hnum, other.x, other.y); }
    hb.spr_dir = spr_dir;
    hb.uhc_parent_cd = self;
    hb.can_hit_self = hit_self;
    hb.multihits = multihits;
    
    //apply buffs (should have the same effects as attack_update's adjust_blade_attack_grid)
    var charge_percent = cd_saved_spin_meter / player_id.uhc_cd_spin_max;
    with (player_id)
    {
        if (0 < get_hitbox_value(atk, hnum, HG_SPIN_DAMAGE_BONUS))
        { 
            hb.damage += charge_percent * get_hitbox_value(atk, hnum, HG_SPIN_DAMAGE_BONUS); 
            hb.damage = floor(hb.damage);
        }
        if (0 < get_hitbox_value(atk, hnum, HG_SPIN_HITPAUSE_BONUS))
        { hb.hitpause += charge_percent * get_hitbox_value(atk, hnum, HG_SPIN_HITPAUSE_BONUS); }
        if (0 < get_hitbox_value(atk, hnum, HG_SPIN_KNOCKBACK_BONUS))
        { hb.kb_value += charge_percent * get_hitbox_value(atk, hnum, HG_SPIN_KNOCKBACK_BONUS); }
        if (0 < get_hitbox_value(atk, hnum, HG_SPIN_KNOCKBACK_SCALING_BONUS))
        { hb.kb_scale += charge_percent * get_hitbox_value(atk, hnum, HG_SPIN_KNOCKBACK_SCALING_BONUS); }
    }
    
    return hb;
}
