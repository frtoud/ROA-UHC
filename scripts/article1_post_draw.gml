//Hitstun pseudostate: add faded overlay to sprite
if (cd_recall_stun_timer > 0)
{
    gpu_set_fog(true, c_dkgray, 1, 1);
    var alpha = (get_gameplay_time() % 10 < 5) ? 0.6 : 0.3; //flashing
    draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, image_angle, c_black, alpha);
    gpu_set_fog(false, c_white, 1, 1);
}