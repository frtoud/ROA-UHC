set_attack_value(AT_FAIR, AG_CATEGORY, 1);
set_attack_value(AT_FAIR, AG_SPRITE, sprite_get("fair"));
set_attack_value(AT_FAIR, AG_NUM_WINDOWS, 3);
set_attack_value(AT_FAIR, AG_HAS_LANDING_LAG, 1);
set_attack_value(AT_FAIR, AG_LANDING_LAG, 6);
set_attack_value(AT_FAIR, AG_HURTBOX_SPRITE, sprite_get("fair_hurt"));

set_window_value(AT_FAIR, 1, AG_WINDOW_TYPE, 0);
set_window_value(AT_FAIR, 1, AG_WINDOW_LENGTH, 8);
set_window_value(AT_FAIR, 1, AG_WINDOW_LENGTH_BLADED, 12);
set_window_value(AT_FAIR, 1, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_FAIR, 1, AG_WINDOW_VSPEED, -1);
set_window_value(AT_FAIR, 1, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_FAIR, 1, AG_WINDOW_SFX, asset_get("sfx_swipe_medium2"));
set_window_value(AT_FAIR, 1, AG_WINDOW_SFX_FRAME, -1);

set_window_value(AT_FAIR, 2, AG_WINDOW_TYPE, 0);
set_window_value(AT_FAIR, 2, AG_WINDOW_LENGTH, 8);
set_window_value(AT_FAIR, 2, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_FAIR, 2, AG_WINDOW_ANIM_FRAME_START, 2);
set_window_value(AT_FAIR, 2, AG_WINDOW_SPIN_COST, 3);

set_window_value(AT_FAIR, 3, AG_WINDOW_TYPE, 0);
set_window_value(AT_FAIR, 3, AG_WINDOW_LENGTH, 12);
set_window_value(AT_FAIR, 3, AG_WINDOW_LENGTH_BLADED, 16);
set_window_value(AT_FAIR, 3, AG_WINDOW_ANIM_FRAMES, 6);
set_window_value(AT_FAIR, 3, AG_WINDOW_ANIM_FRAME_START, 4);
set_window_value(AT_FAIR, 3, AG_WINDOW_HAS_WHIFFLAG, 5);

set_num_hitboxes(AT_FAIR, 2);
set_attack_value(AT_FAIR, AG_NUM_HITBOXES_BLADED, 4);

//Early hit
set_hitbox_value(AT_FAIR, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_FAIR, 1, HG_WINDOW, 2);
set_hitbox_value(AT_FAIR, 1, HG_LIFETIME, 4);
set_hitbox_value(AT_FAIR, 1, HG_HITBOX_X, 20);
set_hitbox_value(AT_FAIR, 1, HG_HITBOX_Y, -28);
set_hitbox_value(AT_FAIR, 1, HG_WIDTH, 40);
set_hitbox_value(AT_FAIR, 1, HG_HEIGHT, 75);
set_hitbox_value(AT_FAIR, 1, HG_PRIORITY, 2);
set_hitbox_value(AT_FAIR, 1, HG_DAMAGE, 6);
set_hitbox_value(AT_FAIR, 1, HG_ANGLE, 40);
set_hitbox_value(AT_FAIR, 1, HG_BASE_KNOCKBACK, 5);
set_hitbox_value(AT_FAIR, 1, HG_KNOCKBACK_SCALING, .6);
set_hitbox_value(AT_FAIR, 1, HG_BASE_HITPAUSE, 6);
set_hitbox_value(AT_FAIR, 1, HG_HITPAUSE_SCALING, .8);
set_hitbox_value(AT_FAIR, 1, HG_VISUAL_EFFECT_X_OFFSET, 32);
set_hitbox_value(AT_FAIR, 1, HG_VISUAL_EFFECT_Y_OFFSET, -10);
set_hitbox_value(AT_FAIR, 1, HG_HIT_SFX, asset_get("sfx_blow_heavy1"));

//(Blade)
set_hitbox_value(AT_FAIR, 3, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_FAIR, 3, HG_WINDOW, 2);
set_hitbox_value(AT_FAIR, 3, HG_LIFETIME, 4);
set_hitbox_value(AT_FAIR, 3, HG_HITBOX_X, 24);
set_hitbox_value(AT_FAIR, 3, HG_HITBOX_Y, -26);
set_hitbox_value(AT_FAIR, 3, HG_WIDTH, 80);
set_hitbox_value(AT_FAIR, 3, HG_HEIGHT, 100);
set_hitbox_value(AT_FAIR, 3, HG_PRIORITY, 8);
set_hitbox_value(AT_FAIR, 3, HG_DAMAGE, 6);
set_hitbox_value(AT_FAIR, 3, HG_SPIN_COST, 5);
set_hitbox_value(AT_FAIR, 3, HG_SPIN_DAMAGE_BONUS, 6.5);
set_hitbox_value(AT_FAIR, 3, HG_SPIN_HITPAUSE_BONUS, 5);
set_hitbox_value(AT_FAIR, 3, HG_SPIN_KNOCKBACK_SCALING_BONUS, .4);
set_hitbox_value(AT_FAIR, 3, HG_ANGLE, 40);
set_hitbox_value(AT_FAIR, 3, HG_BASE_KNOCKBACK, 5);
set_hitbox_value(AT_FAIR, 3, HG_KNOCKBACK_SCALING, .6);
set_hitbox_value(AT_FAIR, 3, HG_BASE_HITPAUSE, 8);
set_hitbox_value(AT_FAIR, 3, HG_HITPAUSE_SCALING, .8);
set_hitbox_value(AT_FAIR, 3, HG_VISUAL_EFFECT_X_OFFSET, 32);
set_hitbox_value(AT_FAIR, 3, HG_VISUAL_EFFECT_Y_OFFSET, -10);
set_hitbox_value(AT_FAIR, 3, HG_HIT_SFX, asset_get("sfx_blow_heavy2"));
set_hitbox_value(AT_FAIR, 3, HG_SPIN_SFX, sound_get("sfx_ssbu_slash2"));

