local profile = {}

local fastCastValue = 0.00 -- 0% from gear listed in Precast set. Note: Do NOT include cure clogs / ruckes rung here.

local ninSJMaxMP = nil -- The Max MP you have when /nin in your idle set
local rdmSJMaxMP = nil -- The Max MP you have when /rdm in your idle set
local blmSJMaxMP = nil -- The Max MP you have when /blm in your idle set

local sets = {
    Idle_Priority = {
        Main =  { 'Solid Wand', 'Yew Wand +1', 'Willow Wand +1' },
        Sub =   { 'Mahogany Shield', 'Parana Shield' },
        Ammo =  { 'Morion Tathlum', 'Happy Egg' },
        Head =  { 'Silver Hairpin', 'Brass Hairpin +1', 'Copper Hairpin +1' },
        Neck =  { 'Justice Badge' },
        Ear1 =  { 'Energy Earring' },
        Ear2 =  { 'Energy Earring' },
        Body =  { 'Baron\'s Saio', 'Ducal Aketon' },
        Hands = { 'Mycophile Cuffs', 'Baron\'s Cuffs', 'Mithran Gauntlets' },
        Ring1 = { 'Saintly Ring' },
        Ring2 = { 'Saintly Ring' },
        Back =  { 'Mist Silk Cape' },
        Waist = { 'Friar\'s Rope' },
        Legs =  { 'Savage Loincloth', 'Seer\'s Slacks', 'Windurstian Slops', 'Mithran Loincloth' },
        Feet =  { 'Seer\'s Pumps', 'Light Soleas', 'Mithran Gaiters' },
    },

    IdleALT = {},

    IdleMaxMP = {},

    Resting = {
        Main = 'Pilgrim\'s Wand',
        Body = 'Seer\'s Tunic',
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

    Cure = {
        Body = 'Baron\'s Saio',
        Ring1 = 'Saintly Ring',
        Ring2 = 'Saintly Ring',
    },

    Cure5 = {},

    Regen = {},

    Barspell = {},

    Cursna = {},

    Enhancing = {
        Body = 'Baron\'s Saio',
        Ring1 = 'Saintly Ring',
        Ring2 = 'Saintly Ring',
    },

    Stoneskin = {},

    Spikes = {},

    Enfeebling = {},

    EnfeeblingMND = {
        Body = 'Baron\'s Saio',
        Ring1 = 'Saintly Ring',
        Ring2 = 'Saintly Ring',
    },

    EnfeeblingINT = {
        Body = 'Baron\'s Saio',
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
    },

    EnfeeblingACC = {},

    Divine = {},

    Banish = {},

    Dark = {},

    Nuke = {},

    NukeACC = {},

    NukeDOT = {},

    TP = {},

    TP_NIN = {},

    WS = {},

    -- Custom Sets - Level Sync Sets For Example
    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},
}
profile.Sets = sets

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 23')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

gcmage = gFunc.LoadFile('common\\gcmage.lua')

profile.HandleAbility = function()
    -- You may add logic here
end

profile.HandleItem = function()
    gcinclude.DoItem()
end

profile.HandlePreshot = function()
    -- You may add logic here
end

profile.HandleMidshot = function()
    -- You may add logic here
end

profile.HandleWeaponskill = function()
    gFunc.EquipSet(sets.WS)
    gcmage.DoFenrirsEarring()
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
    if (myLevel ~= gcinclude.CurrentLevel) then
        gFunc.EvaluateLevels(profile.Sets, myLevel);
        gcinclude.CurrentLevel = myLevel;
    end

    gcmage.DoDefault(ninSJMaxMP, nil, blmSJMaxMP, rdmSJMaxMP, nil)

    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))
end

profile.HandlePrecast = function()
    gcmage.DoPrecast(fastCastValue)
end

profile.HandleMidcast = function()
    gcmage.DoMidcast(sets, ninSJMaxMP, nil, blmSJMaxMP, rdmSJMaxMP, nil)

    local action = gData.GetAction()
    if (action.Skill == 'Enhancing Magic') then
        if (string.match(action.Name, 'Regen')) then
            gFunc.EquipSet('Regen')
        elseif (string.match(action.Name, 'Bar')) then
            gFunc.EquipSet('Barspell')
        end
    elseif (string.match(action.Name, 'Banish')) then
        gFunc.EquipSet('Banish')
    end
end

return profile
