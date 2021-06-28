set_attack_value(AT_JAB, AG_SPRITE, sprite_get("jab"));
set_attack_value(AT_JAB, AG_NUM_WINDOWS, 9);
set_attack_value(AT_JAB, AG_HURTBOX_SPRITE, sprite_get("jab_hurt"));

//Jab 1
set_window_value(AT_JAB, 1, AG_WINDOW_TYPE, 0);
set_window_value(AT_JAB, 1, AG_WINDOW_LENGTH, 8);
set_window_value(AT_JAB, 1, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_JAB, 1, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_JAB, 1, AG_WINDOW_SFX, asset_get("sfx_swipe_weak1"));
set_window_value(AT_JAB, 1, AG_WINDOW_SFX_FRAME, 3);

set_window_value(AT_JAB, 2, AG_WINDOW_TYPE, 0);
set_window_value(AT_JAB, 2, AG_WINDOW_LENGTH, 15);
set_window_value(AT_JAB, 2, AG_WINDOW_CANCEL_TYPE, 1);
set_window_value(AT_JAB, 2, AG_WINDOW_CANCEL_FRAME, 2);
set_window_value(AT_JAB, 2, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_JAB, 2, AG_WINDOW_ANIM_FRAME_START, 2);

//Jab 2
set_window_value(AT_JAB, 3, AG_WINDOW_TYPE, 0);
set_window_value(AT_JAB, 3, AG_WINDOW_LENGTH, 6);
set_window_value(AT_JAB, 3, AG_WINDOW_HSPEED, 3);
set_window_value(AT_JAB, 3, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_JAB, 3, AG_WINDOW_ANIM_FRAME_START, 5);
set_window_value(AT_JAB, 3, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_JAB, 3, AG_WINDOW_SFX, asset_get("sfx_swipe_weak2"));
set_window_value(AT_JAB, 3, AG_WINDOW_SFX_FRAME, 5);

set_window_value(AT_JAB, 4, AG_WINDOW_TYPE, 0);
set_window_value(AT_JAB, 4, AG_WINDOW_LENGTH, 24);
set_window_value(AT_JAB, 4, AG_WINDOW_HSPEED, 6);
set_window_value(AT_JAB, 4, AG_WINDOW_CANCEL_TYPE, 1);
set_window_value(AT_JAB, 4, AG_WINDOW_CANCEL_FRAME, 10);
set_window_value(AT_JAB, 4, AG_WINDOW_ANIM_FRAMES, 5);
set_window_value(AT_JAB, 4, AG_WINDOW_ANIM_FRAME_START, 6);

//Jab 3
set_window_value(AT_JAB, 5, AG_WINDOW_TYPE, 0);
set_window_value(AT_JAB, 5, AG_WINDOW_LENGTH, 4);
set_window_value(AT_JAB, 5, AG_WINDOW_HSPEED, 2);
set_window_value(AT_JAB, 5, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_JAB, 5, AG_WINDOW_ANIM_FRAME_START, 11);
set_window_value(AT_JAB, 5, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_JAB, 5, AG_WINDOW_SFX, asset_get("sfx_swipe_weak1"));
set_window_value(AT_JAB, 5, AG_WINDOW_SFX_FRAME, 3);

set_window_value(AT_JAB, 6, AG_WINDOW_TYPE, 0);
set_window_value(AT_JAB, 6, AG_WINDOW_LENGTH, 6);
set_window_value(AT_JAB, 6, AG_WINDOW_HSPEED, 4);
set_window_value(AT_JAB, 6, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_JAB, 6, AG_WINDOW_ANIM_FRAME_START, 12);

//=====================================================================
//Infinite
set_window_value(AT_JAB, 7, AG_WINDOW_TYPE, 9); //Looping
set_window_value(AT_JAB, 7, AG_WINDOW_LENGTH, 24);
set_window_value(AT_JAB, 7, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_JAB, 7, AG_WINDOW_ANIM_FRAME_START, 14);
set_window_value(AT_JAB, 7, AG_WINDOW_SPIN_COST, 3);

