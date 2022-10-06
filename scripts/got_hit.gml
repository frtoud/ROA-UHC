//got_hit.gml

if (instance_exists(uhc_uspecial_hitbox)) 
{ uhc_uspecial_hitbox.destroyed = true; }
with (oPlayer) if (self != other && uhc_being_buffered_by == other)
{
    uhc_being_buffered_by = noone;
}
