local profile = {}

local fastCastValue = 0.00 -- 4% from gear listed in Precast set

local ninSJMaxMP = nil -- The Max MP you have when /nin in your idle set
local whmSJMaxMP = nil -- The Max MP you have when /whm in your idle set
local rdmSJMaxMP = nil -- The Max MP you have when /rdm in your idle set

local nukeExtraThreshold = 850 -- The minimum MP for which NukeExtra and StoneskinExtra set will be used instead of regular sets (to allow additional nukes using max mp sets)

local warlocks_mantle = false -- Don't add 2% to fastCastValue to this as it is SJ dependant
local republic_circlet = false

local opuntia_hoop = false
local opuntia_hoop_slot = 'Ring1'

local displayheadOnAbility = true

local sets = {
    Idle_Priority = {
        Main =  { 'Solid Wand', 'Yew Wand +1', 'Willow Wand +1' },
--      Sub =   {},
        Ammo =  { 'Morion Tathlum', 'Happy Egg' },
        Head =  { 'Seer\'s Crown +1', 'Silver Hairpin', 'Brass Hairpin +1', 'Copper Hairpin +1' },
        Neck =  { 'Black Neckerchief', 'Justice Badge' },
        Ear1 =  { 'Energy Earring' },
        Ear2 =  { 'Energy Earring' },
        Body =  { 'Seer\'s Tunic', 'Baron\'s Saio', 'Ducal Aketon' },
        Hands = { 'Mycophile Cuffs', 'Baron\'s Cuffs', 'Mithran Gauntlets' },
        Ring1 = { 'Eremite\'s Ring' },
        Ring2 = { 'Eremite\'s Ring' },
        Back =  { 'Mist Silk Cape' },
        Waist = { 'Friar\'s Rope' },
        Legs =  { 'Seer\'s Slacks', 'Windurstian Slops', 'Mithran Loincloth' },
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

    Casting = {},

    -- Used on Stoneskin, Blink, Aquaveil and Utsusemi casts
    SIRD = {},

    -- This will override Precast if /lag is turned on or the spell casting time is too short. e.g. Tier 1: "Stone"
    Yellow = {},

    YellowHNM = {},

    -- Used only on Haste, Refresh, Blink and Utsusemi casts
    Haste = {},

    ConserveMP = {},

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

    StoneskinExtra = {},

    Spikes = {},

    Enfeebling = {},

    EnfeeblingMND = {
        Body = 'Baron\'s Saio',
        Ring1 = 'Saintly Ring',
        Ring2 = 'Saintly Ring',
    },

    EnfeeblingINT = {
        Neck =  'Black Neckerchief',
        Body = 'Baron\'s Saio',
        Ring1 = 'Eremite\'s Ring',
        Ring2 = 'Eremite\'s Ring',
    },

    EnfeeblingACC = {},

    Divine = {},

    Dark = {},

    Stun = {},

    Nuke = {},

    NukeHNM = {},

    NukeACC = {},

    NukeDOT = {},

    NukeExtra = {},

    MB = {},

    -- Custom Sets - Level Sync Sets For Example
    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},
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

gcmage = gFunc.LoadFile('common\\gcmage.lua')

profile.HandleAbility = function()
    if (displayheadOnAbility) then
        AshitaCore:GetChatManager():QueueCommand(-1, '/displayhead')
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
end

profile.OnLoad = function()
    gcinclude.SetAlias(T{'extra'})
    gcdisplay.CreateToggle('Extra', false)
    gcmage.Load()
    profile.SetMacroBook()
end

profile.OnUnload = function()
    gcmage.Unload()
    gcinclude.ClearAlias(T{'extra'})
end

profile.HandleCommand = function(args)
    if (args[1] == 'extra') then
        gcdisplay.AdvanceToggle('Extra')
        gcinclude.Message('Extra', gcdisplay.GetToggle('Extra'))
    else
        gcmage.DoCommands(args, sets)
    end

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

    gcmage.DoDefault(ninSJMaxMP, whmSJMaxMP, nil, rdmSJMaxMP, nil)

    local spikes = gData.GetBuffCount('Blaze Spikes') + gData.GetBuffCount('Shock Spikes') + gData.GetBuffCount('Ice Spikes')
    local isPhysical = gcdisplay.IdleSet == 'Normal' or gcdisplay.IdleSet == 'Alternate' or gcdisplay.IdleSet == 'DT'
    if (opuntia_hoop and spikes > 0 and isPhysical) then
        gFunc.Equip(opuntia_hoop_slot, 'Opuntia Hoop')
    end

    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer()
    if (player.SubJob == 'RDM' and warlocks_mantle) then
        gcmage.DoPrecast(fastCastValue + 0.02)
        gFunc.Equip('Back', 'Warlock\'s Mantle')
    else
        gcmage.DoPrecast(fastCastValue)
    end
end

local ElementalDebuffs = T{ 'Burn','Rasp','Drown','Choke','Frost','Shock' }

profile.HandleMidcast = function()
    gcmage.DoMidcast(sets, ninSJMaxMP, whmSJMaxMP, nukeExtraThreshold, rdmSJMaxMP, nil)

    local player = gData.GetPlayer()
    local action = gData.GetAction()
    if (republic_circlet == true) then
        if (action.Skill == 'Elemental Magic' and gcdisplay.GetCycle('Mode') == 'Potency') then
            if (gcdisplay.GetToggle('Extra') and player.MP >= nukeExtraThreshold) then
                do return end
            end
            if (not ElementalDebuffs:contains(action.Name)) then
                if (conquest:GetInsideControl()) then
                    print(chat.header('GCMage'):append(chat.message('In Region - Using Republic Circlet')))
                    gFunc.Equip('Head', 'Republic Circlet')
                end
            end
        end
    end
end

return profile
