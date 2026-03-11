# New Maps Documentation: Castle & Prison

This document provides comprehensive details about the two new detailed and complex maps added to PolyStrike Arena: the Medieval Castle and Maximum Security Prison.

## 🏰 **Castle Map - Medieval Fortress**

### **Theme & Atmosphere**
A grand medieval fortress with towering stone walls, imposing guard towers, and regal interior spaces. The map captures the essence of a bygone era with banners, torches, and royal architecture.

### **Map Dimensions**
- **Total Size:** 200x200 units
- **Floor Height:** 5 units (stone courtyard)
- **Wall Height:** 30 units (stone fortifications)
- **Tower Height:** 40 units (corner towers)

### **Key Features**

#### **1. Outer Fortifications**
- **Stone Walls:** 10-unit thick perimeter walls surrounding the entire map
- **Four Corner Towers:** Strategic high-ground positions with 40-unit height
- **Drawbridge Entrance:** Main southern entrance with wooden bridge
- **Moat:** Water hazard surrounding the castle (visual only)

#### **2. Interior Layout**
- **Central Keep:** 40x40 unit main tower in the center
- **Throne Room:** Interior space with royal throne and decor
- **Courtyard:** Open central area for combat
- **Interior Walls:** Cross-shaped wall layout dividing the courtyard

#### **3. Strategic Elements**
- **Archways:** Four 10x10 openings in interior walls for movement
- **High Ground Advantage:** Towers provide excellent vantage points
- **Cover Positions:** Multiple walls and structures for tactical positioning
- **Choke Points:** Drawbridge and archways create strategic bottlenecks

### **Spawn Points (12 Total)**
1. **-60, 5, -60** - Northwest courtyard
2. **60, 5, -60** - Northeast courtyard
3. **-60, 5, 60** - Southwest courtyard
4. **60, 5, 60** - Southeast courtyard
5. **0, 5, -80** - North entrance
6. **0, 5, 80** - South entrance (drawbridge)
7. **-80, 5, 0** - West entrance
8. **80, 5, 0** - East entrance
9. **0, 5, 0** - Center courtyard
10. **0, 25, 0** - Top of central keep
11. **-20, 5, -20** - Throne room entrance
12. **20, 5, 20** - Keep courtyard

### **Tactical Gameplay**
- **Vertical Combat:** Multiple elevation levels for strategic positioning
- **Long-Range Engagements:** Open sightlines across courtyard
- **Close-Quarters Combat:** Tight spaces in throne room and towers
- **Flanking Routes:** Multiple paths through archways and around walls

### **Visual Details**
- **Stone Textures:** Realistic brick materials for walls and towers
- **Medieval Decor:** Banners, torches, and royal furnishings
- **Atmospheric Lighting:** Torch flames and ambient lighting
- **Water Effects:** Moat with reflective, semi-transparent water

---

## ⛓️ **Prison Map - Maximum Security Facility**

### **Theme & Atmosphere**
A cold, industrial maximum security prison with concrete walls, steel barriers, and security infrastructure. The map emphasizes tactical gameplay with multiple building interiors and outdoor yard areas.

### **Map Dimensions**
- **Total Size:** 250x250 units
- **Floor Height:** 5 units (concrete surfaces)
- **Wall Height:** 40 units (security barriers)
- **Tower Height:** 50 units (guard towers)

### **Key Features**

#### **1. Security Infrastructure**
- **Perimeter Walls:** 15-unit thick concrete barriers
- **Four Guard Towers:** Corner towers with searchlights
- **Barbed Wire:** Decorative wire on all walls
- **Security Cameras:** Surveillance systems throughout

#### **2. Building Complex**
- **Administration Building:** 80x80 unit central structure
- **Cell Block:** 40x150 unit long narrow building
- **Exercise Yard:** 120x120 unit open area with facilities
- **Interior Walls:** Dividing walls within cell block

#### **3. Prison Facilities**
- **Basketball Court:** Hoop with pole and backboard
- **Weight Bench:** Prison exercise equipment
- **Cell Doors:** Gaps in cell block walls for access
- **Guard Posts:** Security positions in exercise yard

### **Spawn Points (15 Total)**
1. **-80, 5, -80** - Northwest corner
2. **80, 5, -80** - Northeast corner
3. **-80, 5, 80** - Southwest corner
4. **80, 5, 80** - Southeast corner
5. **0, 5, -100** - North entrance
6. **0, 5, 100** - South entrance
7. **-100, 5, 0** - West entrance
8. **100, 5, 0** - East entrance
9. **0, 5, 0** - Center yard
10. **-40, 5, 40** - Guard post area
11. **40, 5, 40** - Guard post area
12. **0, 15, -60** - Cell block entrance
13. **-20, 1, 50** - Basketball area
14. **20, 1, 45** - Weight bench area
15. **0, 25, 0** - Admin building roof

