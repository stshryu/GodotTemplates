extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("example_signal_with_param", print_test)
	EventBus.connect("turn_ended", turn_ended)

func print_test(text1, text2):
	print(text1)
	print('----')
	print(text2)
	
func turn_ended():
	print('turn has ended')