//Finisher
set_window_value(AT_JAB, 8, AG_WINDOW_TYPE, 0);
set_window_value(AT_JAB, 8, AG_WINDOW_LENGTH, 16);
set_window_value(AT_JAB, 8, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_JAB, 8, AG_WINDOW_ANIM_FRAME_START, 18);
set_window_value(AT_JAB, 8, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_JAB, 8, AG_WINDOW_SFX, asset_get("sfx_swipe_medium1"));
set_window_value(AT_JAB, 8, AG_WINDOW_SFX_FRAME, 7);

set_window_value(AT_JAB, 9, AG_WINDOW_TYPE, 0);
set_window_value(AT_JAB, 9, AG_WINDOW_LENGTH, 16);
set_window_value(AT_JAB, 9, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_JAB, 9, AG_WINDOW_ANIM_FRAME_START, 22);

set_num_hitboxes(AT_JAB, 3);
set_attack_value(AT_JAB, AG_NUM_HITBOXES_BLADED, 7);

//===========================================================
//Jab 1
set_hitbox_value(AT_JAB, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_JAB, 1, HG_WINDOW, 1);
set_hitbox_value(AT_JAB, 1, HG_WINDOW_CREATION_FRAME, 4);
set_hitbox_value(AT_JAB, 1, HG_LIFETIME, 6);
set_hitbox_value(AT_JAB, 1, HG_HITBOX_X, 35);
set_hitbox_value(AT_JAB, 1, HG_HITBOX_Y, -25);
set_hitbox_value(AT_JAB, 1, HG_WIDTH, 50);
set_hitbox_value(AT_JAB, 1, HG_HEIGHT, 25);
set_hitbox_value(AT_JAB, 1, HG_PRIORITY, 2);
set_hitbox_value(AT_JAB, 1, HG_DAMAGE, 3);
set_hitbox_value(AT_JAB, 1, HG_ANGLE, 60);
set_hitbox_value(AT_JAB, 1, HG_BASE_KNOCKBACK, 4);
set_hitbox_value(AT_JAB, 1, HG_BASE_HITPAUSE, 6);
set_hitbox_value(AT_JAB, 1, HG_HIT_SFX, asset_get("sfx_blow_weak1"));
set_hitbox_value(AT_JAB, 1, HG_HITBOX_GROUP, 1);

//Blade
set_hitbox_value(AT_JAB, 4, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_JAB, 4, HG_WINDOW, 1);
set_hitbox_value(AT_JAB, 4, HG_WINDOW_CREATION_FRAME, 4);
set_hitbox_value(AT_JAB, 4, HG_LIFETIME, 6);
set_hitbox_value(AT_JAB, 4, HG_HITBOX_X, 40);
set_hitbox_value(AT_JAB, 4, HG_HITBOX_Y, -25);
set_hitbox_value(AT_JAB, 4, HG_WIDTH, 64);
set_hitbox_value(AT_JAB, 4, HG_HEIGHT, 30);
set_hitbox_value(AT_JAB, 4, HG_PRIORITY, 5);
set_hitbox_value(AT_JAB, 4, HG_DAMAGE, 4);
set_hitbox_value(AT_JAB, 4, HG_ANGLE, 60);
set_hitbox_value(AT_JAB, 4, HG_SPIN_COST, 1);
set_hitbox_value(AT_JAB, 4, HG_SPIN_DAMAGE_BONUS, 2.5);
set_hitbox_value(AT_JAB, 4, HG_BASE_KNOCKBACK, 4);
set_hitbox_value(AT_JAB, 4, HG_BASE_HITPAUSE, 6);
set_hitbox_value(AT_JAB, 4, HG_HIT_SFX, asset_get("sfx_blow_weak1"));
set_hitbox_value(AT_JAB, 4, HG_SPIN_SFX, sound_get("sfx_ssbu_slash1"));
set_hitbox_value(AT_JAB, 4, HG_HITBOX_GROUP, 1);

