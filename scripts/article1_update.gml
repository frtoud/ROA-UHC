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
#macro AR_STATE_DSPECIAL     AT_DSPECIAL
//=====================================================

// no logic/timers affected if we're currently in hitstop
if (hitstop) exit;

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

can_recall = false;
can_priority_recall = false;

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
        sound_play(sfx_cd_death);
        instance_destroy(self); exit;
    } break;
//=====================================================
    case AR_STATE_IDLE:
    {
        //Update
        do_gravity();
        do_friction();
        try_pickup();
        if (state != AR_STATE_IDLE) break;
        
        //Dying
        if !(pre_dspecial_immunity > 0) && (cd_spin_meter == 0)
        && !(free) && (state_timer > 1)
        {
            death_timer++;
            if (death_timer > death_timer_max)
            { set_state(AR_STATE_DYING); }
        }
        else
        {
            death_timer = 0;
        }
        
        //recall availability
        can_recall = true;
        
        //Animation
        var spin_percent = (cd_spin_meter / uhc_cd_spin_max);
        
        if (free || spin_percent > 0.6)
        { sprite_index = spr_article_cd_idle_fast; }
        else if (spin_percent > 0.2)
        { sprite_index = spr_article_cd_idle_half; }
        else
        { sprite_index = spr_article_cd_idle_slow; }
        
        image_index += 0.25 + 0.5 * spin_percent;
        
    } break;
//=====================================================
    case AR_STATE_FSTRONG:
    {
        if (was_parried)
        {
            was_parried = false;
            
            //flip direction
            spr_dir *= -1;
            hsp *= -1.5; //slight boost
        }
        
        //Update
        if (hsp * spr_dir > 0)
        {
            hsp -= (spr_dir * cd_accel_force);
            if (0 == state_timer % 5)
            {
                spawn_hitbox(AT_FSTRONG, 2);
            }
        }
        else
        {
            if (has_hit) //finisher
            { spawn_hitbox(AT_FSTRONG, 3); }
            set_state(AR_STATE_ROLL);
        }
        
        //recall availability
        can_priority_recall = true;
        
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
        
        //recall availability
        can_priority_recall = true;
        
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
                spawn_hitbox(AT_USTRONG, 2);
            }
        }
        else
        {
            if (has_hit) //finisher
            { spawn_hitbox(AT_USTRONG, 3); }
            set_state(AR_STATE_DSTRONG_AIR);
        }
        
        //recall availability
        can_priority_recall = true;
        
        //Animation
        sprite_index = spr_article_cd_shoot;
        image_index += 0.5;
    } break;
//=====================================================
    case AR_STATE_DSTRONG:
    {
        //Update
        if (state_timer <= 1)
        {
            //start the rolling
            state_timer = 1;
            dstrong_angular_timer = 0;
            dstrong_angular_timer_prev = -1;
            dstrong_need_gravity = true;

            dstrong_remaining_laps = floor(lerp(cd_dstrong_ground_min_laps, 
                                                cd_dstrong_ground_max_laps, 
                                                dstrong_charge_percent));
            dstrong_current_speed = lerp(cd_dstrong_ground_min_speed, 
                                         cd_dstrong_ground_max_speed, 
                                         dstrong_charge_percent);
        }
        else
        {
            //increment rotation
            dstrong_angular_timer_prev = dstrong_angular_timer;
            dstrong_angular_timer = (dstrong_angular_timer 
                                   + cd_dstrong_rotation_speed_base
                                   + dstrong_remaining_laps * cd_dstrong_rotation_speed_bonus);
            if (dstrong_angular_timer >= 360)
            {
                dstrong_angular_timer -= 360;
                dstrong_angular_timer_prev -= 360; //can be negative; actually helps logic!
            }
        }
        if (!instance_exists(dstrong_hitbox))
        {
            dstrong_hitbox = spawn_hitbox(AT_DSTRONG, 2);
        }
        
        if (was_parried)
        {
            dstrong_hitbox.can_hit_self = true;
            spr_dir *= -1;
            dstrong_angular_timer = 360 - dstrong_angular_timer;
            dstrong_angular_timer_prev = dstrong_angular_timer - 1;
        }
        dstrong_hitbox.spr_dir = spr_dir;
        
        //angular timer of CD dictates how CD behaves
        hsp = -spr_dir * lengthdir_x(dstrong_current_speed, dstrong_angular_timer);
        //  0: +HSP, start of lap, creates hitbox
        // 90: 0HSP
        //180: -HSP, second hitbox
        //270: 0HSP
        //360: lap complete, roll back from zero
        if (dstrong_angular_timer_prev < 0 && state_timer > 1)
        {
            dstrong_remaining_laps--;
        }
        else if (dstrong_angular_timer >=  90 && dstrong_angular_timer_prev <  90)
             || (dstrong_angular_timer >= 270 && dstrong_angular_timer_prev < 270)
        {
            dstrong_need_gravity = free;
            for (var p = 0; p < array_length(dstrong_hitbox.can_hit); p++)
            { dstrong_hitbox.can_hit[p] = (p != last_parried_by_player); }
        }
        //calculate angle towards projected next hit
        //lengthdir_y is not an error: angle 0 is "directly behind" and so needs sine
        var launch_x = -lengthdir_y(dstrong_current_speed/2, dstrong_angular_timer+5)
            launch_x = (launch_x < 0) ? min(launch_x, -3) : max(launch_x, 3)
        var launch_y = -max(2, abs(launch_x/3)); //to compensate 10 frames of gravity
        
        dstrong_hitbox.kb_value = point_distance(0, 0, launch_x, launch_y);
        dstrong_hitbox.kb_angle = point_direction(0, 0, launch_x, launch_y);
        
        dstrong_hitbox.hitbox_timer = 0;
        
        if (hit_wall)
        {
            if (free)
            {
                //bumps into solids, so drop down
                set_state(AR_STATE_IDLE);
                vsp = -6;
                hsp = sign(hsp) * -1;
                
                if (instance_exists(dstrong_hitbox))
                {
                    dstrong_hitbox.destroyed = true;
                    dstrong_hitbox = noone;
                }
            }
            else
            {
                //bumps into solids, so adjust trajectory
                dstrong_angular_timer = (hsp * spr_dir > 0) ? 270 : 90;
                dstrong_angular_timer_prev = dstrong_angular_timer - 1;
                dstrong_remaining_laps--;
                hsp = 0;
            }
        }
        
        if (dstrong_need_gravity) do_gravity();
        
        if (dstrong_remaining_laps <= 0)
        {
            if (has_hit) //finisher
            { spawn_hitbox(AT_DSTRONG, 3); }
            
            set_state(AR_STATE_IDLE);
            hsp *= 0.5;
            
            if (instance_exists(dstrong_hitbox))
            {
                dstrong_hitbox.destroyed = true;
                dstrong_hitbox = noone;
            }
        }
        
        //Animation
        sprite_index = spr_article_cd_dstrong;
        image_index = 0.5 + (dstrong_angular_timer - 90)/360.0 * 12;
        depth = player_id.depth + lengthdir_x(8, dstrong_angular_timer);
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
            spawn_hitbox(AT_DSTRONG_2, (state_timer < cd_dstrong_air_spiking_time) ? 1: 2);
            has_dstrong_hitbox = true;
        }
        else if (!free || has_hit || was_parried)
        {
            if !(has_hit || was_parried) { sound_play(asset_get("sfx_blow_weak1")); }
            set_state(AR_STATE_IDLE);
            vsp = -6;
            hsp = spr_dir * (was_parried ? 1 : -1);
        }
        
        //recall availability
        can_priority_recall = (vsp <= cd_fall_speed || state_timer > 20);
        
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
        
        pickup_priority = max(pickup_priority, 3);
        try_pickup();
        
        if (state == AR_STATE_HELD)
        {
            //blade was just caught
            //Activate DSPECIAL 2?
        }
        else if (0 == state_timer % 5)
        {
            spawn_hitbox(AT_DSPECIAL, 1);
        }
        
        //Animation
        sprite_index = spr_article_cd_shoot;
        //image_angle = lookat_angle;
        image_index += 0.25;
                               
    } break;
