# Tower Defense

A tower-defense game prototype written for the [Processing](https://processing.org/) Java environment. Enemies follow a fixed path, towers automatically target nearby enemies, defeated enemies award money, and towers can be upgraded.

## Run

1. Install Processing 4.
2. Open `tower_defense/tower_defense.pde` in the Processing editor.
3. Run the sketch.

The sketch references `Cannon.png`, `Tesla.png`, and `Xbow.png`, but those sprite files are not currently included in the repository. Add them to the sketch directory before placing towers, or replace the `loadImage` calls with available assets.

## Controls

- Hold `Q` and click to place a cannon.
- Hold `W` and click to place a Tesla tower.
- Hold `E` and click to place a crossbow tower.
- Click an existing tower to select it.
- Press `1`, `2`, or `3` to upgrade the selected tower's damage, range, or fire rate.

The game starts with $600. Enemy waves increase over the first three minutes, and the game ends when an enemy reaches the end of the path.
