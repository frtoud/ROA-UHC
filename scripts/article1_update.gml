//article1_update.gml -- CD
//=====================================================
#macro AR_STATE_DEAD         0 
#macro AR_STATE_IDLE         1
#macro AR_STATE_BOUNCE       2
#macro AR_STATE_FSTRONG      AT_FSTRONG
#macro AR_STATE_FSTRONG_ROLL 4
#macro AR_STATE_USTRONG      AT_USTRONG
#macro AR_STATE_DSTRONG      AT_DSTRONG
#macro AR_STATE_DSTRONG_SPIN AT_DSTRONG_2
#macro AR_STATE_DSPECIAL     AT_DSPECIAL
//=====================================================
visible = state != AR_STATE_DEAD;

switch (state)
{
    case AR_STATE_DEAD:
    {
        x = 0; y = 0;
    } break;
    case AR_STATE_IDLE:
    {
        image_index += 0.2;
        
        if (temp_timer > 0)
        {
            temp_timer--;
        }
        else
        {
            if (place_meeting(x, y, player_id))
            {
                state = AR_STATE_DEAD;
                player_id.uhc_has_cd_blade = true;
                sound_play(asset_get("sfx_coin_collect"));
            }
        }
    } break;
    default: state = AR_STATE_IDLE; 
    break;
}

if (hsp > 0)
{
    hsp -= 0.1;
}