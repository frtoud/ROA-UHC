hurtbox_spr = asset_get("cat_hurtbox");
crouchbox_spr = asset_get("ex_guy_crouch_box");
air_hurtbox_spr = -1;
hitstun_hurtbox_spr = -1;

char_height = 42;
idle_anim_speed = .125;
crouch_anim_speed = 0;
walk_anim_speed = .2;
dash_anim_speed = .25;
pratfall_anim_speed = .25;

walk_speed = 2.75;
walk_accel = 1;
walk_turn_time = 6;
initial_dash_time = 12;
initial_dash_speed = 7.2;
dash_speed = 7;
dash_turn_time = 8;
dash_turn_accel = 1.5;
dash_stop_time = 8;
dash_stop_percent = .3; //the value to multiply your hsp by when going into idle from dash or dashstop
ground_friction = .7;
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
walljump_hsp = 8;
walljump_vsp = 10;
walljump_time = 25;
max_fall = 10; //maximum fall speed without fastfalling
fast_fall = 13; //fast fall speed
gravity_speed = .6;
hitstun_grav = .5;
knockback_adj = 0.95; //the multiplier to KB dealt to you. 1 = default, >1 = lighter, <1 = heavier

land_time = 6; //normal landing frames
prat_land_time = 18;
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
tech_active_frames = 1;
tech_recovery_frames = 1;

//tech roll animation frames
techroll_startup_frames = 1;
techroll_active_frames = 3;
techroll_recovery_frames = 3;
techroll_speed = 9;

//airdodge animation frames
air_dodge_startup_frames = 2;
air_dodge_active_frames = 2;
air_dodge_recovery_frames = 4;
air_dodge_speed = 7.7;

//roll animation frames
roll_forward_startup_frames = 1;
roll_forward_active_frames = 3;
roll_forward_recovery_frames = 3;
roll_back_startup_frames = 1;
roll_back_active_frames = 3;
roll_back_recovery_frames = 3;
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
//NOTE: because of an issue with reset_hitbox_value, it will instead hold the "base + bonus" maximum value. dan pls.
danpls_adjusted_spinbonuses = false; //see update.gml

HG_SPIN_DAMAGE_BONUS = 71;            // HG_DAMAGE
HG_SPIN_HITPAUSE_BONUS = 72;          // HG_BASE_HITPAUSE
HG_SPIN_KNOCKBACK_BONUS = 73;         // HG_BASE_KNOCKBACK
HG_SPIN_KNOCKBACK_SCALING_BONUS = 74; // HG_KNOCKBACK_SCALING
// sound effect adjustment for high spin moves
HG_SPIN_SFX = 75;                     // HG_HIT_SFX 
uhc_spin_sfx_threshold = 0.50; //above 50% spin bonuses, you get the new sounds
uhc_spin_sfx_high_threshold = 0.95; //above 95% spin bonuses, some moves get even more sounds
// (not actual spin percent, see uhc_cd_spin_effective_max below)

// Custom Angle Flipper setup
HG_UHC_MULTIHIT_FLIPPER = 77;
ANGLE_FLIPPER_AUTOLINK = 1; //simulates "pull towards center" but considers position of victim & base KB direction/length
ANGLE_FLIPPER_CD_MULTIHIT = 2; //simulate "pull towards center" but considers position of victim & speed of cd

//=================================================
//Custom vfx & sprites
uhc_anim_blade_spin = 0;
uhc_anim_current_color = get_player_color(player);
uhc_anim_blade_color = uhc_anim_current_color;
init_shader();

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

uhc_pratland_spr = sprite_get("pratland");

//Interface
vfx_label = sprite_get("vfx_label");
vfx_hud_bar = sprite_get("hud_bar");
vfx_hud_ad = sprite_get("hud_bar_ad");
vfx_hud_icons = sprite_get("hud_icons");

vfx_buffering = sprite_get("vfx_buffering");
vfx_mini_buffering = sprite_get("vfx_mini_buffering");
vfx_muted = sprite_get("vfx_muted");

//NSPECIAL 
uhc_anim_nspecial_arm = sprite_get("nspecial_arm");
uhc_anim_nspecial_smear = sprite_get("nspecial_smear");
uhc_anim_nspecial_smear_air = sprite_get("nspecial_air_smear");

