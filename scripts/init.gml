hurtbox_spr = asset_get("cat_hurtbox");
crouchbox_spr = asset_get("ex_guy_crouch_box");
air_hurtbox_spr = -1;
hitstun_hurtbox_spr = -1;

char_height = 52;
idle_anim_speed = .125;
crouch_anim_speed = 0;
walk_anim_speed = .2;
dash_anim_speed = .25;
pratfall_anim_speed = .25;

walk_speed = 2.75;
walk_accel = 1;
walk_turn_time = 6;
initial_dash_time = 14;
initial_dash_speed = 8;
dash_speed = 7.5;
dash_turn_time = 10;
dash_turn_accel = 1.4;
dash_stop_time = 12;
dash_stop_percent = .3; //the value to multiply your hsp by when going into idle from dash or dashstop
ground_friction = .5;
moonwalk_accel = 1.4;

jump_start_time = 5;
jump_speed = 11;
short_hop_speed = 7.5;
djump_speed = 11;
leave_ground_max = 8; //the maximum hsp you can have when you go from grounded to aerial without jumping
max_jump_hsp = 8; //the maximum hsp you can have when jumping from the ground
air_max_speed = 3.75; //the maximum hsp you can accelerate to when in a normal aerial state
jump_change = 3; //maximum hsp when double jumping. If already going faster, it will not slow you down
air_accel = .5;
prat_fall_accel = .85; //multiplier of air_accel while in pratfall
air_friction = .01;
max_djumps = 1;
double_jump_time = 40; //the number of frames to play the djump animation. Can't be less than 31.
walljump_hsp = 7;
walljump_vsp = 11;
walljump_time = 32;
max_fall = 10; //maximum fall speed without fastfalling
fast_fall = 15; //fast fall speed
gravity_speed = .6;
hitstun_grav = .5;
knockback_adj = 1.0; //the multiplier to KB dealt to you. 1 = default, >1 = lighter, <1 = heavier

land_time = 6; //normal landing frames
prat_land_time = 3;
wave_land_time = 8;
wave_land_adj = 1.35; //the multiplier to your initial hsp when wavelanding. Usually greater than 1
wave_friction = .04; //grounded deceleration when wavelanding

//crouch animation frames
crouch_startup_frames = 2;
crouch_active_frames = 1;
crouch_recovery_frames = 2;

//parry animation frames
dodge_startup_frames = 1;
dodge_active_frames = 1;
dodge_recovery_frames = 3;

//tech animation frames
tech_active_frames = 3;
tech_recovery_frames = 1;

//tech roll animation frames
techroll_startup_frames = 2
techroll_active_frames = 2;
techroll_recovery_frames = 2;
techroll_speed = 10;

//airdodge animation frames
air_dodge_startup_frames = 2;
air_dodge_active_frames = 2;
air_dodge_recovery_frames = 4;
air_dodge_speed = 7.7;

//roll animation frames
roll_forward_startup_frames = 2;
roll_forward_active_frames = 4;
roll_forward_recovery_frames = 2;
roll_back_startup_frames = 2;
roll_back_active_frames = 4;
roll_back_recovery_frames = 2;
roll_forward_max = 9; //roll speed
roll_backward_max = 9;

land_sound = asset_get("sfx_gus_land");
landing_lag_sound = asset_get("sfx_gus_land");
waveland_sound = asset_get("sfx_waveland_gus");
jump_sound = asset_get("sfx_jumpground");
djump_sound = asset_get("sfx_jumpair");
air_dodge_sound = asset_get("sfx_quick_dodge");

//visual offsets for when you're in Ranno's bubble
bubble_x = 0;
bubble_y = 8;

//=================================================
//Custom Frame Data indices
AG_NUM_HITBOXES_BLADED = 70;
AG_WINDOW_SPIN_COST = 70;
HG_SPIN_COST = 70;
HG_SPIN_DAMAGE_BONUS = 71;
HG_SPIN_HITPAUSE_BONUS = 72;
HG_SPIN_KNOCKBACK_BONUS = 73;
HG_SPIN_KNOCKBACK_SCALING_BONUS = 74;

//=================================================
//Custom vfx & sprites
uhc_anim_blade_spin = 0;
anim_blink_timer = 0;
anim_blink_timer_max = 60;

//airdodge buffering effect
uhc_anim_last_dodge = { posx:0, posy:0 };

uhc_anim_back_flipping = false;
uhc_anim_backflip_spr = sprite_get("doublejump_back");

vfx_label = sprite_get("vfx_label");
vfx_buffering = sprite_get("vfx_buffering");
vfx_mini_buffering = sprite_get("vfx_mini_buffering");

uhc_victory_quote = "this text coms from" +chr(10)+ " teh init file lololol";

uhc_taunt_videos[31] = noone; //preinitialized to a reasonable amount

uhc_taunt_collect_videos = true;
var i = 0;
//Must stay first
uhc_taunt_videos[i] = { sprite:sprite_get("video_blocked"), song:sound_get("video_blocked"), fps:1  }; i++;

uhc_taunt_videos[i] = { sprite:sprite_get("video_dream"),   song:sound_get("video_dream"),   fps:1  }; i++;
uhc_taunt_videos[i] = { sprite:sprite_get("video_nyan"),    song:sound_get("video_nyan"),    fps:10 }; i++;
uhc_taunt_videos[i] = { sprite:sprite_get("video_rick"),    song:sound_get("video_rick"),    fps:5  }; i++;
uhc_taunt_videos[i] = { sprite:sprite_get("video_unreal"),  song:sound_get("video_unreal"),  fps:15 }; i++;
uhc_taunt_num_videos = i;

uhc_taunt_current_video = noone;
uhc_taunt_timer = 0;
uhc_taunt_opening_timer = 0;
uhc_taunt_opening_timer_max = 8;
uhc_taunt_buffering_timer = 0;
uhc_taunt_reloop = false;

//=================================================
//Balancing variables
uhc_fstrong_throwspeed_base = 7.5;
uhc_fstrong_throwspeed_max = 12;

uhc_cd_spin_drain_base = 0.04;
uhc_cd_spin_drain_idle = 0.10;
uhc_cd_spin_max = 100;

//=================================================
//Custom variables initialized here
uhc_current_cd = noone;
uhc_other_cd = noone;
uhc_has_cd_blade = true;
uhc_no_blade_drain = false;




