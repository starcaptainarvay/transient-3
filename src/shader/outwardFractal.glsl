extern float tick; // Time in seconds since the start of the shader
extern float gain;
extern float delta;
extern float intensity;
// extern int use_delta;
extern vec2 screen_offset; // Offset of the drawing's origin in screen coordinates

#define DIM_COEFF 0.04

vec3 palette( float t ) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263,0.416,0.557);

    return a + b * cos( 6.28318*(c*t+d) );
}

vec4 fractal(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    vec2 uv = ((screen_coords - screen_offset) * 2.0 - love_ScreenSize.xy) / love_ScreenSize.y;
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);

    float scaled_tick = tick * 2.5; // 5

    for (float i = 0.0; i < 4.0; i++) {
        uv = (fract(uv * 1.5) - 0.5) * (intensity);

        float d = length(uv) * exp(-length(uv0));

        vec3 col = palette(length(uv0) + i * 0.4 + scaled_tick);

        d = sin(d * 8.0 + scaled_tick) / 8.0;
        d = abs(d);

        d = pow(0.01 / d, 1.2);

        finalColor += col * d;
    }

    return vec4(finalColor, gain) * color;
}

vec4 vignette(vec4 color, vec2 screen_coords) {
    float radius = 0.75; //1.25; // Adjust for the size of the vignette effect

    // Calculate uv based on screen_coords and screen_offset
    vec2 uv = ((screen_coords - screen_offset) * 2.0 - love_ScreenSize.xy) / love_ScreenSize.y;
    float dist = length(uv);

    // Make everything outside the radius fully transparent
    if (dist > radius) {
        return vec4(0.0, 0.0, 0.0, 0.0); // Fully transparent
    }

    float alpha = clamp((radius - dist) / radius, 0.0, 1.0); // Smooth transition based on distance
    return color * vec4(alpha, alpha, alpha, alpha); // Apply gradient effect
}

vec4 spatialDistortion(vec4 inputColor, vec2 screen_coords) {
    // Calculate uv based on screen_coords and screen_offset
    vec2 uv = ((screen_coords - screen_offset) * 2.0 - love_ScreenSize.xy) / love_ScreenSize.y;

    // Apply a wonky distortion effect
    float distortionStrength = 0.5; // Adjust for the intensity of the distortion
    uv.x += sin(uv.y * 10.0 + tick) * distortionStrength;
    uv.y += cos(uv.x * 10.0 + tick) * distortionStrength;

    // Return the distorted color
    return inputColor * vec4(uv, 1.0, 1.0);
}

vec4 fadeOut(vec4 color, float tick) {
    if (tick > 0.4) { // was 0.6
        float fadeFactor = 1.0 - smoothstep(0.6, 1.2, tick);
        return color * vec4(1.0, 1.0, 1.0, fadeFactor);
    }
    return color;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    // Apply fractal effect first
    vec4 fractalColor = fractal(color, texture, texture_coords, screen_coords);

    // Apply spatial distortion to the fractal output
    vec4 distortedColor = spatialDistortion(fractalColor, screen_coords);

    // Apply vignette to the final result
    vec4 vignettedColor = vignette(distortedColor, screen_coords) * 1.5;

    // Apply fade-out effect based on tick
    return fadeOut(vignettedColor, tick) * DIM_COEFF;
}