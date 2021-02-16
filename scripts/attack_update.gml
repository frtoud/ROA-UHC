//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse();
}

switch (attack)
{
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

if (attack == AT_FSPECIAL){
    if (window == 2){
        if (special_pressed){
            window = 3;
            window_timer = 0;
            destroy_hitboxes();
        }
    }
    can_fast_fall = false;
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

if (attack == AT_DSPECIAL){
    if (window == 2 && !was_parried){
        can_jump = true;
        if (window_timer == 1)
        {
            if (uhc_has_cd_blade)
            { uhc_current_cd.cd_spin_meter = uhc_cd_spin_max; }
            else
            { uhc_current_cd.buffered_state = AT_DSPECIAL; }
        }
    }
    can_fast_fall = false;
    can_move = false
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