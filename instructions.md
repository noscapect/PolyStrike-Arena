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
    *   Create a **ModuleScript** named `PowerUpManager`. Copy the contents of `src/Server/PowerUpManager.lua` into it.

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
    *   Inside the `Sounds` folder, create three **Sound** objects. Name them `Shoot`, `Reload`, and `EnemyHit`.
    *   For each **Sound** object, you will need to provide a **SoundId**. You can find sound effects on the Roblox Creator Marketplace or upload your own.

6.  **Run the Game**
    *   Once all the scripts and sounds are in place, click the **Play** button (or press F5) to start the game.

You should now have a working first-person shooter where you can shoot at enemies that chase you!
