extends Marker2D

@export var taken : bool = false
@export var word_chunk : String = ""

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO.x - 75, Vector2.ZERO.y - 25, 150, 50), Color(0, 0, 0))

func select() -> void:
	self.taken = true
	
func deselect() -> void:
	self.taken = false
