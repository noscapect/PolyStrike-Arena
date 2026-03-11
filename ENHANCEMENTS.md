# PolyStrike Arena - Enhanced Features

This document outlines the major enhancements made to the original PolyStrike Arena project.

## New Maps Added

### The Maze
- **Description**: A grid-based maze level with tight corners and close-quarters combat
- **Features**: 
  - 9 strategic spawn points
  - Complex wall layout creating multiple pathways
  - Perfect for tactical gameplay and ambushes
  - 120x120 arena size with 10-unit high walls

### Warehouse
- **Description**: A large industrial space filled with crates for cover
- **Features**:
  - 13 spawn points for balanced gameplay
  - Dynamic crate clusters for strategic positioning
  - Industrial lighting effects (neon ceiling lights)
  - 200x200 arena with metal walls and concrete floor

### Castle
- **Description**: A medieval fortress with towers, courtyard, and throne room
- **Features**:
  - 12 strategic spawn points across towers and courtyard
  - Four corner towers with high ground advantage
  - Central keep with throne room interior
  - Drawbridge entrance and moat for tactical positioning
  - 200x200 arena with stone walls and medieval architecture

### Prison
- **Description**: A maximum security facility with cell blocks and guard towers
- **Features**:
  - 15 spawn points across yard and building interiors
  - Exercise yard with basketball hoop and weight bench
  - Cell block with narrow corridors and cell doors
  - Guard towers with searchlights and security cameras
  - 250x250 arena with concrete walls and industrial barriers

## Expanded Weapon Arsenal

### New Weapons Added:
1. **Submachine Gun**
   - Fire Rate: 0.05s (very fast)
   - Damage: 8 per shot
   - Clip Size: 40 rounds
   - Ammo: 160 total
   - Reload Time: 1.8s
   - Spread: 0.08

2. **Light Machine Gun**
   - Fire Rate: 0.08s (fast)
   - Damage: 12 per shot
   - Clip Size: 100 rounds
   - Ammo: 400 total
   - Reload Time: 3.5s
   - Spread: 0.06

3. **Crossbow**
   - Fire Rate: 1.2s (slow)
   - Damage: 90 (high damage)
   - Clip Size: 1 bolt
   - Ammo: 20 total
   - Reload Time: 2.5s
   - **Special**: Piercing shots

4. **Plasma Rifle**
   - Fire Rate: 0.2s (medium)
   - Damage: 18 per shot
   - Clip Size: 25 cells
   - Ammo: 100 total
   - Reload Time: 2.2s
   - **Special**: Charged shot capability (1.5s charge time)

## Enhanced Enemy System

### New Enemy Types:
1. **Tank**
   - Health: 200 (high durability)
   - Speed: 8 (slow but charges when close)
   - Color: Dark gray
   - Behavior: Slow movement, charges at high speed when within 15 units

2. **Kamikaze**
   - Health: 50 (low durability)
   - Speed: 20 (very fast)
   - Color: Bright orange
   - Behavior: Rushes at players, explodes on contact (10m radius, 50 damage)

3. **Healer**
   - Health: 70 (medium durability)
   - Speed: 12 (medium speed)
   - Color: Bright purple
   - Behavior: Heals nearby enemies (10 HP every 3 seconds within 20 units)

4. **Sniper**
   - Health: 85 (medium durability)
   - Speed: 11 (medium speed)
   - Color: Bright cyan
   - Behavior: Long-range combat, keeps distance (50+ units), precise shots every 1.5s

### Advanced AI Behaviors:
- **Progressive Difficulty**: Enemy spawn weights change over time
- **Smart Targeting**: Enemies adapt behavior based on distance and player position
- **Team Support**: Healers provide support to nearby enemies
- **Area Denial**: Kamikazes create explosive zones

## Enhanced Power-Up System

### New Power-Ups:
1. **Health Pack**
   - Effect: Instantly heals 50 HP
   - Duration: Instant
   - Visual: Cyan particle effect

2. **Ammo Pack**
   - Effect: Refills current weapon clip
   - Duration: Instant
   - Visual: Yellow particle effect

3. **Shield**
   - Effect: Reduces damage taken, slight movement slowdown
   - Duration: 15 seconds
   - Visual: Blue particle effect

4. **Invisibility**
   - Effect: Makes player invisible to enemies
   - Duration: 8 seconds
   - Visual: White particle effect

### Enhanced Visual Effects:
- Color-coded particle effects for each power-up type
- Temporary visual indicators when effects are active
- Smooth transitions when effects expire

## Improved User Interface

### Enhanced Crosshair System:
- **Dynamic Scaling**: Crosshair size adjusts based on weapon spread
- **Weapon-Specific Colors**:
  - Default: Green (for most weapons)
  - Sniper Rifle: Red (precision targeting)
  - Rocket Launcher: Orange (explosive weapon)
- **Visual Feedback**: Real-time updates based on current weapon

### Smart Health Bar:
- **Color Coding**:
  - Green (70-100% health)
  - Yellow (30-69% health)
  - Red (0-29% health)
- **Visual Warning**: Low health indicators

### Enhanced Ammo Display:
- **Color Coding**:
  - White (full ammo)
  - Yellow (low ammo: <30% of clip)
  - Red (empty clip)
- **Real-time Updates**: Live ammo count display

