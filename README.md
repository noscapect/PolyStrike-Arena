# PolyStrike Arena

This is a fast-paced, modern arcade shooter created for Roblox, inspired by classic arena shooters. Now featuring enhanced gameplay with 4 maps, 9 weapons, 7 enemy types, and advanced game systems.

## How to Play

*   **Movement:** WASD keys
*   **Aim:** Mouse
*   **Shoot:** Left Mouse Button
*   **Sprint:** Hold Left Shift
*   **Reload:** R key
*   **Switch Weapons:** 1-9 keys
*   **Zoom:** Right Mouse Button (Sniper Rifle only)

## Enhanced Features

### 🎮 **Gameplay Systems**
*   **Round-Based Action:** 2-minute rounds with 20-second intermissions for voting.
*   **Dynamic Map Voting:** Players vote for the next map between rounds.
*   **Progressive Difficulty:** Enemy variety and challenge increases throughout each round.
*   **Advanced Scoring:** Real-time leaderboard with damage-based scoring.
*   **Power-Up System:** 6 different power-ups with visual effects and strategic value.

### 🗺️ **Maps (6 Total)**
*   **Arena:** A classic open arena with pillars for cover.
*   **Corridors:** A tight network of intersecting hallways.
*   **The Maze:** A grid-based map with complex navigation and ambush opportunities.
*   **Warehouse:** A large industrial space filled with dynamic crate cover and atmospheric lighting.
*   **Castle:** A medieval fortress with towers, courtyard, and throne room - featuring strategic high ground and narrow passages.
*   **Prison:** A maximum security facility with cell blocks, guard towers, and exercise yard - offering tactical cover and vertical gameplay.

### 🔫 **Weapons (9 Total)**
*   **Pistol:** Standard sidearm with balanced stats.
*   **Shotgun:** Close-range spread damage weapon.
*   **Rocket Launcher:** Explosive area-of-effect damage.
*   **Assault Rifle:** Balanced automatic weapon for medium range.
*   **Sniper Rifle:** Long-range precision weapon with zoom.
*   **Submachine Gun:** Fast-firing close-combat weapon.
*   **Light Machine Gun:** High-capacity sustained fire weapon.
*   **Crossbow:** High-damage piercing shots.
*   **Plasma Rifle:** Energy weapon with charged shot capability.

### 👹 **Enemies (7 Total)**
*   **Melee Zombie:** Basic charging enemy (100 HP).
*   **Ranged Shooter:** Projectile-firing enemy (60 HP).
*   **Dodger:** Fast strafing enemy that avoids shots (80 HP).
*   **Tank:** Heavy enemy with charge attacks (200 HP).
*   **Kamikaze:** Explosive suicide units (50 HP).
*   **Healer:** Support units that heal nearby enemies (70 HP).
*   **Sniper:** Long-range precision enemies (85 HP).

### ⚡ **Power-Ups (6 Total)**
*   **Medkit:** Instant health restoration.
*   **Speed Boost:** Temporary movement speed increase.
*   **Damage Amplifier:** Temporary damage increase.
*   **Health Pack:** Instant 50 HP heal with visual effects.
*   **Ammo Pack:** Refill current weapon clip.
*   **Shield:** Damage reduction and protection.

### 🎨 **Enhanced User Interface**
*   **Dynamic Crosshair:** Size and color change based on weapon type.
*   **Smart Health Bar:** Color-coded health levels (Green/Yellow/Red).
*   **Enhanced Ammo Display:** Color-coded ammo status with low ammo warnings.
*   **Real-time Leaderboard:** Live player scores with updates.
*   **Visual Feedback:** Particle effects for all actions and power-ups.

### 🌍 **Immersive Map Environments**
*   **Physics-Enabled Objects:** Interactive environments that react to player actions.
*   **Particle Effects System:** Visual feedback on all projectile impacts.
*   **Atmospheric Enhancements:** Map-specific lighting and environmental effects.
*   **Dynamic Cover:** Physics-enabled crates in Warehouse that can be moved/destroyed.
*   **Impact Reactions:** Walls, floors, and objects emit sparks and debris when hit.

### ⚡ **Advanced Physics & Effects**
*   **Interactive Physics:** Crates in Warehouse move realistically when shot
*   **Impact Sparks:** All surfaces emit thematic particle effects on projectile hits
*   **Environmental Feedback:** Floor dust, wall debris, and destruction effects
*   **Atmospheric Particles:** Map-specific fog, dust, and lighting effects
*   **Force Reactions:** Objects receive realistic physics forces on impact
*   **Performance Optimized:** Efficient particle systems and physics calculations

### 🔊 **Advanced Audio System**
*   **3D Positional Audio:** Sounds play at correct locations in the world.
*   **9 Sound Effects:** Comprehensive audio feedback for all game actions.
*   **Volume Control:** Per-sound volume settings for optimal experience.
*   **Music Support:** Background music system with volume control.

### 💰 **Enhanced Monetization System**
A comprehensive economy system where players earn and spend currency for cosmetic enhancements:

**Currency Earning:**
*   **Damage Rewards:** Earn 1 credit for every 10 damage dealt
*   **Kill Bonuses:** Additional credits for defeating enemies (varies by enemy type)
*   **Starting Bonus:** All players receive 100 credits to begin

