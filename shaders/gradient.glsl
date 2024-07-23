// gradient.glsl

extern vec2 center;
extern vec2 resolution;
extern vec3 color1;
extern vec3 color2;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 pos = screen_coords / resolution;
    float dist = distance(pos, center);
    vec3 finalColor = mix(color1, color2, dist);
    return vec4(finalColor, 1.0) * color;
}
