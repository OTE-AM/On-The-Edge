Hero powers
===========
(list)

Tactical modules
----------------

### Repair module
* Technical: Only unitDef stuff

### Repair drone (self-repair)
* Description: create unit (commanded by base) which assist given Hero and repair him

### Reclaim module
* Technical: Only unitDef stuff

### Capture module (x)
### Teleport module
### Jumpjet
### Digger (for hide unit underground) (?)
### Terraformer (x)

Sensor-based tactical modules
-----------------------------

All modules listed here should be part of pre-game setup. Every player can pick only one.

* Cloak
* Jammer
* Radar
* Scope (better LOS) 
* Seismic sensor
* Stealth
* (Sonar)

Tactical attacks
----------------
### Napalm Airstrike
* Unit call napalm bomber airstrike which bombs given area with its powers

### Minefield
* Description: Unit spawn minefield of mines in selected area. Mines are close to surface, cost nothing to be hidden, but can be detected by radar.

### EMP mine
* Description: Unit spawn cloaked EMP mine in area which detonates few seconds after activation by enemy unit. Stealth

### Nuke mine
* Description: Unit spawn cloaked nuke mine in area which detonates few seconds after activation by enemy unit.

### Nuclear suprise!
* Description: unit comit suicidal attack which blows all around in nuclear strike. Unit itself is just partly damaged but rest around die in agony.

### Scout area
* Description: player sends aircraft to scout area. Aircraft is controled by base.

### Flying eye
* Description: there is Flying Eye unit, which is spawned near Hero and Player can control it. Eye die when all its energy its fuel is depleted

### Static eye
* Description: there is static camo camera giving LOS in given area. Number of camo cams is limited to level of Hero.

### (Bolid impact)
* Description: one huge asteroid is moved on collision course with planet and hit the ground

### Meteor rain
* Description: rock waterfall from skies

### Nanobots attack
* Description: Release dangerous cloud of nanobots, which will damage given target/s for some time + ministuns
* Counter: can be canceled by EMP pulse => all nanobots are dead
 
### Acid bomb
* Description: All units in area are slowly damaged by acid cloud. Damage remain damage is low for long time.
* Counter: if unit goes in water, acid is neutralized
* (Enhance: napalm or flametrower attack on affected unit spawn bonus damage effect)

### Bugs ward (thumper)
* Description: spawn few Spacebugs (or more Spacebugs on greater levels) which will fight on side of Hero, if he run away and not enemy is around, they follow him.

### Dust storm 
* Description: create Dust storm which makes everything in given range cloaked for limited time

Aura
----
### Command unit
* Description: units in range gets armor bonus or enemy gets armor decrease
* Technical: 2 events without conditions (one adding effect on units, second deleting units from list and canceling effect)

### Repair kit
* Description: units in range slowly "heal" themselves
* Technical: 2 events without conditions (one adding health to units, second deleting units from list)

### Learning module (x)
* Description: soldiers in range gets experience faster

### Loot bag
* Description: for every killed enemy in range you get small amount of metal

True eco
--------

### (+1)
* Description: increase production of robots in choosen factory (per same price)
* Technical: Only change some value in global settings (given factory spawn amount)

### Giants
* Description: in choosen factory Giant unit is made once per given time from this time (can be used multiple times)
* Technical: Only change some value in global settings (given factory spawn amount)
	
Weapons modules
---------------
* Laser
* Flamethrower
* Rapid-rocket salvo shooter
* Sniper rifle
* Rapid plasma machine gun
* Electric short range gun (slow)
* Kicker

Shield like modules
-------------------
* Scrambler for guided rockets
* Plasma deflector
