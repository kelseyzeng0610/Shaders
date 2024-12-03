#version 330 

// Inputs from the vertex shader
in vec3 fragPosition;
in vec3 fragNormal;
in vec3 reflectDir;
in vec3 fragPositionObjectSpace;
in vec3 fragPositionWorldSpace;

// Output color
out vec4 outputColor;

// Uniforms
uniform sampler2D environmentMap; // Bound to texture unit 0
uniform sampler2D objectTexture;   // Bound to texture unit 1
uniform vec3 lightPosition;
uniform float blendFactor;        // From Texture Blend slider
uniform bool useDiffuse;   

void main()
{
    // Compute texture coordinates for environment map (spherical mapping)
    vec3 normalizedReflectDir = normalize(reflectDir);
    vec2 texCoords = vec2(
        atan(normalizedReflectDir.z, normalizedReflectDir.x) / (2.0 * 3.1415926),
        acos(normalizedReflectDir.y) / 3.1415926
    );

    // Sample the environment map
    vec4 envColor = texture(environmentMap, texCoords);
    vec3 posOS = fragPositionObjectSpace;
	vec3 normalizedFragNormal = normalize(fragNormal);
    vec2 objTexCoord = vec2(
        0.5 + atan(posOS.z, posOS.x) / (2.0 * 3.1415926),
        0.5 - acos(posOS.y / length(posOS)) / 3.1415926
    );

    // Sample the object's own texture
    vec4 objColor = texture(objectTexture, objTexCoord);

    // Blend the two textures based on the blend factor
    vec4 baseColor = mix(envColor, objColor, blendFactor);

    // Apply diffuse shading if enabled
    if (useDiffuse)
    {
        vec3 lightDir = normalize(lightPosition - fragPosition);
        float diff = max(dot(normalize(fragNormal), lightDir), 0.0);
        baseColor.rgb *= diff;
    }

    outputColor = baseColor;
}