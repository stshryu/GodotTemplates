# Signal Event Bus

This project will outline a simple event bus architecture that can handle all your signals across multiple scenes without a lot of manual connecting.

## Event Bus Overview

In basic event bus arch we would want a producer to create the originating event, an intermediary bus service (like celery, sns, or sqs) that can process these messages and notify the downstream consumers that an event has been emitted.

For Godot, the best application of this would be to create a centralized Autoload file that acts as the intermediary bus service.

This project has two separate scenes: `scene_1` and `scene_2`.

`scene_1` produces the signal, and `scene_2` consumes it.

## Producer Code

This code lives in a script attached to `scene_1`

```
func _on_button_pressed() -> void:
	EventBus.emit_signal("turn_ended")
    EventBus.emit_signal("example_signal_with_param, "testing", "testing2")
```

## Consumer Code

This code lives in a script attached to `scene_2`

```
func _ready() -> void:
	EventBus.connect("turn_ended", turn_ended)
    EventBus.connect("example_signal_with_param", "print_text")

func turn_ended():
	print('turn has ended')

func print_text(text1, text2):
    print(text1)
    print('----')
    print(text2)
```

## Autoload Script

The Autoload script is very simple to use, any signals you want to emit/consume should be defined here. Examples have been included to show what multiple args being passed into the signal should look like.

```
extends Node

signal turn_ended
signal example_signal_with_param(text_to_display, text2)
```

