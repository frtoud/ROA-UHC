//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse();
}

//==========================================================
// Sync grid data with blade & charge
// always done at least once at the start of a move
if (uhc_update_blade_status) 
{
    adjust_bladed_attack_grid();
    uhc_update_blade_status = false;
}

//==========================================================
//prevents spin cost from not being applied when CD is thrown
uhc_spin_cost_throw_bypass = false;

switch (attack)
{
//==========================================================
    case AT_JAB:
    {
        if (window == 1 && window_timer == 1)
        { uhc_looping_attack_can_exit = false; }
        
        if (window == 5 && window_timer == 1 && (!uhc_has_cd_blade || was_parried))
        { window = 8; } //skip to finisher
        
        if (window == 7)
        {
            if (window_timer >= 4)
            {
                //allow exiting the attack after a minimum time
                uhc_looping_attack_can_exit = true;
            }
            
            if ((window_timer % 6) == 1 && !hitpause)
            && (uhc_has_cd_blade && uhc_current_cd.cd_spin_meter > 0)
            {
                //Looping hitbox as long as you hold
                sound_play(asset_get("sfx_swipe_weak1"));
                create_hitbox(AT_JAB, 6, 0, 0);
            }
            
            if (!attack_down && uhc_looping_attack_can_exit) || (was_parried)
            { 
                window = (was_parried ? 9 : 8);
                window_timer = 0;
                destroy_hitboxes();
                uhc_update_blade_status = true;
            }
        }
        
        //Jab-walking
        if (window >= 7 && !joy_pad_idle)
        {
            off_edge = true;
            
            var walk_dir = right_down - left_down;
            hsp = clamp(hsp + walk_dir * walk_accel, -walk_speed, walk_speed);
            
            if (window == 9 && window_timer > 6 && walk_dir != spr_dir) && !was_parried
            {
                set_state(PS_WALK_TURN);
            }
        }
        
    } break;
//==========================================================
    case AT_DATTACK:
    {
        if (window == 1 && window_timer == 1)
        { uhc_looping_attack_can_exit = false; }
        
        if (window == 3)
        {
            hsp = sign(hsp) * dash_speed;
            
            if (window_timer >= 8)
            {
                //allow exiting the attack after a minimum time
                uhc_looping_attack_can_exit = true;
            }
            
            if ((window_timer % 6) == 1 && !hitpause)
            && (uhc_has_cd_blade && uhc_current_cd.cd_spin_meter > 0)
            {
                //Looping hitbox as long as you hold
                sound_play(asset_get("sfx_swipe_weak1"));
                create_hitbox(AT_DATTACK, 3, 0, 0);
            }
            
            var loopcheck = attack_down 
                        || (uhc_do_cstick_tilt_check && left_stick_down || right_stick_down);

            if (!loopcheck && uhc_looping_attack_can_exit) || (was_parried)
            { 
                window = 4;
                window_timer = 0;
                destroy_hitboxes();
            }
        }
        
        if (!was_parried && has_hit_player)
        {
            can_attack = true;
            //except for these:
            move_cooldown[AT_JAB] = 2;
            move_cooldown[AT_UTILT] = 2;
            move_cooldown[AT_DATTACK] = 2;
        }
    } break;
//==========================================================
    case AT_FSTRONG:
    {
        can_move = window > 2;
        if (window <= 2)
        {
            //dampen fall?
            vsp *= (vsp < 0) ? 1 : 0.85;
        }
        else if (window == 3 && window_timer == 1)
        {
            // RUNE: Remote throw (needs slight bonus to HSP)
            throw_blade(32, 20, uhc_fstrong_throwspeed_base + (strong_charge/60.0) * 
                               (uhc_fstrong_throwspeed_max - uhc_fstrong_throwspeed_base)
                               + (hsp * spr_dir * 0.5) + (uhc_has_cd_blade ? 0 : 1)
                               , 0, AT_FSTRONG);
        }
    } break;
//==========================================================
    case AT_USTRONG:
    {
        can_move = (!hitpause);
        if (window == 3 && window_timer == 1)
        {
            // RUNE: Remote throw (does not get HSP)
            var temp_ustrong_hsp = 
                uhc_has_cd_blade ? (uhc_ustrong_throwspeed_horz + 0.5 * hsp * spr_dir) : 0;

            throw_blade(12, 65, temp_ustrong_hsp, 
                                uhc_ustrong_throwspeed_base + (strong_charge/60.0) * 
                               (uhc_ustrong_throwspeed_max - uhc_ustrong_throwspeed_base), AT_USTRONG);
        }
    } break;
//==========================================================
    case AT_DSTRONG:
    {
        if (window == 3 && window_timer == 1)
        {
            throw_blade(16, 20, -uhc_dstrong_throwspeed, 0, AT_DSTRONG);
            uhc_current_cd.dstrong_charge_percent = (strong_charge/60.0);
        }
    } break;
//==========================================================
    case AT_DSTRONG_2:
    {
        can_move = (!hitpause);
        if (window == 3 && window_timer == 1)
        {
            throw_blade(0, 20, 0, uhc_dstrong_throwspeed, AT_DSTRONG_2);
        }
    } break;
//==========================================================
    case AT_DAIR:
    {
        if (window == 1 && window_timer <= 1)
        {
            uhc_dair_window_bounced = 0;
        }
        else if (window <= 4)
        {
            if (!hitpause && has_hit && window > uhc_dair_window_bounced)
            {
                uhc_dair_window_bounced = window;
                vsp = -(window == 4 ? uhc_dair_boost_final : uhc_dair_boost);
                hsp = 0;
            }
            else if (window_timer == get_window_value(AT_DAIR, window, AG_WINDOW_LENGTH))
            {
                
                if (window == 4) //reset has_hit to an accurate value
                { has_hit = (uhc_dair_window_bounced > 0); }
                else //reset has_hit for future windows
                { has_hit = false; }
            }
            
            if (window < 4 && uhc_dair_window_bounced != 0)
            {
                hsp *= 0.15;
            }
        }
    } break;
//==========================================================
    case AT_BAIR:
    {
        if (window == 2 || window == 3)
        {
            var current_frame = get_gameplay_time();
            var nudge_pos_x = x + spr_dir * get_hitbox_value(AT_BAIR, 2, HG_HITBOX_X);
            var nudge_pos_y = y + get_hitbox_value(AT_BAIR, 2, HG_HITBOX_Y);

            with (oPlayer) if (self != other) && (!hitpause)
            && (uhc_bair_last_pseudograbbed_by == other)
            && (uhc_bair_last_pseudograb_time + other.uhc_bair_pseudograb_length > current_frame)
            {
                x = lerp(x, nudge_pos_x, other.uhc_bair_pseudograb_factor);
                y = lerp(y, nudge_pos_y, other.uhc_bair_pseudograb_factor);
            }
        }
    } break;
//==========================================================
    case AT_UAIR:
    {
        if (uhc_rune_flags.super_flash)
        && (window_timer == 1 && window == 1)
        {
            if (uhc_fspecial_charge_current == uhc_fspecial_charge_max)
            {
                set_hitbox_value(AT_UAIR, 2, HG_BASE_KNOCKBACK, 8);
                set_hitbox_value(AT_UAIR, 2, HG_KNOCKBACK_SCALING, .9);
                set_hitbox_value(AT_UAIR, 2, HG_HIT_SFX, asset_get("sfx_absa_uair"));
            }
            else if (uhc_fspecial_charge_current > uhc_fspecial_charge_half)
            {
                set_hitbox_value(AT_UAIR, 2, HG_BASE_KNOCKBACK, 7);
                set_hitbox_value(AT_UAIR, 2, HG_KNOCKBACK_SCALING, .7);
                set_hitbox_value(AT_UAIR, 2, HG_HIT_SFX, asset_get("sfx_absa_kickhit"));
            }
            else
            {
                reset_hitbox_value(AT_UAIR, 2, HG_BASE_KNOCKBACK);
                reset_hitbox_value(AT_UAIR, 2, HG_KNOCKBACK_SCALING);
                reset_hitbox_value(AT_UAIR, 2, HG_HIT_SFX);
            }
            uhc_fspecial_charge_current = max(0, uhc_fspecial_charge_current - uhc_uair_flash_penalty);
        }
    } break;
//==========================================================
    case AT_NSPECIAL:
    {
        if (window == 1 && special_down)
        && (window_timer == (get_window_value(AT_NSPECIAL, 1, AG_WINDOW_LENGTH) - 1))
        {
            window = 2;
            window_timer = 0;
        }
        else if (window == 2)
        {
            can_jump = true;
            if (shield_pressed)
            {
                window = 4;
                window_timer = 0;
                if (!free && (right_down - left_down) != 0)
                {
                    set_state((right_down - left_down)*spr_dir > 0 ? PS_ROLL_FORWARD : PS_ROLL_BACKWARD);
                }
            }
            else if (!special_down)
            {
                window = 3;
                window_timer = 0;
            }
            else if (uhc_nspecial_charges < uhc_nspecial_charges_max)
                 && (window_timer == (get_window_value(AT_NSPECIAL, 2, AG_WINDOW_LENGTH) - 1))
            {
                uhc_nspecial_charges++;
                sound_play((uhc_nspecial_charges == uhc_nspecial_charges_max ? 
                            asset_get("mfx_star") : asset_get("mfx_player_ready")), 
                            false, noone, 1, 0.75 + (0.15 * uhc_nspecial_charges));
            }
        }
        else if (window == 3)
        {
            if (window_timer == 1 && !hitpause)
            {
                //vsp boost
                if (free) vsp = min(vsp, 0) - 3 - 0.5 *uhc_nspecial_charges;
                
                //set grid data
                set_num_hitboxes(AT_NSPECIAL, 1 + uhc_nspecial_charges);
                
                for (var i = 0; i <= uhc_nspecial_charges; i++)
                {
                    //downwards spread
                    if (free)
                    {
                        temp_angle = -45 + i * 6;
                    }
                    //upwards spread
                    else if (!joy_pad_idle) && (joy_dir >= 45 && joy_dir <= 135)
                    {
                        temp_angle = i * 6;
                    }
                    //very slight spread around center
                    else
                    {
                        temp_angle = 3*i;
                    }
                    
                    set_hitbox_value(AT_NSPECIAL, i+1, HG_PROJECTILE_HSPEED, 
                                     lengthdir_x(uhc_nspecial_speed, temp_angle));
                    set_hitbox_value(AT_NSPECIAL, i+1, HG_PROJECTILE_VSPEED,
                                     lengthdir_y(uhc_nspecial_speed, temp_angle));
                }
                
                //consumes charge
                uhc_nspecial_charges = 0;
            }
        }
    } break;
//==========================================================
    case AT_FSPECIAL:
    {
        if (window <= 4)
        {
            can_move = false;
            //dampen momentum massively
            vsp *= (vsp < 0) ? 1 : 0.65;
            hsp *= (vsp < 0) ? 0.95 : 0.75;
        }
        if (window == 1)
        {
            if (window_timer == 1)
            {
                var goto_window = 
                  (uhc_fspecial_charge_current < uhc_fspecial_charge_half) ? 2 :
                  (uhc_fspecial_charge_current < uhc_fspecial_charge_max)  ? 3 : 4;
                
                set_window_value(AT_FSPECIAL, 1, AG_WINDOW_GOTO, goto_window);
                //Change SFX based on window (SFX stored on the target window)
                set_window_value(AT_FSPECIAL, 1, AG_WINDOW_SFX, 
                   get_window_value(AT_FSPECIAL, goto_window, AG_WINDOW_SFX));
            }
            else if (window_timer == get_window_value(AT_FSPECIAL, 1, AG_WINDOW_LENGTH) - 1)
            {
                move_cooldown[AT_FSPECIAL] = uhc_fspecial_cooldown;
                uhc_fspecial_charge_current = 0;
            }
        }
    } break;
//==========================================================
    case AT_DSPECIAL:
    {
        can_fast_fall = false;
        if (window == 1)
        {
            //try finding a target for CD recall
            if (uhc_has_cd_blade) { uhc_recalling_cd = noone; }
            else
            {
                var target_cd = noone;
                with (obj_article1) if (other.url == player_id.url) //CDs only
                 && (can_recall || (can_priority_recall && current_owner_id == other))
                {
                    if (other.uhc_current_cd == self)
                    {
                        if (other.uhc_rune_flags.dual_disk_system)
                        {
                            continue; //Skip recall. this lets a 2nd CD get created
                        }
                        target_cd = self;
                        break; //best match, can stop looking
                    }
                    if (target_cd == noone) //better than nothing
                    {
                        target_cd = self;
                        continue;
                    }
                    
                    var is_closer = distance_to_object(other) < 
                                    point_distance(target_cd.x, target_cd.y, other.x, other.y);
                                    
                    //closest "last thrown" CD 
                    if ((other == current_owner_id)
                    &&  (other != target_cd.current_owner_id || is_closer))
                    // or closest CD in general if a "last thrown" was not found
                    ||  (other != target_cd.current_owner_id && is_closer)
                    {
                        found_target_cd = self;
                    }
                }
                uhc_recalling_cd = target_cd;
                //CD is not allowed to die before recall happens
                if (uhc_recalling_cd != noone)
                { uhc_recalling_cd.pre_dspecial_immunity = 3; }
            }
            
            if (window_timer == 1)
            {
                uhc_anim_dspecial_image_timer = 0;
            }
            else if (window_timer == get_window_value(AT_DSPECIAL, 1, AG_WINDOW_LENGTH))
            {
                if (uhc_recalling_cd != noone)
                {
                    //handled separately
                    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_HAS_SFX, false);
                }
                else if (uhc_has_cd_blade || uhc_cd_can_respawn)
                {
                    window = 3;
                    window_timer = 0;
                }
                else //No CD, no Target
                {
                    set_window_value(AT_DSPECIAL, 2, AG_WINDOW_HAS_SFX, true);
                }
            }
        }
        else if (window == 2 && window_timer == 1 && !hitpause)
             && (uhc_recalling_cd != noone)
        {
            if (instance_exists(uhc_recalling_cd)
            && (uhc_recalling_cd.can_recall || uhc_recalling_cd.can_priority_recall))
            {
                sound_play(sfx_dspecial_reload);
                //this only becomes the "current CD" once it is caught
                //but it's already stolen from the previous hypercam
                if (uhc_recalling_cd.current_owner_id != self)
                && (uhc_recalling_cd.current_owner_id.uhc_current_cd == uhc_recalling_cd)
                {
                    uhc_recalling_cd.current_owner_id.uhc_current_cd = noone;
                }
                
                uhc_recalling_cd.buffered_state = AT_DSPECIAL;
                uhc_recalling_cd.current_owner_id = self;
                
                uhc_dspecial_is_recalling = true;
            }
            else //!?
            {
                sound_play(sfx_cd_missing);
                uhc_recalling_cd = noone;
            }
        }
        else if (window == 3 && !uhc_has_cd_blade)
        {
            //create new blade
            sound_play(asset_get("sfx_coin_collect"));
            uhc_current_cd = instance_create(x, y, "obj_article1");
            uhc_current_cd.cd_spin_meter = 0; //Set to Zero
            uhc_has_cd_blade = true;
            
            uhc_cd_respawn_timer = 0;
        }
        else if (window == 4)
        {
            if (uhc_current_cd.cd_spin_meter >= uhc_cd_spin_max 
            //RUNE: can overrewind as long as one star is affected
            && !(uhc_rune_flags.star_rewind && uhc_can_overrewind))
            || (shield_pressed || special_pressed || attack_pressed || jump_pressed)
            {
                window = 5;
                window_timer = 0;
            }
            else
            {
                uhc_current_cd.cd_spin_meter += uhc_cd_spin_charge_rate;
                if (window_timer % 6 == 0)
                {
                    create_hitbox(AT_DSPECIAL, 1, 
                                  floor(get_hitbox_value(AT_DSPECIAL, 1, HG_HITBOX_X)),
                                  floor(get_hitbox_value(AT_DSPECIAL, 1, HG_HITBOX_Y)));
                }
            }
        }
        else if (window == 6) || 
        (window == 5 && has_hit && window_timer >= get_window_value(AT_DSPECIAL, 5, AG_WINDOW_CANCEL_FRAME))
        {
            iasa_script();
        }
    } break;