vfx_star_trail = hit_fx_create(sprite_get("vfx_star_trail"), 3);
vfx_star_destroy = hit_fx_create(sprite_get("vfx_star_destroy"), 8);
vfx_star_destroy_longer = hit_fx_create(sprite_get("vfx_star_destroy"), 20);

//FSPECIAL flash
vfx_flash_charge = sprite_get("vfx_flash_charge");
vfx_flash_small = sprite_get("vfx_flash_small");
vfx_flash_medium = sprite_get("vfx_flash_medium");
vfx_flash_large = sprite_get("vfx_flash_large");

uhc_anim_fspecial_flash_spr = noone;
uhc_anim_fspecial_flash_timer = 0;
uhc_anim_fspecial_flash_time = 8;
uhc_anim_fspecial_flash_pre_time = 8;

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

vfx_spinning = hit_fx_create(sprite_get("vfx_spinning"), 4);
vfx_burning = hit_fx_create(asset_get("fire_part_spr1"), 24);

indicator_spr = sprite_get("indicator_triangle");

uhc_anim_buffer_timer = 0;
uhc_anim_dspecial_image_timer = 0;
uhc_anim_platform_timer = 0;
uhc_anim_platform_timer_min =  90; //start of platform visibility
uhc_anim_platform_timer_max = 300 - uhc_anim_platform_timer_min; //time until platform despawns
uhc_anim_platform_buffer_timer = 0;

uhc_anim_frozen_meter = 0;

sfx_dspecial_reload = sound_get("sfx_reload");
sfx_dspecial_reload_done = sound_get("sfx_reload_done");
sfx_cd_death = sound_get("sfx_cd_death");
sfx_cd_catch = sound_get("sfx_reload_done");
sfx_cd_missing = sound_get("sfx_cd_missing");
sfx_cd_respawn = sound_get("sfx_cd_respawn");

//Quote
uhc_victory_quote = "Thx 4 watchign dont forget to rate 5 stars :)";
uhc_handled_victory_quote = false;

//Hat
vfx_hat_spawn = sprite_get("vfx_hat_spawn");
vfx_hat_idle = sprite_get("vfx_hat_idle");
vfx_hat_lost = sprite_get("vfx_hat_lost");
uhc_has_hat = (get_match_setting(SET_SEASON) == 4) //christmas
uhc_lost_hat_pos = {x:0,y:0}
uhc_lost_hat_timer = 0;
uhc_lost_hat_timer_max = 32;

uhc_batteries = detect_online() || !((current_day == 1) && (current_month == 4));

uhc_buffer_breaks_music = (get_synced_var(player) & 0x01) == 0;
uhc_music_is_broken = false;
uhc_music_break_sfx = sound_get("unused");
uhc_music_break_strength = 11;
uhc_music_break_storage = [];
for (var i = 0; i < uhc_music_break_strength; i++)
    uhc_music_break_storage[i] = sound_play(uhc_music_break_sfx, true, 0, 0, 0);


//=================================================
// Taunt video
uhc_taunt_videos[31] = noone; //preinitialized to a reasonable amount
uhc_taunt_collect_videos = true;
var i = 0;
uhc_taunt_videos[i] = make_uhc_video("This video is not available in your country.", 
                                     "video_blocked", "video_blocked", 0, 1); i++;
uhc_taunt_videos[i] = make_uhc_video("Trance - 009 Sound System Dreamscape (HD)", 
                                     "video_dream",   "video_dream",   0);    i++;
uhc_taunt_videos[i] = make_uhc_video("Nyan Cat [original]", 
                                     "video_nyan",    "video_nyan",   10);    i++;
uhc_taunt_videos[i] = make_uhc_video("Rick Astley - Never Gonna Give You Up (Official Music Video)", 
                                     "video_rick",    "video_rick",    8, 2); i++;
uhc_taunt_videos[i] = make_uhc_video("[YTP] The King Downloads Sony Vegas", 
                                     "video_unreal",  "video_unreal", 15);    i++;
uhc_taunt_videos[i] = make_uhc_video("What is love !!! Jim Carrey Troll Face", 
                                     "video_love",    "video_love",   16);    i++;
uhc_taunt_num_videos = i;
uhc_taunt_blocked_video = uhc_taunt_videos[0]; //keep track of this one separately. might be useful

uhc_taunt_videos_unlock_bits = (get_synced_var(player) >> 4) & 0xFFFF;

uhc_playlist_data = get_playlist_persistence();

