set_attack_value(AT_FSPECIAL, AG_CATEGORY, 2);
set_attack_value(AT_FSPECIAL, AG_SPRITE, sprite_get("fspecial"));
set_attack_value(AT_FSPECIAL, AG_NUM_WINDOWS, 5);
set_attack_value(AT_FSPECIAL, AG_HAS_LANDING_LAG, 4);
set_attack_value(AT_FSPECIAL, AG_AIR_SPRITE, sprite_get("fspecial_air"));
set_attack_value(AT_FSPECIAL, AG_HURTBOX_SPRITE, sprite_get("fspecial_hurt"));

set_window_value(AT_FSPECIAL, 1, AG_WINDOW_TYPE, 0);
set_window_value(AT_FSPECIAL, 1, AG_WINDOW_LENGTH, 12);
set_window_value(AT_FSPECIAL, 1, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_FSPECIAL, 1, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_FSPECIAL, 1, AG_WINDOW_SFX, asset_get("sfx_may_arc_cointoss"));
set_window_value(AT_FSPECIAL, 1, AG_WINDOW_SFX_FRAME, -1);
set_window_value(AT_FSPECIAL, 1, AG_WINDOW_GOTO, 3);

//SFX stored, but unused, by the target windows
set_window_value(AT_FSPECIAL, 2, AG_WINDOW_SFX, asset_get("sfx_absa_orb_miss"));
set_window_value(AT_FSPECIAL, 3, AG_WINDOW_SFX, asset_get("sfx_absa_new_whip1"));
set_window_value(AT_FSPECIAL, 4, AG_WINDOW_SFX, asset_get("sfx_absa_whip3"));
for (var wdw = 2; wdw < 5; wdw++)
{
    //Identical windows, but different hitboxes
    //2: no charge
    //3: half charge
    //4: full charge
    set_window_value(AT_FSPECIAL, wdw, AG_WINDOW_TYPE, 0);
    set_window_value(AT_FSPECIAL, wdw, AG_WINDOW_LENGTH, 4);
    set_window_value(AT_FSPECIAL, wdw, AG_WINDOW_ANIM_FRAMES, 1);
    set_window_value(AT_FSPECIAL, wdw, AG_WINDOW_ANIM_FRAME_START, 3);
    set_window_value(AT_FSPECIAL, wdw, AG_WINDOW_HAS_CUSTOM_FRICTION, true);
    set_window_value(AT_FSPECIAL, wdw, AG_WINDOW_CUSTOM_AIR_FRICTION, 3);
    set_window_value(AT_FSPECIAL, wdw, AG_WINDOW_CUSTOM_GROUND_FRICTION, 3);
    set_window_value(AT_FSPECIAL, wdw, AG_WINDOW_GOTO, 5);
}

set_window_value(AT_FSPECIAL, 5, AG_WINDOW_TYPE, 0);
set_window_value(AT_FSPECIAL, 5, AG_WINDOW_LENGTH, 20);
set_window_value(AT_FSPECIAL, 5, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_FSPECIAL, 5, AG_WINDOW_ANIM_FRAME_START, 4);

set_num_hitboxes(AT_FSPECIAL, 6);

//no charge
set_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_FSPECIAL, 1, HG_WINDOW, 2);
set_hitbox_value(AT_FSPECIAL, 1, HG_LIFETIME, 4);
set_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_X, 35);
set_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_Y, -30);
set_hitbox_value(AT_FSPECIAL, 1, HG_WIDTH, 50);
set_hitbox_value(AT_FSPECIAL, 1, HG_HEIGHT, 50);
set_hitbox_value(AT_FSPECIAL, 1, HG_PRIORITY, 1);
set_hitbox_value(AT_FSPECIAL, 1, HG_DAMAGE, 5);
set_hitbox_value(AT_FSPECIAL, 1, HG_ANGLE, 90);
set_hitbox_value(AT_FSPECIAL, 1, HG_BASE_KNOCKBACK, 3);
set_hitbox_value(AT_FSPECIAL, 1, HG_KNOCKBACK_SCALING, 0);
set_hitbox_value(AT_FSPECIAL, 1, HG_BASE_HITPAUSE, 4);
set_hitbox_value(AT_FSPECIAL, 1, HG_EXTRA_HITPAUSE, 12);
set_hitbox_value(AT_FSPECIAL, 1, HG_HIT_SFX, asset_get("sfx_absa_singlezap2"));
set_hitbox_value(AT_FSPECIAL, 1, HG_IGNORES_PROJECTILES, 1);

