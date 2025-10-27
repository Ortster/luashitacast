local profile = {}

local max_hp_in_idle_with_regen_gear_equipped = 1632
local fastCastValue = 0.02 -- 2% from gear

-- Replace these with '' if you do not have them
local temple_gaiters = 'Temple Gaiters'
local temple_gloves = 'Temple Gloves'
local temple_cyclas = 'Tpl. Cyclas +1'
local temple_crown = 'Tpl. Crown +1'

local melee_gaiters = 'Melee Gaiters'
local melee_gloves = 'Mel. Gloves +1'

local muscle_belt = 'Muscle Belt +1'
local garden_bangles = 'Garden Bangles'
local presidential_hairpin = false
local dream_ribbon = true

local kampfer_ring = true
local kampfer_ring_slot = 'Ring2'
local kampfer_earring = true
local kampfer_earring_slot = 'Ear2'

local sets = {
    Idle = {
        Ammo = 'Tiphia Sting',
        Head = 'Genbu\'s Kabuto',
        Neck = 'Jeweled Collar +1',
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Mel. Cyclas +1',
        Hands = 'Dst. Mittens +1',
        Ring1 = 'Shadow Ring',
        Ring2 = 'Sattva Ring',
        Back = 'Shadow Mantle',
        Waist = 'Warwolf Belt',
        Legs = 'Dst. Subligar +1',
        Feet = 'Dst. Leggings +1',
    },
    IdleALT = {},
    Resting = {
        Neck = 'Paisley Scarf',
        Ear2 = 'Sanative Earring',
        Body = 'Mel. Cyclas +1',
        Hands = 'Dst. Mittens +1',
        Back = 'Melee Cape',
        Feet = 'Dst. Leggings +1',
    },
    Town = {
        Head = 'Tpl. Crown +1',
        Body = 'Kirin\'s Osode',
        Hands = 'Mel. Gloves +1',
        Legs = 'Byakko\'s Haidate',
        Feet = 'Melee Gaiters',
    },
    Movement = {
        Feet = 'Herald\'s Gaiters',
    },

    --[[
    8% Base
    5% Merits
    45% Counterstance
    5% Melee Gaiters
    ]]
    DT = {
        Main = 'Cross-Counters', -- 5
        Ammo = 'Fenrir\'s Stone',
        Head = 'Optical Hat',
        Neck = 'Faith Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Merman\'s Earring',
        -- Ear1 = 'Avenger\'s Earring', -- 1
        -- Ear2 = 'Avenger\'s Earring', -- 1
        Body = 'Scp. Harness +1',
        Hands = 'Mel. Gloves +1',
        -- Hands = 'Rasetsu Tekko +1', -- 1
        -- Hands = 'Noritsune Kote',
        Ring1 = 'Sattva Ring',
        Ring2 = 'Toreador\'s Ring',
        Back = 'Shadow Mantle',
        Waist = 'Black Belt',
        Legs = 'Tpl. Hose +1', -- 3
        Feet = 'Rst. Sune-Ate +1', -- 1
    },
    MDT = { -- Shell IV provides 23% MDT
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Merman\'s Earring',
        Ring1 = 'Shadow Ring',
        Ring2 = 'Sattva Ring',
        Back = 'Resentment Cape',
    },
    FireRes = {},
    IceRes = {},
    LightningRes = {},
    EarthRes = {},
    WindRes = {},
    WaterRes = {},
    Evasion = { -- Currently using this as an override for BV2 Zergs
        Head = 'Maat\'s Cap',
        Neck = 'Faith Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Shura Togi',
        Hands = 'Mel. Gloves +1',
        Ring1 = 'Flame Ring',
        Ring2 = 'Triumph Ring',
        Back = 'Forager\'s Mantle',
        Waist = 'Black Belt',
        Legs = 'Shura Haidate',
        Feet = 'Dune Boots',
    },

    Precast = {
        Ear1 = 'Loquac. Earring',
    },
    SIRD = { -- Combination of PDT and SIRD Gear equipped while casting Utsusemi
        Neck = 'Willpower Torque', -- 5
        Ear1 = 'Merman\'s Earring',
        Ear2 = 'Magnetic Earring', -- 8
        Body = 'Dst. Harness +1',
        Hands = 'Dst. Mittens +1',
        Ring1 = 'Jelly Ring',
        Ring2 = 'Sattva Ring',
        Back = 'Shadow Mantle',
        Waist = 'Silver Obi +1', -- 8
        Legs = 'Dst. Subligar +1',
        Feet = 'Mountain Gaiters', -- 5
    },
    Haste = { -- Used for Utsusemi cooldown
        Head = 'Panther Mask +1',
        Waist = 'Black Belt',
        Legs = 'Byakko\'s Haidate',
        Feet = 'Fuma Sune-Ate',
    },

    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},

    TP_LowAcc = {
        Head = 'Panther Mask +1',
        Neck = 'Faith Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Kirin\'s Osode',
        Hands = 'Mel. Gloves +1',
        -- Ring1 = 'Toreador\'s Ring',
        Ring1 = 'Begrudging Ring',
        Ring2 = 'Toreador\'s Ring',
        Back = 'Forager\'s Mantle',
        Waist = 'Black Belt',
        Legs = 'Byakko\'s Haidate',
        Feet = 'Fuma Sune-Ate',
    },
    TP_Aftermath = {},
    TP_Mjollnir_Haste = {},
    TP_HighAcc = {
        Head = 'Maat\'s Cap',
        Body = 'Shura Togi',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Toreador\'s Ring',
    },
    TP_Focus = {
        Ring1 = 'Flame Ring',
        Ring2 = 'Triumph Ring',
    },

    SJ_DRG = {
        Ear2 = 'Wyvern Earring',
        Feet = 'Dune Boots',
    },
    SJ_THF = {
        Ear2 = 'Pilferer\'s Earring',
    },

    WS = {
        Head = 'Maat\'s Cap',
        Neck = 'Thunder Gorget',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Merman\'s Earring',
        Ring1 = 'Flame Ring',
        Ring2 = 'Triumph Ring',
        Legs = 'Shura Haidate',
        Feet = 'Shura Sune-Ate',
        Hands = 'Mel. Gloves +1',
        Back = 'Forager\'s Mantle',
        Waist = 'Black Belt',
    },
    WS_HighAcc = {
        -- Ring1 = 'Toreador\'s Ring',
        Ring1 = 'Begrudging Ring',
        Ring2 = 'Toreador\'s Ring',
    },

    WS_AsuranFists = {
        Neck = 'Faith Torque',
        Ear1 = 'Merman\'s Earring',
    },
    WS_DragonKick = {
        Legs = 'Byakko\'s Haidate',
        Feet = 'Dune Boots',
    },
    WS_HowlingFist = {
    },

    Jump = {
        Head = 'Genbu\'s Kabuto',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Robust Earring',
        Ring1 = 'Robust Ring',
        Ring2 = 'Sattva Ring',
        Back = 'Wyvern Mantle',
        Legs = 'Shura Haidate',
        Feet = 'Dune Boots',
    },
    Chakra = {
        Ammo = 'Happy Egg',
        Head = 'Genbu\'s Kabuto',
        Neck = 'Fortitude Torque',
        Ear1 = 'Robust Earring',
        Ear2 = 'Robust Earring',
        Body = 'Tpl. Cyclas +1',
        Ring1 = 'Robust Ring',
        Ring2 = 'Sattva Ring',
        Back = 'Melee Cape',
        Waist = 'Warwolf Belt',
        Legs = 'Mst. Sitabaki +1',
        Feet = 'Power sandals',
    },

    ChiBlast = {
        Head = 'Tpl. Crown +1',
        Neck = 'Faith Torque',
        Ear1 = 'Cmn. Earring',
        Ear2 = 'Cmn. Earring',
        Hands = 'Dvt. Mitts +1',
        Ring1 = 'Aqua Ring',
        Ring2 = 'Communion Ring',
        Back = 'Melee Cape',
        Legs = 'Tpl. Hose +1',
        Waist = 'Reverend Sash',
        Feet = 'Suzaku\'s Sune-Ate',
    },

    HundredFists = {
        Head = 'Maat\'s Cap',
        Neck = 'Faith Torque',
        Ear1 = 'Brutal Earring',
        Ear2 = 'Merman\'s Earring',
        Body = 'Shura Togi',
        Hands = 'Mel. Gloves +1',
        Ring1 = 'Toreador\'s Ring',
        Ring2 = 'Toreador\'s Ring',
        Back = 'Forager\'s Mantle',
        Waist = 'Black Belt',
        Legs = 'Shura Haidate',
        Feet = 'Dune Boots',
    },
}
profile.Sets = sets