//==========================================================
    case AT_USPECIAL:
    {
        can_move = (window == 6);
        can_fast_fall = false;
        can_wall_jump = (window > 2);
        
        if (window == 2 && window_timer == get_window_value(AT_USPECIAL, 2, AG_WINDOW_LENGTH) - 1)
        {
            uhc_uspecial_start_pos.x = x;
            uhc_uspecial_start_pos.y = y;
            //sync with this for animation
            uhc_anim_last_dodge.posx = x;
            uhc_anim_last_dodge.posy = y;
            uhc_uspecial_last_dir = 90; //default to upwards
        }
        //moving around
        else if (window == 3 || window == 4)
        {
            var uspecial_speed = uhc_uspecial_speed;
            if (!joy_pad_idle)
            {
                uspecial_speed = uhc_uspecial_speed_fast;
                uhc_uspecial_last_dir = joy_dir;
            }
            else if (uhc_do_cstick_special_check)
            {
                var stick_down = (up_stick_down || down_stick_down || left_stick_down || right_stick_down);
                if (stick_down)
                {
                    uspecial_speed = uhc_uspecial_speed_fast;
                    uhc_uspecial_last_dir = point_direction( 0, 0,right_stick_down - left_stick_down, 
                                                                   down_stick_down - up_stick_down);
                }
            }
            hsp = lengthdir_x(uspecial_speed, uhc_uspecial_last_dir);
            vsp = lengthdir_y(uspecial_speed, uhc_uspecial_last_dir);
        }
        var attack_stopped = false;
        var need_ejector = true;
        //non-ejecting cancel on shield (with penalty)
        if (shield_pressed && (window == 3 || window == 4))
        {
            window = 5; 
            window_timer = 1;
            attack_stopped = true;
            need_ejector = false;

            //apply penalty...
            if (0 < uhc_uspecial_soft_cooldown)
            {
               uhc_has_extended_pratland = true;
            }
            //... or start the penalty timer
            else
            {
                uhc_uspecial_soft_cooldown = uhc_uspecial_soft_cooldown_max;
            }
        }
        //autocancel if landing
        else if (!free && window > 2)
        {
            set_state(PS_PRATFALL);
            attack_stopped = true;
        }
        //ran out the clock
        else if (window == 5 && window_timer == 1)
        {
            attack_stopped = true;
        }
        //ejecting victims when its done
        if (attack_stopped)
        {
            if (instance_exists(uhc_uspecial_hitbox)) 
               { uhc_uspecial_hitbox.destroyed = true; }
            
            reset_hitbox_value(AT_USPECIAL, 3, HG_ANGLE);
            var travel_angle = point_direction(uhc_uspecial_start_pos.x, 
                                               uhc_uspecial_start_pos.y, x, y);
            set_hitbox_value(AT_USPECIAL, 3, HG_ANGLE, travel_angle);
            
            with (oPlayer) if (self != other && uhc_being_buffered_by == other)
            {
                //for each victim...
                var victim = self;
                uhc_being_buffered_by = noone;
                with (other) if (need_ejector)//...back to Hypercam
                {
                    var hitbox = create_hitbox(AT_USPECIAL, 3, floor(victim.x), floor(victim.y - victim.char_height/2));
                    hitbox.spr_dir = 1;
                }
            }
        }
    } break;