uhc_taunt_current_video_index = 0;
uhc_taunt_current_video = noone;
uhc_taunt_timer = 0;
uhc_taunt_opening_timer = 0;
uhc_taunt_opening_timer_max = 8;
uhc_taunt_buffering_timer = 0;
uhc_taunt_reloop = false;
uhc_taunt_bufferskip = false;
uhc_taunt_current_audio = noone;
uhc_taunt_muted = false;

//=============================================================
//Screenshot spoofing
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
//Rune flags
uhc_rune_flags = 
{
    deadly_rickroll: has_rune("F"),
    doctor_nair: has_rune("A"),
    ganon_dair: has_rune("B"),
    airdodge_buffering: has_rune("D"),
    star_rewind: has_rune("C"),
    combo_stars: has_rune("H"),
    super_flash: has_rune("G"),
    whiffless: has_rune("L"),

    late_ad: has_rune("M"),
    fire_throws: has_rune("E"),
    passive_rewind: has_rune("I"),
    aircharge_strongs: has_rune("J"),
    wincon: has_rune("K"), //you're welcome ShadowKing
    remote_throws: has_rune("N"),
    dual_disk_system: has_rune("O") //you read that right
}

//=================================================
//Balancing variables
uhc_fstrong_throwspeed_base = 8;
uhc_fstrong_throwspeed_max = 12;
uhc_dstrong_throwspeed = 12;
uhc_ustrong_throwspeed_base = -9;
uhc_ustrong_throwspeed_max = -13;
uhc_ustrong_throwspeed_horz = -0.5;

uhc_bair_pseudograb_length = 12;   //frames when hit until grab stops taking effect (includes hitpause)
uhc_bair_pseudograb_factor = 0.08; //strength of interpolation pulling to target position

uhc_dair_boost = 3;
uhc_dair_boost_final = 7;

uhc_cd_spin_drain_base = 0.035; //per frame
uhc_cd_spin_drain_idle = uhc_rune_flags.passive_rewind ? -0.065 : 0.065; //per frame
uhc_cd_spin_drain_clairen = 0.65; //per frame
uhc_cd_spin_charge_rate = 1.35; //per frame
uhc_cd_spin_max = 100;
uhc_cd_respawn_timer_max = uhc_rune_flags.dual_disk_system ? -1 : 300; //# of frames (FREE when dual-wielding)
uhc_pickup_cooldown_max = 30; //# of frames
uhc_throw_cooldown_max = 12; //# of frames

//% of uhc_cd_spin_max at which bonus scalings starts going down
//ie. at [100..85] you still get 100% bonuses, then linearly down to zero
uhc_cd_spin_effective_max = (uhc_rune_flags.late_ad ? 0.35 : 0.85);

uhc_nspecial_charges_max = 4;
uhc_nspecial_speed = 12;

uhc_fspecial_charge_max = 15*60;
uhc_fspecial_charge_half = 5*60;
uhc_fspecial_cooldown = 1*60;
//super flash rune
uhc_uair_flash_penalty = 4*60;

uhc_uspecial_speed = 3;
uhc_uspecial_speed_fast = 7;
uhc_uspecial_soft_cooldown_max = 150;
uhc_extended_pratland_penalty = 20;

//=================================================
//Custom variables initialized here
uhc_do_cstick_tilt_check = false; //detect cstick inputs
uhc_do_cstick_special_check = false;

uhc_has_cd_blade = true;
uhc_current_cd = instance_create(x, y, "obj_article1"); //CD held (or last CD held)
uhc_pickup_cooldown = 0; //number of frames before being able to pickup a CD
uhc_throw_cooldown_override = 0; //number of frames before you can throw again

uhc_dspecial_is_recalling = false;
uhc_recalling_cd = noone; // target CD of current DSPECIAL

uhc_cd_respawn_timer = 0;
uhc_cd_can_respawn = false;

uhc_update_blade_status = false;
uhc_spin_cost_throw_bypass = false; //allows spin cost to apply if CD is thrown
uhc_no_charging = false; //prevents CD blade drain and FSPECIAL charge

uhc_looping_attack_can_exit = false; //used with jab, dattack

uhc_fresh_air_throw = false; //true if just threw CD in aerial attack
uhc_air_throw_frames = 0; //increases for each frame not landed after an aerial throw

uhc_last_strong_charge = 0; //for air strong charge hitpause

uhc_dair_window_bounced = 0;

