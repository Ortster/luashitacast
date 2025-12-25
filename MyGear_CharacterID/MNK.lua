local profile = {}

local max_hp_in_idle_with_regen_gear_equipped = 1632
local fastCastValue = 0.02 -- 2% from gear listed in Precast set

-- Comment out the equipment within these sets if you do not have them or do not wish to use them
local temple_gaiters = {
    Feet = 'Temple Gaiters',
}
local temple_gloves = {
    Hands = 'Temple Gloves',
}
local temple_cyclas = {
    Body = 'Temple Cyclas', -- Body = 'Tpl. Cyclas +1',
}
local temple_crown = {
    Head = 'Temple Crown', -- Head = 'Tpl. Crown +1',
}
local melee_gaiters = {
    -- Feet = 'Melee Gaiters',
}
local melee_gloves = {
    -- Hands = 'Mel. Gloves +1',
}
local muscle_belt = {
    -- Waist = 'Muscle Belt +1',
}
local garden_bangles = {
    -- Hands = 'Garden Bangles',
}
local presidential_hairpin = {
    -- Head = 'President. Hairpin',
}
local dream_ribbon = {
    -- Head = 'Dream Ribbon',
}
local kampfer_ring = {
    -- Ring2 = 'Kampfer Ring',
}
local kampfer_earring = {
    -- Ear2 = 'Kampfer Earring',
}

local sets = {
    Idle_Priority = {
        Main =  { 'T.M. Hooks +2', 'Tekko Kagi', 'Boreas Cesti', 'Fed. Baghnakhs' },
        Ammo =  { 'Tiphia Sting', 'Civet Sachet', 'Happy Egg' },
        Head =  { 'Temple Crown', 'Empress Hairpin', 'Cmp. Eye Circlet' },
        Neck =  { 'Peacock Amulet', 'Spike Necklace', 'Wing Pendant' },
        Ear1 =  { --[['Brutal Earring',]]'Merman\'s Earring', 'Spike Earring', 'Beetle Earring +1', 'Bone Earring +1' },
        Ear2 =  { 'Merman\'s Earring', 'Spike Earring', 'Beetle Earring +1', 'Bone Earring +1' },
        Body =  { 'Scorpion Harness', 'Mrc.Cpt. Doublet', 'Power Gi' },
        Hands = { 'Temple Gloves', 'Battle Gloves' },
        Ring1 = { 'Toreador\'s Ring', 'Woodsman Ring', 'Venerer Ring', 'Balance Ring +1' },
        Ring2 = { 'Rajas Ring', 'Balance Ring +1' },
        Back =  { 'Amemet Mantle +1', 'Nomad\'s Mantle', 'Traveler\'s Mantle' },
        Waist = { 'Brown Belt', 'Purple Belt' }, --'Black Belt' 
        Legs =  { 'Temple Hose', 'Republic Subligar', 'Bone Subligar +1' },
        Feet =  { 'Fed. Kyahan', 'Light Soleas' },
    },

    IdleALT = {},
    Resting = {
    },
    Town = {
    },
    Movement = {
    },

    --[[
    8% Base
    5% Merits
    45% Counterstance
    10% Melee Gaiters
    ]]
    DT = {
    },
    MDT = {
    },
    FireRes = {},
    IceRes = {},
    LightningRes = {},
    EarthRes = {},
    WindRes = {},
    WaterRes = {},
    Evasion = { -- Currently using this as an alternate HighAcc set for 2H Zergs. See README.md
    },

    Precast = {
    },
    SIRD = { -- Only used for Idle sets and not while Override sets are active
    },
    Haste = { -- Used for Utsusemi cooldown
    },

    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},

    TP_LowAcc = {
    },
    TP_Aftermath = {},
    TP_Mjollnir_Haste = {
    },
    TP_HighAcc = {
    },
    TP_Focus = {
    },

    SJ_DRG = {
    },
    SJ_THF = {
    },

    WS = {
    },
    WS_HighAcc = {
    },

    WS_AsuranFists = {
    },
    WS_DragonKick = {
    },
    WS_HowlingFist = {
    },

    Jump = {
    },
    Chakra = {
    },

    ChiBlast = {
    },

    HundredFists = {
    },

    Weapon_Loadout_1 = {
        Main = 'Destroyers',
    },
    Weapon_Loadout_2 = {
        Main = 'Cross-Counters',
    },
    Weapon_Loadout_3 = {
        Main = 'Faith Baghnakhs',
        Ammo = 'Virtue Stone',
    },
}

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 5')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')
    AshitaCore:GetChatManager():QueueCommand(1, '/lockstyleset 199');
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

