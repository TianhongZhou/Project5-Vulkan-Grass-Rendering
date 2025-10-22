#version 450
#extension GL_ARB_separate_shader_objects : enable

#define BASE_LOD 8.0
#define LOD_DIST 5.0
#define LOD 1

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4[] in_v0; 
layout(location = 1) in vec4[] in_v1;
layout(location = 2) in vec4[] in_v2;

layout(location = 0) out vec4[] out_v0;
layout(location = 1) out vec4[] out_v1;
layout(location = 2) out vec4[] out_v2;

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    out_v0[gl_InvocationID] = in_v0[gl_InvocationID];
    out_v1[gl_InvocationID] = in_v1[gl_InvocationID];
    out_v2[gl_InvocationID] = in_v2[gl_InvocationID];

	// TODO: Set level of tesselation
    // gl_TessLevelInner[0] = ???
    // gl_TessLevelInner[1] = ???
    // gl_TessLevelOuter[0] = ???
    // gl_TessLevelOuter[1] = ???
    // gl_TessLevelOuter[2] = ???
    // gl_TessLevelOuter[3] = ???

    float lod = BASE_LOD;

#if LOD
    vec3 camPos = inverse(camera.view)[3].xyz;
    vec3 v0 = in_v0[gl_InvocationID].xyz;
    vec3 camToBlade = v0 - camPos;
    float dist = length(camToBlade);

    if (dist > LOD_DIST) {
        lod /= 2.0;
    } else if (dist > 2.0 * LOD_DIST) {
        lod /= 4.0;
    }    
#endif

    gl_TessLevelInner[0] = lod;
    gl_TessLevelInner[1] = lod;
    gl_TessLevelOuter[0] = lod;
    gl_TessLevelOuter[1] = lod;
    gl_TessLevelOuter[2] = lod;
    gl_TessLevelOuter[3] = lod;
    gl_TessLevelInner[0] = lod;
}
