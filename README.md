# Rag's LuAshitacast

A combined LuAshitacast for HorizonXI that was originally based off of https://github.com/GetAwayCoxn/Luashitacast-Profiles

These luas were originally written for RDM and BLM however all jobs can use the corresponding templates to automatically implement functionality that is shared across all jobs.

- e.g. All jobs are able to type /fres which will automatically swap your idle gear sets to the Fire Resist set.
- e.g. All melee jobs are able to type /tp to switch between Low Accuracy and High Accuracy TP sets.
- e.g. All mage jobs are able to type /mode to switch between Magic Potency vs Magic Accuracy sets.

A WHM and WAR template is also provided that demonstrates an example for mage and melee jobs that could be copied and renamed to the correct job.

# How to Use

- Download the entire directory From Code > Download ZIP.
- Paste the contents of the luashitacast-master folder into ..\Game\config\addons\luashitacast\
- Rename the Rag_5040 folder to [Your_Character_Name]_[Your_Character_ID]
- Edit Equipment Sets in [JOB].lua. You may delete any of these if you're only looking for a lua one of the jobs.
- Edit Elemental Staves (NQ vs HQ), Obis and some conditional gear in gcmage.lua (or gcmelee.lua for melee jobs).
- Turn On / Off Additional Commands and Logging in gcincluderag.lua.
- The midcast delay assumes you use the PacketFlow plugin. If you don't use PacketFlow, adjust the value in gcmage.lua (or gcmelee.lua for melee jobs).

- If you define a specific mainhand in regular sets, it will still equip the correct stave if you have them listed in gcmage.lua
- FallbackSub set is used only if you wish to define a Sub to fall back to using due to not having a complete set of Elemental Staves.

## Default Commands:
```
[Regular Toggles]
/lock   - locks or unlocks all equipment.
/kite   - toggles Kite set on/off.
          /kite always takes precedence over any other set overrides active.
          e.g. if you have /kite and /fireres toggled on,
          it will equip the kite set instead of or on top of the fire resistance set.
          this allows you to gain 12% move speed while keeping up most of your fire resistance.

[Idle Sets] (Changes your idle set to use these sets instead)
/idle           - toggles between using 2 different idle sets
                  i.e. Normal and Alternate / Idle and IdleALT.
/dt             - toggles DT set on/off.
/mdt            - toggles MDT set on/off.
/iceres /ires   - toggles Ice Resistance set on/off.
/fireres /fres  - toggles Fire Resistance set on/off.
/earthres /eres - toggles Earth Resistance set on/off.
/windres /wres  - toggles Wind Resistance set on/off.
/lightningres /lres /thunderres /tres - toggles Lightning Resistance set on/off.
/evasion        - toggles Evasion set on/off.
                  you could also use this set for counter sets on MNK or other special sets.

[Special Commands]
/warpme           - equips a warp cudgel and uses it after 30 seconds and locks equipment.
                    use /lock to unlock again.
/lockset [number] - equips the given lockset and locks equipment
                    use /lock to unlock again.
```

# Additional Commands for All Mage Jobs:
```
/addmp [number] - adds a set amount of MP to decide usage of the IdleMaxMP set.
                  this can be used when eating food or for other +MP effects.
                  type /addmp without a number to display the current value.
/setmp [number] - sets the mp at which your idle sets will automatically transition
                  to using your IdleMaxMP set.
                  this will override the values defined for /NIN /WHM /RDM /BLM as well.
                  /addmp will still work as per normal in conjunction with this.
                  type /setmp without a number to display the current value.
/oor            - forces use of Master Caster Bracelets / Republican Gold Medal.
                  you can toggle this on when you are in areas where these are active.
/mode           - toggles Elemental & Enfeebling Magic between Potency (Normal) and Accuracy sets.
```

# Additional Commands for All Melee Jobs:
```
/tpset /tp - toggles TP set between a LowAcc and HighAcc set.
             this will be overwritten if you have a DT or Fire Resistance etc. set enabled.
             this is disabled for PLD in favour of just always using Idle sets instead.
```

## Additional Commands for RDM:
```
[Regular Toggles]
/hate   - causes your cures, sleeps, blinds, dispels and binds to equip +enmity set on cast.
/fight  - used to turn off TP set.
          this is automatically used for you when disengaging if your TP is 0.

[Special Sets]
/vert   - equips the Convert set and locks equipment.
          use /lock to unlock again.
/csstun - equips the Stun set and locks equipment (For Chainspell Stunning).
          use /lock to unlock again.
```

## Additional Commands for BLM:
```
[Regular Toggles]
/yellow - equips gear to lower HP before finishing casts to trigger Sorcerer's Ring.
          This is on by default.
/mb     - equips gear that gives bonuses to magic burst damage when casting nukes.
```

## Keybinds:

This LuAshitacast binds the following:
```
[All Jobs]
Alt+F1 - Fire Res
Alt+F2 - Kite
Alt+F3 - DT
Alt+F4 - MDT

[Mages]
F9  - Stun
F10 - Dia

You can use "/rebind XYZ" to bind Alt+F1 to a different set.
e.g. /rebind tres will rebind Alt+F1 to lightning resistance.
```

## Additional Commands (Shorterhand):

If you enable the Shorterhand setting in gcincluderag.lua, additional /commands will work.

- shorterhand.lua is effectively just a pass through to shorthand you can define your own /commands in
- using shorthand syntax like 'me' or partial names will work. e.g. "/i me" will cast invisible on yourself.

```
[All Jobs]
/u1 - Utusemi: Ichi
/u2 - Utsusemi: Ni
/ichi - Utusemi: Ichi
/ni   - Utsusemi: Ni

[Mages]
/c4 - Cure IV
/c3 - Cure III
/c2 - Cure II
/c  - Cure
/i  - Invisible
/s  - Sneak
/ss - Stoneskin
/b  - Blink
/a  - Aquaveil
```

## Additional Notes

LuAshitacast provides functionality to automatically equip Level Sync gear.

This LuAshitacast intentionally does NOT make use of this functionality to make it easier for first time users to be able to copy paste their own gear sets in place of mine.
