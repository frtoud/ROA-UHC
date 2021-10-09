//update.gml

//=====================================================
// if holding a CD; restore if its missing.
if (uhc_has_cd_blade && !instance_exists(uhc_current_cd))
{
    print("hey dude not cool i was hodling tht >:[")
    uhc_current_cd = instance_create(x, y, "obj_article1"); 
}

//=====================================================
//All states that don't count for charges
uhc_no_charging = (state == PS_RESPAWN) || (state == PS_SPAWN) || (state == PS_DEAD)
               || (state == PS_ATTACK_GROUND && attack == AT_TAUNT);

//=====================================================
//FSPECIAL recharge
if (uhc_fspecial_charge_current < uhc_fspecial_charge_max)
    && !uhc_no_charging
{
    uhc_fspecial_charge_current++;
}

//=====================================================
// Blade respawn cooldown
uhc_cd_can_respawn = uhc_cd_respawn_timer >= uhc_cd_respawn_timer_max;
if (!uhc_cd_can_respawn && !uhc_no_charging) && !instance_exists(uhc_current_cd)
{
    uhc_cd_respawn_timer++;
    if (uhc_cd_respawn_timer >= uhc_cd_respawn_timer_max)
    {
        sound_play(sfx_cd_respawn);
    }
}

//=====================================================
//Blade pickup cooldown (see article1_update)
if (uhc_pickup_cooldown > 0)
{ uhc_pickup_cooldown--; }

//=====================================================
//Throws cooldown override (see set_attack)
if (uhc_throw_cooldown_override > 0)
{ uhc_throw_cooldown_override--; }

//=====================================================
// Recalling logic
if (uhc_dspecial_is_recalling) 
{
    //prevent move spam during recall
    move_cooldown[AT_DSPECIAL] = 2;
    
    if (state_cat == SC_HITSTUN) // Got hit
    || (uhc_has_cd_blade) //caught CD
    || (state == PS_DEAD || state == PS_RESPAWN) // Got killed
    || !instance_exists(uhc_recalling_cd) // CD missing
    || (uhc_recalling_cd.state != AT_DSPECIAL 
     && uhc_recalling_cd.buffered_state != AT_DSPECIAL) // CD stopped recall
    {
        if (instance_exists(uhc_recalling_cd) 
        && uhc_recalling_cd.state == AT_DSPECIAL)
        {
            uhc_recalling_cd.buffered_state = 1;  //Idle 
        }
        uhc_recalling_cd = noone; 
        uhc_dspecial_is_recalling = false;
    }
}

//=====================================================
// If this was true (from previous frame) and you were sent to hitstun, lose charge
if (uhc_nspecial_is_charging) && (state_cat == SC_HITSTUN)
{
    uhc_nspecial_charges = 0;
}
uhc_nspecial_is_charging = (state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND)
                            && ((attack == AT_NSPECIAL) && window < 3);

//======================================================
// USpecial Walljump-cancelled: free the victims
if (state == PS_WALL_JUMP && attack == AT_USPECIAL)
{
    if (instance_exists(uhc_uspecial_hitbox)) 
    { uhc_uspecial_hitbox.destroyed = true; }
    with (oPlayer) if (self != other && uhc_being_buffered_by == other)
    {
        uhc_being_buffered_by = noone;
    }
}

