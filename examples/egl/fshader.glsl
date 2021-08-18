#version 300 es

precision highp float;
precision highp int;
precision lowp sampler2D;
precision lowp samplerCube;

uniform float view_width;
uniform float view_height;
uniform float time;

out vec4 FragColor;

in vec4 ourColor;
in vec2 TexCoord;

uniform sampler2D ourTexture;

void main() {
	vec4 tex_color = texture(ourTexture, TexCoord);
	if (ourColor.a+tex_color.a <= 0.0) {
		discard;
	}
	FragColor = vec4(mix(tex_color.rgb, ourColor.rgb, ourColor.a), 1.0);
}
