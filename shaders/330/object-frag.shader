#version 330 

// Inputs from the vertex shader
in vec3 fragPosition;
in vec3 fragNormal;

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
    // Compute view direction (assuming camera at origin)
    vec3 viewDir = normalize(-fragPosition);

    // Reflect view direction around the normal
    vec3 reflectDir = reflect(viewDir, normalize(fragNormal));

    // Compute texture coordinates for environment map (spherical mapping)
    float m = 2.0 * sqrt(
        reflectDir.x * reflectDir.x + 
        reflectDir.y * reflectDir.y + 
        (reflectDir.z + 1.0) * (reflectDir.z + 1.0)
    );
    vec2 envTexCoord = reflectDir.xy / m + 0.5;
	envTexCoord.y = 1.0 - envTexCoord.y;

    // Sample the environment map
    vec4 envColor = texture(environmentMap, envTexCoord);

	vec3 n = normalize(fragNormal);
    float u = 0.5 + atan(n.z, n.x) / (2.0 * 3.1415926);
    float v = 0.5 - asin(n.y) / 3.1415926;
    vec2 objTexCoord = vec2(u, v);

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
