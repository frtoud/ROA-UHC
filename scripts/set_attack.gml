//set_attack.gml

//===============================================
//Strongs to Tilts conversions
if (!uhc_has_cd_blade)
{
    if (attack == AT_FSTRONG) { attack = AT_FTILT; }
    else if (attack == AT_USTRONG) { attack = AT_UTILT; }
    else if (attack == AT_DSTRONG) { attack = AT_DTILT; }
}
//Aerials to Strongs conversions
else if (strong_down && uhc_has_cd_blade)
{
    if (attack == AT_BAIR) { attack = AT_FSTRONG; spr_dir *= -1; }
    else if (attack == AT_FAIR || attack == AT_NAIR) { attack = AT_FSTRONG; }
    else if (attack == AT_UAIR) { attack = AT_USTRONG; }
    else if (attack == AT_DAIR) { attack = AT_DSTRONG_2; }
    
    //Prevent strong charge when in the air
    if (free)
    {
        set_attack_value(AT_FSTRONG, AG_STRONG_CHARGE_WINDOW, 0);
        set_attack_value(AT_USTRONG, AG_STRONG_CHARGE_WINDOW, 0);
    }
    else
    {
        reset_attack_value(AT_FSTRONG, AG_STRONG_CHARGE_WINDOW);
        reset_attack_value(AT_USTRONG, AG_STRONG_CHARGE_WINDOW);
    }
}
//===============================================