# Enhanced Monetization System Documentation

This document details the comprehensive economy and monetization system implemented in PolyStrike Arena, featuring player currency, in-game purchases, and cosmetic enhancements.

## 🏦 **Economy System Overview**

### **Currency: Credits**
- **Base Unit:** Credits (earned through gameplay)
- **Premium Currency:** Robux (real money purchases)
- **Starting Balance:** 100 credits for all new players

### **Earning Mechanisms**

#### **Damage-Based Rewards**
```lua
-- ScoreManager integration
function ScoreManager.addScore(player, amount)
    if scores[player.UserId] then
        scores[player.UserId] += amount
        
        -- Award money for damage dealt (1 credit per 10 damage)
        local moneyAwarded = math.floor(amount / 10)
        if moneyAwarded > 0 then
            EconomyManager.addMoney(player, moneyAwarded)
        end
    end
end
```

#### **Kill Bonuses**
```lua
-- EnemyController integration
local killReward = 0
if enemyTypeName == "MeleeZombie" then
    killReward = 20
elseif enemyTypeName == "RangedShooter" then
    killReward = 25
elseif enemyTypeName == "Dodger" then
    killReward = 30
elseif enemyTypeName == "Tank" then
    killReward = 50
elseif enemyTypeName == "Kamikaze" then
    killReward = 35
elseif enemyTypeName == "Healer" then
    killReward = 40
elseif enemyTypeName == "Sniper" then
    killReward = 45
end
```

## 🛒 **In-Game Shop System**

### **Shop Access**
- **Key Binding:** Press `B` to toggle shop interface
- **Real-time Updates:** Balance and inventory update instantly
- **Visual Interface:** Professional UI with item previews

### **Shop Categories**

#### **Weapon Skins (4 Items)**
| Item | Price | Description | Target Weapon |
|------|-------|-------------|---------------|
| Golden Pistol Skin | 500 credits | Make your pistol shine with this golden finish! | Pistol |
| Neon Rifle Skin | 750 credits | Give your assault rifle a cyberpunk glow! | Assault Rifle |
| Camo Shotgun Skin | 600 credits | Military-grade camouflage for your shotgun! | Shotgun |
| Plasma Rifle Skin | 800 credits | Futuristic plasma coating for your rifle! | Plasma Rifle |

#### **Kill Effects (4 Items)**
| Item | Price | Description | Effect Type |
|------|-------|-------------|-------------|
| Explosion Kill Effect | 1000 credits | Enemies explode in a fiery blast when you defeat them! | Explosion |
| Spark Rain Kill Effect | 800 credits | Victims rain down electric sparks when defeated! | Spark Rain |
| Confetti Kill Effect | 600 credits | Celebrate your victory with a confetti explosion! | Confetti |
| Ghost Kill Effect | 700 credits | Defeated enemies leave behind a spooky ghost! | Ghost |

#### **Currency Packs (4 Items)**
| Pack | Robux Price | Credits | Value |
|------|-------------|---------|-------|
| Small Currency Pack | 99 Robux | 1000 credits | 10 credits/Robux |
| Medium Currency Pack | 249 Robux | 2500 credits | 10 credits/Robux |
| Large Currency Pack | 499 Robux | 6000 credits | 12 credits/Robux |
| Mega Currency Pack | 999 Robux | 15000 credits | 15 credits/Robux |

## 🎮 **Player Experience Flow**

### **1. Earning Currency**
```lua
-- Players earn credits through:
-- - Dealing damage (1 credit per 10 damage)
-- - Defeating enemies (bonus credits per enemy type)
-- - Starting bonus (100 credits)

-- Example: Player deals 150 damage
ScoreManager.addScore(player, 150)
-- Result: Player receives 15 credits
```

### **2. Accessing Shop**
```lua
-- Player presses 'B' key
ShopController.toggleShop()
-- Shop interface opens with current balance
```

### **3. Making Purchases**
```lua
-- Player clicks "BUY" button on item
purchaseEvent:FireServer(item.id)
-- Server validates purchase and updates inventory
```

### **4. Using Purchased Items**
```lua
-- Weapon Skins: Automatically applied when switching to weapon
-- Kill Effects: Player can equip from shop interface
-- Currency Packs: Instant credit addition
```

## 🔧 **Technical Implementation**

### **Server-Side Components**

#### **EconomyManager.lua**
- **Player Balances:** Persistent storage of credit amounts
- **Inventory System:** Tracks owned skins and effects
- **Purchase Validation:** Ensures sufficient funds and prevents exploits
- **Robux Integration:** Handles premium currency purchases

