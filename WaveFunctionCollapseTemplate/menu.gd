extends Control

@onready var generate_button := %Generate
@onready var loadruleset_button := %Ruleset
@onready var wfc := WaveFunctionCollapse.new()

signal generate_scene

func _ready():
	generate_scene.connect(get_node("/root/BaseScene").display_generated_scene)

func _on_generate_pressed():
	var test = wfc.load_ruleset()
	generate_scene.emit(test)

func _on_ruleset_pressed():
	Logger.infomsg("Rulset loaded")
