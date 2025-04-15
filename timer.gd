extends Timer

var total_time : int

func _ready() -> void:
	self.start()

func _on_timeout() -> void:
	total_time += 1
	var m = int(total_time / 60.0)
	var s = total_time - m * 60
	var time = '%01d:%02d' % [m,s]
	get_node("..").text = str("Time: ",time)
