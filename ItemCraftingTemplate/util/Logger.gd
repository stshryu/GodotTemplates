extends Node

var counter = 0

func info(filename: String, message: String):
	var color = _get_color()
	print_rich("[color=%s]File: %s\nMessage: %s" % [color, filename, message])

func error(filename: String, error: String):
	push_error("File: %s has encountered an error\nError: %s" %[filename, error])

func _get_color() -> String:
	var colors = [
		"green", "yellow", "blue", "magenta", "pink", "purple", "cyan", "white", "orange"
	]
	var resp = colors[counter]
	counter = 0 if counter + 1 == colors.size() else counter + 1
	return resp
