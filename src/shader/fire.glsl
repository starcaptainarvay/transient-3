extern float tick; // Time in seconds since the start of the shader
extern float intensity; // Intensity of the flames, ranges from 0 to 1
extern vec2 dimensions;

vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

float rand(vec2 n) {
    return fract(sin(cos(dot(n, vec2(12.9898, 12.1414)))) * 83758.5453);
}

float noise(vec2 n) {
    const vec2 d = vec2(0.0, 1.0);
    vec2 b = floor(n), f = smoothstep(vec2(0.0), vec2(1.0), fract(n));
    return mix(mix(rand(b), rand(b + d.yx), f.x), mix(rand(b + d.xy), rand(b + d.yy), f.x), f.y);
}

float fbm(vec2 n) {
    float total = 0.0, amplitude = 1.0;
    for (int i = 0; i < 5; i++) {
        total += noise(n) * amplitude;
        n += n * 1.7;
        amplitude *= 0.47;
    }
    return total;
}

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
    const vec3 c1 = vec3(0.5, 0.0, 0.1);
    const vec3 c2 = vec3(0.9, 0.1, 0.0);
    const vec3 c3 = vec3(0.2, 0.1, 0.7);
    const vec3 c4 = vec3(1.0, 0.9, 0.1);
    const vec3 c5 = vec3(0.1);
    const vec3 c6 = vec3(0.9);

    vec2 speed = vec2(1.2, 0.1);
    float shift = 1.327 + sin(tick * 2.0) / 2.4;

    // Adjust alpha and scale based on a logarithmic map of intensity
    float logIntensity = log(1.0 + 9.0 * intensity) / log(10.0); // Logarithmic scaling
    float alpha = smoothstep(0.0, 0.9, logIntensity) * logIntensity;
    float dist = mix(1.5, 3.5, pow(logIntensity, 2.0));

    vec2 p = screen_coords.xy * dist / dimensions.x;
    p.x -= tick / 1.1;
    float q = fbm(p - tick * 0.01 + 1.0 * sin(tick) / 10.0);
    float qb = fbm(p - tick * 0.002 + 0.1 * cos(tick) / 5.0);
    float q2 = fbm(p - tick * 0.44 - 5.0 * cos(tick) / 7.0) - 6.0;
    float q3 = fbm(p - tick * 0.9 - 10.0 * cos(tick) / 30.0) - 4.0;
    float q4 = fbm(p - tick * 2.0 - 20.0 * sin(tick) / 20.0) + 2.0;
    q = (q + qb - .4 * q2 - 2.0 * q3 + .6 * q4) / 3.8;
    vec2 r = vec2(fbm(p + q / 2.0 + tick * speed.x - p.x - p.y), fbm(p + q - tick * speed.y));
    vec3 c = mix(c1, c2, fbm(p + r)) + mix(c3, c4, r.x) - mix(c5, c6, r.y);
    vec3 finalColor = vec3(c * cos(shift * screen_coords.y / dimensions.y));
    finalColor += .05;
    finalColor.r *= .8;
    vec3 hsv = rgb2hsv(finalColor);
    hsv.y *= hsv.z * 1.1;
    hsv.z *= hsv.y * 1.13;
    hsv.y = (2.2 - hsv.z * .9) * 1.20;
    finalColor = hsv2rgb(hsv);

    return vec4(finalColor, alpha) * color;
}