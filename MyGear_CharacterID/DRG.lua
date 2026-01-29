local profile = {}

local fastCastValue = 0.00 -- 0% from gear listed in Precast set

local max_hp_in_idle_with_regen_gear_equipped = 0 -- You could set this to 0 if you do not wish to ever use regen gear

local heal_hp_threshold_whm = 859
local heal_hp_threshold_rdm = 869

-- Comment out the equipment within these sets if you do not have them or do not wish to use them
local ethereal_earring = {
    -- Ear2 = 'Ethereal Earring',
}
local warlocks_mantle = { -- Don't add 2% to fastCastValue for this as it is SJ dependant
    -- Back = 'Warlock\'s Mantle',
}

local sets = {
    Idle_Priority = {
        Main =  { 'Orichalcum Lance', 'Gnd.Kgt. Lance', 'Mythril Lance +1', 'Peregrine', 'Ryl.Sqr. Halbred', 'Fuscina' },
        --Main =  { 'Bourdonasse' },
        Ammo =  { 'Tiphia Sting', 'Civet Sachet', 'Happy Egg' },
        Head =  { 'Homam Zucchetto', 'Wyvern Helm', 'Walkure Mask', 'Empress Hairpin', 'Ryl.Ftm. Bandana' },
        Neck =  { 'Love Torque', 'Peacock Amulet', 'Spike Necklace', 'Wing Pendant' },
        Ear1 =  { 'Brutal Earring', 'Merman\'s Earring', 'Spike Earring', 'Beetle Earring +1', 'Bone Earring +1' },
        Ear2 =  { 'Beastly Earring', 'Merman\'s Earring', 'Spike Earring', 'Beetle Earring +1', 'Bone Earring +1' },
        Body =  { 'Drachen Mail', 'Scorpion Harness', 'Brigandine', 'Mrc.Cpt. Doublet', 'Beetle Harness +1', 'Bone Harness +1' },
        Hands = { 'Homam Manopolas', 'Drachen Fng. Gnt.', 'Battle Gloves' },
        Ring1 = { 'Toreador\'s Ring', 'Woodsman Ring', 'Venerer Ring', 'Balance Ring +1' },
        Ring2 = { 'Rajas Ring', 'Balance Ring +1' },
        Back =  { 'Amemet Mantle +1', 'Nomad\'s Mantle', 'Traveler\'s Mantle' },
        Waist = { 'Swift Belt', 'Life Belt', 'Tilt Belt', 'Brave Belt', 'Warrior\'s Belt' },
        Legs =  { 'Homam Cosciales', 'Drachen Brais', 'Republic Subligar', 'Bone Subligar +1' },
        Feet =  { 'Homam Gambieras', 'Crimson Greaves', 'Bounding Boots' },
    },
    IdleALT = {},
    Resting = {},
    Town = {},
    Movement = {},
    Movement_TP = {},

    DT = {},
    MDT = {},
    FireRes = {},
    IceRes = {},
    LightningRes = {},
    EarthRes = {},
    WindRes = {},
    WaterRes = {},
    Evasion = {},

    Precast = {},
    SIRD = { -- Only used for Idle sets and not while Override sets are active
    },
    Haste = { -- Used for Utsusemi cooldown
    },

    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},

    TP_LowAcc = {
        Ammo = 'Tiphia Sting',
        Head = 'Homam Zucchetto',
        Neck = 'Love Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Scorpion Harness',
        Hands = 'Homam Manopolas',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Swift Belt',
        Legs = 'Homam Cosciales',
        Feet = 'Homam Gambieras',
    },
    TP_Aftermath = {},
    TP_Mjollnir_Haste = {},
    TP_HighAcc = {
        Ammo = 'Tiphia Sting',
        Head = 'Homam Zucchetto',
        Neck = 'Love Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Scorpion Harness',
        Hands = 'Homam Manopolas',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Swift Belt',
        Legs = 'Homam Cosciales',
        Feet = 'Homam Gambieras',
    },

    -- throw on everything that has HP+  Listed items will be best HP gear 
    MaxHP = {
        --Ammo = 'Happy Egg',
          Head = 'Drachen Armet', --Head = 'Drn. Armet +1', -- A Defensive wyvern will use Healing Breath when HP is at 50% or less.
        --Neck = 'Shield Pendant', --Neck = 'Ajase Beads', 
        --Ear1 = 'Ethereal Earring', -- cassie earring hp +50
        --Ear2 = 'Loquac. Earring', -- bloodbead earring hp +25
        --Body = 'Homam Corazza',-- carnage aketon hp+85
        --Hands = 'Homam Manopolas', -- Alkyoneus's Bracelets hp+40
        --Ring1 = 'Bomb Queen Ring', -- Bomb Queen Ring hp+75
        --Ring2 = 'Victory Ring', -- bloodbead ring hp+50
        --Back = 'Gigant Mantle', -- Gigant Mantle hp+80
        --Waist = 'Powerful Rope', -- Forest Sash hp+30
        --Legs = 'Drachen Brais', --Legs = 'Homam Cosciales', -- (wyvern hp+10%)
        --Feet = 'Homam Gambieras', -- Homam Gambieras hp+31 
    },

    -- Heal / Steady Wing based on WyvMaxHP
    BreathBonus = {
        Head = 'Drachen Armet', --Head = 'Wym. Armet +1', -- +66.7% Healing Breath bonus
        Body = 'Wyvern Mail', -- (wyvern hp+10%)
      --Hands = 'Ostreger Mitts', -- (wyvern hp+10) 
        Legs = 'Drachen Brais', --Legs = 'Drn. Brais +1', -- (wyvern hp+15%)
        Feet = 'Homam Gambieras', -- (wyvern hp+50)
    },

    -- For Damage Bonus when /DD, only helm
    BreathBonus_NonMage = {
        Head = 'Drachen Armet', --Head = 'Wym. Armet +1', -- Elemental Breath roughly a 16.5% increase.
    },

    Stoneskin = {},

    ['Ancient Circle'] = {
        Legs = 'Drachen Brais', --Legs = 'Drn. Brais +1',
    },

    ['Jump'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Love Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Scorpion Harness',  --Body = 'Homam Corazza', -- use Homam body for the +1% trip att. when that procs you can almost instantly ws.  
        Hands = 'Hecatomb Mittens',
        Ring1 = 'Toreador\'s Ring', --can swap in Dex+5 ring as well for slightly less acc but +2-3% crit to do dex modifier 
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Wyrm Belt',        --Waist = 'Warwolf Belt', -- Why? Sacrifice ACC for ATK?
        Legs = 'Barone Cosciales',  --Legs = 'Drn. Brais +1', -- not a bad choice. can use Drachen legs +1(acc +9) if you need more acc. 
        Feet = 'Drachen Greaves',   --Feet = 'Drn. Greaves +1', -- upgrade to the +1's(dex +5, enhances jump attack bonus from 10 to 15)
    },
    ['Jump Accuracy'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Love Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Scorpion Harness',
        Hands = 'Hecatomb Mittens',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Wyrm Belt',
        Legs = 'Barone Cosciales',
        Feet = 'Drachen Greaves',
    },

    ['High Jump'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Love Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Scorpion Harness',  --Body = 'Homam Corazza', -- use Homam body for the +1% trip att. when that procs you can almost instantly ws.  
        Hands = 'Hecatomb Mittens',
        Ring1 = 'Toreador\'s Ring',  -- upgrade to vaulter's ring(+10% att when high jump)
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Wyrm Belt',        --Waist = 'Warwolf Belt', -- Why? Sacrifice ACC for ATK?
        Legs = 'Wyrm Brais',  --Legs = 'Wym. Brais +1', -- good piece. other choice is Wyrm brais(enmity shead increased from 50% to 60%)
        Feet = 'Crimson Greaves',    --Feet = 'Hct. Leggings', -- Use anything with +att, +str, +dex. upgrade to hecatomb feet(str +6, Dex +3)
    },
    ['High Jump Accuracy'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Love Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Scorpion Harness',
        Hands = 'Hecatomb Mittens',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Wyrm Belt',   
        Legs = 'Wyrm Brais',
        Feet = 'Crimson Greaves',
    },

    ['Super Jump'] = {},

    ['Call Wyvern'] = {
        Body = 'Wyrm Mail',
    },

    ['Spirit Link'] = {
        Legs = 'Drachen Brais',   -- (wyvern hp+10%)
        Body = 'Wyvern Mail',     -- (wyvern hp+65)
      --Hands = 'Ostreger Mitts', -- (wyvern hp+10) 
        Legs = 'Drachen Brais',   -- (wyvern hp+10%) Legs = 'Drn. Brais +1', -- (wyvern hp+15%)
        Feet = 'Homam Gambieras', -- (wyvern hp+50)
    },

    WS = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Love Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Scorpion Harness',  --Body = 'Hecatomb Harness',
        Hands = 'Hecatomb Mittens',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Wyrm Belt',        --Waist = 'Warwolf Belt', -- Why? Sacrifice ACC for ATK?
        Legs = 'Drachen Brais',     --Legs = 'Drn. Brais +1',
        Feet = 'Drachen Greaves',
    },

    WS_HighAcc = {},

    -- Acc WS
    ['Penta Thrust'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Love Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Scorpion Harness',  --Body = 'Hecatomb Harness',
        Hands = 'Hecatomb Mittens',
        Ring1 = 'Toreador\'s Ring', --Ring1 = 'Victory Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Wyrm Belt',        --Waist = 'Warwolf Belt', -- Why? Sacrifice ACC for ATK?
        Legs = 'Drachen Brais',     --Legs = 'Drn. Brais +1',
        Feet = 'Crimson Greaves',    --Feet = 'Hct. Leggings',
    },

    -- STR WS
    ['Wheeling Thrust'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Light Gorget',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Drachen Mail',      --Body = 'Hecatomb Harness',
        Hands = 'Hecatomb Mittens',
        Ring1 = 'Victory Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',  --Back = 'Forager\'s Mantle',
        Waist = 'Warwolf Belt',
        Legs = 'Barone Cosciales',
      --Feet = 'Barone Gambieras',  --Feet = 'Hct. Leggings',
    },

    -- STR WS
    ['Impulse Drive'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Spike Necklace',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Drachen Mail',      --Body = 'Hecatomb Harness',
        Hands = 'Hecatomb Mittens',
        Ring1 = 'Victory Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Warwolf Belt',
        Legs = 'Barone Cosciales',
      --Feet = 'Barone Gambieras',  --Feet = 'Hct. Leggings',
    },

    -- STR WS
    ['Skewer'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Light Gorget',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Drachen Mail',      --Body = 'Hecatomb Harness',
        Hands = 'Hecatomb Mittens',
        Ring1 = 'Victory Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Warwolf Belt',
        Legs = 'Barone Cosciales',
      --Feet = 'Barone Gambieras',  --Feet = 'Hct. Leggings',
    },

    ['Geirskogul'] = {},

    Weapon_Loadout_1 = {},
    Weapon_Loadout_2 = {},
    Weapon_Loadout_3 = {
        Main = 'Bourdonasse'
    },
    
    LockStyle = {
        Main = 'Orichalcum Lance',
        -- Sub = '',
        -- Range = '',
        -- Ammo = '',
        Head =  'Homam Zucchetto',
        Body =  'Shep. Doublet',
        Hands = 'Homam Manopolas',
        Legs =  'Homam Cosciales',
        Feet =  'Homam Gambieras',
    },
}

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