## Advanced Audio System

### New Sound Effects:
- **Player Hit**: Dedicated sound for when player takes damage
- **Explosion**: Enhanced explosion audio for rockets and kamikazes
- **Power Up**: Distinct sound for collecting power-ups
- **Menu Navigation**: UI interaction sounds
- **Round Start/End**: Announcements for game phases

### Audio Features:
- **3D Positioning**: Sounds play at correct locations in world
- **Volume Control**: Per-sound volume settings
- **Temporary Sounds**: Dynamic sound creation for positional effects
- **Music Support**: Background music system with volume control

## Progressive Game Difficulty

### Dynamic Enemy Spawning:
- **Time-Based Scaling**: Enemy difficulty increases throughout the round
- **Weighted Probabilities**:
  - Early game: More basic enemies (MeleeZombie, RangedShooter)
  - Mid game: Balanced mix with Dodgers
  - Late game: Heavy enemies (Tanks, Kamikazes, Healers, Snipers)

### Spawn Rate Adjustments:
- Maintains 5-second spawn interval
- Increases enemy variety and difficulty over time
- Creates escalating tension as rounds progress

## Technical Improvements

### Code Organization:
- **Modular Design**: Enhanced separation of concerns
- **Error Handling**: Improved robustness and fallbacks
- **Performance**: Optimized loops and object creation
- **Maintainability**: Clear code structure for easy expansion

### Visual Polish:
- **Particle Effects**: Enhanced visual feedback for all actions
- **Lighting**: Industrial lighting in Warehouse map
- **Materials**: Varied textures and materials for different maps
- **Animations**: Smooth transitions and effects

## Setup Requirements

### Game Pass Configuration:
Update `src/Server/MonetizationManager.lua` with actual Game Pass IDs:
```lua
local gamePasses = {
    GoldenPistol = YOUR_GOLDEN_PISTOL_ID,
    SpecialKillEffects = YOUR_KILL_EFFECTS_ID
}
```

### Sound Assets:
Create these sound objects in `ReplicatedStorage/Sounds/`:
- Shoot
- Reload
- EnemyHit
- PlayerHit
- Explosion
- PowerUp
- MenuSelect
- RoundStart
- RoundEnd

## Gameplay Experience

### Enhanced Combat:
- **Weapon Variety**: 9 different weapons with unique characteristics
- **Tactical Depth**: Different weapons excel in different situations
- **Enemy Variety**: 7 enemy types with distinct behaviors and strategies
- **Power Management**: Strategic use of temporary power-ups

### Map Diversity:
- **Arena**: Classic open combat with pillar cover
- **Corridors**: Tight hallway engagements
- **The Maze**: Complex navigation and ambush opportunities
- **Warehouse**: Large-scale combat with dynamic cover

### Progression System:
- **Dynamic Difficulty**: Rounds become more challenging over time
- **Strategic Depth**: Players must adapt tactics as enemy composition changes
- **Reward System**: High scores and kill streaks provide satisfaction

This enhanced version of PolyStrike Arena provides a much richer and more engaging first-person shooter experience with modern game design principles and extensive customization options.

## Lobby System Implementation

### Comprehensive Lobby Features:
- **Social Hub**: Players can interact, view leaderboards, and access the shop
- **Optional Participation**: Players choose whether to join rounds or stay in lobby
- **Spectator Mode**: Watch active rounds from a designated viewing platform
- **Real-time Updates**: Live player status, round progress, and economy data
- **Persistent Economy**: Currency and inventory persist between rounds

### Player States & Actions:
- **In Lobby**: Default state for all players with social interaction
- **Spectating**: Watching round from elevated viewing platform
- **In-Game**: Actively participating in combat
- **Round Complete**: Returns to lobby after round ends

### Key Actions:
- **Join Round**: Enter active combat (L key or Join Round button)
- **Spectate**: Watch from viewing platform (Spectate button)
- **Shop Access**: Browse and purchase items (Shop button or B key)
- **Leave Lobby**: Return to lobby from any state (Leave Lobby button)
- **Toggle Lobby**: Quick access with L key

### Technical Implementation:
- **LobbyManager.lua**: Server-side lobby management with player state tracking
- **LobbyController.lua**: Client-side professional lobby interface
- **Integrated Environment**: 100x100 unit lobby area with viewing platform
- **Seamless Integration**: Works perfectly with existing game systems

### Lobby Environment:
- **Spacious Layout**: 100x100 unit interaction area
- **Transparent Walls**: 80% transparency for visibility
- **Viewing Platform**: 40x40 unit elevated area at (0, 10, -30)
- **Safe Zone**: No combat or hazards in lobby area
- **Professional UI**: Clean, intuitive interface with real-time updates

### Game Flow Integration:
1. **Lobby Phase**: Players interact, shop, prepare (5 seconds)
2. **Voting Phase**: Map selection with lobby participation
3. **Round Start**: Active players teleport to map
4. **Spectator Mode**: Lobby players can watch from platform
5. **Round Progress**: 2-minute combat with live updates
6. **Round End**: All players return to lobby
7. **Intermission**: 20-second break before next cycle

This lobby system transforms PolyStrike Arena from a simple shooter into a comprehensive social gaming experience, providing players with meaningful activities before, during, and after each round while maintaining the fast-paced action that defines the game.
