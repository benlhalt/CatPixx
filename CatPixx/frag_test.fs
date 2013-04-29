/*
 * File: ApertureSineGratingShader.frag.txt
 * Shader for drawing of basic parameterized sine grating patches.
 * Applies a circular aperture of radius 'Radius'.
 *
 * (c) 2010 by Mario Kleiner, licensed under GPL.
 *		 
 */

uniform float Radius;
uniform vec2  Center;

uniform vec4 Offset;

varying vec4  baseColor;
varying float FreqTwoPi;

void main()
{
    /* Query current output texel position: */
    vec2 pos = gl_TexCoord[0].xy;

    /* If distance to center (aka radius of pixel) > Radius, discard this pixel: */
    if (distance(pos, vec2(0.0,1.0)) > 0.5) discard;

    /* Evaluate sine grating at requested position, frequency and phase: */
    float sv = sin(pos.x * FreqTwoPi) + 1.0;

    /* Multiply/Modulate base color and alpha with calculated sine            */
    /* values, add some constant color/alpha Offset, assign as final fragment */
    /* output color: */
    gl_FragColor = (baseColor * sv);
}