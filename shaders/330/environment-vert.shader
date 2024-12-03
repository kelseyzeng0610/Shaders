// #version 330 core

// // Vertex attributes
// layout(location = 0) in vec3 myPosition;

// // Outputs to the fragment shader
// output vec2 fragTexCoord;

// // Uniforms
// uniform mat4 modelMatrix;
// uniform mat4 viewMatrix;
// uniform mat4 perspectiveMatrix;

// void main()
// {
//     // Transform vertex position to world space
//     vec4 worldPosition = modelMatrix * vec4(myPosition, 1.0);

//     // Compute texture coordinates for spherical mapping
//     vec3 normal = normalize(myPosition);
//     float u = 0.5 + atan(normal.z, normal.x) / (2.0 * 3.1415926);
//     float v = 0.5 - asin(normal.y) / 3.1415926;
//     fragTexCoord = vec2(u, v);

//     // Compute final vertex position
//     gl_Position = perspectiveMatrix * viewMatrix * worldPosition;
// }


#version 330
layout(location = 0) in vec3 myPosition;
out vec3 worldPosition;

uniform mat4 viewMatrix;
uniform mat4 perspectiveMatrix;

void main()
{
    // Scale the sphere to make it large
    vec4 pos = vec4(myPosition * 7.0, 1.0); // Increased scale
    worldPosition = myPosition; // Pass position to fragment shader
    gl_Position = perspectiveMatrix * viewMatrix * pos;
}
