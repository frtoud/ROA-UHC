set_attack_value(AT_USTRONG, AG_CATEGORY, 2);
set_attack_value(AT_USTRONG, AG_SPRITE, sprite_get("ustrong"));
set_attack_value(AT_USTRONG, AG_AIR_SPRITE, sprite_get("ustrong_air"));
set_attack_value(AT_USTRONG, AG_NUM_WINDOWS, 4);
set_attack_value(AT_USTRONG, AG_STRONG_CHARGE_WINDOW, 1);
set_attack_value(AT_USTRONG, AG_HURTBOX_SPRITE, sprite_get("ustrong_hurt"));

set_window_value(AT_USTRONG, 1, AG_WINDOW_TYPE, 0);
set_window_value(AT_USTRONG, 1, AG_WINDOW_LENGTH, 8);
set_window_value(AT_USTRONG, 1, AG_WINDOW_ANIM_FRAMES, 2);

set_window_value(AT_USTRONG, 2, AG_WINDOW_TYPE, 0);
set_window_value(AT_USTRONG, 2, AG_WINDOW_LENGTH, 8);
set_window_value(AT_USTRONG, 2, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_USTRONG, 2, AG_WINDOW_ANIM_FRAME_START, 2);

set_window_value(AT_USTRONG, 3, AG_WINDOW_TYPE, 0);
set_window_value(AT_USTRONG, 3, AG_WINDOW_LENGTH, 3);
set_window_value(AT_USTRONG, 3, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_USTRONG, 3, AG_WINDOW_ANIM_FRAME_START, 3);
set_window_value(AT_USTRONG, 3, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_USTRONG, 3, AG_WINDOW_SFX, asset_get("sfx_swipe_heavy2"));

set_window_value(AT_USTRONG, 4, AG_WINDOW_TYPE, 0);
set_window_value(AT_USTRONG, 4, AG_WINDOW_LENGTH, 20);
set_window_value(AT_USTRONG, 4, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_USTRONG, 4, AG_WINDOW_ANIM_FRAME_START, 4);

set_num_hitboxes(AT_USTRONG, 0);
set_attack_value(AT_USTRONG, AG_NUM_HITBOXES_BLADED, 1);

set_hitbox_value(AT_USTRONG, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_USTRONG, 1, HG_WINDOW, 3);
set_hitbox_value(AT_USTRONG, 1, HG_LIFETIME, 2);
set_hitbox_value(AT_USTRONG, 1, HG_HITBOX_X, 20);
set_hitbox_value(AT_USTRONG, 1, HG_HITBOX_Y, -40);
set_hitbox_value(AT_USTRONG, 1, HG_WIDTH, 40);
set_hitbox_value(AT_USTRONG, 1, HG_HEIGHT, 80);
set_hitbox_value(AT_USTRONG, 1, HG_SHAPE, 0);
set_hitbox_value(AT_USTRONG, 1, HG_PRIORITY, 2);
set_hitbox_value(AT_USTRONG, 1, HG_DAMAGE, 3);
set_hitbox_value(AT_USTRONG, 1, HG_ANGLE, 100);
set_hitbox_value(AT_USTRONG, 1, HG_BASE_KNOCKBACK, 9);
set_hitbox_value(AT_USTRONG, 1, HG_ANGLE_FLIPPER, ANGLE_FLIPPER_AUTOLINK);
set_hitbox_value(AT_USTRONG, 1, HG_HITSTUN_MULTIPLIER, 0.3);
set_hitbox_value(AT_USTRONG, 1, HG_HIT_LOCKOUT, 3);
set_hitbox_value(AT_USTRONG, 1, HG_BASE_HITPAUSE, 5);
set_hitbox_value(AT_USTRONG, 1, HG_HITPAUSE_SCALING, .5);
set_hitbox_value(AT_USTRONG, 1, HG_SPIN_DAMAGE_BONUS, 1.25);
set_hitbox_value(AT_USTRONG, 1, HG_HIT_SFX, sound_get("sfx_ssbu_slash1"));

