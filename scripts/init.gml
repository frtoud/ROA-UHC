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
jump_speed = 11.5;
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
prat_land_time = 16;
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
dodge_recovery_frames = 4;

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
AG_NUM_HITBOXES_BLADED = 70; // Number of hitboxes when holding a blade
AG_WINDOW_SPIN_COST = 70;    // CD Charge cost of using the move when reaching this window
AG_WINDOW_LENGTH_BLADED = 71;// Length of window if holding blade
HG_SPIN_COST = 70;           // CD Charge cost of hitting with this hitbox

// Scaling bonuses applied on top of their respective values depending on CD Charge:
HG_SPIN_DAMAGE_BONUS = 71;            // HG_DAMAGE
HG_SPIN_HITPAUSE_BONUS = 72;          // HG_BASE_HITPAUSE
HG_SPIN_KNOCKBACK_BONUS = 73;         // HG_BASE_KNOCKBACK
HG_SPIN_KNOCKBACK_SCALING_BONUS = 74; // HG_KNOCKBACK_SCALING 

//=================================================
//Custom vfx & sprites
uhc_anim_blade_spin = 0;
uhc_anim_current_color = get_player_color(player);
uhc_anim_blade_color = uhc_anim_current_color;

uhc_anim_blade_force_draw = false; //strongs need to draw a CD that was just thrown

uhc_anim_blink_timer = 0;
uhc_anim_blink_timer_max = 16;
uhc_anim_blinker_shading = 0.0; //0 is black, 1 is fully bright

//airdodge buffering effect
uhc_anim_last_dodge = { posx:0, posy:0 };

for (var k = 0; k < 8; k++)
{
   var spr_string = "vfx_glitch" + string(k);
   vfx_glitches_array[k] = hit_fx_create(sprite_get(spr_string), 4);
   sprite_change_offset(spr_string, 12, 10);
}
vfx_glitch = vfx_glitches_array[0];
uhc_anim_rand_x = 0;
uhc_anim_rand_y = 0;

//Jabwalk
uhc_anim_jabwalk_timer = 0;
uhc_anim_jabwalk_frame = 0;
uhc_anim_jabwalk_legs_spr = sprite_get("jab_legs");

//Backflips
uhc_anim_back_flipping = false;
uhc_anim_backflip_spr = sprite_get("doublejump_back");

//Interface
vfx_label = sprite_get("vfx_label");
vfx_hud_bar = sprite_get("hud_bar");
vfx_hud_icons = sprite_get("hud_icons");

vfx_buffering = sprite_get("vfx_buffering");
vfx_mini_buffering = sprite_get("vfx_mini_buffering");

//FSPECIAL flash
vfx_flash_charge = sprite_get("vfx_flash_charge");
vfx_flash_small = sprite_get("vfx_flash_small");
vfx_flash_medium = sprite_get("vfx_flash_medium");
vfx_flash_large = sprite_get("vfx_flash_large");

uhc_anim_fspecial_flash_spr = noone;
uhc_anim_fspecial_flash_timer = 0;

//DSPECIAL Rewind
uhc_anim_rewind = 
{
    active: false,
    top_split:  0,
    bot_split:  0,
    top_offset: 0,
    mid_offset: 0,
    bot_offset: 0,
    sprite: sprite_get("vfx_rewind")
};

uhc_anim_buffer_timer = 0;
uhc_anim_dspecial_image_timer = 0;

sfx_dspecial_reload = sound_get("sfx_reload");
sfx_dspecial_reload_done = sound_get("sfx_reload_done");
sfx_cd_death = sound_get("sfx_cd_death");
sfx_cd_missing = sound_get("sfx_cd_missing");
sfx_cd_respawn = sound_get("sfx_cd_respawn");

//Quote
uhc_victory_quote = "Thx 4 watchign dont forget to rate 5 stars :)";
uhc_handled_victory_quote = false;

