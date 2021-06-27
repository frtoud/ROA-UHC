set_attack_value(AT_BAIR, AG_CATEGORY, 1);
set_attack_value(AT_BAIR, AG_SPRITE, sprite_get("bair"));
set_attack_value(AT_BAIR, AG_NUM_WINDOWS, 5);
set_attack_value(AT_BAIR, AG_HAS_LANDING_LAG, 1);
set_attack_value(AT_BAIR, AG_LANDING_LAG, 4);
set_attack_value(AT_BAIR, AG_HURTBOX_SPRITE, sprite_get("bair_hurt"));

set_window_value(AT_BAIR, 1, AG_WINDOW_TYPE, 0);
set_window_value(AT_BAIR, 1, AG_WINDOW_LENGTH, 6);
set_window_value(AT_BAIR, 1, AG_WINDOW_LENGTH_BLADED, 10);
set_window_value(AT_BAIR, 1, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_BAIR, 1, AG_WINDOW_VSPEED, -1);
set_window_value(AT_BAIR, 1, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_BAIR, 1, AG_WINDOW_SFX, asset_get("sfx_swipe_weak2"));
set_window_value(AT_BAIR, 1, AG_WINDOW_SFX_FRAME, -1);

set_window_value(AT_BAIR, 2, AG_WINDOW_TYPE, 0);
set_window_value(AT_BAIR, 2, AG_WINDOW_LENGTH, 5);
set_window_value(AT_BAIR, 2, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_BAIR, 2, AG_WINDOW_ANIM_FRAME_START, 1);
set_window_value(AT_BAIR, 2, AG_WINDOW_SPIN_COST, 3);

set_window_value(AT_BAIR, 3, AG_WINDOW_TYPE, 0);
set_window_value(AT_BAIR, 3, AG_WINDOW_LENGTH, 4);
set_window_value(AT_BAIR, 3, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_BAIR, 3, AG_WINDOW_ANIM_FRAME_START, 3);
set_window_value(AT_BAIR, 3, AG_WINDOW_VSPEED, -1);
set_window_value(AT_BAIR, 3, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_BAIR, 3, AG_WINDOW_SFX, asset_get("sfx_swipe_weak1"));
set_window_value(AT_BAIR, 3, AG_WINDOW_SFX_FRAME, 3);

set_window_value(AT_BAIR, 4, AG_WINDOW_TYPE, 0);
set_window_value(AT_BAIR, 4, AG_WINDOW_LENGTH, 5);
set_window_value(AT_BAIR, 4, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_BAIR, 4, AG_WINDOW_ANIM_FRAME_START, 4);

set_window_value(AT_BAIR, 5, AG_WINDOW_TYPE, 0);
set_window_value(AT_BAIR, 5, AG_WINDOW_LENGTH, 8);
set_window_value(AT_BAIR, 5, AG_WINDOW_LENGTH_BLADED, 12);
set_window_value(AT_BAIR, 5, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_BAIR, 5, AG_WINDOW_ANIM_FRAME_START, 6);
set_window_value(AT_BAIR, 5, AG_WINDOW_HAS_WHIFFLAG, 1);

set_num_hitboxes(AT_BAIR, 2);
set_attack_value(AT_BAIR, AG_NUM_HITBOXES_BLADED, 4);

//First Hit
set_hitbox_value(AT_BAIR, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_BAIR, 1, HG_WINDOW, 2);
set_hitbox_value(AT_BAIR, 1, HG_LIFETIME, 5);
set_hitbox_value(AT_BAIR, 1, HG_HITBOX_X, -35);
set_hitbox_value(AT_BAIR, 1, HG_HITBOX_Y, -20);
set_hitbox_value(AT_BAIR, 1, HG_WIDTH, 50);
set_hitbox_value(AT_BAIR, 1, HG_HEIGHT, 20);
set_hitbox_value(AT_BAIR, 1, HG_PRIORITY, 2);
set_hitbox_value(AT_BAIR, 1, HG_DAMAGE, 4);
set_hitbox_value(AT_BAIR, 1, HG_ANGLE, 45);
set_hitbox_value(AT_BAIR, 1, HG_ANGLE_FLIPPER, 4);
set_hitbox_value(AT_BAIR, 1, HG_BASE_KNOCKBACK, 4);
set_hitbox_value(AT_BAIR, 1, HG_BASE_HITPAUSE, 3);
set_hitbox_value(AT_BAIR, 1, HG_VISUAL_EFFECT_X_OFFSET, -32);
set_hitbox_value(AT_BAIR, 1, HG_VISUAL_EFFECT_Y_OFFSET, -10);
set_hitbox_value(AT_BAIR, 1, HG_HIT_SFX, asset_get("sfx_blow_medium1"));
set_hitbox_value(AT_BAIR, 1, HG_HITBOX_GROUP, 1);
//(Blade)
set_hitbox_value(AT_BAIR, 3, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_BAIR, 3, HG_WINDOW, 2);
set_hitbox_value(AT_BAIR, 3, HG_LIFETIME, 5);
set_hitbox_value(AT_BAIR, 3, HG_HITBOX_X, -40);
set_hitbox_value(AT_BAIR, 3, HG_HITBOX_Y, -20);
set_hitbox_value(AT_BAIR, 3, HG_WIDTH, 100);
set_hitbox_value(AT_BAIR, 3, HG_HEIGHT, 25);
set_hitbox_value(AT_BAIR, 3, HG_PRIORITY, 1);
set_hitbox_value(AT_BAIR, 3, HG_DAMAGE, 4);
set_hitbox_value(AT_BAIR, 3, HG_ANGLE, 40);
set_hitbox_value(AT_BAIR, 3, HG_ANGLE_FLIPPER, 4);
set_hitbox_value(AT_BAIR, 3, HG_BASE_KNOCKBACK, 6);
set_hitbox_value(AT_BAIR, 3, HG_BASE_HITPAUSE, 3);
set_hitbox_value(AT_BAIR, 3, HG_SPIN_DAMAGE_BONUS, 3);
set_hitbox_value(AT_BAIR, 3, HG_VISUAL_EFFECT_X_OFFSET, -32);
set_hitbox_value(AT_BAIR, 3, HG_VISUAL_EFFECT_Y_OFFSET, -10);
set_hitbox_value(AT_BAIR, 3, HG_HIT_SFX, asset_get("sfx_blow_medium2"));
set_hitbox_value(AT_BAIR, 3, HG_HITBOX_GROUP, 1);

