set_attack_value(AT_UTILT, AG_SPRITE, sprite_get("utilt"));
set_attack_value(AT_UTILT, AG_NUM_WINDOWS, 3);
set_attack_value(AT_UTILT, AG_HURTBOX_SPRITE, sprite_get("utilt_hurt"));

set_window_value(AT_UTILT, 1, AG_WINDOW_TYPE, 0);
set_window_value(AT_UTILT, 1, AG_WINDOW_LENGTH, 4);
set_window_value(AT_UTILT, 1, AG_WINDOW_LENGTH_BLADED, 6);
set_window_value(AT_UTILT, 1, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_UTILT, 1, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_UTILT, 1, AG_WINDOW_SFX, asset_get("sfx_buzzsaw_throw"));
set_window_value(AT_UTILT, 1, AG_WINDOW_SFX_FRAME, -1);

set_window_value(AT_UTILT, 2, AG_WINDOW_TYPE, 0);
set_hitbox_value(AT_UTILT, 2, AG_WINDOW_SPIN_COST, 1);
set_window_value(AT_UTILT, 2, AG_WINDOW_LENGTH, 18);
set_window_value(AT_UTILT, 2, AG_WINDOW_ANIM_FRAMES, 6);
set_window_value(AT_UTILT, 2, AG_WINDOW_ANIM_FRAME_START, 2);

set_window_value(AT_UTILT, 3, AG_WINDOW_TYPE, 0);
set_window_value(AT_UTILT, 3, AG_WINDOW_LENGTH, 10);
set_window_value(AT_UTILT, 3, AG_WINDOW_LENGTH_BLADED, 12);
set_window_value(AT_UTILT, 3, AG_WINDOW_ANIM_FRAMES, 5);
set_window_value(AT_UTILT, 3, AG_WINDOW_ANIM_FRAME_START, 8);
set_window_value(AT_UTILT, 3, AG_WINDOW_HAS_WHIFFLAG, 1);

set_num_hitboxes(AT_UTILT, 3);
set_attack_value(AT_UTILT, AG_NUM_HITBOXES_BLADED, 6);

set_hitbox_value(AT_UTILT, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_UTILT, 1, HG_WINDOW, 2);
set_hitbox_value(AT_UTILT, 1, HG_LIFETIME, 2);
set_hitbox_value(AT_UTILT, 1, HG_HITBOX_Y, -50);
set_hitbox_value(AT_UTILT, 1, HG_HITBOX_X, 5);
set_hitbox_value(AT_UTILT, 1, HG_WIDTH, 32);
set_hitbox_value(AT_UTILT, 1, HG_HEIGHT, 80);
set_hitbox_value(AT_UTILT, 1, HG_PRIORITY, 2);
set_hitbox_value(AT_UTILT, 1, HG_DAMAGE, 1);
set_hitbox_value(AT_UTILT, 1, HG_ANGLE, 85);
set_hitbox_value(AT_UTILT, 1, HG_ANGLE_FLIPPER, 4);
set_hitbox_value(AT_UTILT, 1, HG_BASE_KNOCKBACK, 6);
set_hitbox_value(AT_UTILT, 1, HG_BASE_HITPAUSE, 1);
set_hitbox_value(AT_UTILT, 1, HG_HIT_SFX, asset_get("sfx_blow_weak2"));
set_hitbox_value(AT_UTILT, 1, HG_HITBOX_GROUP, 1);
//Blade
set_hitbox_value(AT_UTILT, 4, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_UTILT, 4, HG_WINDOW, 2);
set_hitbox_value(AT_UTILT, 4, HG_LIFETIME, 2);
set_hitbox_value(AT_UTILT, 4, HG_HITBOX_Y, -80);
set_hitbox_value(AT_UTILT, 4, HG_HITBOX_X, 5);
set_hitbox_value(AT_UTILT, 4, HG_WIDTH, 44);
set_hitbox_value(AT_UTILT, 4, HG_HEIGHT, 60);
set_hitbox_value(AT_UTILT, 4, HG_PRIORITY, 7);
set_hitbox_value(AT_UTILT, 4, HG_DAMAGE, 2);
set_hitbox_value(AT_UTILT, 4, HG_ANGLE, 85);
set_hitbox_value(AT_UTILT, 4, HG_ANGLE_FLIPPER, 4);
set_hitbox_value(AT_UTILT, 4, HG_BASE_KNOCKBACK, 5);
set_hitbox_value(AT_UTILT, 4, HG_BASE_HITPAUSE, 2);
set_hitbox_value(AT_UTILT, 4, HG_SPIN_DAMAGE_BONUS, 1.75);
set_hitbox_value(AT_UTILT, 4, HG_SPIN_HITPAUSE_BONUS, 1);
set_hitbox_value(AT_UTILT, 4, HG_SPIN_KNOCKBACK_SCALING_BONUS, .1);
set_hitbox_value(AT_UTILT, 4, HG_HIT_SFX, asset_get("sfx_blow_weak1"));
set_hitbox_value(AT_UTILT, 4, HG_SPIN_SFX, sound_get("sfx_ssbu_slash1"));
set_hitbox_value(AT_UTILT, 4, HG_HITBOX_GROUP, 1);