//half charge
set_hitbox_value(AT_FSPECIAL, 2, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_FSPECIAL, 2, HG_WINDOW, 3);
set_hitbox_value(AT_FSPECIAL, 2, HG_LIFETIME, 4);
set_hitbox_value(AT_FSPECIAL, 2, HG_HITBOX_X, 50);
set_hitbox_value(AT_FSPECIAL, 2, HG_HITBOX_Y, -30);
set_hitbox_value(AT_FSPECIAL, 2, HG_WIDTH, 80);
set_hitbox_value(AT_FSPECIAL, 2, HG_HEIGHT, 60);
set_hitbox_value(AT_FSPECIAL, 2, HG_PRIORITY, 3);
set_hitbox_value(AT_FSPECIAL, 2, HG_DAMAGE, 8);
set_hitbox_value(AT_FSPECIAL, 2, HG_ANGLE, 90);
set_hitbox_value(AT_FSPECIAL, 2, HG_BASE_KNOCKBACK, 7);
set_hitbox_value(AT_FSPECIAL, 2, HG_KNOCKBACK_SCALING, .1);
set_hitbox_value(AT_FSPECIAL, 2, HG_BASE_HITPAUSE, 0);
set_hitbox_value(AT_FSPECIAL, 2, HG_EXTRA_HITPAUSE, 24);
set_hitbox_value(AT_FSPECIAL, 2, HG_HIT_SFX, asset_get("sfx_absa_singlezap2"));
set_hitbox_value(AT_FSPECIAL, 2, HG_IGNORES_PROJECTILES, 1);

set_hitbox_value(AT_FSPECIAL, 3, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_FSPECIAL, 3, HG_WINDOW, 3);
set_hitbox_value(AT_FSPECIAL, 3, HG_LIFETIME, 4);
set_hitbox_value(AT_FSPECIAL, 3, HG_HITBOX_X, 75);
set_hitbox_value(AT_FSPECIAL, 3, HG_HITBOX_Y, -30);
set_hitbox_value(AT_FSPECIAL, 3, HG_WIDTH, 70);
set_hitbox_value(AT_FSPECIAL, 3, HG_HEIGHT, 125);
set_hitbox_value(AT_FSPECIAL, 3, HG_PRIORITY, 2);
set_hitbox_value(AT_FSPECIAL, 3, HG_DAMAGE, 6);
set_hitbox_value(AT_FSPECIAL, 3, HG_ANGLE, 90);
set_hitbox_value(AT_FSPECIAL, 3, HG_BASE_KNOCKBACK, 6);
set_hitbox_value(AT_FSPECIAL, 3, HG_KNOCKBACK_SCALING, .1);
set_hitbox_value(AT_FSPECIAL, 3, HG_BASE_HITPAUSE, 0);
set_hitbox_value(AT_FSPECIAL, 3, HG_EXTRA_HITPAUSE, 20);
set_hitbox_value(AT_FSPECIAL, 3, HG_HIT_SFX, asset_get("sfx_absa_singlezap2"));
set_hitbox_value(AT_FSPECIAL, 3, HG_IGNORES_PROJECTILES, 1);