//==========================================================
    case AT_TAUNT:
    {
        if (window == 4)
        {
            if (taunt_pressed || special_pressed 
            || attack_pressed || jump_pressed)
            {
                window = 5;
                window_timer = 0;
                uhc_taunt_reloop = taunt_pressed;
            }
        }
        else if (window == 6 && uhc_taunt_reloop)
        {
            window = 2;
        }
        
        if (window == 3 || window == 4 || window == 5) && (shield_pressed)
        {
            uhc_taunt_muted = !uhc_taunt_muted;
            clear_button_buffer(PC_SHIELD_PRESSED);
            if (uhc_taunt_muted) sound_play(sound_get("sfx_popup"));

            if !(uhc_rune_flags.deadly_rickroll && uhc_taunt_current_video.special == 2)
            {
                if (uhc_taunt_muted)
                    sound_stop(uhc_taunt_current_audio);
                else if (uhc_taunt_buffering_timer == 0)
                    uhc_taunt_current_audio = 
                    sound_play(uhc_taunt_current_video.song, true, noone, 1, 1);
            }
        }

        //==============================================================
        // RUNE: Rickroll earrape
        // I'm almost sorry
        if (uhc_rune_flags.deadly_rickroll) && (uhc_taunt_current_video != noone)
         && (uhc_taunt_current_video.special == 2) && (uhc_taunt_timer % 31 == 1)
        {
            with (oPlayer) 
            if (self != other) && (get_player_team(player) != get_player_team(other.player))
            {
                var distance = point_distance(other.x, other.y, x, y);
                if (distance < 100)
                    take_damage(player, other.player, 4);
                else if (distance < 250)
                    take_damage(player, other.player, 2);
                else
                    take_damage(player, other.player, 1);
            }
        }
        //==============================================================
    } break;
    default:
    break;
