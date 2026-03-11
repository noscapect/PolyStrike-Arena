# Lobby System Documentation

This document details the comprehensive lobby system implemented in PolyStrike Arena, providing players with a social hub for interaction, shopping, and spectating before each round.

## 🏠 **Lobby System Overview**

### **Core Features**
- **Social Hub:** Players can interact, view leaderboards, and access the shop
- **Optional Participation:** Players choose whether to join rounds or stay in lobby
- **Spectator Mode:** Watch active rounds from a designated viewing platform
- **Real-time Updates:** Live player status, round progress, and economy data
- **Persistent Economy:** Currency and inventory persist between rounds

### **Lobby Flow**
```
Player Join → Lobby Phase → Voting → Round Start → Spectator/Player Choice → Round Progress → Intermission → Repeat
```

## 🎮 **Player States and Actions**

### **Player States**
1. **In Lobby:** Default state for all players
2. **Spectating:** Watching round from viewing platform
3. **In-Game:** Actively participating in combat
4. **Round Complete:** Returns to lobby after round ends

### **Player Actions**
- **Join Round:** Enter active combat (L key or Join Round button)
- **Spectate:** Watch from viewing platform (Spectate button)
- **Shop Access:** Browse and purchase items (Shop button or B key)
- **Leave Lobby:** Return to lobby from any state (Leave Lobby button)
- **Toggle Lobby:** Quick access with L key

## 🏗️ **Technical Architecture**

### **Server-Side Components**

#### **LobbyManager.lua**
- **Player Management:** Tracks lobby vs in-game players
- **Lobby Area Creation:** Dynamic lobby environment with viewing platform
- **Round State Tracking:** Manages active round status and timing
- **Teleportation:** Moves players between lobby and game areas
- **Remote Events:** Handles client-server communication

#### **Key Functions**
```lua
-- Player Management
addPlayerToLobby(player)     -- Add player to lobby
removePlayer(player)         -- Remove player from game
joinRound(player)           -- Move player to active round
spectateRound(player)       -- Move player to spectate mode

-- Round Management
setRoundActive(active)      -- Start/end round
clearLobby()               -- Reset lobby state
getLobbyData()             -- Get current lobby state
```

#### **Remote Events/Functions**
- `LobbyUpdateEvent` - Broadcast lobby state changes
- `PlayerJoinLobbyEvent` - Handle player lobby entry
- `PlayerLeaveLobbyEvent` - Handle player lobby exit
- `SpectateRoundEvent` - Handle spectate requests
- `JoinRoundEvent` - Handle round join requests
- `GetLobbyData` - Retrieve current lobby information

### **Client-Side Components**

#### **LobbyController.lua**
- **UI Creation:** Professional lobby interface with player lists
- **Real-time Updates:** Live data synchronization with server
- **Player Interaction:** Button handlers and key bindings
- **Visual Feedback:** Highlight current player, status indicators

#### **UI Components**
- **Main Lobby Frame:** 80% screen coverage with dark theme
- **Player Lists:** Separate sections for lobby and in-game players
- **Action Buttons:** Shop, Spectate, Join Round, Leave Lobby
- **Status Displays:** Round timer, player count, economy info
- **Balance Display:** Real-time currency updates

## 🎨 **Lobby Environment**

### **Physical Layout**
```
┌─────────────────────────────────────┐
│           LOBBY AREA                │
│  ┌─────────────────────────────┐    │
│  │                             │    │
│  │        VIEWING              │    │
│  │        PLATFORM             │    │
│  │    (Spectator Area)         │    │
│  │                             │    │
│  └─────────────────────────────┘    │
│                                     │
│    ┌─────────────┐                   │
│    │             │                   │
│    │   LOBBY     │                   │
│    │   FLOOR     │                   │
│    │             │                   │
│    └─────────────┘                   │
│                                     │
└─────────────────────────────────────┘
```

### **Lobby Features**
- **100x100 Unit Floor:** Spacious interaction area
- **Transparent Walls:** 80% transparency for visibility
- **Viewing Platform:** 40x40 unit elevated area at (0, 10, -30)
- **Spectator Text:** "SPECTATOR VIEW" display on platform
- **Safe Zone:** No combat or hazards in lobby area

## 🛒 **Integrated Systems**

### **Shop Integration**
- **Seamless Access:** Shop opens from lobby interface
- **Real-time Balance:** Currency updates reflect purchases
- **Inventory Display:** Owned items shown in lobby
- **Persistent Data:** Shop progress maintained between rounds

