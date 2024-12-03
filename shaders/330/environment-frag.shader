// #version 330 core

// // Inputs from the vertex shader
// in vec2 fragTexCoord;

// // Output color
// out vec4 outputColor;

// // Uniforms
// uniform sampler2D environmentMap; // Bound to texture unit 0

// void main()
// {
//     // Sample the environment map using the computed texture coordinates
//     outputColor = texture(environmentMap, fragTexCoord);
// }

#version 330

in vec3 worldPosition;
out vec4 outputColor;

uniform sampler2D environmentMap;

void main()
{
    vec3 normalizedPos = normalize(worldPosition); // Normalize world position
    
	
	
    float u = 0.5 + atan(normalizedPos.z,normalizedPos.x) / (2.0 * 3.1415926);
    float v = 0.5 - asin(normalizedPos.y) / 3.1415926;
    vec2 fragTexCoord = vec2(u, v);


    // Clamp texCoords to avoid edge cases
    vec2 texCoords = clamp(fragTexCoord, 0.0, 1.0);

    outputColor = texture(environmentMap, texCoords);
}

