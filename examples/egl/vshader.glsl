#version 300 es

precision highp float;
precision highp int;
precision lowp sampler2D;
precision lowp samplerCube;

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec4 aColor;
layout (location = 2) in vec2 aTexCoord;

uniform float view_width;
uniform float view_height;
uniform float time;

out vec4 ourColor;
out vec2 TexCoord;

void main() {
	// aPos is in screen coordinates
	// normalize to [-1,1],
	// flip y-axis
	vec2 nPos = aPos.xy;
	nPos.x = nPos.x/view_width;
	nPos.y = nPos.y/view_height;
	nPos.x = nPos.x*2.0-1.0;
	nPos.y = nPos.y*2.0-1.0;
	nPos.y *= -1.0;

	gl_Position = vec4(nPos, 1.0,1.0);

	ourColor = aColor;
	TexCoord = aTexCoord;
}