### **Economy Integration**
- **Currency Display:** Live balance in lobby interface
- **Earning Updates:** Credits earned during spectating
- **Purchase History:** Items remain available after purchase
- **Progress Tracking:** Economy progress visible to all players

### **Leaderboard Integration**
- **Live Updates:** Real-time score changes in lobby
- **Round History:** Previous round winners displayed
- **Player Status:** Current round participants shown
- **Spectator View:** Watch scores update during combat

## 🎯 **Gameplay Integration**

### **Round Progression**
1. **Lobby Phase:** Players interact, shop, prepare
2. **Voting Phase:** Map selection with lobby participation
3. **Round Start:** Active players teleport to map
4. **Spectator Mode:** Lobby players can watch from platform
5. **Round End:** All players return to lobby
6. **Intermission:** Brief pause before next cycle

### **Player Choice System**
- **Optional Participation:** No forced round joining
- **Flexible Spectating:** Join/leave spectating at will
- **Easy Access:** Simple controls for all actions
- **Clear Status:** Visual indicators for current state

### **Spectator Experience**
- **Elevated View:** Clear sightlines of combat area
- **Live Updates:** Real-time score and action updates
- **Safe Observation:** No risk of accidental participation
- **Strategic Learning:** Watch player tactics and strategies

## 🔧 **Configuration Options**

### **Timing Settings**
```lua
ROUND_DURATION = 120        -- 2 minutes per round
INTERMISSION_DURATION = 20  -- 20 seconds between rounds
LOBBY_SETUP_DELAY = 5       -- Brief pause for lobby initialization
```

### **UI Customization**
- **Color Schemes:** Configurable theme colors
- **Button Layout:** Adjustable button positioning
- **Font Sizes:** Scalable text for different resolutions
- **Transparency:** Customizable UI transparency levels

### **Lobby Environment**
- **Size Configuration:** Adjustable lobby dimensions
- **Platform Height:** Configurable spectator elevation
- **Wall Transparency:** Adjustable visibility settings
- **Lighting:** Environment lighting controls

## 🚀 **Future Enhancement Opportunities**

### **Social Features**
- **Player Chat:** Text chat system for lobby communication
- **Friend System:** Friend lists and quick join functionality
- **Voice Chat:** Spatial audio for lobby interactions
- **Emotes:** Player expression and celebration system

### **Advanced Spectating**
- **Camera Controls:** Free camera movement for spectators
- **Player Tracking:** Follow specific players during combat
- **Replay System:** Recorded round playback
- **Statistics Display:** Detailed player performance metrics

### **Lobby Activities**
- **Mini-games:** Small activities during lobby phase
- **Training Mode:** Practice area with target dummies
- **Customization Station:** Preview skins and effects
- **Achievement Display:** Showcase player accomplishments

### **Enhanced UI**
- **3D Player Models:** Rotating character previews
- **Animated Backgrounds:** Dynamic lobby environment
- **Personalization:** Customizable player lobby profiles
- **Notification System:** Alerts for shop updates and events

## 🛡️ **Security and Performance**

### **Security Measures**
- **Server Validation:** All lobby actions validated server-side
- **Anti-Cheat:** Spectator mode prevents gameplay interference
- **Data Protection:** Player economy data secured
- **Access Control:** Proper permissions for lobby actions

### **Performance Optimization**
- **Efficient Updates:** Minimal network traffic for lobby data
- **UI Optimization:** Smooth interface with low resource usage
- **Memory Management:** Proper cleanup of lobby objects
- **Scalability:** Supports large player counts efficiently

## 📊 **Player Experience Metrics**

### **Engagement Features**
- **Low Barrier Entry:** Easy lobby access and navigation
- **Clear Objectives:** Obvious actions and available choices
- **Reward Systems:** Currency and progression visible
- **Social Interaction:** Multiple ways to engage with other players

### **Accessibility**
- **Simple Controls:** Intuitive key bindings and buttons
- **Clear Feedback:** Visual and audio confirmation of actions
- **Status Indicators:** Obvious player state representation
- **Help System:** Tooltips and instructions for new players

This lobby system transforms PolyStrike Arena from a simple shooter into a comprehensive social gaming experience, providing players with meaningful activities before, during, and after each round while maintaining the fast-paced action that defines the game.