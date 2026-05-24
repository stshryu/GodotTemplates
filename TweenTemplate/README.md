# Tween Templates

This guide should go over the basics of Tweens in Godot, and how easily you can create living and breathing game interactions using them.

The majority of this data is coming from [christophe's interactive tween guide](https://qaqelol.itch.io/tweens)

The guide above is a trove of tween usage, and should be referred to where needed.

## The basics of tweens

A basic tween looks like so:

```
var tween = create_tween()
var target = $TextureRect 

tween.tween_property(target, "position:y", 100.0, 1.0)
tween.tween_property(target, "rotation_degrees", 90.0, 1.0)
tween.tween_property(target, "scale", (1.5, 1.5), 1.0)
```

The first line creates a tween, and our target is some already defined `$TextureRect`.

Each line executes in order, and the `tween_property` takes in three parameters, the target, the property to manipulate and its corresponding values.

Additionally, you can change the way the tween transitions these values by calling property modifications on the tween itself before adding a tween property

```
var tween = create_tween()

tween.set_trans(Tween.TRANS_LINEAR)
tween.set_ease(Tween.EASE_IN)
tween.tween_property($Sprite2D, "position:x", 100, 1.0)
```

This changes how the property gets applied to the tween. A full list of [tween transition enums can be found here](https://docs.godotengine.org/en/stable/classes/class_tween.html#enum-tween-transitiontype).

Likewise a full list of [tween ease methods can be found here](https://docs.godotengine.org/en/stable/classes/class_tween.html#enum-tween-easetype).

## Lifecycle of Tweens

Tweens get freed up by the engine the moment their purpose is finished. They can't be called ahead of time, and must be instantiated and used ad hoc when needed.

This does mean that you need to be careful when instantiating multiple tweens through code to animate a single target.

```
var target = $TextureRect
var tween: Tween

func start_anim():
    if tween: tween.kill()

    tween = create_tween()
    tween.set_trans(Tween.TRANS_SINE)
    tween.tween_property(target, "scale", Vector2(1.5, 1.5), 0.2)
    tween.tween_property(target, "rotation", 3.14, 2.0).as_relative()
```

The code block above ensures that we won't be instantiating multiple tweens to animate on a target, which can cause unexpected behaviors.
