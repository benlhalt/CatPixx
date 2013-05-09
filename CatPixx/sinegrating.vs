#version 150

in vec2 position2d;
smooth out vec2 fragCoord;

void main()
{
    gl_Position = mat4(vec4(1.0/1.6,0,0,0), vec4(0,1,0,0), vec4(0,0,0,0), vec4(0,0,0,2)) * vec4(position2d, 0.0, 1.0);
    fragCoord = position2d;
}