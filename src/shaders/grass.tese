#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4[] in_v0;
layout(location = 1) in vec4[] in_v1;
layout(location = 2) in vec4[] in_v2;

layout(location = 0) out float fs_v;
layout(location = 1) out vec3 fs_nor;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 v0 = in_v0[0].xyz;
    vec3 v1 = in_v1[0].xyz;
    vec3 v2 = in_v2[0].xyz;

    float orientation = in_v0[0].w;
    float width = in_v2[0].w;

    vec3 va = mix(v0, v1, v);
    vec3 vb = mix(v1, v2, v);
    vec3 vc = mix(va, vb, v);

    vec3 t0 = normalize(vb - va);
    vec3 t1 = normalize(vec3(-cos(orientation), 0.0, sin(orientation)));

    vec3 vc0 = vc - width * t1;
    vec3 vc1 = vc + width * t1;
    float t = u + v / 2 - u * v;
    vec3 pos = mix(vc0, vc1, t);

    fs_v = v;
    fs_nor = normalize(cross(t0, t1));
    
    gl_Position = camera.proj * camera.view * vec4(pos, 1.0);
}
