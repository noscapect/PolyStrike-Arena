# PolyStrike Arena

This is a fast-paced, modern arcade shooter created for Roblox, inspired by classic arena shooters.

## How to Play

*   **Movement:** WASD keys
*   **Aim:** Mouse
*   **Shoot:** Left Mouse Button
*   **Sprint:** Hold Left Shift
*   **Reload:** R key
*   **Switch Weapons:** 1, 2, 3 keys

## Features

### Gameplay
*   **Round-Based Action:** The game is played in rounds, with a short intermission between each round.
*   **Map Voting:** At the end of each round, players vote for the next map to be played.
*   **Scoring System:** Earn points by damaging enemies. A leaderboard displays the scores for all players in the round.
*   **Power-Ups:** Medkits spawn randomly in the arena to heal players.

### Maps
The game features a variety of maps, each offering different tactical challenges:
*   **Arena:** A classic open arena with pillars for cover.
*   **Corridors:** A tight network of intersecting hallways.
*   **The Maze:** A grid-based map with tight corners and close-quarters combat.
*   **Warehouse:** A large industrial space filled with crates for cover.

### Weapons
The game features a variety of weapons, each with unique properties:
*   **Pistol:** A standard sidearm with a decent fire rate and clip size.
*   **Shotgun:** A powerful close-range weapon that fires multiple projectiles in a spread.
*   **Rocket Launcher:** Fires explosive rockets that deal area-of-effect damage.
*   **Ammo & Reloading:** Each weapon has a limited clip size and ammo pool, requiring you to reload strategically.

### Enemies
A diverse cast of enemies will challenge you:
*   **Melee Zombie:** A basic enemy that will chase you down.
*   **Ranged Shooter:** Keeps its distance and fires projectiles at you.
*   **Dodger:** A nimble enemy that strafes from side to side to avoid your shots.

### User Interface
*   **Health Bar:** A graphical health bar displays your current health.
*   **Weapon & Ammo Display:** The UI shows your currently equipped weapon and ammo count.
*   **Leaderboard:** The scoreboard is displayed on the side of the screen, showing player scores in real-time.

### Audio
*   **Sound System:** The game includes a sound system for actions like shooting, reloading, and hitting enemies. (Requires user-provided sound assets).

### Monetization
The game is monetized through cosmetic Game Passes that do not provide a gameplay advantage:
*   **Golden Pistol:** Unlocks a cosmetic skin for the pistol.
*   **Special Kill Effects:** Displays a special particle effect when you defeat an enemy.

## Project Structure

The project is organized into three main directories:

*   `src/Client`: Contains all client-side scripts, which run on the player's device. This includes controllers for the player, weapons, UI, and sound.
*   `src/Server`: Contains all server-side scripts, which run on the Roblox server. This includes controllers for enemies, the game loop, and managing game state.
*   `src/Shared`: Contains modules that are used by both the client and the server, such as the level data.