//======================================================
// Kirby compatibility
if (swallowed && instance_exists(enemykirby))
{
    //Move setup
    var ability_spr = sprite_get("cmp_kirby");
    var ability_hurt = sprite_get("cmp_kirby_hurt")
    var ability_icon = sprite_get("cmp_kirby_icon")
    var kirby_sleep_sfx = sound_get("cmp_kirby_sleep")
    
    with (enemykirby)
    {
        //Define AT_EXTRA_3 for Kirby
        {
            set_attack_value(AT_EXTRA_3, AG_CATEGORY, 2);
            set_attack_value(AT_EXTRA_3, AG_SPRITE, ability_spr);
            set_attack_value(AT_EXTRA_3, AG_AIR_SPRITE, ability_spr);
            set_attack_value(AT_EXTRA_3, AG_NUM_WINDOWS, 3);
            set_attack_value(AT_EXTRA_3, AG_OFF_LEDGE, 1);
            set_attack_value(AT_EXTRA_3, AG_HURTBOX_SPRITE, ability_hurt);

            set_window_value(AT_EXTRA_3, 1, AG_WINDOW_TYPE, 0);
            set_window_value(AT_EXTRA_3, 1, AG_WINDOW_LENGTH, 12);
            set_window_value(AT_EXTRA_3, 1, AG_WINDOW_ANIM_FRAMES, 3);
            set_window_value(AT_EXTRA_3, 1, AG_WINDOW_HAS_SFX, 1);
            set_window_value(AT_EXTRA_3, 1, AG_WINDOW_SFX, asset_get("sfx_absa_orb_miss"));
            set_window_value(AT_EXTRA_3, 1, AG_WINDOW_SFX_FRAME, 11);
            set_window_value(AT_EXTRA_3, 2, AG_WINDOW_GOTO, 0);

            set_window_value(AT_EXTRA_3, 2, AG_WINDOW_TYPE, 0);
            set_window_value(AT_EXTRA_3, 2, AG_WINDOW_LENGTH, 4);
            set_window_value(AT_EXTRA_3, 2, AG_WINDOW_ANIM_FRAMES, 2);
            set_window_value(AT_EXTRA_3, 2, AG_WINDOW_ANIM_FRAME_START, 3);
            set_window_value(AT_EXTRA_3, 2, AG_WINDOW_HAS_CUSTOM_FRICTION, true);
            set_window_value(AT_EXTRA_3, 2, AG_WINDOW_CUSTOM_AIR_FRICTION, 3);
            set_window_value(AT_EXTRA_3, 2, AG_WINDOW_CUSTOM_GROUND_FRICTION, 3);
            set_window_value(AT_EXTRA_3, 2, AG_WINDOW_GOTO, 0);
            
            set_window_value(AT_EXTRA_3, 3, AG_WINDOW_TYPE, 0);
            set_window_value(AT_EXTRA_3, 3, AG_WINDOW_LENGTH, 20);
            set_window_value(AT_EXTRA_3, 3, AG_WINDOW_ANIM_FRAMES, 4);
            set_window_value(AT_EXTRA_3, 3, AG_WINDOW_ANIM_FRAME_START, 5);
            set_window_value(AT_EXTRA_3, 3, AG_WINDOW_GOTO, 0);

            set_num_hitboxes(AT_EXTRA_3, 6);

            //no charge
            set_hitbox_value(AT_EXTRA_3, 1, HG_HITBOX_TYPE, 1);
            set_hitbox_value(AT_EXTRA_3, 1, HG_WINDOW, 2);
            set_hitbox_value(AT_EXTRA_3, 1, HG_LIFETIME, 4);
            set_hitbox_value(AT_EXTRA_3, 1, HG_HITBOX_X, 30);
            set_hitbox_value(AT_EXTRA_3, 1, HG_HITBOX_Y, -24);
            set_hitbox_value(AT_EXTRA_3, 1, HG_WIDTH, 50);
            set_hitbox_value(AT_EXTRA_3, 1, HG_HEIGHT, 50);
            set_hitbox_value(AT_EXTRA_3, 1, HG_PRIORITY, 1);
            set_hitbox_value(AT_EXTRA_3, 1, HG_DAMAGE, 5);
            set_hitbox_value(AT_EXTRA_3, 1, HG_ANGLE, 90);
            set_hitbox_value(AT_EXTRA_3, 1, HG_BASE_KNOCKBACK, 3);
            set_hitbox_value(AT_EXTRA_3, 1, HG_KNOCKBACK_SCALING, 0);
            set_hitbox_value(AT_EXTRA_3, 1, HG_BASE_HITPAUSE, 4);
            set_hitbox_value(AT_EXTRA_3, 1, HG_EXTRA_HITPAUSE, 12);
            set_hitbox_value(AT_EXTRA_3, 1, HG_VISUAL_EFFECT, 20);
            set_hitbox_value(AT_EXTRA_3, 1, HG_HIT_SFX, asset_get("sfx_absa_singlezap2"));
            set_hitbox_value(AT_EXTRA_3, 1, HG_IGNORES_PROJECTILES, 1);

            //half charge
            set_hitbox_value(AT_EXTRA_3, 2, HG_HITBOX_TYPE, 1);
            set_hitbox_value(AT_EXTRA_3, 2, HG_WINDOW, 0);
            set_hitbox_value(AT_EXTRA_3, 2, HG_LIFETIME, 4);
            set_hitbox_value(AT_EXTRA_3, 2, HG_HITBOX_X, 45);
            set_hitbox_value(AT_EXTRA_3, 2, HG_HITBOX_Y, -24);
            set_hitbox_value(AT_EXTRA_3, 2, HG_WIDTH, 80);
            set_hitbox_value(AT_EXTRA_3, 2, HG_HEIGHT, 60);
            set_hitbox_value(AT_EXTRA_3, 2, HG_PRIORITY, 3);
            set_hitbox_value(AT_EXTRA_3, 2, HG_DAMAGE, 8);
            set_hitbox_value(AT_EXTRA_3, 2, HG_ANGLE, 90);
            set_hitbox_value(AT_EXTRA_3, 2, HG_BASE_KNOCKBACK, 7);
            set_hitbox_value(AT_EXTRA_3, 2, HG_KNOCKBACK_SCALING, .1);
            set_hitbox_value(AT_EXTRA_3, 2, HG_BASE_HITPAUSE, 0);
            set_hitbox_value(AT_EXTRA_3, 2, HG_EXTRA_HITPAUSE, 24);
            set_hitbox_value(AT_EXTRA_3, 2, HG_VISUAL_EFFECT, 21);
            set_hitbox_value(AT_EXTRA_3, 2, HG_HIT_SFX, asset_get("sfx_absa_singlezap2"));
            set_hitbox_value(AT_EXTRA_3, 2, HG_IGNORES_PROJECTILES, 1);

            set_hitbox_value(AT_EXTRA_3, 3, HG_HITBOX_TYPE, 1);
            set_hitbox_value(AT_EXTRA_3, 3, HG_WINDOW, 0);
            set_hitbox_value(AT_EXTRA_3, 3, HG_LIFETIME, 4);
            set_hitbox_value(AT_EXTRA_3, 3, HG_HITBOX_X, 70);
            set_hitbox_value(AT_EXTRA_3, 3, HG_HITBOX_Y, -24);
            set_hitbox_value(AT_EXTRA_3, 3, HG_WIDTH, 70);
            set_hitbox_value(AT_EXTRA_3, 3, HG_HEIGHT, 125);
            set_hitbox_value(AT_EXTRA_3, 3, HG_PRIORITY, 2);
            set_hitbox_value(AT_EXTRA_3, 3, HG_DAMAGE, 6);
            set_hitbox_value(AT_EXTRA_3, 3, HG_ANGLE, 90);
            set_hitbox_value(AT_EXTRA_3, 3, HG_BASE_KNOCKBACK, 6);
            set_hitbox_value(AT_EXTRA_3, 3, HG_KNOCKBACK_SCALING, .1);
            set_hitbox_value(AT_EXTRA_3, 3, HG_BASE_HITPAUSE, 0);
            set_hitbox_value(AT_EXTRA_3, 3, HG_EXTRA_HITPAUSE, 20);
            set_hitbox_value(AT_EXTRA_3, 3, HG_VISUAL_EFFECT, 21);
            set_hitbox_value(AT_EXTRA_3, 3, HG_HIT_SFX, asset_get("sfx_absa_singlezap2"));
            set_hitbox_value(AT_EXTRA_3, 3, HG_IGNORES_PROJECTILES, 1);

            //full charge
            set_hitbox_value(AT_EXTRA_3, 4, HG_HITBOX_TYPE, 1);
            set_hitbox_value(AT_EXTRA_3, 4, HG_WINDOW, 0);
            set_hitbox_value(AT_EXTRA_3, 4, HG_LIFETIME, 4);
            set_hitbox_value(AT_EXTRA_3, 4, HG_HITBOX_X, 45);
            set_hitbox_value(AT_EXTRA_3, 4, HG_HITBOX_Y, -24);
            set_hitbox_value(AT_EXTRA_3, 4, HG_WIDTH, 80);
            set_hitbox_value(AT_EXTRA_3, 4, HG_HEIGHT, 60);
            set_hitbox_value(AT_EXTRA_3, 4, HG_PRIORITY, 5);
            set_hitbox_value(AT_EXTRA_3, 4, HG_DAMAGE, 15);
            set_hitbox_value(AT_EXTRA_3, 4, HG_ANGLE, 90);
            set_hitbox_value(AT_EXTRA_3, 4, HG_BASE_KNOCKBACK, 7);
            set_hitbox_value(AT_EXTRA_3, 4, HG_KNOCKBACK_SCALING, .3);
            set_hitbox_value(AT_EXTRA_3, 4, HG_BASE_HITPAUSE, 0);
            set_hitbox_value(AT_EXTRA_3, 4, HG_EXTRA_HITPAUSE, 50);
            set_hitbox_value(AT_EXTRA_3, 4, HG_VISUAL_EFFECT, 197);
            set_hitbox_value(AT_EXTRA_3, 4, HG_HIT_SFX, asset_get("sfx_absa_singlezap2"));

            set_hitbox_value(AT_EXTRA_3, 5, HG_HITBOX_TYPE, 1);
            set_hitbox_value(AT_EXTRA_3, 5, HG_WINDOW, 0);
            set_hitbox_value(AT_EXTRA_3, 5, HG_LIFETIME, 4);
            set_hitbox_value(AT_EXTRA_3, 5, HG_HITBOX_X, 105);
            set_hitbox_value(AT_EXTRA_3, 5, HG_HITBOX_Y, -24);
            set_hitbox_value(AT_EXTRA_3, 5, HG_WIDTH, 140);
            set_hitbox_value(AT_EXTRA_3, 5, HG_HEIGHT, 180);
            set_hitbox_value(AT_EXTRA_3, 5, HG_PRIORITY, 4);
            set_hitbox_value(AT_EXTRA_3, 5, HG_DAMAGE, 12);
            set_hitbox_value(AT_EXTRA_3, 5, HG_ANGLE, 90);
            set_hitbox_value(AT_EXTRA_3, 5, HG_BASE_KNOCKBACK, 6);
            set_hitbox_value(AT_EXTRA_3, 5, HG_KNOCKBACK_SCALING, .3);
            set_hitbox_value(AT_EXTRA_3, 5, HG_BASE_HITPAUSE, 0);
            set_hitbox_value(AT_EXTRA_3, 5, HG_EXTRA_HITPAUSE, 40);
            set_hitbox_value(AT_EXTRA_3, 5, HG_VISUAL_EFFECT, 197);
            set_hitbox_value(AT_EXTRA_3, 5, HG_HIT_SFX, asset_get("sfx_absa_singlezap2"));

            set_hitbox_value(AT_EXTRA_3, 6, HG_HITBOX_TYPE, 1);
            set_hitbox_value(AT_EXTRA_3, 6, HG_WINDOW, 0);
            set_hitbox_value(AT_EXTRA_3, 6, HG_LIFETIME, 4);
            set_hitbox_value(AT_EXTRA_3, 6, HG_HITBOX_X, 145);
            set_hitbox_value(AT_EXTRA_3, 6, HG_HITBOX_Y, -24);
            set_hitbox_value(AT_EXTRA_3, 6, HG_WIDTH, 100);
            set_hitbox_value(AT_EXTRA_3, 6, HG_HEIGHT, 300);
            set_hitbox_value(AT_EXTRA_3, 6, HG_PRIORITY, 3);
            set_hitbox_value(AT_EXTRA_3, 6, HG_DAMAGE, 10);
            set_hitbox_value(AT_EXTRA_3, 6, HG_ANGLE, 90);
            set_hitbox_value(AT_EXTRA_3, 6, HG_BASE_KNOCKBACK, 5);
            set_hitbox_value(AT_EXTRA_3, 6, HG_KNOCKBACK_SCALING, .2);
            set_hitbox_value(AT_EXTRA_3, 6, HG_BASE_HITPAUSE, 0);
            set_hitbox_value(AT_EXTRA_3, 6, HG_EXTRA_HITPAUSE, 30);
            set_hitbox_value(AT_EXTRA_3, 6, HG_VISUAL_EFFECT, 197);
            set_hitbox_value(AT_EXTRA_3, 6, HG_HIT_SFX, asset_get("sfx_absa_singlezap2"));
        }
        newicon = ability_icon;
        //Hypercam will track this Kirby to handle screenshot shenanigans
        uhc_handler_id = other;
        uhc_has_kirby_ability = true;
        uhc_kirby_charge = other.uhc_fspecial_cooldown;
    }
    swallowed = false;
}

