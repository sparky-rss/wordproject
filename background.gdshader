shader_type canvas_item;
//
//uniform float blue = 1.0; // you can assign a default value to uniforms

void vertex() {
  //VERTEX += vec2(cos(TIME)*25.0, sin(TIME)*25.0);
////Combined with the TIME built-in variable, this can be used for basic animation.
}

void fragment() {
  COLOR = vec4(0.008, .133, .431, 1.0); //first 3 shaders will fully override the sprite
  //COLOR = vec4(UV, 0.5, 0.9); 
  //COLOR = vec4(UV, 0.5, 1.0); //UV varies between 0-1 from left-right and from top-bottom.
  //COLOR.b = 1.0; // This shader will result in a blue-tint of the sprite
  //COLOR = texture(TEXTURE, UV); // this is how you read from the texture
  //COLOR.b = blue;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
