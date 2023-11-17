shader_type fog;

uniform sampler2D noise_texture;
uniform float noise_scale : hint_range(-2.0, 16.0)= 0.257;
uniform float flatness: hint_range(-2.0, 16.0) = 7.165;
uniform float density: hint_range(-2.0, 2.0) = 0.555;
uniform sampler2D grad_tex;


void fog() {
	vec2 move_uv = vec2(0.2,0.0)*TIME;
	float detail_noise = texture (noise_texture, WORLD_POSITION.xz *noise_scale+move_uv*0.1).r;
	detail_noise *=0.1;
	float noise = texture(noise_texture, WORLD_POSITION.xz*noise_scale).r;
	DENSITY = mix(1.0,noise, UVW.y*flatness);
	DENSITY *= step(0.0, -SDF)*density;
	vec3 col = texture(grad_tex, vec2(DENSITY,0.5)).rgb;
	EMISSION = vec3(col);
	ALBEDO = vec3(col);
}
