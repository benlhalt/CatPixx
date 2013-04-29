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

/* Constants that we need 2*pi: */
const float twopi = 2.0 * 3.141592654;

/* Conversion factor from degrees to radians: */
const float deg2rad = 3.141592654 / 180.0;

/* Constant from setup code: Premultiply to contrast value: */

/* Attributes passed from Screen(): See the ProceduralShadingAPI.m file for infos: */

/* Information passed to the fragment shader: Attributes and precalculated per patch constants: */
varying vec4  baseColor;
varying float FreqTwoPi;

void main()
{
    /* Apply standard geometric transformations to patch: */
    gl_Position = ftransform();

    /* Don't pass real texture coordinates, but ones corrected for hardware offsets (-0.5,0.5) */
    gl_TexCoord[0] = (gl_TextureMatrix[0] * gl_MultiTexCoord0) + vec4(-0.5, 0.5, 0.0, 0.0);

    /* Contrast value is stored in auxParameters0[2]: */
    float Contrast = 1.0;

    /* Convert Phase from degrees to radians: */
    
    /* Precalc a couple of per-patch constant parameters: */
    FreqTwoPi = 5.0 * twopi;

    /* Premultiply the wanted Contrast to the color: */
    baseColor = vec4(0.5 ,0.5, 0.5, 1.0);
}