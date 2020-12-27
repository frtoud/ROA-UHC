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
//Generic logic for blade stats
if (uhc_has_cd_blade)
{
    //activate blade hitboxes
    if (0 < get_attack_value(attack, AG_NUM_HITBOXES_BLADED))
    { set_num_hitboxes(attack, get_attack_value(attack, AG_NUM_HITBOXES_BLADED)); }
    
    //apply buffs based on current charge level
    var charge_percent = (uhc_current_cd.cd_spin_meter / uhc_cd_spin_max);
    for (var hb = 1; hb <= get_num_hitboxes(attack); hb++)
    {
        // Projectile-blades handled separately
        if (1 == get_hitbox_value(attack, hb, HG_HITBOX_TYPE))
        {
            apply_spin_bonus(charge_percent, attack, hb, HG_DAMAGE, HG_SPIN_DAMAGE_BONUS);
            apply_spin_bonus(charge_percent, attack, hb, HG_BASE_HITPAUSE, HG_SPIN_HITPAUSE_BONUS);
            apply_spin_bonus(charge_percent, attack, hb, HG_BASE_KNOCKBACK, HG_SPIN_KNOCKBACK_BONUS);
            apply_spin_bonus(charge_percent, attack, hb, HG_KNOCKBACK_SCALING, HG_SPIN_KNOCKBACK_SCALING_BONUS);
        }
    }
}
else
{
    //reset to number of non-bladed hitboxes
    reset_num_hitboxes(attack);
}

//===============================================
#define apply_spin_bonus(charge_percent, atk, hnum, base_index, bonus_index)
{
    if (0 < get_hitbox_value(atk, hnum, bonus_index))
    {
        reset_hitbox_value(atk, hnum, base_index);
        
        // total = base + charge * bonus
        var value = get_hitbox_value(atk, hnum, base_index)
           + (charge_percent * get_hitbox_value(atk, hnum, bonus_index) );
        set_hitbox_value(atk, hnum, base_index, value);
    }
}