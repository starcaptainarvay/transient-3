extern float tick;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    float speed = 0.25; // speed of hue cycling
    float hue = mod(tick * speed + texture_coords.x + texture_coords.y, 1.0);

    // Convert hue to RGB
    float r = abs(hue * 6.0 - 3.0) - 1.0;
    float g = 2.0 - abs(hue * 6.0 - 2.0);
    float b = 2.0 - abs(hue * 6.0 - 4.0);
    
    vec3 rgb = clamp(vec3(r, g, b), 0.0, 1.0);

    return vec4(rgb, 1.0) * color;
}
