shader_type canvas_item;

uniform float speed : hint_range(0.0, 1.0, 0.01);
uniform float parallax_distance : hint_range(0.0, 1.0, 0.1);

void fragment() {
	COLOR = texture(TEXTURE,UV + vec2(TIME * speed * parallax_distance,0.0));
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
