extern float tick;
extern float delta;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {

    vec4 original_pixel = Texel(texture, texture_coords);
    vec3 rgb = vec3(1.0, 0.05 * tick, delta);

    return original_pixel * color * vec4(rgb, 1.0);
}