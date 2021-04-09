//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse();
}

// Sync grid data with blade & charge
// always done at least once at the start of a move
if (uhc_update_blade_status) 
{
    adjust_bladed_attack_grid();
    uhc_update_blade_status = false;
}

switch (attack)
{
//==========================================================
    case AT_DATTACK:
    {
        hsp = clamp(hsp, -dash_speed, dash_speed);
        
        if (window == 1 && window_timer == 1)
        { uhc_dattack_can_exit = false; }
        
        if (window == 3)
        {
            if (window_timer >= 8)
            {
                uhc_dattack_can_exit = true;
            }
            
            if ((window_timer % 6) == 1 && !hitpause)
            && (uhc_has_cd_blade && uhc_current_cd.cd_spin_meter > 0)
            {
                //Looping hitbox as long as you hold
                sound_play(asset_get("sfx_swipe_weak1"));
                create_hitbox(AT_DATTACK, 4, 0, 0);
            }
            
            if (!attack_down && uhc_dattack_can_exit) 
            { 
                window = 4;
                window_timer = 0;
                destroy_hitboxes();
            }
        }
    } break;
//==========================================================
    case AT_FSTRONG:
    {
        can_move = false;
        if (window <= 2)
        {
            //dampen fall?
            vsp *= (vsp < 0) ? 1 : 0.85;
        }
        else if (window == 3 && window_timer == 1)
        {
            throw_blade(32, 20, uhc_fstrong_throwspeed_base + (strong_charge/60.0) * 
                               (uhc_fstrong_throwspeed_max - uhc_fstrong_throwspeed_base)
                               + (hsp*spr_dir*0.5), 0, AT_FSTRONG);
        }
    } break;
//==========================================================
    case AT_USTRONG:
    {
        if (window == 3 && window_timer == 1)
        {
            throw_blade(12, 65, uhc_ustrong_throwspeed_horz + 0.5* hsp, 
                                uhc_ustrong_throwspeed_base + (strong_charge/60.0) * 
                               (uhc_ustrong_throwspeed_max - uhc_ustrong_throwspeed_base), AT_USTRONG);
        }
    } break;
//==========================================================
    case AT_DSTRONG_2:
    {
        if (window == 2 && window_timer == 1)
        {
            throw_blade(0, 20, 0, uhc_dstrong_throwspeed, AT_DSTRONG_2);
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
        else if (window == 4) && (hitpause)
        {
            //Hitpause dictates the length of the plasma stun
            //but the point is to not have hitpause on hypercam
            hitstop = 0;
            hitpause = false;
        }
    } break;
//==========================================================
    case AT_DSPECIAL:
    {
        can_shield = (window > 1);
        
        if (window == 1 && window_timer == 6)
        {
            uhc_anim_dspecial_image_timer = 0;
            if (!uhc_has_cd_blade)
            {
                //"create" new blade
                uhc_current_cd.buffered_state = 0; //Set to DEAD
                uhc_has_cd_blade = true;
            }
        }
        else if (window == 2)
        {
            if (uhc_current_cd.cd_spin_meter >= uhc_cd_spin_max)
            {
                window = 3;
                window_timer = 0;
            }
            else
            {
                uhc_current_cd.cd_spin_meter += uhc_cd_spin_charge_rate;
            }
        }
    } break;
//==========================================================
    case AT_TAUNT:
    {
        if (window >= 2 && window <= 6)
        { suppress_stage_music(0, 0.01); }

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
    } break;
    default:
    break;
//==========================================================
}

if (attack == AT_NSPECIAL){
    if (window == 3){
        if (special_pressed){
            window = 1;
            window_timer = 0;
        }
    }
}

if (attack == AT_USPECIAL){
    if (window == 1 && window_timer == 1){
        times_through = 0;
    }
    if (window == 2){
        if (window_timer == get_window_value(attack, 2, AG_WINDOW_LENGTH)){
            if (times_through < 10){
                times_through++;
                window_timer = 0;
            }
        }
        if (!joy_pad_idle){
            hsp += lengthdir_x(1, joy_dir);
            vsp += lengthdir_y(1, joy_dir);
        } else {
            hsp *= .6;
            vsp *= .6;
        }
        var fly_dir = point_direction(0,0,hsp,vsp);
        var fly_dist = point_distance(0,0,hsp,vsp);
        var max_speed = 12;
        if (fly_dist > max_speed){
            hsp = lengthdir_x(max_speed, fly_dir);
            vsp = lengthdir_y(max_speed, fly_dir);
        }
        if (special_pressed && times_through > 0){
            window = 4;
            window_timer = 0;
        }
        if (shield_pressed){
            window = 3;
            window_timer = 0;
        }
    }
    if (window > 3 && window < 6 && window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH)){
        window++;
        window_timer = 0;
    }
}


//==============================================================================
// Blade costs
if (uhc_has_cd_blade && window_timer == 1)
{
    var window_cost = get_window_value(attack, window, AG_WINDOW_SPIN_COST);
    uhc_current_cd.cd_spin_meter = 
       clamp(uhc_current_cd.cd_spin_meter - window_cost, 0, uhc_cd_spin_max);
}

//==============================================================================
#define throw_blade(xoffset, yoffset, hspd, vspd, cd_atk)
{
    uhc_current_cd.x = x + (spr_dir * xoffset);
    uhc_current_cd.y = y - yoffset;
    uhc_current_cd.hsp = spr_dir * hspd;
    uhc_current_cd.vsp = vspd;
    uhc_current_cd.spr_dir = spr_dir;
    
    uhc_has_cd_blade = false;
    
    //Set specific attack as the CD state
    uhc_current_cd.buffered_state = cd_atk;
    
    //swapping CD indexes
    var temp_cd = uhc_current_cd;
    uhc_current_cd = uhc_other_cd;
    uhc_other_cd = temp_cd;
}
//==============================================================================
#define adjust_bladed_attack_grid()
{
    if (uhc_has_cd_blade)
    {
        //activate blade hitboxes
        if (0 < get_attack_value(attack, AG_NUM_HITBOXES_BLADED))
        { set_num_hitboxes(attack, get_attack_value(attack, AG_NUM_HITBOXES_BLADED)); }
        
        //apply buffs based on current charge level
        var charge_percent = (uhc_current_cd.cd_spin_meter / uhc_cd_spin_max);
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
        }
    }
    else
    {
        //reset to number of non-bladed hitboxes
        reset_num_hitboxes(attack);
    }
}

//===============================================
#define apply_spin_bonus(charge_percent, atk, hnum, base_index, bonus_index)
{
    if (0 < get_hitbox_value(atk, hnum, bonus_index))
    {
        reset_hitbox_value(atk, hnum, base_index);
        
        // total = base + charge * bonus
        var value = get_hitbox_value(atk, hnum, base_index)
           + (charge_percent * get_hitbox_value(atk, hnum, bonus_index) );
        set_hitbox_value(atk, hnum, base_index, value);
    }
}