//==========================================================
}

//==========================================================
if (attack == AT_FSTRONG || attack == AT_DSTRONG || attack == AT_USTRONG || attack == AT_DSTRONG_2)
{
    //RUNE: remote throws
    if (!uhc_has_cd_blade && (window == 1 && window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH) - 2))
        uhc_current_cd.buffered_state = 6; //spinup state when almost throwing

    //RUNE: fire disc
    if (uhc_rune_flags.fire_throws) && (window == 1)
    {
        if (strong_charge < 55 && strong_charge % 3 == 1)
        {
            strong_charge++; //accelerate normal chargetimes
        }
        else if (strong_charge == 58 && uhc_current_cd.rune_fire_charge < 30)
        {
            strong_charge--;
            uhc_last_strong_charge--; //hack to make aircharge rune still apply hitpause
            uhc_current_cd.rune_fire_charge++;
            if (uhc_has_cd_blade && uhc_current_cd.rune_fire_charge % 25 == 1)
            {
                take_damage( player, -1, 1);
            }
        }
        else if (window_timer == 1)
        {
            uhc_current_cd.rune_fire_charge = 0;
        }
    }
}

//==============================================================================
// Blade costs
if (uhc_has_cd_blade || uhc_spin_cost_throw_bypass) 
&& (window_timer == 1 && !hitpause)
{
    var window_cost = get_window_value(attack, window, AG_WINDOW_SPIN_COST);
    uhc_current_cd.cd_spin_meter = 
       clamp(uhc_current_cd.cd_spin_meter - window_cost, 0, uhc_cd_spin_max);
}

