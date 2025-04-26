extern float tick;
extern float delta;
extern float intensity;
extern float willEffect;
extern float amplitudeEffect;

#define PI 3.14159265358979323846

vec2 random2(vec2 st) {
    return fract(sin(vec2(dot(st, vec2(127.1, 311.7)), dot(st, vec2(269.5, 183.3)))) * 43758.5453);
}

vec4 noise_effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    // Normalize screen coordinates
    float ctick = mod(tick, 1.0) - 0.5;
    float cdelta = delta * 0.5;
    
    vec2 rand = vec2(ctick/intensity + cdelta, ctick/intensity + cdelta);
    vec2 uv = (screen_coords / vec2(love_ScreenSize.xy)) + rand;

    // Parameters for Perlin-like noise
    float scale = 10.0; // Scale of the noise
    float intensity = 1.0; // Intensity of the noise

    // Generate gradient noise using a smoother function
    vec2 p = uv * scale;
    vec2 i = floor(p);
    vec2 f = fract(p);

    // Smoothstep interpolation
    f = f * f * (3.0 - 2.0 * f);

    // Random gradients at the corners of the cell
    float a = dot(random2(i), f - vec2(0.0, 0.0));
    float b = dot(random2(i + vec2(1.0, 0.0)), f - vec2(1.0, 0.0));
    float c = dot(random2(i + vec2(0.0, 1.0)), f - vec2(0.0, 1.0));
    float d = dot(random2(i + vec2(1.0, 1.0)), f - vec2(1.0, 1.0));

    // Interpolate the results
    float noise = mix(mix(a, b, f.x), mix(c, d, f.x), f.y);

    // Scale the noise by intensity
    noise = noise * intensity;

    // Create a mask effect by mixing the noise with the base color
    vec4 noiseColor = vec4(vec3(noise), 1.0);
    return mix(color, noiseColor, 0.5);
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    // Normalize screen coordinates
    // float ctick = mod(tick, 1.0)/3 + 0.7;
    vec2 uv = screen_coords / vec2(love_ScreenSize.xy);

    // Parameters for distortion
    // TODO multiply by will effect
    float distortionStrength = (amplitudeEffect/10000); // Strength of the distortion 
    float waveFrequency = 5; // Frequency of the distortion waves
    float speed = willEffect/10; // Speed of the distortion animation

    // Calculate distortion offset
    float offsetX = sin(uv.y * waveFrequency + speed * tick) * distortionStrength;
    float offsetY = cos(uv.x * waveFrequency + speed * tick) * distortionStrength;

    // Apply distortion to texture coordinates
    vec2 distortedCoords = texture_coords + vec2(offsetX, offsetY);

    // Clamp the distorted coordinates to prevent tiling
    vec2 clampedCoords = clamp(distortedCoords, 0.0, 1.0);

    // Sample the texture with clamped coordinates
    vec4 distortedColor = Texel(texture, clampedCoords);

    vec4 noiseColor = noise_effect(color, texture, texture_coords, screen_coords);
    // Return the distorted color
    return distortedColor * color * noiseColor * 1.2;
}