//Kirby's attack_update
with (oPlayer) if (uhc_handler_id == other)
{
    if (uhc_has_kirby_ability)
    {
        //passive recharge
        if (uhc_kirby_charge < uhc_handler_id.uhc_fspecial_charge_max)
        { uhc_kirby_charge++; }
        //animation counter
        if (uhc_kirby_anim_timer > 0)
        { uhc_kirby_anim_timer--; }

        if (current_ability == 0)
        {
            //Losing the ability is needed to get a new one so this is ok
            uhc_has_kirby_ability = false;
            uhc_kirby_charge = 0;
            uhc_kirby_anim_timer = 0;
            uhc_handler_id = noone;
            move_cooldown[AT_EXTRA_3] = 0;
        }
        else if ((state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND)
                && (attack == AT_EXTRA_3))
        {
            //Using the copied move -- see attack_update FSPECIAL
            if (window <= 2)
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
                    has_hit_is_new = true;

                    var charge_level = 
                    (uhc_kirby_charge < uhc_handler_id.uhc_fspecial_charge_half) ? 1 :
                    (uhc_kirby_charge < uhc_handler_id.uhc_fspecial_charge_max)  ? 2 : 3;
                    
                    //Change SFX/hitbox activations based on charge
                    set_window_value(AT_EXTRA_3, 1, AG_WINDOW_SFX, 
                                        (charge_level == 1) ? asset_get("sfx_absa_orb_miss") :
                                        (charge_level == 2) ? asset_get("sfx_absa_new_whip1") 
                                                            : asset_get("sfx_absa_whip3"));
                    
                    set_hitbox_value(AT_EXTRA_3, 1, HG_WINDOW, (charge_level == 1) ? 2 : 0);
                    
                    set_hitbox_value(AT_EXTRA_3, 2, HG_WINDOW, (charge_level == 2) ? 2 : 0);
                    set_hitbox_value(AT_EXTRA_3, 3, HG_WINDOW, (charge_level == 2) ? 2 : 0);

                    set_hitbox_value(AT_EXTRA_3, 4, HG_WINDOW, (charge_level == 3) ? 2 : 0);
                    set_hitbox_value(AT_EXTRA_3, 5, HG_WINDOW, (charge_level == 3) ? 2 : 0);
                    set_hitbox_value(AT_EXTRA_3, 6, HG_WINDOW, (charge_level == 3) ? 2 : 0);

                    uhc_kirby_anim_charge_level = charge_level;
                }
                else if (window_timer == get_window_value(AT_EXTRA_3, 1, AG_WINDOW_LENGTH) - 1)
                {
                    //Kirby's cooldown counts down twice as fast!?
                    move_cooldown[AT_EXTRA_3] = 2 * uhc_handler_id.uhc_fspecial_cooldown;
                    uhc_kirby_charge = 0;
                    uhc_kirby_anim_timer = uhc_handler_id.uhc_anim_fspecial_flash_time;

                    //for easter egg to accurately take the current sprite (check below is one frame late)
                    with (oPlayer)
                    {
                        uhc_kirby_last_sprite.spr = sprite_index;
                        uhc_kirby_last_sprite.img = image_index;
                        uhc_kirby_last_sprite.time = get_gameplay_time();
                    }
                }
            }
            else if (window == 2 && has_hit && has_hit_is_new)
            {
                has_hit_is_new = false;
                //detect a hit during window 2
                //should be hitbox #1 of AT_EXTRA_1
                //see hit_player
                if instance_exists(hit_player_obj) && instance_exists(my_hitboxID)
                && (my_hitboxID.attack == AT_EXTRA_3 && my_hitboxID.hbox_num == 1)
                {
                    var victim = hit_player_obj;
                    with (uhc_handler_id) 
                    if (uhc_unsafe_screenshot.next_time < current_time)
                    {
                        uhc_unsafe_screenshot.sfx_time   = current_time +   500;
                        uhc_unsafe_screenshot.start_time = current_time +   750;
                        uhc_unsafe_screenshot.rise_time  = current_time +  1000;
                        uhc_unsafe_screenshot.fall_time  = current_time +  1000 + (uhc_fast_screenshot ? 1000 : 6000);
                        uhc_unsafe_screenshot.end_time   = current_time +  1250 + (uhc_fast_screenshot ? 1000 : 6000);
                        with (oPlayer) if ("uhc_unsafe_screenshot" in self)
                        { uhc_unsafe_screenshot.next_time  = current_time + 10000; }
                        
                        var scale = 1 + victim.small_sprites;
                        
                        var height_offset = clamp(victim.y - other.y + 2, -24, 24);
                        uhc_unsafe_screenshot.target = victim;
                        uhc_unsafe_screenshot.spr_dir = victim.spr_dir;
                        if ("uhc_custom_screenshot_sprite" in victim
                        && victim.uhc_custom_screenshot_sprite != noone)
                        {
                            uhc_unsafe_screenshot.sprite = victim.uhc_custom_screenshot_sprite;
                            uhc_unsafe_screenshot.image  = 0;
                            uhc_unsafe_screenshot.spr_top = 
                                sprite_get_yoffset(uhc_unsafe_screenshot.sprite) - 47/scale - height_offset;
                            uhc_unsafe_screenshot.spr_left = 
                                abs(sprite_get_xoffset(uhc_unsafe_screenshot.sprite)) - 43/scale;
                        }
                        else if ("uhc_kirby_last_sprite" in victim
                        && victim.uhc_kirby_last_sprite.spr != noone
                        && abs(get_gameplay_time() - victim.uhc_kirby_last_sprite.time) < 5)
                        {
                            uhc_unsafe_screenshot.sprite = victim.uhc_kirby_last_sprite.spr;
                            uhc_unsafe_screenshot.image  = victim.uhc_kirby_last_sprite.img;
                            uhc_unsafe_screenshot.spr_top = 
                                sprite_get_yoffset(uhc_unsafe_screenshot.sprite) - 47/scale - height_offset;
                            uhc_unsafe_screenshot.spr_left = 
                                abs(sprite_get_xoffset(uhc_unsafe_screenshot.sprite)) - 43/scale;
                        }
                        else
                        {
                            uhc_unsafe_screenshot.sprite = victim.sprite_index;
                            uhc_unsafe_screenshot.image  = victim.image_index;
                            uhc_unsafe_screenshot.spr_left = abs(victim.sprite_xoffset) - 43/scale;
                            uhc_unsafe_screenshot.spr_top = victim.sprite_yoffset - (47+height_offset)/scale;
                        }
                    }
                }
            }
        }
    }
}