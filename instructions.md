# Instructions

These instructions will guide you through setting up this project in Roblox Studio.

## Prerequisites

*   You need to have [Roblox Studio](https://www.roblox.com/create) installed.

## Setup Steps

1.  **Create a New Project**
    *   Open Roblox Studio.
    *   Click on **New** and select the **Baseplate** template.

2.  **Set up the Workspace**
    *   In the **Explorer** window on the right, you will see the structure of your game.
    *   We will be adding scripts to `ServerScriptService` and `StarterPlayer/StarterPlayerScripts`.

3.  **Create the Scripts**

    You will need to create several scripts and module scripts. To do this, hover over a folder in the Explorer, click the `+` icon, and select the appropriate script type (`Script`, `LocalScript`, or `ModuleScript`).

    **Server Scripts (in `ServerScriptService`):**

    *   Create a **Script** named `Server`. Copy the contents of `src/Server/Server.lua` into it.
    *   Create a **ModuleScript** named `EnemyController`. Copy the contents of `src/Server/EnemyController.lua` into it.
    *   Create a **ModuleScript** named `GameController`. Copy the contents of `src/Server/GameController.lua` into it.
    *   Create a **ModuleScript** named `LevelManager`. Copy the contents of `src/Server/LevelManager.lua` into it.
    *   Create a **ModuleScript** named `VoteManager`. Copy the contents of `src/Server/VoteManager.lua` into it.
    *   Create a **ModuleScript** named `ScoreManager`. Copy the contents of `src/Server/ScoreManager.lua` into it.
    *   Create a **ModuleScript** named `MonetizationManager`. Copy the contents of `src/Server/MonetizationManager.lua` into it.
    *   Create a **ModuleScript** named `PowerUpController`. Copy the contents of `src/Server/PowerUpController.lua` into it.

    **Client Scripts (in `StarterPlayer` > `StarterPlayerScripts`):**

    *   Create a **LocalScript** named `Client`. Copy the contents of `src/Client/Client.lua` into it.
    *   Create a **ModuleScript** named `PlayerController`. Copy the contents of `src/Client/PlayerController.lua` into it.
    *   Create a **ModuleScript** named `WeaponController`. Copy the contents of `src/Client/WeaponController.lua` into it.
    *   Create a **ModuleScript** named `VotingController`. Copy the contents of `src/Client/VotingController.lua` into it.
    *   Create a **ModuleScript** named `ScoreboardController`. Copy the contents of `src/Client/ScoreboardController.lua` into it.
    *   Create a **ModuleScript** named `UIController`. Copy the contents of `src/Client/UIController.lua` into it.
    *   Create a **ModuleScript** named `SoundManager`. Copy the contents of `src/Client/SoundManager.lua` into it.
    *   Create a **ModuleScript** named `KillEffectController`. Copy the contents of `src/Client/KillEffectController.lua` into it.

    **Shared Scripts (in `ReplicatedStorage`):**

    *   Create a **Folder** named `Levels`.
    *   Inside `Levels`, create a **ModuleScript** named `Arena`. Copy the contents of `src/Shared/Levels/Arena.lua` into it.
    *   Inside `Levels`, create a **ModuleScript** named `Corridors`. Copy the contents of `src/Shared/Levels/Corridors.lua` into it.
    *   Inside `Levels`, create a **ModuleScript** named `TheMaze`. Copy the contents of `src/Shared/Levels/TheMaze.lua` into it.
    *   Inside `Levels`, create a **ModuleScript** named `Warehouse`. Copy the contents of `src/Shared/Levels/Warehouse.lua` into it.

4.  **Monetization Setup**

    *   This project uses Game Passes for monetization. You will need to create them on the Roblox website for your game.
    *   Once you have created the Game Passes, open the `MonetizationManager.lua` script (in `ServerScriptService`).
    *   Replace the placeholder `0` values in the `gamePasses` table with your actual Game Pass IDs.

5.  **Add Sounds**

    *   In the **Explorer** window, create a new **Folder** in `ReplicatedStorage` and name it `Sounds`.
    *   Inside the `Sounds` folder, create **nine** **Sound** objects. Name them:
      - `Shoot`
      - `Reload`
      - `EnemyHit`
      - `PlayerHit`
      - `Explosion`
      - `PowerUp`
      - `MenuSelect`
      - `RoundStart`
      - `RoundEnd`
    *   For each **Sound** object, you will need to provide a **SoundId**. You can find sound effects on the Roblox Creator Marketplace or upload your own.

6.  **Run the Game**
    *   Once all the scripts and sounds are in place, click the **Play** button (or press F5) to start the game.

## Enhanced Features

### Maps
You now have **6 different maps** to play on:
- **Arena**: Classic open arena with pillars for cover
- **Corridors**: Tight network of intersecting hallways  
- **The Maze**: Grid-based map with complex navigation
- **Warehouse**: Large industrial space with dynamic crate cover
- **Castle**: Medieval fortress with towers, courtyard, and throne room
- **Prison**: Maximum security facility with cell blocks and guard towers

### Weapons
Choose from **9 different weapons**:
- **Pistol**: Standard sidearm
- **Shotgun**: Close-range spread damage
- **Rocket Launcher**: Explosive area damage
- **Assault Rifle**: Balanced automatic weapon
- **Sniper Rifle**: Long-range precision
- **Submachine Gun**: Fast-firing close combat
- **Light Machine Gun**: High-capacity sustained fire
- **Crossbow**: High-damage piercing shots
- **Plasma Rifle**: Energy weapon with charged shots

### Enemies
Face **7 different enemy types** with unique behaviors:
- **Melee Zombie**: Basic charging enemy
- **Ranged Shooter**: Projectile-firing enemy
- **Dodger**: Fast strafing enemy
- **Tank**: Heavy enemy with charge attacks
- **Kamikaze**: Explosive suicide units
- **Healer**: Support units that heal allies
- **Sniper**: Long-range precision enemies

### Power-Ups
Collect **6 different power-ups**:
- **Medkit**: Instant health restoration
- **Speed Boost**: Temporary movement speed increase
- **Damage Amplifier**: Temporary damage increase
- **Health Pack**: Instant 50 HP heal
- **Ammo Pack**: Refill current weapon clip
- **Shield**: Damage reduction and protection

### Game Features
- **Dynamic Difficulty**: Enemy variety increases throughout rounds
- **Progressive Spawning**: More challenging enemies appear over time
- **Enhanced UI**: Dynamic crosshair, color-coded health/ammo displays
- **Advanced Audio**: 3D positional sound effects
- **Visual Effects**: Particle effects for all actions and power-ups

You should now have a fully-featured modern first-person shooter with extensive customization options and engaging gameplay!

## Lobby System Features

### Social Hub
- **Player Interaction**: Chat and interact with other players before rounds
- **Shop Access**: Browse and purchase cosmetic items from the in-game shop
- **Leaderboard Viewing**: Check current scores and previous round winners
- **Preparation Area**: Get ready and strategize before joining combat

### Optional Participation
- **Choose Your Role**: Decide whether to join the round or stay in the lobby
- **Spectator Mode**: Watch active rounds from an elevated viewing platform
- **Flexible Participation**: Join or leave rounds at your own pace
- **Safe Environment**: No pressure to participate every round

### Key Controls
- **L Key**: Toggle lobby access
- **B Key**: Open/close the shop interface
- **Join Round Button**: Enter active combat
- **Spectate Button**: Watch the current round
- **Leave Lobby Button**: Return to lobby from any state

### Lobby Environment
- **Spacious Layout**: 100x100 unit interaction area
- **Viewing Platform**: Elevated 40x40 unit area for spectating
- **Transparent Walls**: 80% transparency for visibility
- **Professional UI**: Clean, intuitive interface with real-time updates

### Game Flow
1. **Lobby Phase**: Interact, shop, and prepare (5 seconds)
2. **Voting Phase**: Participate in map selection
3. **Round Start**: Active players teleport to the selected map
4. **Spectator Mode**: Watch from the viewing platform
5. **Round Progress**: 2-minute combat with live updates
6. **Round End**: All players return to lobby
7. **Intermission**: 20-second break before next cycle

### Economy Integration
- **Persistent Currency**: Credits and inventory persist between rounds
- **Real-time Updates**: Live balance and purchase history
- **Seamless Shopping**: Shop access directly from lobby interface
- **Progress Tracking**: View economy progress and achievements

This lobby system transforms PolyStrike Arena into a comprehensive social gaming experience, providing meaningful activities before, during, and after each round while maintaining the fast-paced action that defines the game!
