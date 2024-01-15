shader_type sky;

uniform sampler2D skyTexture;

void sky() {
	// Called for every visible pixel in the sky background, as well as all pixels
	// in the radiance cubemap.
	COLOR = texture(skyTexture,SKY_COORDS).rgb;
}
