local profile = {}

local fastCastValue = 0.00 -- 0% from gear

local ethereal_earring = false
local ethereal_earring_slot = 'Ear2'

local warlocks_mantle = false -- Don't add 2% to fastCastValue to this as it is SJ dependant

local heal_hp_threshold_whm = 859
local heal_hp_threshold_rdm = 869

--[[
bourdonasse - blunt damage (skellingtons)
barone cosciales
Barone Corazza

ohat, dusk feet is probably the "smartest" order
warwolf belt
]]


local sets = {
    Idle_Priority = {
        Main =  { 'Orichalcum Lance', 'Gnd.Kgt. Lance', 'Mythril Lance +1', 'Peregrine', 'Ryl.Sqr. Halbred', 'Fuscina' },
--      Sub = '',
        Ammo =  { 'Tiphia Sting', 'Civet Sachet', 'Happy Egg' },
        Head =  { 'Wyvern Helm', 'Walkure Mask', 'Empress Hairpin', 'Ryl.Ftm. Bandana' },
        Neck =  { 'Peacock Amulet', 'Spike Necklace', 'Wing Pendant' },
        Ear1 =  { --[['Brutal Earring',]]'Merman\'s Earring', 'Spike Earring', 'Beetle Earring +1', 'Bone Earring +1' },
        Ear2 =  { 'Beastly Earring', 'Merman\'s Earring', 'Spike Earring', 'Beetle Earring +1', 'Bone Earring +1' },
        Body =  { 'Scorpion Harness', 'Brigandine', 'Mrc.Cpt. Doublet', 'Beetle Harness +1', 'Bone Harness +1' },
        Hands = { 'Drachen Fng. Gnt.', 'Battle Gloves' },
        Ring1 = { 'Toreador\'s Ring', 'Woodsman Ring', 'Venerer Ring', 'Balance Ring +1' },
        Ring2 = { 'Rajas Ring', 'Balance Ring +1' },
        Back =  { 'Amemet Mantle +1', 'Nomad\'s Mantle', 'Traveler\'s Mantle' },
        Waist = { 'Swift Belt', 'Life Belt', 'Tilt Belt', 'Brave Belt', 'Warrior\'s Belt' },
        Legs =  { 'Drachen Brais', 'Republic Subligar', 'Bone Subligar +1' },
        Feet =  { 'Bounding Boots' },
    },
    IdleALT = {},

    Resting = {
        --Ammo = 'Happy Egg',
      --Head = 'Darksteel Cap',
        --Neck = 'Peacock Amulet',
        --Ear1 = 'Spike Earring', -- get a Sanative earring(hp recovered while healing +4) 
       -- Ear2 = 'Beastly Earring',
      --Body = 'Barone Corazza',
      --Hands = 'Darksteel Mittens',
      --Ring1 = 'Victory Ring',
      --Ring2 = 'Victory Ring',
      --  Back = 'Amemet Mantle +1',
      --  Waist = 'Life Belt',
      --Legs = 'Darksteel Subligar',
      --  Feet = 'Dst. Leggings', -- use wyrm greaves(wyvern hp recovered while healing +6) to get your pets hp back faster when kneeling. 
    },

    Town = {},

    Movement = {},

    DT = {},

    -- Shell IV provides 23% MDT
    MDT = {},

    FireRes = {},

    IceRes = {},

    LightningRes = {},

    EarthRes = {},

    WindRes = {},

    WaterRes = {},

    Evasion = {},

    Precast = {},

    SIRD = {},

    -- Used for Utsusemi cooldown
    Haste = {},

    TP_LowAcc = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Peacock Amulet',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Scorpion Harness',
        Hands = 'Dusk Gloves',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Swift Belt',
        Legs = 'Drachen Brais',
        Feet = 'Bounding Boots',
    },

    TP_HighAcc = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Peacock Amulet',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Scorpion Harness',
        Hands = 'Dusk Gloves',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Swift Belt',
        Legs = 'Drachen Brais',
        Feet = 'Bounding Boots',
    },

    -- throw on everything that has HP+  Listed items will be best HP gear 
    MaxHP = {
        Ammo = 'Happy Egg',
        Head = 'Drachen Armet', -- A Defensive wyvern will use Healing Breath when HP is at 50% or less.
        --Neck = 'Ajase Beads',
        --Ear1 = 'Spike Earring', -- cassie earring hp +50
        --Ear2 = 'Spike Earring', -- bloodbead earring hp +25
        --Body = 'Drachen Mail', -- carnage aketon hp+85
        --Hands = 'Drachen Fng. Gnt.', -- Alkyoneus's Bracelets hp+40
        --Ring1 = 'Toreador\'s Ring', -- Bomb Queen Ring hp+75
        --Ring2 = 'Victory Ring', -- bloodbead ring hp+50
        --Back = 'Amemet Mantle +1', -- Gigant Mantle hp+80
        --Waist = 'Life Belt', -- Forest Sash hp+30
        Legs = 'Drachen Brais', -- (wyvern hp+10%)
        --Feet = 'Drachen Greaves', -- Homam Gambieras hp+31 
    },

    -- Heal / Steady Wing based on WyvMaxHP
    BreathBonus = {
        Head = 'Drachen Armet',
        Legs = 'Drachen Brais', -- (wyvern hp+10%)
      --Head = 'Wym. Armet +1', -- +66.7% Healing Breath bonus
      --Body = 'Wyvern Mail', -- (wyvern hp+65)
      --Hands = 'Ostreger Mitts', -- (wyvern hp+10) 
      --Legs = 'Drn. Brais +1', -- (wyvern hp+15%)
      --Feet = 'Homam Gambieras', -- (wyvern hp+50)
    },

    -- For Damage Bonus when /DD, only helm
    BreathBonus_NonMage = {
        Head = 'Drachen Armet',
      --Head = 'Wym. Armet +1', -- Elemental Breath roughly a 16.5% increase.
    },

    Stoneskin = {},

    -- Custom Sets - Level Sync Sets For Example
    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},

    ['Ancient Circle'] = {
        Legs = 'Drachen Brais',
    },
    
    ['Jump'] = {
        Ammo = 'Tiphia Sting', -- bis unless elvaan. RSE ammo str+2
        Head = 'Wyvern Helm',
        Neck = 'Peacock Amulet',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Scorpion Harness', -- use Homam body for the +1% trip att. when that procs you can almost instantly ws.  
        Hands = 'Dusk Gloves', -- any thing with +att, +str, +dex, +vit. upgrade to Hecatomb mittens(str +7, Dex +4) 
        Ring1 = 'Toreador\'s Ring', -- acc is good. throw in Rajas ring in a slot when you have it. can swap in Dex+5 ring as well for slightly less acc but +2-3% crit to do dex modifier 
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Life Belt', --swap to warwolf belt(str +5, Dex +5, Vit +5)
        Legs = 'Barone Cosciales', -- not a bad choice. can use Drachen legs +1(acc +9) if you need more acc. 
        Feet = 'Drachen Greaves', -- upgrade to the +1's(dex +5, enhances jump attack bonus from 10 to 15)
    },
    
    ['High Jump'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Peacock Amulet',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Scorpion Harness', -- use Homam body for the +1% trip att. when that procs you can almost instantly ws.  
        Hands = 'Dusk Gloves',
        Ring1 = 'Toreador\'s Ring', -- upgrade to vaulter's ring(+10% att when high jump)
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Life Belt', --swap to warwolf belt(str +5, Dex +5, Vit +5)
        Legs = 'Barone Cosciales', -- good piece. other choice is Wyrm brais(enmity shead increased from 50% to 60%)
        Feet = 'Bounding Boots', -- these only help jump and not high jump. Use anything with +att, +str, +dex. upgrade to hecatomb feet(str +6, Dex +3)
    },
    
    ['Super Jump'] = {},
    
    ['Call Wyvern'] = {
      --Body = 'Wyrm Mail',
    },
    
    ['Spirit Link'] = {
        Legs = 'Drachen Brais', -- (wyvern hp+10%)
      --Body = 'Wyvern Mail', -- (wyvern hp+65)
      --Hands = 'Ostreger Mitts', -- (wyvern hp+10) 
      --Legs = 'Drn. Brais +1', -- (wyvern hp+15%)
      --Feet = 'Homam Gambieras', -- (wyvern hp+50)
    },

    WS = {},
    WS_HighAcc = {},

    -- Acc WS
    ['Penta Thrust'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Peacock Amulet',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Scorpion Harness',
        Hands = 'Dusk Gloves',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
        Waist = 'Life Belt',
        Legs = 'Drachen Brais',
        Feet = 'Bounding Boots',
    },
    
    -- STR WS
    ['Wheeling Thrust'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Spike Necklace',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Drachen Mail',
        Hands = 'Dusk Gloves',
      --Ring1 = 'Victory Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
      --Waist = 'Warwolf Belt',
        Legs = 'Barone Cosciales',
      --Feet = 'Barone Gambieras',
    },
    
    -- STR WS
    ['Impulse Drive'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Spike Necklace',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Drachen Mail',
        Hands = 'Dusk Gloves',
      --Ring1 = 'Victory Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
      --Waist = 'Warwolf Belt',
        Legs = 'Barone Cosciales',
      --Feet = 'Barone Gambieras',
    },
    
    -- STR WS
    ['Skewer'] = {
        Ammo = 'Tiphia Sting',
        Head = 'Wyvern Helm',
        Neck = 'Spike Necklace',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Beastly Earring',
        Body = 'Drachen Mail',
        Hands = 'Dusk Gloves',
      --Ring1 = 'Victory Ring',
        Ring2 = 'Rajas Ring',
        Back = 'Amemet Mantle +1',
      --Waist = 'Warwolf Belt',
        Legs = 'Barone Cosciales',
      --Feet = 'Barone Gambieras',
    },
    
    ['Geirskogul'] = {
    },
}
profile.Sets = sets

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')
    AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 200');
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

gcmelee = gFunc.LoadFile('common\\gcmelee.lua')

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
    
    if (gcinclude.ManualLevel ~= nil) then
        myLevel = gcinclude.ManualLevel;
    end
    if (myLevel ~= gcinclude.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        gcinclude.CurrentLevel = myLevel;
    end

    gcmelee.DoDefault()
    
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

    if (ethereal_earring == true and isMage) then
        gFunc.Equip(ethereal_earring_slot, 'Ethereal Earring')
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
    if (player.SubJob == 'RDM' and warlocks_mantle) then
        gcmelee.DoPrecast(fastCastValue + 0.02)
        gFunc.Equip('Back', 'Warlock\'s Mantle')
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
