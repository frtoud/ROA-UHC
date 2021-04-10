//==============================================================
//Clean up data structures
if ("uhc_blade_spr_map" in self && ds_map_valid(uhc_blade_spr_map))
{
    ds_map_destroy(uhc_blade_spr_map);
}
//==============================================================
//prevent this from looping in the CSS
if (uhc_taunt_current_video != noone)
{
    sound_stop(uhc_taunt_current_video.song);
}

//==============================================================
//Sending win quotes to result screen
if (!uhc_handled_victory_quote)
{
    // Naive solution: cram into keyboard_string
    // interpreted as a string buffer, limit of 1024 chars
    // format: uhc:{<playernumber><priority><string data>¤}
    var assembled_string = "uhc{";
    
    with (oPlayer) 
    {
        if (url == other.url) // Hypercam-specific
        //&& (test all player teams?)
        {
            var priority = "1";
            var uhc_quote = uhc_victory_quote;
            if (get_match_setting(SET_RUNES))
            {
                priority = "2";
                uhc_quote = "thank u 4 watching my king for a day speedrun, sucribe for more content :)";
            }
            //else... >:]
            
            assembled_string += string(player) + priority + uhc_quote + "¤";
        }
        else if ("uhc_victory_quote" in self)
        {
            var priority = "1";
            assembled_string += string(player) + priority + uhc_victory_quote + "¤";
        }
        else
        {
            var builtin_quote = try_get_quote(url);
            if (string_length(builtin_quote) > 0)
            { assembled_string += string(player) + "1" + builtin_quote + "¤"; }
        }
        uhc_handled_victory_quote = true; //only one Hypercam has to handle this for everyone
    }
    
    keyboard_string = assembled_string + "}"
                    // Hi.
                    // This is a bit of a hack; smuggling a set of values in this keyboard_string...
                    // So I am copying over the previous keyboard_string in case you use it too.
                    // (whatever still fits in the 1024 limit)
                    // I would ask that you do the same, in case both our mods fight together!
                    + string_copy(keyboard_string, 0, 
                                  min(string_length(keyboard_string), 
                                      1020 - string_length(assembled_string)));

    // Ideal solution... not sure why GML panics...?
    // Sneak this list to victory screen; which will decide which quote to pick
    // WARNING: this depends on init_shader.gml to clean it up later & avoid a blatant memory leak
    /*
    var list = ds_list_create();
    ds_list_set(list, 0, "Hoi");
    set_color_profile_slot(0, 8, list, 0, 0); //Can't input: not a number?
    sprite_change_offset("victory_quote_bg", list+0, 0); //Can't do arithmetic on a ds_list index?
    */
}

//==============================================================
#define try_get_quote(char_url)
{
    //=========================================================
    // Approximate maximum line:
    // "aaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaa";
    //=========================================================
    var quote = "";
    switch (char_url)
    {
        //=================================================================
        // Hi!
        // If you see your mod's URL in here, feel free to copy/edit
        // the victory quotes into your own mod with:
        //    uhc_victory_quote = "Helo yutub";
        // This will override the built in behavior!
        //=================================================================
        // KFAD
        //=================================================================
        case "2218690857": // King Dedede
           quote = "if this tutoriel helped you pls subscribe for more kirby videos"; 
           break;
        case "2263955842": // Reimu (ZUN stand-in)
           quote = "2hu lets play #948539 ZUN FINAL BOSS"; 
           break;
        case "2318304706": // Geno
           quote = "https://www.latlmes.com/ opinion/free-snes-emulator -no-survey-1"; 
           break;
        case "2177081326": // Nico Nico
           quote = "i would have lovd to tem up with u!! lets hang out more sometime!"; 
           break;
        //=================================================================
        // Bonus
        //=================================================================
        case "2108835464": // Take a guess
           quote = "lmaoooooo ahahahshahajh he said it he said tit im piickle woodmaaaan!!!!11!!"; 
           break;
        //=================================================================
        // Base cast
        //=================================================================
        case CH_ZETTERBURN: 
           quote = "Thx 4 wathcing Lion King streaming 240p suscribe for mre movies"; 
           break;
        case CH_CLAIREN: 
           quote = "future gen. consels wii2 ps4 xbox720?"; 
           break;
        case CH_ETALUS: 
           quote = "Club Pengun lets play (part 4 final boss & endig)"; 
           break;
        case CH_RANNO:
           quote = "Frogger's adventire (gcn) title theme & ending"; 
           break;
        case CH_KRAGG: 
           quote = "How 2 get mincraft free no virus 100% workign 2011"; 
           break;
        case CH_MAYPUL:
           quote = "ending theme: badgerbadgerbadgre remix by weebl"; 
           break;
        case CH_ORI:
           quote = "How 2 get double NP in neopets (Updated 2008)"; 
           break;
        case CH_FORSBURN:
        case CH_ORCANE:
        case CH_SYLVANOS:
        case CH_WRASTOR:
        case CH_ABSA:
        case CH_ELLIANA:
        case CH_SHOVEL_KNIGHT:
        default: break;
    }
    return quote;
}