**In-Game Shop:**
*   **Weapon Skins:** 4 unique cosmetic skins for different weapons
*   **Kill Effects:** 4 special particle effects for enemy defeats
*   **Currency Packs:** Robux purchases for instant credit boosts

**Shop Items:**
*   **Golden Pistol Skin** (500 credits) - Make your pistol shine!
*   **Neon Rifle Skin** (750 credits) - Cyberpunk glow for your assault rifle!
*   **Camo Shotgun Skin** (600 credits) - Military-grade camouflage!
*   **Plasma Rifle Skin** (800 credits) - Futuristic plasma coating!
*   **Explosion Kill Effect** (1000 credits) - Enemies explode in fiery blasts!
*   **Spark Rain Kill Effect** (800 credits) - Victims rain down electric sparks!
*   **Confetti Kill Effect** (600 credits) - Celebrate with confetti explosions!
*   **Ghost Kill Effect** (700 credits) - Defeated enemies leave spooky ghosts!

**Robux Currency Packs:**
*   **Small Pack:** 99 Robux for 1000 credits
*   **Medium Pack:** 249 Robux for 2500 credits  
*   **Large Pack:** 499 Robux for 6000 credits
*   **Mega Pack:** 999 Robux for 15000 credits

**Shop Access:**
*   Press **B** key to open/close the shop interface
*   Real-time balance display and inventory management
*   Visual item previews with descriptions and pricing
*   Instant purchase confirmation and item activation

## Technical Features

### **Progressive Difficulty System**
- Enemy spawn weights dynamically change throughout rounds
- Early game: More basic enemies (MeleeZombie, RangedShooter)
- Mid game: Balanced mix with Dodgers
- Late game: Heavy enemies (Tanks, Kamikazes, Healers, Snipers)

### **Advanced AI Behaviors**
- Smart targeting based on distance and player position
- Team support mechanics (Healers)
- Area denial strategies (Kamikazes)
- Adaptive movement patterns

### **Visual Polish**
- Industrial lighting effects in Warehouse map
- Color-coded particle effects for all power-ups
- Smooth transitions and UI animations
- Enhanced material variety across maps

### **Performance Optimized**
- Efficient object pooling and cleanup
- Optimized loops and calculations
- Robust error handling and fallbacks
- Modular code architecture for easy expansion

## Project Structure

The project is organized into three main directories:

*   `src/Client`: Contains all client-side scripts, which run on the player's device. This includes controllers for the player, weapons, UI, sound, and visual effects.
*   `src/Server`: Contains all server-side scripts, which run on the Roblox server. This includes controllers for enemies, the game loop, scoring, voting, and power-ups.
*   `src/Shared`: Contains modules that are used by both the client and the server, such as the level data.

## Setup Requirements

### Game Pass Configuration
Update `src/Server/MonetizationManager.lua` with actual Game Pass IDs:
```lua
local gamePasses = {
    GoldenPistol = YOUR_GOLDEN_PISTOL_ID,
    SpecialKillEffects = YOUR_KILL_EFFECTS_ID
}
```

### Sound Assets
Create these sound objects in `ReplicatedStorage/Sounds/`:
- Shoot, Reload, EnemyHit, PlayerHit, Explosion, PowerUp, MenuSelect, RoundStart, RoundEnd

## Enhanced Experience

This enhanced version of PolyStrike Arena provides a rich, modern first-person shooter experience with:
- **Strategic Depth**: Multiple weapons and maps encourage different tactics
- **Progressive Challenge**: Dynamic difficulty keeps gameplay engaging
- **Visual Polish**: Professional-grade UI and effects
- **Audio Immersion**: Comprehensive sound design
- **Replay Value**: Varied enemy encounters and map rotation

Perfect for players who enjoy fast-paced action with tactical depth and modern game design principles!

## 📚 **Documentation**

This project includes comprehensive documentation:

- **README.md** - Main project overview and features
- **instructions.md** - Setup and installation guide  
- **ENHANCEMENTS.md** - Complete enhancement overview and technical details
- **MAP_ENHANCEMENTS.md** - Physics and particle effects documentation
- **MONETIZATION_SYSTEM.md** - Comprehensive economy and shop system documentation

## 🎮 **Complete Feature Set**

### **Core Gameplay**
- 6 immersive maps with physics and particle effects
- 9 diverse weapons with unique characteristics
- 7 enemy types with advanced AI behaviors
- 6 power-ups with visual effects
- Round-based progression with voting

### **Visual & Audio**
- Dynamic crosshair system
- Smart health and ammo displays
- Real-time leaderboard
- 3D positional audio
- Atmospheric lighting and effects

### **Economy & Monetization**
- Damage-based currency earning
- Kill bonus rewards
- 8 cosmetic items (4 skins + 4 kill effects)
- 4 Robux currency packs
- Professional shop interface
- Secure server-side validation

### **Lobby System**
- **Social Hub:** Player interaction and preparation area
- **Optional Participation:** Players choose whether to join rounds
- **Spectator Mode:** Watch rounds from elevated viewing platform
- **Real-time Updates:** Live player status and economy data
- **Integrated Shop:** Seamless access to in-game purchases
- **Professional Interface:** Clean, intuitive lobby UI

### **Technical Excellence**
- Progressive difficulty system
- Advanced AI with team mechanics
- Performance-optimized code
- Modular architecture
- Comprehensive error handling
- Professional documentation
