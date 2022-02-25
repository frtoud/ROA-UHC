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
#macro AR_STATE_BASHED       4
#macro AR_STATE_BASH_THROW   5
//=====================================================

//one exception to condition below: this is based on player behavior
// REMOTE THROWS: penalty no longer makes any sense. flat %
if (rune_throw_was_remote)
{
    aerial_strong_frames = floor(rune_remote_penalty * aerial_strong_frames_max);
}
else if (aerial_strong_check)
{
	if (current_owner_id.free && aerial_strong_frames < aerial_strong_frames_max) 
	    aerial_strong_frames++;
	else 
	    aerial_strong_check = false;
}

// no logic/timers affected if we're currently in hitstop
if (hitstop) exit;

//=====================================================
//applying buffered state
if (buffered_state != AR_STATE_BUFFER)
{
    set_state(buffered_state);
    cd_saved_spin_meter = cd_spin_meter;
    buffered_state = AR_STATE_BUFFER;
    
    destroy_cd_hitboxes();
}
//=====================================================

//General logic
visible = (state != AR_STATE_HELD);
ignores_walls = (state == AR_STATE_DSPECIAL);

unbashable = (state == AR_STATE_HELD || state == AR_STATE_DYING);

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
        if (state_timer <= 1)
        {
            fstrong_starting_speed = abs(hsp);
        }
        if (!instance_exists(cd_hitbox))
        {
            cd_hitbox = spawn_hitbox(AT_FSTRONG, 2);
        }
        if (was_parried)
        {
            cd_hitbox.can_hit_self = true;
            was_parried = false;
            
            //flip direction
            spr_dir *= -1; 
            //adapt speed in a way that it can reach the thrower
            hsp = -sign(hsp) * min(1.3 * fstrong_starting_speed, player_id.uhc_fstrong_throwspeed_max);
        }
        cd_hitbox.hitbox_timer = 0;
        cd_hitbox.spr_dir = spr_dir;
        
        //Update
        if (hsp * spr_dir > 0)
        {
            hsp -= (spr_dir * cd_accel_force);
            if (0 == state_timer % 5)
            {
                refresh_cd_hitbox();
                var hfx = spawn_hit_fx( x, y, player_id.vfx_spinning);
                hfx.draw_angle = random_func( 7, 180, true);
            }
        }
        else
        {
            destroy_cd_hitboxes();

            if (has_hit) //finisher
            {
                var finisher = spawn_hitbox(AT_FSTRONG, 3);
                if (aerial_strong_frames > 0)
                {
                	finisher.kb_scale *= lerp(1.0, aerial_strong_max_penality, 
                	    (aerial_strong_frames * 1.0/aerial_strong_frames_max));
                }
            }
            
            if (hit_wall)
            {
                sound_play(asset_get("sfx_blow_weak1"));
                vsp = -6;
                hsp = -spr_dir;
                set_state(AR_STATE_IDLE); 
                cd_recall_stun_timer = cd_low_recall_stun;
            }
            else
            {
                set_state(AR_STATE_ROLL); 
            }
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
        if (state_timer > 30 || hit_wall)
        {
            if (hit_wall)
            {
                sound_play(asset_get("sfx_blow_weak1"));
                vsp = -6;
                hsp = spr_dir;
            }
            set_state(AR_STATE_IDLE);
        }

        //=====================================================
        else if (rune_throw_was_remote)
        {
            // RUNE: Remote throw (does not get HSP)
            hsp *= 0.9;
            if (state_timer < cd_roll_grav_time) 
                vsp += 0.02 * state_timer * cd_grav_force;
        }
        //=====================================================

        else if (-hsp * spr_dir < cd_roll_speed)
        {
            hsp -= (spr_dir * cd_accel_force);
        }
        else
        {
            hsp = -spr_dir * cd_roll_speed;
        }
        if (state_timer > cd_roll_grav_time) do_gravity();
        if try_pickup() break;
        
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
	        if (!instance_exists(cd_hitbox))
	        {
	            cd_hitbox = spawn_hitbox(AT_USTRONG, 2);
	        }
            cd_hitbox.hitbox_timer = 0;
	        
            do_gravity();
            if (was_parried)
            {
                was_parried = false;
                vsp = max(abs(vsp), cd_reflect_vspeed);
                set_state(AR_STATE_DSTRONG_AIR);
            	destroy_cd_hitboxes();
            }
            else if (0 == state_timer % 5)
            {
                refresh_cd_hitbox();
                var hfx = spawn_hit_fx( x, y, player_id.vfx_spinning);
                hfx.draw_angle = random_func( 7, 180, true);
            }
        }
        else
        {
            destroy_cd_hitboxes();
            
            if (has_hit) //finisher
            { 
                var finisher = spawn_hitbox(AT_USTRONG, 3);
                if (aerial_strong_frames > 0)
                {
                	finisher.kb_scale *= lerp(1.0, aerial_strong_max_penality, 
                	    (aerial_strong_frames * 1.0/aerial_strong_frames_max));
                }
            }
            
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
        if (!instance_exists(cd_hitbox))
        {
            cd_hitbox = spawn_hitbox(AT_DSTRONG, 2);
        }
        
        if (was_parried)
        {
            cd_hitbox.can_hit_self = true;
            spr_dir *= -1;
            dstrong_angular_timer = 360 - dstrong_angular_timer;
            dstrong_angular_timer_prev = dstrong_angular_timer - 1;
        }
        cd_hitbox.spr_dir = spr_dir;
        
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
            refresh_cd_hitbox();
        }
        //calculate angle towards projected next hit
        //lengthdir_y is not an error: angle 0 is "directly behind" and so needs sine
        var launch_x = -lengthdir_y(dstrong_current_speed/2, dstrong_angular_timer+5)
            launch_x = (launch_x < 0) ? min(launch_x, -3) : max(launch_x, 3)
        var launch_y = -max(2, abs(launch_x/3)); //to compensate 10 frames of gravity
        
        cd_hitbox.kb_value = point_distance(0, 0, launch_x, launch_y);
        cd_hitbox.kb_angle = point_direction(0, 0, launch_x, launch_y);
        
        cd_hitbox.hitbox_timer = 0;
        
        if (hit_wall)
        {
            sound_play(asset_get("sfx_blow_weak1"));
            if (free)
            {
                //bumps into solids, so drop down
                set_state(AR_STATE_IDLE);
                vsp = -6;
                hsp = sign(hsp) * -1;
                
            	destroy_cd_hitboxes();
                cd_recall_stun_timer = cd_low_recall_stun;
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
        
        if (dstrong_need_gravity) 
            do_gravity();
        else
            vsp *= 0.7;
        
        if (dstrong_remaining_laps <= 0)
        {
            destroy_cd_hitboxes();
            
            if (has_hit) //finisher
            {
                var finisher = spawn_hitbox(AT_DSTRONG, 3);
                if (aerial_strong_frames > 0)
                {
                	finisher.kb_scale *= lerp(1.0, aerial_strong_max_penality, 
                	    (aerial_strong_frames * 1.0/aerial_strong_frames_max));
                }
            }
            
            set_state(AR_STATE_IDLE);
            hsp *= 0.5;
        }
        //recall availability
        can_priority_recall = true;
        
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

        var can_spike = (state_timer < cd_dstrong_air_spiking_time)
        
        if (state_timer <= 1)
        {
            state_timer = 1;
            cd_has_hitbox = false;
        }
        if (vsp > cd_dstrong_air_min_speed_for_hitbox)
        {
            if (can_spike && 1 == state_timer % 3)
            {
                var hfx = spawn_hit_fx( x, y, player_id.vfx_spinning);
                hfx.draw_angle = random_func( 7, 180, true);
            }

            if (!cd_has_hitbox)
            {
                spawn_hitbox(AT_DSTRONG_2, can_spike ? 1: 2);
                cd_has_hitbox = true;
            }
        }
        if (was_parried)
        {
            was_parried = false;
            destroy_cd_hitboxes();
            if (can_spike)
            {
                set_state(AR_STATE_USTRONG);
                vsp = -cd_reflect_vspeed;
                hsp = 0;
            }
            else
            {
                set_state(AR_STATE_IDLE);
                cd_recall_stun_timer = cd_high_recall_stun;
                vsp = -vsp * 0.75;
                hsp = 0;
            }
            
        }
        else if (!free || has_hit)
        {
            if !(has_hit) 
            { 
                sound_play(asset_get("sfx_blow_weak1"));
            }
            set_state(AR_STATE_IDLE);
            vsp = -6;
            hsp = -spr_dir;
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
        pre_dspecial_immunity = max(2, pre_dspecial_immunity);
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
        
        //pickup logic
        pickup_priority = max(pickup_priority, 3);
        if try_pickup() break;

        //create hitbox
        if (!instance_exists(cd_hitbox))
        {
            cd_hitbox = spawn_hitbox(AT_DSPECIAL, 2);
        }
        cd_hitbox.hitbox_timer = 0;
        
        //=====================================================
        //WINCON RUNE
        if (current_owner_id.uhc_rune_flags.wincon)
        {
            if (rune_wincon_active && has_hit)
            {
                //shortcut to parried state
                was_parried = true;
                hsp *= -1;
                x += hsp;
            }
            else if (state_timer <= 1 || has_hit)
            {
                has_hit = false;
                rune_wincon_active = false;
                rune_wincon_timer = 0;
            }
            else if (!rune_wincon_active)
            {
                rune_wincon_timer++;
                if (rune_wincon_timer >= rune_wincon_timer_max)
                && (total_speed >= rune_wincon_speed_min)
                {
                    rune_wincon_active = true;
                    destroy_cd_hitboxes();
                    cd_hitbox = spawn_hitbox(AT_DSPECIAL, 3);
                }
                
            }
        }
        //=====================================================

        
        if (was_parried)
        {
            was_parried = false;
            destroy_cd_hitboxes();
            set_state(AR_STATE_IDLE);
            vsp = -6;
            hsp = sign(hsp);
        }
        else if (rune_wincon_active)
        {
            // damage/knockback depends on current speed
            cd_hitbox.damage = 0.5 * total_speed;
            cd_hitbox.kb_angle = point_direction(0, 0, hsp * spr_dir, 3 * min(vsp-2, -5));
            cd_hitbox.kb_value = total_speed; 

            if (total_speed > 20)      cd_hitbox.sound_effect = sound_get("sfx_ssbm_bat");
            else if (total_speed > 15) cd_hitbox.sound_effect = sound_get("sfx_tf2_sawblade");
            else                       cd_hitbox.sound_effect = asset_get("sfx_blow_heavy2");
            
            var hfx = spawn_hit_fx( x, y, player_id.vfx_spinning);
            hfx.draw_angle = random_func( 7, 180, true);
        }
        else if (0 == state_timer % 5)
        {
            refresh_cd_hitbox(state_timer > 3);
            var hfx = spawn_hit_fx( x, y, player_id.vfx_spinning);
            hfx.draw_angle = random_func( 7, 180, true);
        }
        
        //Animation
        sprite_index = spr_article_cd_shoot;
        image_index += 0.25;
                               
    } break;
//=====================================================
    case AR_STATE_BASHED:
    {
        //bashed CD functionally identical to a reflected CD:
        // - Ori cant get hit by it
        // - Hypercam cannot recall it
        last_parried_by_player = bashed_id.player;
        if (!getting_bashed)
        {
            set_state(AR_STATE_BASH_THROW);
        }
    } break;
//=====================================================
    case AR_STATE_BASH_THROW:
    {
        //See FSTRONG: similar logic, but omnidirectional
        if (!instance_exists(cd_hitbox))
        {
            cd_hitbox = spawn_hitbox(AT_FSTRONG, 2);
        }
        if (was_parried)
        {
            was_parried = false;
            
            //flip direction
            spr_dir *= -1;
            hsp *= -1.5; //slight boost
            vsp *= -1.5; //slight boost
        }
        cd_hitbox.hitbox_timer = 0;
        cd_hitbox.spr_dir = spr_dir;
        
        //Update
        var speed_val = point_distance(0, 0, hsp, vsp);
        var speed_dir = point_direction(0, 0, hsp, vsp);
        if (speed_val > cd_accel_force)
        {
            speed_val -= cd_accel_force;
            hsp = lengthdir_x(speed_val, speed_dir);
            vsp = lengthdir_y(speed_val, speed_dir);
            if (0 == state_timer % 5)
            {
                refresh_cd_hitbox();
                var hfx = spawn_hit_fx( x, y, player_id.vfx_spinning);
                hfx.draw_angle = random_func( 7, 180, true);
            }
        }
        else
        {
            if (has_hit) //finisher
            { 
                spawn_hitbox(AT_FSTRONG, 3);
            }
            set_state(AR_STATE_IDLE);

            //with bounce 
            if (has_hit || !free || hit_wall)
            {
                if (!has_hit) 
                {
                    sound_play(asset_get("sfx_blow_weak1")); 
                    cd_recall_stun_timer = cd_high_recall_stun;
                }

                vsp = -6;
                hsp = spr_dir * (hit_wall ? 1 : -1);
            }
        }
        
        //recall availability
        can_priority_recall = false;
        
        //Animation
        sprite_index = spr_article_cd_shoot;
        image_index += 0.5;
        
    } break;
//=====================================================
    default: set_state(AR_STATE_IDLE);
    break;
}

state_timer++;

//=====================================================
//getting hit can interrupt the attack
if (state == AR_STATE_FSTRONG) || (state == AR_STATE_USTRONG) 
|| (state == AR_STATE_DSTRONG) || (state == AR_STATE_DSTRONG_AIR)
|| (state == AR_STATE_DSPECIAL) || (state == AR_STATE_BASH_THROW)
{
    if (try_get_hit())
    {
        destroy_cd_hitboxes();
        set_state(AR_STATE_IDLE);
        sound_play(asset_get("sfx_shovel_hit_heavy1"), false, noone, 1, 1.2);
    }
}

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
// Clairen field: weakens charge, prevents recall, stops attacks
if (state != AR_STATE_HELD && is_in_clairen_field())
{
    cd_spin_meter -= player_id.uhc_cd_spin_drain_clairen;
    cd_spin_meter = clamp(cd_spin_meter, 0, player_id.uhc_cd_spin_max);

    if (state != AR_STATE_IDLE && state != AR_STATE_DYING)
    {
        sound_play(asset_get("sfx_clairen_hit_med"));
        set_state(AR_STATE_IDLE);
    }
    
    can_recall = false;
    can_priority_recall = false;
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
    else if (y > room_height + 20)
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
//Hitstun pseudostate
if (cd_recall_stun_timer > 0)
{
    cd_recall_stun_timer--;
    can_recall = false;
    can_priority_recall = false;
}
if (cd_pickup_stun_timer > 0)
{
    cd_pickup_stun_timer--;
}

//=====================================================
//Parry/Reflection logic reset
was_parried = false;
if ( state == AR_STATE_HELD || state == AR_STATE_IDLE || state == AR_STATE_DYING)
{
    last_parried_by_player = 0;
}

//=====================================================
//Ori bash detection
if (getting_bashed && state != AR_STATE_BASHED)
{
    set_state(AR_STATE_BASHED);
    destroy_cd_hitboxes();
}

//==============================================================================
#define set_state(new_state)
{
    prev_state = state;
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
    hsp *= (1 - (free ? cd_air_frict_force : cd_frict_force));
}
//==============================================================================
// call to check if the article is in clairen's no-fun-zone.
#define is_in_clairen_field()
{
    return place_meeting(x, y, asset_get("plasma_field_obj"));
}
//==============================================================================
#define try_pickup()
{
    if (cd_pickup_stun_timer > 0) return false;

	var was_caught = false;
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
        was_caught = true;
        destroy_cd_hitboxes();
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
            //Prevent throws for a short period
            uhc_throw_cooldown_override = uhc_throw_cooldown_max;
            
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
    
    return was_caught;
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
        { hb.damage = floor(lerp(hb.damage, get_hitbox_value(atk, hnum, HG_SPIN_DAMAGE_BONUS), charge_percent)); }
        if (0 < get_hitbox_value(atk, hnum, HG_SPIN_HITPAUSE_BONUS))
        {hb.hitpause = lerp(hb.hitpause, get_hitbox_value(atk, hnum, HG_SPIN_HITPAUSE_BONUS), charge_percent); }
        if (0 < get_hitbox_value(atk, hnum, HG_SPIN_KNOCKBACK_BONUS))
        {hb.kb_value = lerp(hb.kb_value, get_hitbox_value(atk, hnum, HG_SPIN_KNOCKBACK_BONUS), charge_percent); }
        if (0 < get_hitbox_value(atk, hnum, HG_SPIN_KNOCKBACK_SCALING_BONUS))
        {hb.kb_scale = lerp(hb.kb_scale, get_hitbox_value(atk, hnum, HG_SPIN_KNOCKBACK_SCALING_BONUS), charge_percent); }
        
        //SFX
        if (0 < get_hitbox_value(atk, hnum, HG_SPIN_SFX) && charge_percent > uhc_spin_sfx_threshold)
        { hb.sound_effect = get_hitbox_value(atk, hnum, HG_SPIN_SFX); }
    }
    
    return hb;
}
//==============================================================================
#define refresh_cd_hitbox()
var antipolite = (argument_count > 0) ? argument[0] : false;
{
    if (is_array(cd_hitbox.can_hit))
    {
        //Do not refresh players in hitstun-pause (reverse-polite)
        var in_hitstunpause = [];
        in_hitstunpause[array_length(cd_hitbox.can_hit)] = false; //init everything to zero
        if (antipolite) with (oPlayer)
        {
            //might have multiple oPlayer per player
            if (state_cat == SC_HITSTUN && hitpause)
                in_hitstunpause[player] = true;
        }

        for (var p = 0; p < array_length(cd_hitbox.can_hit); p++)
        { 
            cd_hitbox.can_hit[p] = (p != last_parried_by_player) && !in_hitstunpause[p]; 
        }
        cd_hitbox.stop_effect = false;
    }
}
//==============================================================================
#define destroy_cd_hitboxes()
{
    with (pHitBox) if ("uhc_parent_cd" in self) && (uhc_parent_cd == other)
    {
        destroyed = true;
    }
    cd_has_hitbox = false;
    cd_hitbox = noone;
}

//==============================================================================
// inspired by Supersonic's hit detection template (somewhat trimmed)
// https://pastebin.com/zUXGn0QK thx 1138
#define try_get_hit()
{
    var was_hit = false;

    var team_attack = get_match_setting(SET_TEAMATTACK);
    var cd_owner_id = current_owner_id;

    var best_hitbox = noone;
    var best_priority = 0.5;
    var best_damage = 0.5;

    with (pHitBox)
    {
        //only get hit by the best possible hitbox that could have damaged your current owner
	    if (player != cd_owner_id.player || can_hit_self)
        && ((hit_priority > best_priority) || (hit_priority == best_priority && damage > best_damage))
	    && (cd_owner_id.can_be_hit[player] == 0) && (can_hit[cd_owner_id.player])
        && (proj_break == 0 || ("uhc_parent_cd" in self && other != uhc_parent_cd))
	    && (get_player_team(cd_owner_id.player) != get_player_team(player) || team_attack)
	    && (self == collision_circle(other.x, other.y, other.cd_hittable_radius, self, true, false))
        {
            best_hitbox = self;
            best_priority = hit_priority;
            best_damage = damage;
        }
    }

    if (instance_exists(best_hitbox))
    {
        was_hit = true;
        var hb = best_hitbox;
        //simulate getting hit
        var kb_adj = 1.1;
        var simulated_percent = 30;

        // CD Knockback
        var kb_val = max(cd_min_knockback, (hb.force_flinch) ? 0.3 : 
                    hb.kb_value + (simulated_percent + hb.damage) * hb.kb_scale * kb_adj * 0.12);
        var kb_dir = get_hitbox_angle(hb);

        hsp = clamp(lengthdir_x(kb_val, kb_dir), -cd_max_kb_hsp, cd_max_kb_hsp);
        vsp = clamp(lengthdir_y(kb_val, kb_dir), -cd_max_kb_vsp, 3);
        if (hsp < 1 && hsp > -1) hsp = -spr_dir;
        if (vsp < 1) vsp -= 2;

        // CD "hitstun"
        cd_recall_stun_timer = (hb.kb_value * 4 *((kb_adj - 1) * 0.6 + 1))
                             + (hb.damage * 0.12 * hb.kb_scale * 4 * 0.65 * kb_adj) 
                             + cd_extra_hitstun;
        cd_pickup_stun_timer = cd_recall_stun_timer;

        // CD hitpause
        var desired_hitstop = min(20, floor(hb.hitpause + hb.damage * hb.hitpause_growth * 0.05));
        hitstop = desired_hitstop;

        with (hb)
        {
            //simulate having hit
            has_hit = true;
            sound_play(sound_effect);

            spawn_hit_fx(floor( (x + other.x)/2), floor( (y + other.y)/2), hit_effect);
            stop_effect = true; //prevents spawning of effect since it's already been done

            if (type == 1) //melee
            {
                //simulate having hit
                with (player_id)
                {
                    has_hit = true;

                    //apply hitstop
                    if (!hitpause)
                    {
                        old_vsp = vsp;
                        old_hsp = hsp;
                    }
                    hitpause = true;
                    if (hitstop < desired_hitstop)
                    {
                        hitstop = desired_hitstop;
                        hitstop_full = desired_hitstop;
                    }
                }
            }
            else  //projectiles
            {
                if (!transcendent) 
                {
                    destroyed = true;
                }
            }
        }
    }

    return was_hit;
}
