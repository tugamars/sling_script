# Sling Script
 FiveM weapon sling script
 Join my discord and find other cool scripts [here](https://discord.gg/U5GY4Cwepz)
 
# Description

This script allows players to sling their weapons to the back/front.

# Preview

You can see a preview of how this works [here](https://youtu.be/HwekOJofxxg)

# Features

- Allows to customize what weapons can be used (see config.lua)
- Allows to customize if a weapon can be used only in the back or if it can be used in the front too
- The command is configurable
- Keeps weapons attachaments on "unsling"
- Keeps weapons ammo on "unsling"
- Syncronized across network

# To-Do

- Adding weapons mag and attachaments to the object (currently i can't figure out a good way of doing it due to the coords)
- Adding keybinds to the script (currently clients can do it on their side using [console keybinds](https://cookbook.fivem.net/2020/01/06/using-the-new-console-key-bindings/)

# Config

The default config allows for the following weapons with all their components:
 - SMG
 - AR
 - Sniper Rifle (back only)
 - Heavy Sniper (back only)
 - Heavy Sniper Mk2 (back only)
 - Marksman rifle
 - Pump shotgun
 - Sawn-off shotgun
 - Marksman rifle MK2

You can add other weapons by finding their weapon hashes, component hashes and object names:
- [Weapon Hash](https://wiki.gtanet.work/index.php?title=Weapons_Models)
- [Component Hash](https://wiki.rage.mp/index.php?title=Weapons_Components)
- [Object list](http://gtahash.site/)

The "allowone" stands for if its allowed on the front or not. True = allowed, false = not allowed.


# Credits
This is based of [Scully's Sling Script](https://forum.cfx.re/t/standalone-law-enforcement-sling/1365649)

Indecision#7334 for helping me test and giving suggestions