gcmelee = gFunc.LoadFile('common\\gcmelee.lua')

sets.ethereal_earring = ethereal_earring
sets.warlocks_mantle = warlocks_mantle
profile.Sets = gcmelee.AppendSets(sets)

local JobAbilities = T{
    'Jump',
    'High Jump',
    'Super Jump',
    'Spirit Link',
    'Call Wyvern',
    'Ancient Circle',
}

local WeaponSkills = T{
    'Impulse Drive',
    'Wheeling Thrust',
    'Skewer',
    'Penta Thrust',
    'Geirskogul',
}

profile.HandleAbility = function()
    gcmelee.DoAbility()

    local action = gData.GetAction()
    if (action.Name == 'Steady Wing') then
        gFunc.EquipSet(sets.BreathBonus)
    elseif (JobAbilities:contains(action.Name)) then
        gFunc.EquipSet(sets[action.Name])
    end

    if (gcmelee.GetAccuracyMode() == 'HighAcc') then
        if (action.Name == 'Jump') then
            gFunc.EquipSet('Jump Accuracy')
        elseif (action.Name == 'High Jump') then
            gFunc.EquipSet('High Jump Accuracy')
        end
    end
end

profile.HandleItem = function()
    gcinclude.DoItem()
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    gcmelee.DoWS()

    local action = gData.GetAction()
    if (WeaponSkills:contains(action.Name)) then
      gFunc.EquipSet(sets[action.Name])
    end
