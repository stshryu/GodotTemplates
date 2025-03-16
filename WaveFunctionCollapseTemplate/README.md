# Wave Function Collapse Template

The basic function here is to write out the logic for a procedurally generated _anything_ using the wave function collapse.

## Setup

In order to set up the project, we'll need to set up a custom data layer (called the `identifier` layer in our code, or the data layer in index `0`).

I had to manually map each tile (tiles with the exact same tile have the same ID). Might have to see if there is a way to pull some pixel hash value (or color hash value) to create hashes of tiles to that this doesn't have to be done by hand, e.g. the basic green grass tiles are all the same id because they're all a solid green color, or some of the nested trees are the same tile id since they contain the exact same pixels.
