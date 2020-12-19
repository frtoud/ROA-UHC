//animation.gml

anim_blade_spin = (3 + anim_blade_spin - 0.2) % 3;
anim_blink_timer = (anim_blink_timer + 2) % anim_blink_timer_max;

if (get_gameplay_time() % 60 == 0)
{
    //at_dspecial_has_blade = !at_dspecial_has_blade;
}

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