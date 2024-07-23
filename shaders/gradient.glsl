// gradient.glsl

extern vec2 center;
extern vec2 size;
extern vec3 color1;
extern vec3 color2;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    float dist = length((screen_coords - center) / (size * 0.5)); // divide by half the size because it starts from the center
    vec3 finalColor = mix(color1, color2, dist);
    return vec4(finalColor, 1.0) * color;
}