//==============================================================================
#define throw_blade(xoffset, yoffset, hspd, vspd, cd_atk)
{
    //throw failure: disc missing
    if !instance_exists(uhc_current_cd) return; 

    if (uhc_has_cd_blade)
    {
        uhc_current_cd.x = x + (spr_dir * xoffset);
        uhc_current_cd.y = y - yoffset;
    }

    uhc_current_cd.hsp = spr_dir * hspd;
    uhc_current_cd.vsp = vspd;
    uhc_current_cd.spr_dir = spr_dir;
    
    uhc_current_cd.rune_throw_was_remote = !uhc_has_cd_blade;

    uhc_has_cd_blade = false;
    uhc_pickup_cooldown = uhc_pickup_cooldown_max;
    
    //Set specific attack as the CD state
    uhc_current_cd.buffered_state = cd_atk;

    //just thrown a CD, need to apply costs inconditionally
    uhc_spin_cost_throw_bypass = true;

    //what if the melee hitbox was parried?
    if (was_parried)
    {
        uhc_current_cd.was_parried = true;
        uhc_current_cd.last_parried_by_player = parry_id.player;
    }
    
    // air throw penality detection
    uhc_current_cd.aerial_strong_check = free;
    uhc_current_cd.aerial_strong_frames = 0;
}
//==============================================================================
#define adjust_bladed_attack_grid()
{
    //Hitbox bonuses
    if (uhc_has_cd_blade)
    {
        //activate blade hitboxes
        if (0 < get_attack_value(attack, AG_NUM_HITBOXES_BLADED))
        { set_num_hitboxes(attack, get_attack_value(attack, AG_NUM_HITBOXES_BLADED)); }
        
        //apply buffs based on current charge level
        var charge_percent = (uhc_current_cd.cd_spin_meter / uhc_cd_spin_max);
        charge_percent = min(1, charge_percent / uhc_cd_spin_effective_max);

        for (var hb = 1; hb <= get_num_hitboxes(attack); hb++)
        {
            // Projectile-blades handled separately
            if (1 == get_hitbox_value(attack, hb, HG_HITBOX_TYPE))
            {
                apply_spin_bonus(charge_percent, attack, hb, HG_DAMAGE, HG_SPIN_DAMAGE_BONUS);
                apply_spin_bonus(charge_percent, attack, hb, HG_BASE_HITPAUSE, HG_SPIN_HITPAUSE_BONUS);
                apply_spin_bonus(charge_percent, attack, hb, HG_BASE_KNOCKBACK, HG_SPIN_KNOCKBACK_BONUS);
                apply_spin_bonus(charge_percent, attack, hb, HG_KNOCKBACK_SCALING, HG_SPIN_KNOCKBACK_SCALING_BONUS);
            }
            
            //SFX "bonus"
            if (get_hitbox_value(attack, hb, HG_SPIN_SFX) > 0)
            {
                if (attack == AT_FAIR || attack == AT_BAIR)
                && (charge_percent > uhc_spin_sfx_high_threshold)
                { set_hitbox_value(attack, hb, HG_HIT_SFX, sound_get("sfx_tf2_sawblade")); }
                else if (charge_percent > uhc_spin_sfx_threshold)
                { set_hitbox_value(attack, hb, HG_HIT_SFX, get_hitbox_value(attack, hb, HG_SPIN_SFX)); }
                else
                { reset_hitbox_value(attack, hb, HG_HIT_SFX); }
            }
        }
    }
    else
    {
        //reset to number of non-bladed hitboxes
        reset_num_hitboxes(attack);
    }
    
    //Window bonuses
    for (var w = 1; w <= get_attack_value(attack, AG_NUM_WINDOWS); w++)
    {
        reset_window_value(attack, w, AG_WINDOW_LENGTH);
        if (uhc_has_cd_blade)
        && (0 < get_window_value(attack, w, AG_WINDOW_LENGTH_BLADED))
        { 
            set_window_value(attack, w, AG_WINDOW_LENGTH,
                             get_window_value(attack, w, AG_WINDOW_LENGTH_BLADED));
        }
    }

    //RUNE: whifflag immunity
    if (uhc_rune_flags.whiffless && !uhc_has_cd_blade) has_hit = true;
}

//===============================================
#define apply_spin_bonus(charge_percent, atk, hnum, base_index, bonus_index)
{
    if (0 < get_hitbox_value(atk, hnum, bonus_index))
    {
        reset_hitbox_value(atk, hnum, base_index);
        
        // total = base + charge * bonus
        // DAN PLS FIX: actually using lerp(base -> base+bonus) to restrain a bug with reset.
        var value = lerp(get_hitbox_value(atk, hnum, base_index), 
                         get_hitbox_value(atk, hnum, bonus_index), charge_percent);
        set_hitbox_value(atk, hnum, base_index, value);
    }
}