set_hitbox_value(AT_UTILT, 2, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_UTILT, 2, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_UTILT, 2, HG_WINDOW, 2);
set_hitbox_value(AT_UTILT, 2, HG_WINDOW_CREATION_FRAME, 7);
set_hitbox_value(AT_UTILT, 2, HG_LIFETIME, 2);
set_hitbox_value(AT_UTILT, 2, HG_HITBOX_Y, -60);
set_hitbox_value(AT_UTILT, 2, HG_HITBOX_X, -5);
set_hitbox_value(AT_UTILT, 2, HG_HITBOX_GROUP, 2);
//Blade
set_hitbox_value(AT_UTILT, 5, HG_PARENT_HITBOX, 4);
set_hitbox_value(AT_UTILT, 5, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_UTILT, 5, HG_WINDOW, 2);
set_hitbox_value(AT_UTILT, 5, HG_WINDOW_CREATION_FRAME, 7);
set_hitbox_value(AT_UTILT, 5, HG_LIFETIME, 2);
set_hitbox_value(AT_UTILT, 5, HG_HITBOX_Y, -88);
set_hitbox_value(AT_UTILT, 5, HG_HITBOX_X, -5);
set_hitbox_value(AT_UTILT, 5, HG_HITBOX_GROUP, 2);


set_hitbox_value(AT_UTILT, 3, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_UTILT, 3, HG_WINDOW, 2);
set_hitbox_value(AT_UTILT, 3, HG_WINDOW_CREATION_FRAME, 14);
set_hitbox_value(AT_UTILT, 3, HG_LIFETIME, 4);
set_hitbox_value(AT_UTILT, 3, HG_HITBOX_Y, -60);
set_hitbox_value(AT_UTILT, 3, HG_HITBOX_X, -5);
set_hitbox_value(AT_UTILT, 3, HG_WIDTH, 40);
set_hitbox_value(AT_UTILT, 3, HG_HEIGHT, 80);
set_hitbox_value(AT_UTILT, 3, HG_PRIORITY, 2);
set_hitbox_value(AT_UTILT, 3, HG_DAMAGE, 4);
set_hitbox_value(AT_UTILT, 3, HG_ANGLE, 90);
set_hitbox_value(AT_UTILT, 3, HG_BASE_KNOCKBACK, 6);
set_hitbox_value(AT_UTILT, 3, HG_KNOCKBACK_SCALING, 0.2);
set_hitbox_value(AT_UTILT, 3, HG_BASE_HITPAUSE, 5);
set_hitbox_value(AT_UTILT, 3, HG_HITPAUSE_SCALING, .25);
set_hitbox_value(AT_UTILT, 3, HG_HIT_SFX, asset_get("sfx_blow_weak2"));
set_hitbox_value(AT_UTILT, 3, HG_HITBOX_GROUP, 3);
//Blade
set_hitbox_value(AT_UTILT, 6, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_UTILT, 6, HG_WINDOW, 2);
set_hitbox_value(AT_UTILT, 6, HG_WINDOW_CREATION_FRAME, 14);
set_hitbox_value(AT_UTILT, 6, HG_LIFETIME, 4);
set_hitbox_value(AT_UTILT, 6, HG_HITBOX_Y, -84);
set_hitbox_value(AT_UTILT, 6, HG_HITBOX_X, -5);
set_hitbox_value(AT_UTILT, 6, HG_WIDTH, 50);
set_hitbox_value(AT_UTILT, 6, HG_HEIGHT, 60);
set_hitbox_value(AT_UTILT, 6, HG_PRIORITY, 7);
set_hitbox_value(AT_UTILT, 6, HG_DAMAGE, 5);
set_hitbox_value(AT_UTILT, 6, HG_ANGLE, 90);
set_hitbox_value(AT_UTILT, 6, HG_BASE_KNOCKBACK, 7);
set_hitbox_value(AT_UTILT, 6, HG_KNOCKBACK_SCALING, 0.4);
set_hitbox_value(AT_UTILT, 6, HG_BASE_HITPAUSE, 7);
set_hitbox_value(AT_UTILT, 6, HG_HITPAUSE_SCALING, .35);
set_hitbox_value(AT_UTILT, 6, HG_SPIN_COST, 2);
set_hitbox_value(AT_UTILT, 6, HG_SPIN_DAMAGE_BONUS, 3.5);
set_hitbox_value(AT_UTILT, 6, HG_SPIN_HITPAUSE_BONUS, 4);
set_hitbox_value(AT_UTILT, 6, HG_SPIN_KNOCKBACK_SCALING_BONUS, .45);
set_hitbox_value(AT_UTILT, 6, HG_HIT_SFX, asset_get("sfx_blow_weak1"));
set_hitbox_value(AT_UTILT, 6, HG_SPIN_SFX, sound_get("sfx_ssbu_slash1b"));
set_hitbox_value(AT_UTILT, 6, HG_HITBOX_GROUP, 3);