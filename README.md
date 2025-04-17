# Glossary

## 1. Inventory

Basic inventory system, with pickups, quantities and class based architecture to allow for easy expansion if needed.

## 2. [Vampire Survivors Template](vampiresurvivortemplate/README.md)

Implemented Features for a VampireSurvivor-esque game. Complete with leveling, different weapons, different mobs and basic menu functionality.

## 3. 2D Tilebased Movement Template

Basic 2D plane tile based movement (think Pokemon GBA esque) where you have cardinal directional movement, with the ability to spin in place to change directions without moving (to change which direction you're facing). 

Also includes the ability to jump over ledges in one direction.

## 4. [Item Crafting Template](ItemCraftingTemplate/README.md)

Create a system where items can be created with unique stats, crafted with unique stats, and equipped to change how the player operates.

The goal is to emulate a PoE style of item management where stats have certain rules to how they can appear, different tiers of items and the ability to manipulate how often certain modifiers appear.

## 5. [Level Editor Template](LevelEditorTemplate/README.md)

A basic in-game level editor scene that lets the user place objects, that can then be saved, and rendered into the game space allowing the user to interact with the objects they just placed.

Like Stardew Valley's building placement editor.

Also added a SceneManager, that handles loading, deleting, pre-loading and threading the loads of multiple scenes. Probably applicable to all the other templates as a base.

## 6. [Wave Function Collapse Template](WaveFunctionCollapseTemplate/README.md)

The project also happens to have an up to date Logger class (refer to it vs other projects for a better approach to the function). I'll eventually get around to refactoring all the utility singletons.

Procedural generation via Wave Function Collapse.

## 7. [Advanced Custom Resources Template](AdvancedCustomResourcesTemplate/README.md)

This project will take a look at nested custom resoruces and how they can be used to simplify interconnected scenes.

The main goal is to create a boilerplate template that can be plugged into any sort of project that uses a base scene that different child scenes can affect and manipulate, think like FTL/Into the Breach where different weapons/subsystems can be added to the base scene (the ship) which can then affect the board (enemy ship) by using their ability which does different things (laser vs. rocket for example).

We are also going to explore a little about passing priority in-between scenes and the contract that needs to be formed between the various scenes/subscenes to make that happen.
