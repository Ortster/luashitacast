local profile = {}

local fastCastValue = 0.00 -- 20% from traits 22% from gear listed in Precast set

local ninSJMaxMP = nil -- The Max MP you have when /nin in your idle set
local whmSJMaxMP = 178 -- The Max MP you have when /whm in your idle set
local blmSJMaxMP = nil -- The Max MP you have when /blm in your idle set
local drkSJMaxMP = nil -- The Max MP you have when /drk in your idle set

local blue_cotehardie = false
local blue_cotehardie_plus_one = false
local dilation_ring = false
local dilation_ring_slot = 'Ring2'

local sets = {
    Idle_Priority = {
        Main =  { 'Solid Wand', 'Yew Wand +1', 'Willow Wand +1' },
        Sub =   { 'Mahogany Shield', 'Parana Shield' },
        Ammo =  { 'Morion Tathlum', 'Happy Egg' },
        Head =  { 'Silver Hairpin', 'Brass Hairpin +1', 'Copper Hairpin +1' },
        Neck =  { 'Justice Badge' },
        Ear1 =  { 'Energy Earring' },
        Ear2 =  { 'Energy Earring' },
        Body =  { 'Baron\'s Saio', 'Beetle Harness +1', 'Bone Harness +1', 'Ducal Aketon' },
        Hands = { 'Mycophile Cuffs', 'Baron\'s Cuffs', 'Battle Gloves' },
        Ring1 = { 'Eremite\'s Ring' },
        Ring2 = { 'Eremite\'s Ring' },
        Back =  { 'Mist Silk Cape' },
        Waist = { 'Friar\'s Rope' },
        Legs =  { 'Seer\'s Slacks', 'Windurstian Slops', 'Dream Pants +1' },
        Feet =  { 'Seer\'s Pumps', 'Light Soleas', 'Mithran Gaiters' },
    },

    IdleALT = {},

    IdleMaxMP = {},

    Resting = {
        Main = 'Pilgrim\'s Wand',
        Legs = 'Baron\'s Slops',
    },
    Town = {},

    Movement = {},

    DT = {},

    DTNight = {},

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

    -- Default Casting Equipment when using Idle sets
    Casting = {},

    -- Used on Stoneskin, Blink, Aquaveil and Utsusemi casts
    SIRD = {},

    -- Used only on Haste, Refresh, Blink and Utsusemi casts
    Haste = {},

    ConserveMP = {},

    -- Switches to this set when casting Sleep, Blind, Dispel and Bind if /hate is toggled on
    Hate = {},

    Cheat_C3HPDown = {},

    Cheat_C4HPDown = {},

    Cheat_HPUp = {},

    Cure = {
        Ring1 = 'Saintly Ring',
        Ring2 = 'Saintly Ring',
    },

    Cursna = {},

    Enhancing = {
        Ring1 = 'Saintly Ring',
        Ring2 = 'Saintly Ring',
    },

    Stoneskin = {},

    Spikes = {},

    Enfeebling = {},

    EnfeeblingMND = {
        Ring1 = 'Saintly Ring',
        Ring2 = 'Saintly Ring',
    },

    EnfeeblingINT = {
        Neck =  'Black Neckerchief',
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
    },

    EnfeeblingACC = {},

    -- Just using my Hate set here for Flash
    Divine = {},

    Dark = {},

    Nuke = {},

    NukeACC = {},

    NukeDOT = {},

    -- Type /vert to equip this set and /lock your gear at the same time.
    Convert = {},

    -- Out of Region Convert Set
    ConvertOOR = {},

    Stun = {},

    -- You can also type /csstun to equip this set and /lock your gear at the same time if you have a tinfoil hat.
    StunACC = {},

    TP = {},

    TP_HighAcc = {},

    TP_NIN = {},

    TP_Mjollnir_Haste = {},

    WS = {},

    WS_HighAcc = {},

    WS_Soil = {},

    WS_Evisceration = {},

    WS_Spirits = {},

    WS_Energy = {},

    -- Custom Sets - Level Sync Sets For Example
    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},
}
profile.Sets = sets

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 25')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')

    --AshitaCore:GetChatManager():QueueCommand(-1, '/bind F9 //dia')
    --AshitaCore:GetChatManager():QueueCommand(-1, '/bind F10 //stun')
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

gcmage = gFunc.LoadFile('common\\gcmage.lua')

profile.HandleAbility = function()
end

profile.HandleItem = function()
    gcinclude.DoItem()
end

profile.HandlePreshot = function()
end

profile.HandleMidshot = function()
end

profile.HandleWeaponskill = function()
    local action = gData.GetAction()

    gFunc.EquipSet(sets.WS)
    if (gcdisplay.GetCycle('TP') == 'HighAcc') then
        gFunc.EquipSet('WS_HighAcc')
    end
    gcmage.DoFenrirsEarring()

    if (action.Name == 'Savage Blade') or (action.Name == 'Vorpal Blade') or (action.Name == 'Swift Blade') then
        gFunc.EquipSet(sets.WS_Soil)
    end

    if (action.Name == 'Evisceration') then
        gFunc.EquipSet(sets.WS_Soil)
        gFunc.EquipSet(sets.Evisceration)
    end

    if (action.Name == 'Energy Drain') or (action.Name == 'Energy Steal') then
        gFunc.EquipSet(sets.WS_Energy)
    end

    if (action.Name == 'Spirits Within') then
        gFunc.EquipSet(sets.WS_Spirits)
    end
end

profile.OnLoad = function()
    gcmage.Load()
    profile.SetMacroBook()
end

profile.OnUnload = function()
    gcmage.Unload()
end

profile.HandleCommand = function(args)
    gcmage.DoCommands(args)

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

    gcmage.DoDefault(ninSJMaxMP, whmSJMaxMP, blmSJMaxMP, nil, drkSJMaxMP)

    local player = gData.GetPlayer()
    if (blue_cotehardie and player.MP <= 40) then
        gFunc.Equip('Body', 'Blue Cotehardie')
    end
    if (blue_cotehardie_plus_one and player.MP <= 50) then
        gFunc.Equip('Body', 'Blue Cotehard. +1')
    end

    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))
end

profile.HandlePrecast = function()
    gcmage.DoPrecast(fastCastValue)
end

profile.HandleMidcast = function()
    gcmage.DoMidcast(sets, ninSJMaxMP, whmSJMaxMP, blmSJMaxMP, nil, drkSJMaxMP)

    local action = gData.GetAction()
    if (dilation_ring) then -- Haste is technically MP inefficient but I prefer to just always use it anyway
        if (action.Name == 'Haste' or action.Name == 'Refresh') then
            gFunc.Equip(dilation_ring_slot, 'Dilation Ring')
        end
    end
end

return profile
