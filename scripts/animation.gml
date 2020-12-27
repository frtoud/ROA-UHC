//animation.gml

//===============================================================
//Blade spin animation
if (uhc_has_cd_blade)
{
    var spin_speed = 0.5 * (uhc_current_cd.cd_spin_meter / uhc_cd_spin_max);
    anim_blade_spin = (3 + anim_blade_spin - spin_speed) % 3;
}

//Blinker animation
anim_blink_timer = (anim_blink_timer + 2) % anim_blink_timer_max;
//===============================================================

init_shader();

switch (state)
{
    case PS_IDLE:
    {
        
    } break;
    case PS_WALK:
    {
        //walk sound (synced with 8 frames walk, 0.2 anim speed)
        if ((state_timer % 20) == 15)
        {
            sound_play(asset_get("sfx_may_arc_five"), false, noone, 0.2, 3);
        }
    } break;
    case PS_JUMPSQUAT:
    {
        //wheeled sprite when jumping from a dash
        image_index = (prev_state == PS_DASH 
                    || prev_state == PS_DASH_START
                    || prev_state == PS_DASH_TURN) ? 1 : 0;
        
    } break;
    case PS_AIR_DODGE:
    {
        if (window == 0)
        {
            //beginning of dodge
            anim_last_dodge.posx = x;
            anim_last_dodge.posy = y;
        }
    } break;
    default: break;
}