uhc_fspecial_charge_current = 0;

uhc_nspecial_charges = 0;
uhc_nspecial_is_charging = false;

uhc_uspecial_hitbox = noone;
uhc_uspecial_start_pos = { x:0, y:0 };
uhc_uspecial_last_dir = 0; //controller cannot rely on joy_dir when idle; it reverts to zero

uhc_uspecial_soft_cooldown = 0;
uhc_has_extended_pratland = false;


//from other_init, for simplicity
uhc_handler_id = noone;

//RUNES
uhc_is_star_rewinding = false;
uhc_can_overrewind = false; //allows UHC to rewind even at end of playback, while a star is active

//somewhat wonky combo counter
//see hit_player.gml
uhc_combo_prehit_flag = false; // allows multihits to count as one move; to let the last hitbox grant a star
uhc_last_hit_landed = AT_TAUNT;

//=================================================
// Compatibility Zone

//Pokémon Stadium
pkmn_stadium_front_img = sprite_get("cmp_stadium_front");
pkmn_stadium_back_img = sprite_get("cmp_stadium_back");
pkmn_stadium_name_override = "HyperCam";

//Mt. Dedede Stadium
arena_title = "Five-Star Freeware";
arena_short_name = "HyperCam 2";

//Trial Grounds
guiltySprite = sprite_get("cmp_trial_grounds");

//Hikaru
Hikaru_Title = "Five-Star Freeware";

//Wall-E
walle_taunt_sound = sound_get("cmp_walle");
walle_taunt_type = 1;
walle_taunt_playing = false;

//TCO
tcoart = sprite_get("cmp_tco");

//Kirby
enemykirby = noone;
kirbyability = 16;
swallowed = false;
// for easter egg to work
uhc_kirby_last_sprite = { spr: noone, img: 0, time: 0 };

//Agent N
nname = "Unregistered HyperCam 2"
ncode1 = "Outfitted with a deadly sawblade and throwing stars.";
ncode2 = "Creator unknown, but deeply nostalgic.";
ncode3 = "Pretends to be royalty; incessantly asks to subscribe.";

//Po & Gumbo
pot_compat_variable = sprite_get("cmp_gumbo");
pot_compat_text = "PBJ Sandwich";

//Mamizou
mamizou_transform_spr = sprite_get("cmp_mamizou");

//=========================================================================
#define make_uhc_video
var video_title = argument[0], 
    sprite_name = argument[1],
    sound_name  = argument[2], 
    video_fps   = argument[3];
//set to 1 to skip bufferring
//set to 2 to be extra loud if "deadly rickroll" rune is active 
var video_special = argument_count > 4 ? argument[4] : 0;
{
    //cheating: this is preferrably done in load.gml, but I'm lazy.
    sprite_change_offset(sprite_name, 11, 8);
    
    return { title:video_title,
             sprite:sprite_get(sprite_name),
             song:sound_get(sound_name),
             fps:video_fps,
             special:video_special
           };
}
//=========================================================================
#define detect_online()
{
    for (var cur = 0; cur < 4; cur++)
    {
        if (get_player_hud_color(cur+1) == $64e542) //online-only color 
            return true;
    }
    return false;
}
//=========================================================================
#macro IMPOSSIBLY_LONG_TIME 999999999999999999999999999999999999999999999
#define get_playlist_persistence()
{
    var data = noone;
    with asset_get("hit_fx_obj") if ("uhc_playlist_persistence" in self)
    {
        data = self; break;
    }
    if !instance_exists(data)
    {
        data = spawn_hit_fx(-999, -999, 0);
        data.uhc_playlist_persistence = true;
        data.player = 0;
        data.visible = false;
        data.persistent = true;

        //making data last "forever"
        data.pause = IMPOSSIBLY_LONG_TIME;
        data.hit_length = IMPOSSIBLY_LONG_TIME;
        data.pause_timer = 0;
        data.step_timer = 0;

        //initialized to basic info
        data.playlist = [];
        data.playlist_bits = 0x00;
        data.playlist_urls = [
            "2177081326",
            "1933111975",
            "1890617624",
            "2390163800",
            "2561615071",
            CH_ZETTERBURN,
            CH_WRASTOR,
            CH_ORCANE,
            CH_KRAGG,
            CH_ORI,
            CH_SHOVEL_KNIGHT
        ]; //should match animation.gml#try_get_builtin_video
    }
    return data;
}
