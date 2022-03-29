//hitbox_update

//=====================================================
// DSPECIAL's buffering zone
if (attack == AT_USPECIAL && hbox_num == 2)
{
    player_id.uhc_uspecial_hitbox = self;
}
// NSPECIAL group-reflection
else if (attack == AT_NSPECIAL)
{
    star_was_parried = false;
    star_already_reflected = false;

    //RUNE: star rewind
    star_is_rewinding = false;
}