set_attack_value(AT_NSPECIAL, AG_CATEGORY, 2);
set_attack_value(AT_NSPECIAL, AG_SPRITE, sprite_get("nspecial"));
set_attack_value(AT_NSPECIAL, AG_NUM_WINDOWS, 3);
set_attack_value(AT_NSPECIAL, AG_AIR_SPRITE, sprite_get("nspecial_air"));
set_attack_value(AT_NSPECIAL, AG_HURTBOX_SPRITE, sprite_get("nspecial_hurt"));
set_attack_value(AT_NSPECIAL, AG_HURTBOX_AIR_SPRITE, sprite_get("nspecial_air_hurt"));

set_window_value(AT_NSPECIAL, 1, AG_WINDOW_TYPE, 0);
set_window_value(AT_NSPECIAL, 1, AG_WINDOW_LENGTH, 6);
set_window_value(AT_NSPECIAL, 1, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_NSPECIAL, 1, AG_WINDOW_GOTO, 3);

//Loops to charge using attack_update.gml
set_window_value(AT_NSPECIAL, 2, AG_WINDOW_TYPE, 9); //Looping
set_window_value(AT_NSPECIAL, 2, AG_WINDOW_LENGTH, 16);
set_window_value(AT_NSPECIAL, 2, AG_WINDOW_ANIM_FRAMES, 5); //controlled manually
set_window_value(AT_NSPECIAL, 2, AG_WINDOW_ANIM_FRAME_START, 2);

set_window_value(AT_NSPECIAL, 3, AG_WINDOW_TYPE, 0);
set_window_value(AT_NSPECIAL, 3, AG_WINDOW_LENGTH, 28);
set_window_value(AT_NSPECIAL, 3, AG_WINDOW_ANIM_FRAMES, 5);
set_window_value(AT_NSPECIAL, 3, AG_WINDOW_ANIM_FRAME_START, 7);
set_window_value(AT_NSPECIAL, 3, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_NSPECIAL, 3, AG_WINDOW_SFX, asset_get("sfx_swipe_weak1"));
set_window_value(AT_NSPECIAL, 3, AG_WINDOW_SFX_FRAME, 4);

//charge-cancel window
set_window_value(AT_NSPECIAL, 4, AG_WINDOW_TYPE, 1);
set_window_value(AT_NSPECIAL, 4, AG_WINDOW_LENGTH, 8);
set_window_value(AT_NSPECIAL, 4, AG_WINDOW_ANIM_FRAMES, -2); //not a typo >:]
set_window_value(AT_NSPECIAL, 4, AG_WINDOW_ANIM_FRAME_START, 2);
set_window_value(AT_NSPECIAL, 4, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_NSPECIAL, 4, AG_WINDOW_SFX, asset_get("mfx_unstar"));
set_window_value(AT_NSPECIAL, 4, AG_WINDOW_SFX_FRAME, 1);

set_num_hitboxes(AT_NSPECIAL, 1);

//projectiles are pretty much identical
for (var i = 1; i <= 5; i++)
{
    set_hitbox_value(AT_NSPECIAL, i, HG_HITBOX_TYPE, 2);
    set_hitbox_value(AT_NSPECIAL, i, HG_WINDOW, 3);
    set_hitbox_value(AT_NSPECIAL, i, HG_WINDOW_CREATION_FRAME, 5 + 1*(i-1));
    set_hitbox_value(AT_NSPECIAL, i, HG_LIFETIME, 45);
    set_hitbox_value(AT_NSPECIAL, i, HG_HITBOX_X, -15);
    set_hitbox_value(AT_NSPECIAL, i, HG_HITBOX_Y, -15);
    set_hitbox_value(AT_NSPECIAL, i, HG_WIDTH, 16);
    set_hitbox_value(AT_NSPECIAL, i, HG_HEIGHT, 16);
    set_hitbox_value(AT_NSPECIAL, i, HG_PRIORITY, 3);
    set_hitbox_value(AT_NSPECIAL, i, HG_PROJECTILE_GROUND_BEHAVIOR, 0);
    set_hitbox_value(AT_NSPECIAL, i, HG_PROJECTILE_WALL_BEHAVIOR, 0);
    set_hitbox_value(AT_NSPECIAL, i, HG_DAMAGE, 1);
    set_hitbox_value(AT_NSPECIAL, i, HG_BASE_KNOCKBACK, 5);
    set_hitbox_value(AT_NSPECIAL, i, HG_BASE_HITPAUSE, 2);
    set_hitbox_value(AT_NSPECIAL, i, HG_FORCE_FLINCH, 1);
    set_hitbox_value(AT_NSPECIAL, i, HG_ANGLE, 75);
    set_hitbox_value(AT_NSPECIAL, i, HG_HIT_SFX, asset_get("sfx_blow_weak1"));
    set_hitbox_value(AT_NSPECIAL, i, HG_PROJECTILE_SPRITE, sprite_get("proj_star"));
    set_hitbox_value(AT_NSPECIAL, i, HG_PROJECTILE_MASK, -1);
    set_hitbox_value(AT_NSPECIAL, i, HG_PROJECTILE_DESTROY_EFFECT, vfx_star_destroy);
    set_hitbox_value(AT_NSPECIAL, i, HG_PROJECTILE_HSPEED, uhc_nspecial_speed);

    if (uhc_rune_flags.star_rewind)
    {
        set_hitbox_value(AT_NSPECIAL, i, HG_LIFETIME, 2 * get_hitbox_value(AT_NSPECIAL, i, HG_LIFETIME));
        set_hitbox_value(AT_NSPECIAL, i, HG_PROJECTILE_ENEMY_BEHAVIOR, 1);
    }
}