//=================================================
// Taunt video
uhc_taunt_videos[31] = noone; //preinitialized to a reasonable amount
uhc_taunt_collect_videos = true;
var i = 0;
add_uhc_video(i, "video_blocked",  1, 1); i++;
add_uhc_video(i, "video_dream",    1, 0); i++;
add_uhc_video(i, "video_nyan",    10, 0); i++;
add_uhc_video(i, "video_rick",     8, 0); i++;
add_uhc_video(i, "video_unreal",  15, 0); i++;
add_uhc_video(i, "video_love",    16, 0); i++;
uhc_taunt_num_videos = i;

uhc_taunt_current_video_index = 0;
uhc_taunt_current_video = noone;
uhc_taunt_timer = 0;
uhc_taunt_opening_timer = 0;
uhc_taunt_opening_timer_max = 8;
uhc_taunt_buffering_timer = 0;
uhc_taunt_reloop = false;

//NOTE: time values unsafe for online! only used in rendering!
uhc_fast_screenshot = 2 < (is_player_on(1) + is_player_on(2) + is_player_on(3) + is_player_on(4));
uhc_unsafe_screenshot = 
{
    sfx_time:  -1, //sound effect
    start_time:-1, //start of rising animation
    rise_time: -1, //end of rising animation
    fall_time: -1, //start of falling animation
    end_time:  -1, //end of falling animation
    next_time: -1, //Cooldown for next screenshot
    
    target: noone,
    sprite: noone,
    image: noone,
    spr_dir: 0,
    spr_left: 0,
    spr_top: 0
};
vfx_screenshot_tab = sprite_get("vfx_screenshot");

//=================================================
//Balancing variables
uhc_fstrong_throwspeed_base = 8;
uhc_fstrong_throwspeed_max = 12;
uhc_dstrong_throwspeed = 12;
uhc_ustrong_throwspeed_base = -9;
uhc_ustrong_throwspeed_max = -13;
uhc_ustrong_throwspeed_horz = -1;

uhc_dair_boost = 3;
uhc_dair_boost_final = 7;

uhc_cd_spin_drain_base = 0.04;
uhc_cd_spin_drain_idle = 0.10;
uhc_cd_spin_charge_rate = 1;
uhc_cd_spin_max = 100;
uhc_cd_respawn_timer_max = 300;

uhc_nspecial_charges_max = 4;
uhc_nspecial_speed = 12;

uhc_fspecial_charge_max = 480; // 8s * 60
uhc_fspecial_charge_half = 240; // 4s * 60
uhc_fspecial_cooldown = 60; // 1s * 60

uhc_uspecial_speed = 3;
uhc_uspecial_speed_fast = 7;

//=================================================
//Custom variables initialized here
uhc_has_cd_blade = true;
uhc_current_cd = instance_create(x, y, "obj_article1"); //CD held (or last CD held)
uhc_pickup_cooldown = 0;

uhc_dspecial_is_recalling = false;
uhc_recalling_cd = noone; // target CD of current DSPECIAL

uhc_cd_respawn_timer = 0;

uhc_update_blade_status = false;
uhc_spin_cost_throw_bypass = false; //allows spin cost to apply if CD is thrown
uhc_no_charging = false; //prevents CD blade drain and FSPECIAL charge

uhc_looping_attack_can_exit = false; //used with jab, dattack

uhc_dair_window_bounced = 0;

uhc_fspecial_charge_current = 0;

uhc_nspecial_charges = 0;
uhc_nspecial_is_charging = false;

uhc_uspecial_hitbox = noone;
uhc_uspecial_start_pos = { x:0, y:0 };

//=========================================================================
#define add_uhc_video(video_index, video_filename, video_fps, video_special)
{
    //cheating: this is preferrably done in load.gml, but I'm lazy.
    sprite_change_offset(video_filename, 11, 8);
    
    uhc_taunt_videos[video_index] = { sprite:sprite_get(video_filename),   
                                      song:sound_get(video_filename),   
                                      fps:video_fps,
                                      special:video_special
                                    };
}