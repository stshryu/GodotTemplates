# Player Features

## Player Weapons and Modifiers

1. Weapons that behave differently
    - Bow: Shoots an arrow projectile that has a base projectile speed, pierce count, and max travel distance. It deals damage once to an enemy once it enters their hurtbox, and if pierce is still greater than 0, will continue onwards until pierce is 0 or the max travel distance is reached.
        - The bow itself shoots its projectiles out based on an arc (a 90 degree arc, so if you have 2 projectiles you'll shoot at two ends of 45 degrees from the player)
    - Sword: Shoots a number of projectiles that slows down per unit hit down to a minimum projectile speed. The projectiles don't do impact damage (and pierce infintely) but they deal damage based on the amount of time they spend inside the hurtbox. E.G. as the projectile moves slower and as the mobs spend more time in the sword hitbox, they'll be constantly damaged.
1. Both weapons have customizable aiming (the sword is autoaimed by default, the bow is manually aimed by default).
1. Upgrades that affect both the weapon (projectile counts) as well as the projectile (proj speed, damage, pierce, travel distance) are all mechanics that allow us to affect player power level.
1. Player leveling. Experience points exist to allow the player to gain levels (the baseline functionality is that the damage, proj speed and travel distance all go up by +2 every level). But we can add in things that maybe gives an additional projectile per level, or more max health and movement speed etc...

## Player Abilities

1. We implemented two abilities: Dashing and Teleporting.
    - Dashing: Quickly moves the player in the targeted direction (modifies the player movement speed, while locking in their facing direction). Can be alt cast to instead move the player in their current MOVING direction E.G. the mouse can be targeting lower right, but if the player is moving towards the top left, they'll dash towards the top left.
    - Teleport: After a brief channel, the player teleports to the targeted direction, up to a maximum distance. Additionally, can be alt cast to instead teleport to the targeted location BEFORE the channel completes E.G. you can lock in your teleport location at the start of the cast time, instead of wherever your mouse is at the end of the cast time.

Both of those abilities have their associated animations that seamlessly is created via the AnimationTree.

# Mob Features

1. Enemies that behave differently
    - A bear that moves slowly, has more health and deals slow damage on contact
    - A bat that moves quickly, has less health, and deals large damage on contact
1. Enemies that spawn outside of the screen, and constantly run towards the player in a configurable timer.

Both of the enemies drop loot (exp baubles) that allow the player to pick them up and gain levels.

# Game Features

A splash page and main menu that allows players to start the game at start.

A pause menu that allows us to either restart the level, resume the level, or exit the game. The pause menu also stops the game process, and hangs it until resumed (or restarted).

Additionally, the exp baubles that the enemies drop are collated into a larger drop (that combines the xp together into 1 drop) to keep the screen free of clutter and to clean up nodes as the game progresses.