//full charge
set_hitbox_value(AT_FSPECIAL, 4, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_FSPECIAL, 4, HG_WINDOW, 4);
set_hitbox_value(AT_FSPECIAL, 4, HG_LIFETIME, 4);
set_hitbox_value(AT_FSPECIAL, 4, HG_HITBOX_X, 50);
set_hitbox_value(AT_FSPECIAL, 4, HG_HITBOX_Y, -30);
set_hitbox_value(AT_FSPECIAL, 4, HG_WIDTH, 80);
set_hitbox_value(AT_FSPECIAL, 4, HG_HEIGHT, 60);
set_hitbox_value(AT_FSPECIAL, 4, HG_PRIORITY, 5);
set_hitbox_value(AT_FSPECIAL, 4, HG_DAMAGE, 15);
set_hitbox_value(AT_FSPECIAL, 4, HG_ANGLE, 90);
set_hitbox_value(AT_FSPECIAL, 4, HG_BASE_KNOCKBACK, 7);
set_hitbox_value(AT_FSPECIAL, 4, HG_KNOCKBACK_SCALING, .3);
set_hitbox_value(AT_FSPECIAL, 4, HG_EFFECT, 11);
set_hitbox_value(AT_FSPECIAL, 4, HG_BASE_HITPAUSE, 16);
set_hitbox_value(AT_FSPECIAL, 4, HG_HITPAUSE_SCALING, 0.1);
set_hitbox_value(AT_FSPECIAL, 4, HG_HIT_SFX, asset_get("sfx_absa_singlezap2"));

set_hitbox_value(AT_FSPECIAL, 5, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_FSPECIAL, 5, HG_WINDOW, 4);
set_hitbox_value(AT_FSPECIAL, 5, HG_LIFETIME, 4);
set_hitbox_value(AT_FSPECIAL, 5, HG_HITBOX_X, 110);
set_hitbox_value(AT_FSPECIAL, 5, HG_HITBOX_Y, -30);
set_hitbox_value(AT_FSPECIAL, 5, HG_WIDTH, 140);
set_hitbox_value(AT_FSPECIAL, 5, HG_HEIGHT, 180);
set_hitbox_value(AT_FSPECIAL, 5, HG_PRIORITY, 4);
set_hitbox_value(AT_FSPECIAL, 5, HG_DAMAGE, 12);
set_hitbox_value(AT_FSPECIAL, 5, HG_ANGLE, 90);
set_hitbox_value(AT_FSPECIAL, 5, HG_BASE_KNOCKBACK, 6);
set_hitbox_value(AT_FSPECIAL, 5, HG_KNOCKBACK_SCALING, .3);
set_hitbox_value(AT_FSPECIAL, 5, HG_EFFECT, 11);
set_hitbox_value(AT_FSPECIAL, 5, HG_BASE_HITPAUSE, 12);
set_hitbox_value(AT_FSPECIAL, 5, HG_HITPAUSE_SCALING, 0.1);
set_hitbox_value(AT_FSPECIAL, 5, HG_HIT_SFX, asset_get("sfx_absa_singlezap2"));

set_hitbox_value(AT_FSPECIAL, 6, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_FSPECIAL, 6, HG_WINDOW, 4);
set_hitbox_value(AT_FSPECIAL, 6, HG_LIFETIME, 4);
set_hitbox_value(AT_FSPECIAL, 6, HG_HITBOX_X, 150);
set_hitbox_value(AT_FSPECIAL, 6, HG_HITBOX_Y, -30);
set_hitbox_value(AT_FSPECIAL, 6, HG_WIDTH, 100);
set_hitbox_value(AT_FSPECIAL, 6, HG_HEIGHT, 300);
set_hitbox_value(AT_FSPECIAL, 6, HG_PRIORITY, 3);
set_hitbox_value(AT_FSPECIAL, 6, HG_DAMAGE, 10);
set_hitbox_value(AT_FSPECIAL, 6, HG_ANGLE, 90);
set_hitbox_value(AT_FSPECIAL, 6, HG_BASE_KNOCKBACK, 5);
set_hitbox_value(AT_FSPECIAL, 6, HG_KNOCKBACK_SCALING, .2);
set_hitbox_value(AT_FSPECIAL, 6, HG_EFFECT, 11);
set_hitbox_value(AT_FSPECIAL, 6, HG_BASE_HITPAUSE, 8);
set_hitbox_value(AT_FSPECIAL, 6, HG_HITPAUSE_SCALING, 0.1);
set_hitbox_value(AT_FSPECIAL, 6, HG_HIT_SFX, asset_get("sfx_absa_singlezap2"));