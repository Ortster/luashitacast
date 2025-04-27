local profile = {}

local max_hp_in_idle_with_regen_gear_equipped = 663
local fastCastValue = 0.00 -- 2% from gear

-- Replace these with '' if you do not have them
local temple_gaiters = '' -- 'Temple Gaiters'
local temple_gloves = '' -- 'Temple Gloves'
local temple_cyclas = '' -- 'Tpl. Cyclas +1'
local temple_crown = '' -- 'Tpl. Crown +1'

local melee_gaiters = '' -- 'Melee Gaiters'
local melee_gloves = '' -- 'Mel. Gloves +1'

local muscle_belt = ''
local garden_bangles = ''
local presidential_hairpin = false
local dream_ribbon = false

local kampfer_ring = false
local kampfer_ring_slot = 'Ring2'
local kampfer_earring = false
local kampfer_earring_slot = 'Ear2'

local sets = {
    Idle_Priority = {
        Main =  { 'Boreas Cesti', 'Fed. Baghnakhs' },
        Ammo =  { 'Civet Sachet', 'Happy Egg' },
        Head =  { 'Empress Hairpin', 'Cmp. Eye Circlet' },
        Neck =  { 'Spike Necklace', 'Wing Pendant' },
        Ear1 =  { 'Spike Earring', 'Beetle Earring +1', 'Bone Earring +1' },
        Ear2 =  { 'Spike Earring', 'Beetle Earring +1', 'Bone Earring +1' },
        Body =  { 'Mrc.Cpt. Doublet', 'Power Gi' },
        Hands = { 'Battle Gloves' },
        Ring1 = { 'Woodsman Ring', 'Deft Ring +1', 'Balance Ring +1' },
        Ring2 = { 'Woodsman Ring', 'Venerer Ring', 'Balance Ring +1' },
        Back =  { 'Amemet Mantle', 'Nomad\'s Mantle', 'Traveler\'s Mantle' },
        Waist = { 'Brown Belt', 'Purple Belt' },
        Legs =  { 'Republic Subligar', 'Bone Subligar +1' },
        Feet =  { 'Fed. Kyahan', 'Light Soleas' },
    },

    IdleALT = {},

    Resting = {},

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

    -- Currently using this as an override for BV2 Zergs
    Evasion = {},

    Precast = {},

    -- Combination of PDT and SIRD Gear equipped while casting Utsusemi
    SIRD = {},

    -- Used for Utsusemi cooldown
    Haste = {},

    TP_LowAcc = {},

    TP_HighAcc = {},

    TP_Mjollnir_Haste = {},

    TP_Focus = {},

    SJ_DRG = {},

    SJ_THF = {},

    WS = {},

    WS_HighAcc = {},

    WS_AsuranFists = {},


    WS_DragonKick = {},

    WS_HowlingFist = {},

    Jump = {},

    Chakra = {},

    ChiBlast = {},

    HundredFists = {},

    -- Custom Sets - Level Sync Sets For Example
    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},
}
profile.Sets = sets

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 5')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')
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

            if (muscle_belt ~= '') then
                gFunc.Equip('Waist', muscle_belt)
            end
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
