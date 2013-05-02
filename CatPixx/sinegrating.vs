/*
 * File: BasicSineGratingShader.vert.txt
 * Shader for drawing of basic parameterized sine grating patches.
 *
 * This is the vertex shader. It takes the attributes (parameters)
 * provided by the Screen('DrawTexture(s)') command, performs some
 * basic calculations on it - the calculations that only need to be
 * done once per grating patch and that can be reliably carried out
 * at sufficient numeric precision in a vertex shader - then it passes
 * results of computations and other attributes as 'varying' parameters
 * to the fragment shader.
 *
 * (c) 2007 by Mario Kleiner, licensed under GPL.
 *		 
 */

#version 150

/* Constants that we need 2*pi: */
const float twopi = 2.0 * 3.141592654;

/* Conversion factor from degrees to radians: */
const float deg2rad = 3.141592654 / 180.0;

/* Constant from setup code: Premultiply to contrast value: */
//uniform float contrastPreMultiplicator;

/* Attributes passed from Screen(): See the ProceduralShadingAPI.m file for infos: */
in vec2 position2d;
smooth out vec2 fragCoord;
//attribute vec4 modulateColor;
//attribute vec4 auxParameters0;

/* Information passed to the fragment shader: Attributes and precalculated per patch constants: */
out vec4  baseColor;
//varying float Phase;
//varying float FreqTwoPi;

void main()
{
    /* Apply standard geometric transformations to patch: */
    gl_Position = mat4(vec4(1.0/1.6,0,0,0), vec4(0,1,0,0), vec4(0,0,0,0), vec4(0,0,0,2)) * vec4(position2d, 0.0, 1.0); //ftransform();

    /* Don't pass real texture coordinates, but ones corrected for hardware offsets (-0.5,0.5) */
//    gl_TexCoord[0] = (gl_TextureMatrix[0] * gl_MultiTexCoord0) + vec4(-0.5, 0.5, 0.0, 0.0);

    /* Contrast value is stored in auxParameters0[2]: */
//    float Contrast = auxParameters0[2];

    /* Convert Phase from degrees to radians: */
//    Phase = deg2rad * auxParameters0[0];

    /* Precalc a couple of per-patch constant parameters: */
//    FreqTwoPi = auxParameters0[1] * twopi;

    /* Premultiply the wanted Contrast to the color: */
    baseColor = vec4(1.0, 1.0, 1.0, 1.0);//modulateColor * Contrast * contrastPreMultiplicator;
    fragCoord = position2d;
}