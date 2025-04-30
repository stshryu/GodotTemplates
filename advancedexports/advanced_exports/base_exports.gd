class_name BaseExports
extends Resource

"""
This file is going to handle a basic export template.

Export a collection of variables that can be set via the inspector.

This is the most basic version of an export, and is the simplest to implement.
"""

@export_category("String Category") ## Categories allow us to split the exported inspector values up.
@export_group("Big Group") ## Groups allow you to split up existing sections to hide/show as needed. Categories override groups, so having a group above a category does nothing.
@export var string_name: String ## Simple name in a small text box
@export_subgroup("Smaller Group")
@export_multiline var string_desc: String ## Large text box for longer strings

@export_category("Number Category")
@export_range(0, 100, 1) var int_range: int ## An integer with a clamped range (0, 100) with steps of 1
@export_range(-10.0, 10.0, 0.2) var float_range: float ## A float range (-10,10) with steps of 0.2

@export_category("Flags and Enums Category")
## Flags can have any number of values. Keep in mind the resulting elements value will have the sum of all the values.
## Meaning if fire, water and air are selected, the value of elements will be 11. If only fire and air are selected, elements will be 9.
## Think of these as bitwise flags.
@export_flags("Fire:1", "Water:2", "Earth:4", "Air:8") var elements = 0
## Enums are nice because we can define a named GDScript enum, which means we can create exportable enums from other defined classes.
## There are two ways to implement this: One is to simply set the type hint to the name of the enum we want to target (the first one bewlo)
## the second way is to set an array with its type hit as the enum. If you try out both you'll see the difference in the inspector, and depending
## on what you want to target it might change how you want to flag these fields.
enum TestEnums {Test1, Test2, Test3}
@export var enumtest: TestEnums
@export var enumtest2: Array[TestEnums]