profile.SetMacroBook = function()
    -- AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1')
    -- AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

gcmelee = gFunc.LoadFile('common\\gcmelee.lua')

profile.HandleAbility = function()
    local action = gData.GetAction()

    if string.match(action.Name, 'Jump') then
        gFunc.EquipSet(sets.Jump)
    elseif (action.Name == 'Chi Blast') then
        gFunc.EquipSet(sets.ChiBlast)
    elseif (action.Name == 'Chakra') then
        gFunc.EquipSet(sets.Chakra)
        if (temple_cyclas ~= '') then
            gFunc.Equip('Body', temple_cyclas)
        end
        if (melee_gloves ~= '') then
            gFunc.Equip('Hands', melee_gloves)
        end
    elseif (action.Name == 'Dodge') then
        if (temple_gaiters ~= '') then
            gFunc.Equip('Feet', temple_gaiters)
        end
    elseif (action.Name == 'Boost') then
        if (temple_gloves ~= '') then
            gFunc.Equip('Hands', temple_gloves)
        end
    elseif (action.Name == 'Focus') then
        if (temple_crown ~= '') then
            gFunc.Equip('Head', temple_crown)
        end
    elseif (action.Name == 'Counterstance') then
        if (melee_gaiters ~= '') then
            gFunc.Equip('Feet', melee_gaiters)
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
    local player = gData.GetPlayer()

    if (action.Name == 'Asuran Fists') then
        gFunc.EquipSet(sets.WS_AsuranFists)
    elseif (action.Name == 'Dragon Kick') then
        gFunc.EquipSet(sets.WS_DragonKick)
    elseif (action.Name == 'Howling Fist') then
        gFunc.EquipSet(sets.WS_HowlingFist)
    end

    if (player.SubJob == 'THF') then
        gFunc.EquipSet(sets.SJ_THF)
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
    gcmelee.DoDefault()

    local player = gData.GetPlayer()
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
        if (player.HPP < 50 and muscle_belt ~= '') then
            gFunc.Equip('Waist', muscle_belt)
        end
        if (player.HP < max_hp_in_idle_with_regen_gear_equipped) then
            local environment = gData.GetEnvironment()

            if (garden_bangles ~= '' and environment.Time >= 6 and environment.Time < 18) then
                gFunc.Equip('hands', garden_bangles)
            end
            if (presidential_hairpin and conquest:GetOutsideControl()) then
                gFunc.Equip('Head', 'President. Hairpin')
            end
            if (dream_ribbon) then
                gFunc.Equip('Head', 'Dream Ribbon')
            end
        end
    end

    gcmelee.DoDefaultOverride()

    if (gcdisplay.IdleSet == 'DT') then
        if (player.HPP <= 75 and player.TP <= 1000) then
            if (kampfer_ring) then
                gFunc.Equip(kampfer_ring_slot, 'Kampfer Ring')
            end
        end
        if (player.HPP <= 25 and player.TP <= 1000) then
            if (kampfer_earring) then
                gFunc.Equip(kampfer_earring_slot, 'Kampfer Earring')
            end
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
