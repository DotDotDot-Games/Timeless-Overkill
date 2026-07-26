shader_type canvas_item;

uniform vec4 color_modulate: source_color;
void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	float avg = (tex.r + tex.g + tex.b) / 3.0;
	
	COLOR = vec4(avg,avg,avg,tex.a);
}
//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
