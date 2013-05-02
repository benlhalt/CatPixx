/*
 * File: ApertureSineGratingShader.frag.txt
 * Shader for drawing of basic parameterized sine grating patches.
 * Applies a circular aperture of radius 'Radius'.
 *
 * (c) 2010 by Mario Kleiner, licensed under GPL.
 *		 
 */

#version 150

//uniform float Radius;
//uniform vec2  Center;
//
//uniform vec4 Offset;

in vec4  baseColor;
uniform float Phase;
//varying float FreqTwoPi;
out vec4 outColor;

void main()
{
    /* Query current output texel position: */
    vec2 pos = gl_FragCoord.xy;

    /* If distance to center (aka radius of pixel) > Radius, discard this pixel: */
    //if (distance(pos, vec2(0,0)) > 800.0) discard;

    /* Evaluate sine grating at requested position, frequency and phase: */
    float sv = sin(pos.x * 0.1 + Phase);

    /* Multiply/Modulate base color and alpha with calculated sine            */
    /* values, add some constant color/alpha Offset, assign as final fragment */
    /* output color: */
    outColor = (baseColor * sv) + 0.0;
}