//======================================================
//Late Hit
set_hitbox_value(AT_FAIR, 2, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_FAIR, 2, HG_WINDOW, 2);
set_hitbox_value(AT_FAIR, 2, HG_WINDOW_CREATION_FRAME, 4);
set_hitbox_value(AT_FAIR, 2, HG_LIFETIME, 4);
set_hitbox_value(AT_FAIR, 2, HG_HITBOX_X, 4);
set_hitbox_value(AT_FAIR, 2, HG_HITBOX_Y, 0);
set_hitbox_value(AT_FAIR, 2, HG_WIDTH, 50);
set_hitbox_value(AT_FAIR, 2, HG_HEIGHT, 32);
set_hitbox_value(AT_FAIR, 2, HG_PRIORITY, 2);
set_hitbox_value(AT_FAIR, 2, HG_DAMAGE, 6);
set_hitbox_value(AT_FAIR, 2, HG_ANGLE, 30);
set_hitbox_value(AT_FAIR, 2, HG_BASE_KNOCKBACK, 5);
set_hitbox_value(AT_FAIR, 2, HG_KNOCKBACK_SCALING, .4);
set_hitbox_value(AT_FAIR, 2, HG_BASE_HITPAUSE, 6);
set_hitbox_value(AT_FAIR, 2, HG_HITPAUSE_SCALING, .25);
set_hitbox_value(AT_FAIR, 2, HG_VISUAL_EFFECT_X_OFFSET, 32);
set_hitbox_value(AT_FAIR, 2, HG_VISUAL_EFFECT_Y_OFFSET, -10);
set_hitbox_value(AT_FAIR, 2, HG_HIT_SFX, asset_get("sfx_blow_heavy1"));
set_hitbox_value(AT_FAIR, 2, HG_ANGLE_FLIPPER, 3);

//(Blade)
set_hitbox_value(AT_FAIR, 4, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_FAIR, 4, HG_WINDOW, 2);
set_hitbox_value(AT_FAIR, 4, HG_WINDOW_CREATION_FRAME, 4);
set_hitbox_value(AT_FAIR, 4, HG_LIFETIME, 4);
set_hitbox_value(AT_FAIR, 4, HG_HITBOX_X, 8);
set_hitbox_value(AT_FAIR, 4, HG_HITBOX_Y, 4);
set_hitbox_value(AT_FAIR, 4, HG_WIDTH, 80);
set_hitbox_value(AT_FAIR, 4, HG_HEIGHT, 50);
set_hitbox_value(AT_FAIR, 4, HG_PRIORITY, 8);
set_hitbox_value(AT_FAIR, 4, HG_DAMAGE, 6);
set_hitbox_value(AT_FAIR, 4, HG_SPIN_COST, 5);
set_hitbox_value(AT_FAIR, 4, HG_SPIN_DAMAGE_BONUS, 4.5);
set_hitbox_value(AT_FAIR, 4, HG_SPIN_HITPAUSE_BONUS, 4);
set_hitbox_value(AT_FAIR, 4, HG_SPIN_KNOCKBACK_SCALING_BONUS, .4);
set_hitbox_value(AT_FAIR, 4, HG_ANGLE, 30);
set_hitbox_value(AT_FAIR, 4, HG_BASE_KNOCKBACK, 5);
set_hitbox_value(AT_FAIR, 4, HG_KNOCKBACK_SCALING, .4);
set_hitbox_value(AT_FAIR, 4, HG_BASE_HITPAUSE, 6);
set_hitbox_value(AT_FAIR, 4, HG_HITPAUSE_SCALING, .4);
set_hitbox_value(AT_FAIR, 4, HG_VISUAL_EFFECT_X_OFFSET, 32);
set_hitbox_value(AT_FAIR, 4, HG_VISUAL_EFFECT_Y_OFFSET, -10);
set_hitbox_value(AT_FAIR, 4, HG_HIT_SFX, asset_get("sfx_blow_heavy2"));
set_hitbox_value(AT_FAIR, 4, HG_SPIN_SFX, sound_get("sfx_ssbu_slash2"));
set_hitbox_value(AT_FAIR, 4, HG_ANGLE_FLIPPER, 3);