### **Tactical Gameplay**
- **Cover-Based Combat:** Multiple walls, posts, and structures
- **Indoor/Outdoor Transitions:** Movement between buildings and yard
- **Vertical Gameplay:** Multiple floor levels and roof access
- **Close-Quarters Combat:** Tight spaces in cell block and admin building

### **Visual Details**
- **Industrial Materials:** Concrete, metal, and steel textures
- **Security Elements:** Searchlights, cameras, and barbed wire
- **Prison Equipment:** Basketball hoop, weight bench, guard posts
- **Emergency Lighting:** Red emergency lights for atmosphere

---

## 🎮 **Gameplay Integration**

### **Map-Specific Strategies**

#### **Castle Map Strategies**
- **High Ground Control:** Use towers for sniping and observation
- **Center Control:** Dominate the courtyard for map control
- **Flanking Tactics:** Use archways for surprise attacks
- **Defensive Positions:** Use walls and throne room for defense

#### **Prison Map Strategies**
- **Cover Usage:** Utilize guard posts and walls for protection
- **Building Control:** Secure admin building and cell block interiors
- **Yard Dominance:** Control the exercise yard for open combat
- **Vertical Positioning:** Use admin building roof for vantage points

### **Weapon Effectiveness**

#### **Castle Map**
- **Sniper Rifle:** Excellent for tower-to-tower combat
- **Rocket Launcher:** Effective in open courtyard areas
- **Assault Rifle:** Balanced for most situations
- **Shotgun:** Powerful in throne room and tower interiors

#### **Prison Map**
- **Submachine Gun:** Ideal for close-quarters in buildings
- **Assault Rifle:** Versatile for yard and building combat
- **Shotgun:** Devastating in cell block corridors
- **Rifle:** Effective for long-range across yard

### **Enemy Behavior Adaptations**

#### **Castle Map**
- **Ranged Shooters:** Use towers for elevated attacks
- **Dodgers:** Navigate archways for hit-and-run tactics
- **Snipers:** Occupy corner towers for long-range combat
- **Tanks:** Charge across open courtyard areas

#### **Prison Map**
- **Healers:** Use admin building for safe healing
- **Kamikazes:** Rush through cell block corridors
- **Ranged Shooters:** Use guard posts for cover
- **Dodgers:** Navigate between yard obstacles

---

## 🏗️ **Technical Implementation**

### **Map Creation Features**
- **Modular Design:** Easy to modify and expand
- **Performance Optimized:** Efficient geometry and materials
- **Collision Detection:** Proper hit detection for all surfaces
- **Visual Hierarchy:** Clear visual distinction between areas

### **Integration Points**
- **LevelManager:** Automatically detected and loaded
- **Spawn System:** Strategic placement for balanced gameplay
- **Physics System:** Compatible with existing physics effects
- **Audio System:** Map-specific ambient sounds

### **Future Enhancement Opportunities**

#### **Castle Map**
- **Siege Weapons:** Catapult or trebuchet projectiles
- **Secret Passages:** Hidden tunnels or trapdoors
- **Dynamic Elements:** Drawbridge that can be raised/lowered
- **Weather Effects:** Rain or fog for atmosphere

#### **Prison Map**
- **Power Outages:** Temporary lighting failures
- **Alarm Systems:** Security lockdown mechanics
- **Escape Routes:** Hidden tunnels or ventilation shafts
- **Guard AI:** Non-combatant NPCs for immersion

---

## 📊 **Map Statistics**

### **Castle Map**
- **Total Objects:** 45+ structural elements
- **Spawn Points:** 12 strategic locations
- **Elevation Levels:** 4 different heights
- **Cover Positions:** 20+ tactical locations

### **Prison Map**
- **Total Objects:** 50+ structural elements
- **Spawn Points:** 15 strategic locations
- **Building Interiors:** 3 major structures
- **Cover Positions:** 25+ tactical locations

These two new maps significantly expand the tactical diversity of PolyStrike Arena, offering players vastly different combat experiences while maintaining the fast-paced action that defines the game. The Castle provides medieval siege warfare with verticality and open spaces, while the Prison offers tactical close-quarters combat with industrial cover and multiple building interiors.