#version 450

// vulkan NDC:	x: -1(left), 1(right)
//				y: -1(top), 1(bottom)

vec2 positions[3] = vec2[](
	vec2(0.0, -0.5),
	vec2(0.5, 0.5),
	vec2(-0.5, 0.5)
);

vec3 colors[3] = vec3[](
	vec3(1.0, 0.0, 0.0),
	vec3(0.0, 1.0, 0.0),
	vec3(0.0, 0.0, 1.0)
);

layout(location = 0) out vec3 fragColor;

void main() {
	// Initial bug: black, black, red triangle
	gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
	fragColor = colors[gl_VertexIndex];
	
	// Test 1: if-else-cascade using indices (works)
	/*gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
	if (gl_VertexIndex == 0) {
		fragColor = colors[0];
	} else if (gl_VertexIndex == 1) {
		fragColor = colors[1];
	} else if (gl_VertexIndex == 2) {
		fragColor = colors[2];
	}*/
	
	// Test 2: if-else-cascade using gl_VertexIndex as index (fails: black, black, red triangle)
	/*gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);
	if (gl_VertexIndex == 0) {
		fragColor = colors[gl_VertexIndex];
	} else if (gl_VertexIndex == 1) {
		fragColor = colors[gl_VertexIndex];
	} else if (gl_VertexIndex == 2) {
		fragColor = colors[gl_VertexIndex];
	}*/
	
	// Test 3: swapped order (works)
	/*fragColor = colors[gl_VertexIndex];
	gl_Position = vec4(positions[gl_VertexIndex], 0.0, 1.0);*/
}
