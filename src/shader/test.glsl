vec4 effect(vec4 color, vec2 texture_coords, vec2 screen_coords) 
{
    vec4 pixel = color;
    number average = (pixel.r+pixel.b+pixel.g)/3.0;
    number factor = screen_coords.x/screenWidth;
    pixel.r = pixel.r + (average-pixel.r) * factor;
    pixel.g = pixel.g + (average-pixel.g) * factor;
    pixel.b = pixel.b + (average-pixel.b) * factor;
    return pixel;
}