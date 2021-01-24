//update.gml

//=====================================================
// Guarantee CD article always exists
if (!instance_exists(uhc_current_cd))
{ 
    uhc_current_cd = instance_create(x, y, "obj_article1"); 
}
if (!instance_exists(uhc_other_cd))
{
    uhc_other_cd = has_rune("o") ? instance_create(0, 0, "obj_article1") 
                                 : uhc_current_cd;
}
//=====================================================

//CD drain exceptions
uhc_no_blade_drain = (state == PS_RESPAWN)
                  || (state == PS_SPAWN)
                  || (state == PS_ATTACK_GROUND && attack == AT_TAUNT);