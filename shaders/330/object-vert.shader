#version 330 

// Vertex attributes
layout(location = 0) in vec3 myPosition;
layout(location = 1) in vec3 myNormal;

// Outputs to the fragment shader
out vec3 fragPosition;
out vec3 fragNormal;


// Uniforms
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 perspectiveMatrix;
uniform mat3 normalMatrix;

void main()
{
    
    vec4 worldPosition = modelMatrix * vec4(myPosition, 1.0);
    fragPosition = worldPosition.xyz;

   
    fragNormal = normalize(normalMatrix * myNormal);

    
    gl_Position = perspectiveMatrix * viewMatrix * worldPosition;
}