// Multihit
set_hitbox_value(AT_USTRONG, 2, HG_HITBOX_TYPE, 2);
set_hitbox_value(AT_USTRONG, 2, HG_LIFETIME, 4);
set_hitbox_value(AT_USTRONG, 2, HG_WIDTH, 40);
set_hitbox_value(AT_USTRONG, 2, HG_HEIGHT, 40);
set_hitbox_value(AT_USTRONG, 2, HG_PRIORITY, 3);
set_hitbox_value(AT_USTRONG, 2, HG_IGNORES_PROJECTILES, 1);
set_hitbox_value(AT_USTRONG, 2, HG_PROJECTILE_DESTROY_EFFECT, 1); //none
set_hitbox_value(AT_USTRONG, 2, HG_PROJECTILE_ENEMY_BEHAVIOR, 1);
set_hitbox_value(AT_USTRONG, 2, HG_PROJECTILE_GROUND_BEHAVIOR, 1);
set_hitbox_value(AT_USTRONG, 2, HG_PROJECTILE_WALL_BEHAVIOR, 1);
set_hitbox_value(AT_USTRONG, 2, HG_PROJECTILE_UNBASHABLE, 1);
set_hitbox_value(AT_USTRONG, 2, HG_PROJECTILE_DOES_NOT_REFLECT, 1);
set_hitbox_value(AT_USTRONG, 2, HG_PROJECTILE_IS_TRANSCENDENT, 1);
set_hitbox_value(AT_USTRONG, 2, HG_PROJECTILE_PLASMA_SAFE, 1);
set_hitbox_value(AT_USTRONG, 2, HG_ANGLE, 25);
set_hitbox_value(AT_USTRONG, 2, HG_ANGLE_FLIPPER, ANGLE_FLIPPER_CD_MULTIHIT);
set_hitbox_value(AT_USTRONG, 2, HG_DAMAGE, 1);
set_hitbox_value(AT_USTRONG, 2, HG_TECHABLE, 3);
set_hitbox_value(AT_USTRONG, 2, HG_BASE_KNOCKBACK, 2);
set_hitbox_value(AT_USTRONG, 2, HG_BASE_HITPAUSE, 2);
set_hitbox_value(AT_USTRONG, 2, HG_SPIN_COST, 1);
set_hitbox_value(AT_USTRONG, 2, HG_HIT_SFX, sound_get("sfx_ssbu_slash1b"));
set_hitbox_value(AT_USTRONG, 2, HG_PROJECTILE_SPRITE, asset_get("empty_sprite"));
set_hitbox_value(AT_USTRONG, 2, HG_PROJECTILE_MASK, -1);

//Finisher
set_hitbox_value(AT_USTRONG, 3, HG_HITBOX_TYPE, 2);
set_hitbox_value(AT_USTRONG, 3, HG_LIFETIME, 2);
set_hitbox_value(AT_USTRONG, 3, HG_WIDTH, 80);
set_hitbox_value(AT_USTRONG, 3, HG_HEIGHT, 80);
set_hitbox_value(AT_USTRONG, 3, HG_PRIORITY, 5);
set_hitbox_value(AT_USTRONG, 3, HG_PROJECTILE_DESTROY_EFFECT, 1); //none
set_hitbox_value(AT_USTRONG, 3, HG_PROJECTILE_ENEMY_BEHAVIOR, 1);
set_hitbox_value(AT_USTRONG, 3, HG_PROJECTILE_GROUND_BEHAVIOR, 1);
set_hitbox_value(AT_USTRONG, 3, HG_PROJECTILE_WALL_BEHAVIOR, 1);
set_hitbox_value(AT_USTRONG, 3, HG_PROJECTILE_UNBASHABLE, 1);
set_hitbox_value(AT_USTRONG, 3, HG_PROJECTILE_DOES_NOT_REFLECT, 1);
set_hitbox_value(AT_USTRONG, 3, HG_PROJECTILE_IS_TRANSCENDENT, 1);
set_hitbox_value(AT_USTRONG, 3, HG_PROJECTILE_PLASMA_SAFE, 1);
set_hitbox_value(AT_USTRONG, 3, HG_ANGLE, 90);
set_hitbox_value(AT_USTRONG, 3, HG_DAMAGE, 6);
set_hitbox_value(AT_USTRONG, 3, HG_HIT_LOCKOUT, 9);
set_hitbox_value(AT_USTRONG, 3, HG_HITSTUN_MULTIPLIER, 0.8);
set_hitbox_value(AT_USTRONG, 3, HG_BASE_KNOCKBACK, 6);
set_hitbox_value(AT_USTRONG, 3, HG_KNOCKBACK_SCALING, 0.7);
set_hitbox_value(AT_USTRONG, 3, HG_BASE_HITPAUSE, 8);
set_hitbox_value(AT_USTRONG, 3, HG_HITPAUSE_SCALING, 0.6);
set_hitbox_value(AT_USTRONG, 3, HG_SPIN_COST, 8);
set_hitbox_value(AT_USTRONG, 3, HG_SPIN_DAMAGE_BONUS, 4.2);
set_hitbox_value(AT_USTRONG, 3, HG_SPIN_KNOCKBACK_SCALING_BONUS, 0.4);
set_hitbox_value(AT_USTRONG, 3, HG_VISUAL_EFFECT, 304);
set_hitbox_value(AT_USTRONG, 3, HG_HIT_SFX, sound_get("sfx_ssbu_slash3"));
set_hitbox_value(AT_USTRONG, 3, HG_PROJECTILE_SPRITE, asset_get("empty_sprite"));
set_hitbox_value(AT_USTRONG, 3, HG_PROJECTILE_MASK, -1);
