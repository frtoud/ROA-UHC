set_attack_value(AT_DSTRONG_2, AG_CATEGORY, 1);
set_attack_value(AT_DSTRONG_2, AG_SPRITE, sprite_get("dstrong_air"));
set_attack_value(AT_DSTRONG_2, AG_NUM_WINDOWS, 4);
set_attack_value(AT_DSTRONG_2, AG_HAS_LANDING_LAG, 1);
set_attack_value(AT_DSTRONG_2, AG_LANDING_LAG, 8);
set_attack_value(AT_DSTRONG_2, AG_HURTBOX_SPRITE, sprite_get("dstrong_air_hurt"));

set_window_value(AT_DSTRONG_2, 1, AG_WINDOW_TYPE, 1);
set_window_value(AT_DSTRONG_2, 1, AG_WINDOW_LENGTH, 8);
set_window_value(AT_DSTRONG_2, 1, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_DSTRONG_2, 1, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_DSTRONG_2, 1, AG_WINDOW_SFX_FRAME, 7);
set_window_value(AT_DSTRONG_2, 1, AG_WINDOW_SFX, asset_get("sfx_swipe_heavy1"));

set_window_value(AT_DSTRONG_2, 2, AG_WINDOW_TYPE, 1);
set_window_value(AT_DSTRONG_2, 2, AG_WINDOW_LENGTH, 4);
set_window_value(AT_DSTRONG_2, 2, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_DSTRONG_2, 2, AG_WINDOW_ANIM_FRAME_START, 2);
set_window_value(AT_DSTRONG_2, 2, AG_WINDOW_VSPEED, -8);
set_window_value(AT_DSTRONG_2, 2, AG_WINDOW_VSPEED_TYPE, 2);
set_window_value(AT_DSTRONG_2, 2, AG_WINDOW_SPIN_COST, 8);

set_window_value(AT_DSTRONG_2, 3, AG_WINDOW_TYPE, 1);
set_window_value(AT_DSTRONG_2, 3, AG_WINDOW_LENGTH, 15);
set_window_value(AT_DSTRONG_2, 3, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_DSTRONG_2, 3, AG_WINDOW_ANIM_FRAME_START, 3);

set_num_hitboxes(AT_DSTRONG_2, 0);

set_hitbox_value(AT_DSTRONG_2, 1, HG_HITBOX_TYPE, 2);
set_hitbox_value(AT_DSTRONG_2, 1, HG_LIFETIME, 1);
set_hitbox_value(AT_DSTRONG_2, 1, HG_WIDTH, 40);
set_hitbox_value(AT_DSTRONG_2, 1, HG_HEIGHT, 40);
set_hitbox_value(AT_DSTRONG_2, 1, HG_SHAPE, 0);
set_hitbox_value(AT_DSTRONG_2, 1, HG_PRIORITY, 2);
set_hitbox_value(AT_DSTRONG_2, 1, HG_DAMAGE, 8);
set_hitbox_value(AT_DSTRONG_2, 1, HG_ANGLE, 270);
set_hitbox_value(AT_DSTRONG_2, 1, HG_BASE_KNOCKBACK, 8);
set_hitbox_value(AT_DSTRONG_2, 1, HG_KNOCKBACK_SCALING, 1);
set_hitbox_value(AT_DSTRONG_2, 1, HG_BASE_HITPAUSE, 7);
set_hitbox_value(AT_DSTRONG_2, 1, HG_HITPAUSE_SCALING, .9);
set_hitbox_value(AT_DSTRONG_2, 1, HG_SPIN_COST, 12);
set_hitbox_value(AT_DSTRONG_2, 1, HG_SPIN_DAMAGE_BONUS, 4.25);
set_hitbox_value(AT_DSTRONG_2, 1, HG_VISUAL_EFFECT, 13);
set_hitbox_value(AT_DSTRONG_2, 1, HG_VISUAL_EFFECT_X_OFFSET, 10);
set_hitbox_value(AT_DSTRONG_2, 1, HG_HIT_SFX, asset_get("sfx_blow_heavy1"));
set_hitbox_value(AT_DSTRONG_2, 1, HG_HITSTUN_MULTIPLIER, 1.0);
set_hitbox_value(AT_DSTRONG_2, 1, HG_PROJECTILE_SPRITE, asset_get("empty_sprite"));
set_hitbox_value(AT_DSTRONG_2, 1, HG_PROJECTILE_MASK, -1);
set_hitbox_value(AT_DSTRONG_2, 1, HG_PROJECTILE_UNBASHABLE, 1);
set_hitbox_value(AT_DSTRONG_2, 1, HG_PROJECTILE_DOES_NOT_REFLECT, 1);
set_hitbox_value(AT_DSTRONG_2, 1, HG_PROJECTILE_IS_TRANSCENDENT, 1);
set_hitbox_value(AT_DSTRONG_2, 1, HG_PROJECTILE_PLASMA_SAFE, 1);