end

profile.OnLoad = function()
    gcmelee.Load()
    profile.SetMacroBook()
    gFunc.LockStyle(profile.Sets.LockStyle);
end

profile.OnUnload = function()
    gcmelee.Unload()
end

profile.HandleCommand = function(args)
    gcmelee.DoCommands(args)

    if (args[1] == 'horizonmode') then
        profile.HandleDefault()
    end
end

profile.HandleDefault = function()
    local player = gData.GetPlayer()
    local myLevel = player.MainJobSync;

    if (myLevel ~= gcinclude.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        gcinclude.CurrentLevel = myLevel;
    end

    gcmelee.DoDefault(max_hp_in_idle_with_regen_gear_equipped)
    
    local isWHM = player.SubJob == 'WHM'
    local isRDM = player.SubJob == 'RDM'
    local isMage = isWHM or isRDM
    local weakened = gData.GetBuffCount('Weakness')

    if (isWHM and player.HP <= heal_hp_threshold_whm and weakened < 1) then
        gFunc.EquipSet(sets.DT)
    end
    if (isRDM and player.HP <= heal_hp_threshold_rdm and weakened < 1) then
        gFunc.EquipSet(sets.DT)
    end

    if (isMage) then
        gFunc.EquipSet('ethereal_earring')
    end

    gcmelee.DoDefaultOverride()

    local petAction = gData.GetPetAction()
    if (petAction ~= nil) then
        if (isMage) then
            gFunc.EquipSet(sets.BreathBonus)
        else
            gFunc.EquipSet(sets.BreathBonus_NonMage)
        end
        return
    end

    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer()
    if (player.SubJob == 'RDM' and warlocks_mantle.Back) then
        gcmelee.DoPrecast(fastCastValue + 0.02)
        gFunc.EquipSet('warlocks_mantle')
    else
        gcmelee.DoPrecast(fastCastValue)
    end
end

profile.HandleMidcast = function()
    gcmelee.DoMidcast(sets)

    local player = gData.GetPlayer()
    local action = gData.GetAction()
    if (player.SubJob == 'WHM' or player.SubJob == 'RDM') then
        if (action.Name == 'Stoneskin') then
            gFunc.EquipSet(sets.Stoneskin)
        else
            gFunc.EquipSet(sets.MaxHP)
        end
    end
end

return profile
