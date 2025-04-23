extern float tick;
extern float delta;

float lerp(float a, float b, float t) {
    return a + t * (b - a);
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    float speed = 0.25; // speed of hue cycling
    float t = mod(tick, 2.0) / 2.0; // Normalize tick to a 0-1 range over 2 seconds

    // Lerp between red and blue
    vec3 red = vec3(1.0, 0.0, 0.0);
    vec3 blue = vec3(0.0, 0.0, 1.0);
    vec3 rgb = mix(red, blue, t);

    // Add a white border effect based on delta
    float borderSize = 0.05; // Adjust border size as needed
    vec2 center = vec2(0.5, 0.5);
    float distance = length(texture_coords - center);
    float border = smoothstep(0.5 - borderSize - delta, 0.5 - borderSize, distance);

    vec3 finalColor = mix(vec3(1.0), rgb, border);

    return vec4(finalColor, 1.0) * color;
}
