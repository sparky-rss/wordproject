extends Node2D

@export var word_chunk : String = ""
var targeted_rest_node : Node
var targeted_reveal_node : Node
var selected = false

var left_rest_nodes = []
var left_words_array = []

var right_rest_nodes = []
var right_words_array = []

var answer_reveal_nodes = []

func _ready():
	# Get nodes from groups
	left_rest_nodes = get_tree().get_nodes_in_group("left_zone")
	left_words_array = get_tree().get_nodes_in_group("left_word")

	right_rest_nodes = get_tree().get_nodes_in_group("right_zone")
	right_words_array = get_tree().get_nodes_in_group("right_word")

	# Assign default rest nodes
	for i in left_words_array.size():
		left_rest_nodes[i].select()
		left_words_array[i].targeted_rest_node = left_rest_nodes[i]

	for i in right_words_array.size():
		right_rest_nodes[i].select()
		right_words_array[i].targeted_rest_node = right_rest_nodes[i]
	

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("Click") or event == InputEventScreenTouch and is_inside_tree():
		selected = true

func _physics_process(delta: float) -> void:
	if selected:
		self.global_position = lerp(self.global_position, get_global_mouse_position(), 25 * delta)
	else:
		self.global_position = lerp(self.global_position, targeted_rest_node.global_position, 10 * delta)
		targeted_rest_node.word_chunk = self.word_chunk

func _input(event):
	if not selected and is_inside_tree():
		return # Only handle input for the selected (dragged) node

	if event is InputEventMouseButton and is_inside_tree():
		if event.button_index == MOUSE_BUTTON_LEFT and not event.is_pressed():
			release()
	if event is InputEventScreenTouch and is_inside_tree():
		if event.pressed == false:
			release()

func release():
	selected = false

	var zone_data = _get_zone_data()
	var rest_nodes = zone_data["rest_nodes"]
	var word_array = zone_data["word_array"]

	var shortest_dist = min(75, global_position.distance_to(targeted_rest_node.global_position))
	var closest_node = targeted_rest_node

	for node in rest_nodes:
		var distance = global_position.distance_to(node.global_position)
		if distance < shortest_dist:
			closest_node = node
			shortest_dist = distance

	if closest_node == targeted_rest_node:
		return
	elif !closest_node.taken:
		targeted_rest_node.deselect()
		targeted_rest_node = closest_node
		closest_node.select()
	else:
		var other_word = _get_word_at_rest_node(word_array, closest_node)
		if other_word:
			var old_node = targeted_rest_node
			targeted_rest_node.deselect()

			# Swap targets
			other_word.targeted_rest_node = old_node
			old_node.select()

			targeted_rest_node = closest_node
			targeted_rest_node.select()

func _get_zone_data() -> Dictionary:
	if self.is_in_group("left_word"):
		return {
			"rest_nodes": left_rest_nodes,
			"word_array": left_words_array
		}
	elif self.is_in_group("right_word"):
		return {
			"rest_nodes": right_rest_nodes,
			"word_array": right_words_array
		}
	return {}

func _get_word_at_rest_node(word_array, rest_node):
	for word in word_array:
		if word.targeted_rest_node == rest_node:
			return word
	return null


func _on_node_2d_reveal_answers() -> void:
	right_words_array = get_tree().get_nodes_in_group("right_word")
	answer_reveal_nodes = get_tree().get_nodes_in_group("answers")
	for i in right_words_array.size():
		right_rest_nodes[i].select()
		right_words_array[i].targeted_rest_node = answer_reveal_nodes[i]
