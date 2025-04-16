# Advanced Usage of Custom Resources

## TODO:

Created the basic relationship between the custom resources and our base scene. We want to add the ability to parse a directory to pull out all the relevant `.tres` files to load our scenes from disk without needing to have a reference to them in the code.

Also want to ensure that subscenes can take priority over the base scene (for example when placing the straight line ability I want to be able to rotate the arrow, which means that clicking should NOT affect the base game).

Will probably need signals to have each communicate when priority is taken by which subscene.

## Basic Concept

We want to have an ability resource that basically holds a variety of scenes. By defining them as export variables, and defining methods that load/use those scenes we can ensure that any custom created abilities can interact with our game world, store screen, and any other custom scene properly without issue.

## Project Setup

The project is going to have 4 basic components:

1. Assets
2. base_scene - Holds the scene data for our base game
3. special_abilities - Holds all the ability data (including our base ability class)
4. store_scene - Holds the scene data for a store screen, which is separate from our base scene.

## Creating a modular resource