//======================================================
//Second Hit
set_hitbox_value(AT_BAIR, 2, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_BAIR, 2, HG_WINDOW, 4);
set_hitbox_value(AT_BAIR, 2, HG_LIFETIME, 5);
set_hitbox_value(AT_BAIR, 2, HG_HITBOX_X, -25);
set_hitbox_value(AT_BAIR, 2, HG_HITBOX_Y, -25);
set_hitbox_value(AT_BAIR, 2, HG_WIDTH, 70);
set_hitbox_value(AT_BAIR, 2, HG_HEIGHT, 35);
set_hitbox_value(AT_BAIR, 2, HG_PRIORITY, 2);
set_hitbox_value(AT_BAIR, 2, HG_DAMAGE, 5);
set_hitbox_value(AT_BAIR, 2, HG_ANGLE, 135);
set_hitbox_value(AT_BAIR, 2, HG_BASE_KNOCKBACK, 4);
set_hitbox_value(AT_BAIR, 2, HG_KNOCKBACK_SCALING, .3);
set_hitbox_value(AT_BAIR, 2, HG_BASE_HITPAUSE, 6);
set_hitbox_value(AT_BAIR, 2, HG_HITPAUSE_SCALING, .25);
set_hitbox_value(AT_BAIR, 2, HG_VISUAL_EFFECT_X_OFFSET, -32);
set_hitbox_value(AT_BAIR, 2, HG_VISUAL_EFFECT_Y_OFFSET, -10);
set_hitbox_value(AT_BAIR, 2, HG_HIT_SFX, asset_get("sfx_blow_medium1"));
set_hitbox_value(AT_BAIR, 2, HG_HITBOX_GROUP, 2);
//(Blade)
set_hitbox_value(AT_BAIR, 4, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_BAIR, 4, HG_WINDOW, 4);
set_hitbox_value(AT_BAIR, 4, HG_LIFETIME, 5);
set_hitbox_value(AT_BAIR, 4, HG_HITBOX_X, -35);
set_hitbox_value(AT_BAIR, 4, HG_HITBOX_Y, -20);
set_hitbox_value(AT_BAIR, 4, HG_WIDTH, 90);
set_hitbox_value(AT_BAIR, 4, HG_HEIGHT, 60);
set_hitbox_value(AT_BAIR, 4, HG_PRIORITY, 4);
set_hitbox_value(AT_BAIR, 4, HG_DAMAGE, 5);
set_hitbox_value(AT_BAIR, 4, HG_ANGLE, 135);
set_hitbox_value(AT_BAIR, 4, HG_BASE_KNOCKBACK, 4);
set_hitbox_value(AT_BAIR, 4, HG_KNOCKBACK_SCALING, .4);
set_hitbox_value(AT_BAIR, 4, HG_BASE_HITPAUSE, 6);
set_hitbox_value(AT_BAIR, 4, HG_HITPAUSE_SCALING, .25);
set_hitbox_value(AT_BAIR, 4, HG_SPIN_COST, 5);
set_hitbox_value(AT_BAIR, 4, HG_SPIN_DAMAGE_BONUS, 6);
set_hitbox_value(AT_BAIR, 4, HG_SPIN_HITPAUSE_BONUS, 4);
set_hitbox_value(AT_BAIR, 4, HG_SPIN_KNOCKBACK_BONUS, 3);
set_hitbox_value(AT_BAIR, 4, HG_SPIN_KNOCKBACK_SCALING_BONUS, .5);
set_hitbox_value(AT_BAIR, 4, HG_VISUAL_EFFECT_X_OFFSET, -32);
set_hitbox_value(AT_BAIR, 4, HG_VISUAL_EFFECT_Y_OFFSET, -10);
set_hitbox_value(AT_BAIR, 4, HG_HIT_SFX, asset_get("sfx_blow_heavy1"));
set_hitbox_value(AT_BAIR, 4, HG_SPIN_SFX, sound_get("sfx_ssbu_slash2"));
set_hitbox_value(AT_BAIR, 4, HG_HITBOX_GROUP, 2);