#### **ScoreManager.lua Integration**
```lua
-- Enhanced to award currency alongside score
function ScoreManager.addScore(player, amount)
    -- Original scoring logic
    scores[player.UserId] += amount
    
    -- New: Currency award
    local moneyAwarded = math.floor(amount / 10)
    EconomyManager.addMoney(player, moneyAwarded)
end
```

#### **EnemyController.lua Integration**
```lua
-- Enhanced to award kill bonuses
humanoid.Died:Connect(function()
    -- Find killer
    local killer = creatorValue.Value
    
    -- Award kill bonus
    EconomyManager.addMoney(killer, killReward)
    
    -- Trigger kill effect
    showKillEffectEvent:FireClient(killer, rootPart.Position, enemyType.Behavior)
end)
```

### **Client-Side Components**

#### **ShopController.lua**
- **UI Creation:** Dynamic shop interface with scrolling items
- **Item Display:** Visual previews with descriptions and pricing
- **Purchase Handling:** Client-server communication for purchases
- **Inventory Management:** Real-time updates of owned items

#### **KillEffectsController.lua**
- **Effect System:** 5 different kill effect types
- **Visual Effects:** Particle systems and physics-based effects
- **Audio Integration:** Sound effects synchronized with visuals
- **Player Customization:** Equippable effects system

## 🎨 **Visual and Audio Features**

### **Kill Effects**

#### **Default Effect**
- Simple yellow sparks
- Basic feedback for uncustomized players

#### **Explosion Effect**
- Fire explosion with blast radius
- Particle effects and explosion sound
- 8-unit blast radius for environmental impact

#### **Spark Rain Effect**
- Electric blue particles falling from above
- Physics-based falling particles
- Electric sound effects

#### **Confetti Effect**
- Colorful confetti particles with physics
- Random velocities and colors
- Cheerful sound effects

#### **Ghost Effect**
- White, ethereal particle effects
- Spooky visual atmosphere
- Ghostly sound effects

### **Shop Interface**
- **Professional Design:** Clean, modern UI
- **Item Previews:** Visual representation of each item
- **Real-time Updates:** Balance and ownership status
- **Responsive Design:** Adapts to different screen sizes

## 🛡️ **Security and Anti-Cheat**

### **Server-Side Validation**
- All purchases validated on server
- Balance checks prevent negative spending
- Inventory updates only through server events

### **Client-Side Protection**
- No direct access to economy functions
- All actions routed through remote events/functions
- Visual feedback only, no actual economy manipulation

### **Data Persistence**
- Player balances stored in server memory
- Inventory data persists through sessions
- Automatic cleanup on player disconnect

## 📊 **Economic Balance**

### **Earning Rates**
- **Damage Rate:** 1 credit per 10 damage
- **Kill Bonuses:** 20-50 credits per enemy
- **Average Round Earnings:** 200-500 credits (depending on skill)

### **Pricing Strategy**
- **Entry Level:** 500-800 credits for basic items
- **Premium Items:** 1000 credits for high-impact effects
- **Value Scaling:** Higher-tier currency packs offer better value

### **Progression Curve**
- **Early Game:** Players can afford basic items quickly
- **Mid Game:** Premium items become accessible
- **Late Game:** Multiple purchases and customization options

## 🔌 **Integration Points**

### **Existing Systems Enhanced**
- **ScoreManager:** Now awards currency alongside points
- **EnemyController:** Now triggers kill rewards and effects
- **UIController:** Balance display in main interface
- **SoundManager:** New sound effects for shop and effects

### **New Systems Added**
- **EconomyManager:** Core economy and shop logic
- **ShopController:** Client-side shop interface
- **KillEffectsController:** Visual effects system

### **Remote Events/Functions**
- `GetShopItems`: Retrieve shop catalog
- `GetPlayerData`: Get balance and inventory
- `PurchaseEvent`: Process item purchases
- `EquipKillEffect`: Equip kill effects
- `ShowKillEffectEvent`: Trigger kill effects

## 🚀 **Future Enhancement Opportunities**

### **Additional Features**
- **Battle Pass System:** Seasonal progression with rewards
- **Daily Challenges:** Bonus currency for completing objectives
- **Trading System:** Player-to-player item trading
- **Limited Time Items:** Special event-exclusive cosmetics

### **Advanced Economy**
- **Player Rankings:** Leaderboards with economic data
- **Guild Systems:** Shared economy for teams
- **Marketplace:** Player-driven economy with item sales
- **Subscription Benefits:** Monthly perks and bonuses

### **Enhanced Visuals**
- **3D Item Previews:** Rotating 3D models in shop
- **Animated Effects:** Preview animations for effects
- **Customizable UI:** Player-customizable shop layouts
- **Achievement Displays:** Showcase rare items and accomplishments

This monetization system provides a robust, fair, and engaging economy that enhances player experience while maintaining game balance and preventing pay-to-win scenarios.