#version 330
layout(location = 0) in vec3 myPosition;
layout(location = 1) in vec3 myNormal;

// Combined outputs
out vec3 reflectDir;
out vec3 fragPosition;
out vec3 fragNormal;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 perspectiveMatrix;
uniform vec3 eyePosition;
uniform mat3 normalMatrix;

void main()
{
    // Calculate world space position
    vec4 worldPosition = modelMatrix * vec4(myPosition, 1.0);
    fragPosition = worldPosition.xyz;
    
    // Calculate normal in world space
    fragNormal = normalize(normalMatrix * myNormal);
    
    // Calculate view-space position and normal for reflection
    mat4 modelViewMatrix = viewMatrix * modelMatrix;
    vec3 viewSpacePos = (modelViewMatrix * vec4(myPosition, 1)).xyz;
    vec3 viewSpaceNormal = normalize((modelViewMatrix * vec4(myNormal, 0)).xyz);
    
    // Calculate reflection direction
    vec3 viewDir = normalize(viewSpacePos);
    vec3 worldReflect = reflect(viewDir, viewSpaceNormal);
    reflectDir = inverse(mat3(viewMatrix)) * normalize(worldReflect);
    
    // Output final position
    gl_Position = perspectiveMatrix * modelViewMatrix * vec4(myPosition, 1);
}