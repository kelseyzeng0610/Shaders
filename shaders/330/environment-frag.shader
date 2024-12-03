#version 330

in vec3 worldPosition;
out vec4 outputColor;

uniform sampler2D environmentMap;

void main()
{
    vec3 normalizedPos = normalize(worldPosition); // Normalize world position
    vec2 texCoords = vec2(
        atan(normalizedPos.z, normalizedPos.x) / (2.0 * 3.1415926),
        acos(normalizedPos.y) / 3.1415926
    );
    
    outputColor = texture(environmentMap, texCoords);
}