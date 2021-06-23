set_attack_value(AT_TAUNT, AG_SPRITE, sprite_get("taunt"));
set_attack_value(AT_TAUNT, AG_NUM_WINDOWS, 7);
set_attack_value(AT_TAUNT, AG_HAS_LANDING_LAG, 3);
set_attack_value(AT_TAUNT, AG_OFF_LEDGE, 1);
set_attack_value(AT_TAUNT, AG_HURTBOX_SPRITE, asset_get("cat_hurtbox"));


set_window_value(AT_TAUNT, 1, AG_WINDOW_TYPE, 0);
set_window_value(AT_TAUNT, 1, AG_WINDOW_LENGTH, 15);
set_window_value(AT_TAUNT, 1, AG_WINDOW_ANIM_FRAMES, 3);

//Click in
set_window_value(AT_TAUNT, 2, AG_WINDOW_TYPE, 0);
set_window_value(AT_TAUNT, 2, AG_WINDOW_LENGTH, 12);
set_window_value(AT_TAUNT, 2, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_TAUNT, 2, AG_WINDOW_ANIM_FRAME_START, 3);
set_window_value(AT_TAUNT, 2, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_TAUNT, 2, AG_WINDOW_SFX_FRAME, 4);
set_window_value(AT_TAUNT, 2, AG_WINDOW_SFX, sound_get("sfx_click"));

set_window_value(AT_TAUNT, 3, AG_WINDOW_TYPE, 0);
set_window_value(AT_TAUNT, 3, AG_WINDOW_LENGTH, 12);
set_window_value(AT_TAUNT, 3, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_TAUNT, 3, AG_WINDOW_ANIM_FRAME_START, 6);

//Loop
set_window_value(AT_TAUNT, 4, AG_WINDOW_TYPE, 9); //looping
set_window_value(AT_TAUNT, 4, AG_WINDOW_LENGTH, 10);
set_window_value(AT_TAUNT, 4, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_TAUNT, 4, AG_WINDOW_ANIM_FRAME_START, 9);

set_window_value(AT_TAUNT, 5, AG_WINDOW_TYPE, 0);
set_window_value(AT_TAUNT, 5, AG_WINDOW_LENGTH, 12);
set_window_value(AT_TAUNT, 5, AG_WINDOW_ANIM_FRAMES, -3); //not a typo >:]
set_window_value(AT_TAUNT, 5, AG_WINDOW_ANIM_FRAME_START, 9);

//Click out
set_window_value(AT_TAUNT, 6, AG_WINDOW_TYPE, 0);
set_window_value(AT_TAUNT, 6, AG_WINDOW_LENGTH, 12);
set_window_value(AT_TAUNT, 6, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_TAUNT, 6, AG_WINDOW_ANIM_FRAME_START, 3);
set_window_value(AT_TAUNT, 6, AG_WINDOW_HAS_SFX, 1);
set_window_value(AT_TAUNT, 6, AG_WINDOW_SFX_FRAME, 4);
set_window_value(AT_TAUNT, 6, AG_WINDOW_SFX, sound_get("sfx_click"));

set_window_value(AT_TAUNT, 7, AG_WINDOW_TYPE, 0);
set_window_value(AT_TAUNT, 7, AG_WINDOW_LENGTH, 15);
set_window_value(AT_TAUNT, 7, AG_WINDOW_ANIM_FRAMES, -3); //not a typo >:]
set_window_value(AT_TAUNT, 7, AG_WINDOW_ANIM_FRAME_START, 3);

set_num_hitboxes(AT_TAUNT, 0);