#version 150

uniform float contrast;
uniform float radius;
uniform vec2  center;
uniform float orientation;
uniform float phase;
uniform float spatialFrequency;

smooth in vec2 fragCoord;

out vec4 outColor;

void main()
{
    if (distance(fragCoord, center) > radius) discard;
    
    float r = length(fragCoord.xy);

    float sv = 0.5 * sin((mat2(vec2(cos(orientation), -sin(orientation)), vec2(sin(orientation), cos(orientation)))*(fragCoord.xy-center)).x * spatialFrequency - phase);

    outColor = vec4(0.5, 0.5, 0.5, 1.0) + (sv * contrast);
}