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