//=====================================================
    default: set_state(AR_STATE_IDLE);
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
        set_state(AR_STATE_DYING);
    }
}

//=====================================================
//Recalling status update in case states were changed this frame
if (state == AR_STATE_DYING || state == AR_STATE_HELD)
|| (last_parried_by_player != 0) //cannot recall if reflected
{
    can_recall = false;
    can_priority_recall = false;
}

//=====================================================
//Parry/Reflection logic reset
was_parried = false;
if ( state == AR_STATE_HELD || state == AR_STATE_IDLE || state == AR_STATE_DYING)
{
    last_parried_by_player = 0;
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
    if (free && vsp < cd_fall_speed) 
    {
        vsp += cd_grav_force;
        if (vsp > cd_fall_speed) vsp = cd_fall_speed;
    }
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
    var any_owner = (pickup_priority <= 0);
    
    if (pickup_priority > 0)
    { pickup_priority--; }
    
    with (oPlayer) if ("url" in self && other.player_id.url == url)
                   && (any_owner || (other.current_owner_id == self))
                   && (!uhc_has_cd_blade)
                   && (state_cat != SC_HITSTUN)
                   && (uhc_pickup_cooldown == 0)
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
        sound_play(sfx_cd_catch);
        
        if (found_player_id != current_owner_id)
        {
            //unlink from previous owner if needed
            if (current_owner_id.uhc_current_cd == self)
            { current_owner_id.uhc_current_cd = noone; }
            current_owner_id = found_player_id;
        }
        current_owner_id.uhc_current_cd = self;
        
        with (current_owner_id)
        {
        // "Crownslide": catch blade to remove friction for 12 frames
            if (state_cat == SC_GROUND_NEUTRAL || state_cat == SC_AIR_NEUTRAL)
            || (state == PS_LAND || state == PS_WAVELAND || state == PS_WALK_TURN 
            ||  state == PS_DASH_START || state == PS_DASH || state == PS_DASH_TURN || state == PS_DASH_STOP)
            {
                set_attack(AT_DSPECIAL);
                window = 6;
            }
        }
    }
}
//==============================================================================
#define spawn_hitbox(atk, hnum)
{
    var hb = noone;
    with (current_owner_id) { hb = create_hitbox(atk, hnum, other.x, other.y); }
    hb.spr_dir = spr_dir;
    hb.uhc_parent_cd = self;
    
    if (last_parried_by_player != 0)
    {
        hb.can_hit_self = true;
        for (var p = 0; p < array_length(hb.can_hit); p++)
        { hb.can_hit[p] = (p != last_parried_by_player); }
    }
    
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
