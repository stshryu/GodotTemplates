extends Node

var counter = 0

func infomsg(message: Variant, filename := ""):
	var colorstr = "[color=%s]" % _get_color()
	var filestr = "File: %s\n" % filename if filename else ""
	var msgstr = "Message: %s" % message
	print_rich("%s%s%s" % [colorstr, filestr, msgstr])
	
func errormsg(error_msg: Variant, filename := ""):
	var filestr = "File: %s\n" % filename if filename else ""
	var msgstr = "Error: %s" % error_msg
	push_error("%s%s" % [filestr, msgstr])
	
func _get_color() -> String:
	var colors = [
		"green", "yellow", "magenta", "pink", "purple", "cyan", "white", "orange"
	]
	var resp = colors[counter]
	counter = 0 if counter + 1 == colors.size() else counter + 1
	return resp