//===========================================================
//Jab 2
set_hitbox_value(AT_JAB, 2, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_JAB, 2, HG_WINDOW, 4);
set_hitbox_value(AT_JAB, 2, HG_LIFETIME, 8);
set_hitbox_value(AT_JAB, 2, HG_HITBOX_X, 30);
set_hitbox_value(AT_JAB, 2, HG_HITBOX_Y, -25);
set_hitbox_value(AT_JAB, 2, HG_WIDTH, 60);
set_hitbox_value(AT_JAB, 2, HG_HEIGHT, 30);
set_hitbox_value(AT_JAB, 2, HG_PRIORITY, 2);
set_hitbox_value(AT_JAB, 2, HG_DAMAGE, 3);
set_hitbox_value(AT_JAB, 2, HG_ANGLE, 60);
set_hitbox_value(AT_JAB, 2, HG_BASE_KNOCKBACK, 4);
set_hitbox_value(AT_JAB, 2, HG_BASE_HITPAUSE, 6);
set_hitbox_value(AT_JAB, 2, HG_HIT_SFX, asset_get("sfx_blow_weak1"));
set_hitbox_value(AT_JAB, 2, HG_HITBOX_GROUP, 2);

//Blade
set_hitbox_value(AT_JAB, 5, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_JAB, 5, HG_WINDOW, 4);
set_hitbox_value(AT_JAB, 5, HG_LIFETIME, 8);
set_hitbox_value(AT_JAB, 5, HG_HITBOX_X, 45);
set_hitbox_value(AT_JAB, 5, HG_HITBOX_Y, -25);
set_hitbox_value(AT_JAB, 5, HG_WIDTH, 80);
set_hitbox_value(AT_JAB, 5, HG_HEIGHT, 32);
set_hitbox_value(AT_JAB, 5, HG_PRIORITY, 5);
set_hitbox_value(AT_JAB, 5, HG_DAMAGE, 4);
set_hitbox_value(AT_JAB, 5, HG_ANGLE, 60);
set_hitbox_value(AT_JAB, 5, HG_SPIN_COST, 1);
set_hitbox_value(AT_JAB, 5, HG_SPIN_DAMAGE_BONUS, 2.5);
set_hitbox_value(AT_JAB, 5, HG_BASE_KNOCKBACK, 4);
set_hitbox_value(AT_JAB, 5, HG_BASE_HITPAUSE, 6);
set_hitbox_value(AT_JAB, 5, HG_HIT_SFX, asset_get("sfx_blow_weak1"));
set_hitbox_value(AT_JAB, 5, HG_SPIN_SFX, sound_get("sfx_ssbu_slash1b"));
set_hitbox_value(AT_JAB, 5, HG_HITBOX_GROUP, 2);

//===========================================================
//Jab 3's infinite (also spawned manually)
set_hitbox_value(AT_JAB, 6, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_JAB, 6, HG_WINDOW, 6);
set_hitbox_value(AT_JAB, 6, HG_LIFETIME, 3);
set_hitbox_value(AT_JAB, 6, HG_HITBOX_X, 45);
set_hitbox_value(AT_JAB, 6, HG_HITBOX_Y, -24);
set_hitbox_value(AT_JAB, 6, HG_WIDTH, 35);
set_hitbox_value(AT_JAB, 6, HG_HEIGHT, 35);
set_hitbox_value(AT_JAB, 6, HG_PRIORITY, 3);
set_hitbox_value(AT_JAB, 6, HG_DAMAGE, 1);
set_hitbox_value(AT_JAB, 6, HG_ANGLE, 65);
set_hitbox_value(AT_JAB, 6, HG_SPIN_COST, 2);
set_hitbox_value(AT_JAB, 6, HG_SPIN_DAMAGE_BONUS, 1.5);
set_hitbox_value(AT_JAB, 6, HG_ANGLE_FLIPPER, 10);
set_hitbox_value(AT_JAB, 6, HG_BASE_KNOCKBACK, 3);
set_hitbox_value(AT_JAB, 6, HG_KNOCKBACK_SCALING, 0.2);
set_hitbox_value(AT_JAB, 6, HG_HITSTUN_MULTIPLIER, 0.5);
set_hitbox_value(AT_JAB, 6, HG_BASE_HITPAUSE, 4);
set_hitbox_value(AT_JAB, 6, HG_VISUAL_EFFECT, 302);
set_hitbox_value(AT_JAB, 6, HG_HIT_SFX, sound_get("sfx_ssbu_slash1"));
set_hitbox_value(AT_JAB, 6, HG_HITBOX_GROUP, -1);

