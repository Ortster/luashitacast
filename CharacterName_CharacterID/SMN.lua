local profile = {}

local fastCastValue = 0.00 -- 4% from gear not including carbuncles cuffs or evokers boots

local carbuncles_cuffs = false
local evokers_boots = false

local cureMP = 895 -- Cure set max MP

local sets = {
    Idle_Priority = {
        Main =  { 'Solid Wand', 'Yew Wand +1', 'Willow Wand +1', "Maple Wand +1" },
        Sub =   { 'Mahogany Shield', 'Parana Shield' },
        Ammo =  { 'Morion Tathlum', 'Happy Egg' },
        Head =  { 'Silver Hairpin', 'Brass Hairpin +1', 'Copper Hairpin +1' },
        Neck =  { 'Justice Badge' },
        Ear1 =  { 'Energy Earring' },
        Ear2 =  { 'Energy Earring' },
        Body =  { 'Seer\'s Tunic', 'Baron\'s Saio', 'Ducal Aketon' },
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

    Resting = {},

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

    Cure = {},

    Cursna = {},

    Enhancing = {},

    Stoneskin = {},

    Spikes = {},

    Enfeebling = {},

    EnfeeblingMND = {},

    EnfeeblingINT = {},

    EnfeeblingACC = {},

    Divine = {},

    Dark = {},

    Nuke = {},

    NukeACC = {},

    NukeDOT = {},

    -- Used only when you do not have complete staff sets
    FallbackSub = {},

    BP_Delay = {},

    BP = {},

    BP_Magical = {},

    BP_Physical = {},

    BP_Hybrid = {},

    -- Custom Sets - Level Sync Sets For Example
    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},
}
profile.Sets = sets

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 35')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')

    --AshitaCore:GetChatManager():QueueCommand(-1, '/bind F9 //dia')
    --AshitaCore:GetChatManager():QueueCommand(-1, '/bind F10 //dia')
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

local SmnSkill = T{'Shining Ruby','Glittering Ruby','Crimson Howl','Inferno Howl','Frost Armor','Crystal Blessing','Aerial Armor','Hastega II','Fleet Wind','Hastega','Earthen Ward','Earthen Armor','Rolling Thunder','Lightning Armor','Soothing Current','Ecliptic Growl','Heavenward Howl','Ecliptic Howl','Noctoshield','Dream Shroud','Altana\'s Favor','Reraise','Reraise II','Reraise III','Raise','Raise II','Raise III','Wind\'s Blessing'}
local SmnHealing = T{'Healing Ruby','Healing Ruby II','Whispering Wind','Spring Water'}
local SmnMagical = T{'Searing Light','Meteorite','Holy Mist','Inferno','Fire II','Fire IV','Meteor Strike','Conflag Strike','Diamond Dust','Blizzard II','Blizzard IV','Heavenly Strike','Aerial Blast','Aero II','Aero IV','Wind Blade','Earthen Fury','Stone II','Stone IV','Geocrush','Judgement Bolt','Thunder II','Thunder IV','Thunderstorm','Thunderspark','Tidal Wave','Water II','Water IV','Grand Fall','Howling Moon','Lunar Bay','Ruinous Omen','Somnolence','Nether Blast','Night Terror','Level ? Holy'}
local SmnEnfeebling = T{'Diamond Storm','Sleepga','Shock Squall','Slowga','Tidal Roar','Pavor Nocturnus','Ultimate Terror','Nightmare','Mewing Lullaby','Eerie Eye'}
local SmnHybrid = T{'Flaming Crush','Burning Strike'}

gcmage = gFunc.LoadFile('common\\gcmage.lua')

profile.HandleAbility = function()
    gcmage.DoAbility()
    gFunc.EquipSet('BP_Delay')
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
    -- You may add logic here
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

    local petAction = gData.GetPetAction()
    if (petAction ~= nil) then
        gFunc.EquipSet('BP')

        -- Era provides near zero gear options so almost all of these just default to the default BP set or Magical
        if (SmnSkill:contains(petAction.Name)) then
            -- Do Nothing
        elseif (SmnMagical:contains(petAction.Name)) then
            gFunc.EquipSet(sets.BP_Magical)
        elseif (SmnHybrid:contains(petAction.Name)) then
            gFunc.EquipSet(sets.BP_Hybrid)
        elseif (SmnHealing:contains(petAction.Name)) then
            -- Do Nothing
        elseif (SmnEnfeebling:contains(petAction.Name)) then
            gFunc.EquipSet(sets.BP_Magical)
        else
            gFunc.EquipSet(sets.BP_Physical)
        end
    else
        gcmage.DoDefault(nil, nil, nil, nil)
    end
    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))
end

profile.HandlePrecast = function()
    gcmage.DoPrecast(fastCastValue)

    local action = gData.GetAction()
    if (action.Skill == 'Summoning') then
        if (carbuncles_cuffs) then
            gFunc.Equip('Hands', 'Carbuncle\'s Cuffs')
        end
        if (evokers_boots) then
            gFunc.Equip('Feet', 'Evoker\'s Boots')
        end
    end
end

profile.HandleMidcast = function()
    gcmage.DoMidcast(sets, cureMP, cureMP, cureMP, cureMP)
end

return profile