gcmelee = gFunc.LoadFile('common\\gcmelee.lua')

sets.temple_gaiters = temple_gaiters
sets.temple_gloves = temple_gloves
sets.temple_cyclas = temple_cyclas
sets.temple_crown = temple_crown
sets.melee_gaiters = melee_gaiters
sets.melee_gloves = melee_gloves
sets.muscle_belt = muscle_belt
sets.garden_bangles = garden_bangles
sets.presidential_hairpin = presidential_hairpin
sets.dream_ribbon = dream_ribbon
sets.kampfer_ring = kampfer_ring
sets.kampfer_earring = kampfer_earring
profile.Sets = gcmelee.AppendSets(sets)

profile.HandleAbility = function()
    gcmelee.DoAbility()

    local action = gData.GetAction()

    if string.match(action.Name, 'Jump') then
        gFunc.EquipSet(sets.Jump)
    elseif (action.Name == 'Chi Blast') then
        gFunc.EquipSet(sets.ChiBlast)
    elseif (action.Name == 'Chakra') then
        gFunc.EquipSet(sets.Chakra)
        gFunc.EquipSet('temple_cyclas')
        gFunc.EquipSet('melee_gloves')
    elseif (action.Name == 'Dodge') then
        gFunc.EquipSet('temple_gaiters')
    elseif (action.Name == 'Boost') then
        gFunc.EquipSet('temple_gloves')
    elseif (action.Name == 'Focus') then
        gFunc.EquipSet('temple_crown')
    elseif (action.Name == 'Counterstance') then
        gFunc.EquipSet('melee_gaiters')
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
    local player = gData.GetPlayer()

    if (action.Name == 'Asuran Fists') then
        gFunc.EquipSet(sets.WS_AsuranFists)
    elseif (action.Name == 'Dragon Kick') then
        gFunc.EquipSet(sets.WS_DragonKick)
    elseif (action.Name == 'Howling Fist') then
        gFunc.EquipSet(sets.WS_HowlingFist)
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

    if (myLevel ~= gcinclude.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        gcinclude.CurrentLevel = myLevel;
    end

    gcmelee.DoDefault()

    local focus = gData.GetBuffCount('Focus')
    local hundredFists = gData.GetBuffCount('Hundred Fists')

    if (hundredFists == 1) then
        gFunc.EquipSet(sets.HundredFists)
    end

    if (focus == 1 and gcdisplay.IdleSet == 'LowAcc') then
        gFunc.EquipSet(sets.TP_Focus)
    end

    if (player.Status == 'Engaged') then
        if (player.SubJob == 'DRG') then
            gFunc.EquipSet(sets.SJ_DRG)
        elseif (player.SubJob == 'THF') then
            gFunc.EquipSet(sets.SJ_THF)
        end
    end

    if (player.Status == 'Idle') then
        if (player.HPP < 50) then
            gFunc.EquipSet('muscle_belt')
        end
        if (player.HP < max_hp_in_idle_with_regen_gear_equipped) then
            local environment = gData.GetEnvironment()
            if (environment.Time >= 6 and environment.Time < 18) then
                gFunc.EquipSet('garden_bangles')
            end
            if (conquest:GetOutsideControl()) then
                gFunc.EquipSet('presidential_hairpin')
            end
            gFunc.EquipSet('dream_ribbon')
        end
    end

    gcmelee.DoDefaultOverride()

    if (gcdisplay.IdleSet == 'DT') then
        if (player.HPP <= 75 and player.TP <= 1000) then
            gFunc.EquipSet('kampfer_ring')
        end
        if (player.HPP <= 25 and player.TP <= 1000) then
            gFunc.EquipSet('kampfer_earring')
        end
    end

    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))
end

profile.HandlePrecast = function()
    gcmelee.DoPrecast(fastCastValue)
end

profile.HandleMidcast = function()
    gcmelee.DoMidcast(sets)
end

return profile
