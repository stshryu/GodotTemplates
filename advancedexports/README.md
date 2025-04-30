# Advanced Exports

This project contains the multiple ways we can create `@exports` in godot, which are designed to help the Godot editor display the correct values for specific scripts/resources.

## Basic Exports

Basic exports are the stuff we've been using in our scripts using `@export var ...`.

## Advanced Exports

Advanced exports uses various given export methods `@export_multiline, @export_flag ...`.

## Tools

Tools allows the editor to run the script, which lets us create conditional flags for auto-updating which fields are present at runtime.

We can also auto populate fields (E.G. if the team name is "RED" we can set the team color to automatically be some arbitrary RGB value).