//===========================================================
//Finisher
set_hitbox_value(AT_JAB, 3, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_JAB, 3, HG_WINDOW, 8);
set_hitbox_value(AT_JAB, 3, HG_WINDOW_CREATION_FRAME, 8);
set_hitbox_value(AT_JAB, 3, HG_LIFETIME, 6);
set_hitbox_value(AT_JAB, 3, HG_HITBOX_X, 30);
set_hitbox_value(AT_JAB, 3, HG_HITBOX_Y, -25);
set_hitbox_value(AT_JAB, 3, HG_WIDTH, 60);
set_hitbox_value(AT_JAB, 3, HG_HEIGHT, 25);
set_hitbox_value(AT_JAB, 3, HG_PRIORITY, 2);
set_hitbox_value(AT_JAB, 3, HG_DAMAGE, 5);
set_hitbox_value(AT_JAB, 3, HG_ANGLE, 60);
set_hitbox_value(AT_JAB, 3, HG_BASE_KNOCKBACK, 4);
set_hitbox_value(AT_JAB, 3, HG_BASE_HITPAUSE, 6);
set_hitbox_value(AT_JAB, 3, HG_HIT_SFX, asset_get("sfx_blow_weak1"));
set_hitbox_value(AT_JAB, 3, HG_HITBOX_GROUP, 3);

//Blade
set_hitbox_value(AT_JAB, 7, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_JAB, 7, HG_WINDOW, 8);
set_hitbox_value(AT_JAB, 7, HG_WINDOW_CREATION_FRAME, 8);
set_hitbox_value(AT_JAB, 7, HG_LIFETIME, 6);
set_hitbox_value(AT_JAB, 7, HG_HITBOX_X, 30);
set_hitbox_value(AT_JAB, 7, HG_HITBOX_Y, -25);
set_hitbox_value(AT_JAB, 7, HG_WIDTH, 90);
set_hitbox_value(AT_JAB, 7, HG_HEIGHT, 50);
set_hitbox_value(AT_JAB, 7, HG_PRIORITY, 6);
set_hitbox_value(AT_JAB, 7, HG_DAMAGE, 5);
set_hitbox_value(AT_JAB, 7, HG_ANGLE, 70);
set_hitbox_value(AT_JAB, 7, HG_SPIN_COST, 1);
set_hitbox_value(AT_JAB, 7, HG_SPIN_DAMAGE_BONUS, 4.5);
set_hitbox_value(AT_JAB, 7, HG_SPIN_KNOCKBACK_SCALING_BONUS, 0.2);
set_hitbox_value(AT_JAB, 7, HG_BASE_KNOCKBACK, 4);
set_hitbox_value(AT_JAB, 7, HG_KNOCKBACK_SCALING, 0.5);
set_hitbox_value(AT_JAB, 7, HG_BASE_HITPAUSE, 6);
set_hitbox_value(AT_JAB, 7, HG_HIT_SFX, asset_get("sfx_blow_medium1"));
set_hitbox_value(AT_JAB, 7, HG_SPIN_SFX, sound_get("sfx_ssbu_slash3"));
set_hitbox_value(AT_JAB, 7, HG_HITBOX_GROUP, 3);
