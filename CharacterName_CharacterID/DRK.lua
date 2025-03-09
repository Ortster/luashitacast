local profile = {}

local fastCastValue = 0.00 -- 7% from gear

local use_chaos_burgeonet_for_tp_during_souleater = false

local parade_gorget = false
local fenrirs_stone = false

-- Set to true if you have the obi
local karin_obi = false
local dorin_obi = false
local suirin_obi = false
local furin_obi = false
local hyorin_obi = false
local rairin_obi = false
local korin_obi = false
local anrin_obi = false

local sets = {
    Idle = {},

    IdleALT = {},

    IdleDT = {},

    IdleALTDT = {},

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

    -- Use this set for your zerg set. See README.md
    Evasion = {},

    Precast = {},

    SIRD = {},

    -- Used for Utsusemi and Stun cooldown
    Haste = {},

    Hate = {},

    TP_LowAcc = {},

    TP_HighAcc = {},

    TP_Mjollnir_Haste = {},

    WS = {},

    WS_HighAcc = {},

    WS_Guillotine = {},

    WS_SpinningSlash = {},

    WS_CrossReaper = {},

    WeaponBash = {},

    ArcaneCircle = {},

    SoulEater = {},

    Nuke = {},

    Enfeebling = {},

    Drain = {},

    Absorb = {},

    -- Custom Sets - Level Sync Sets For Example
    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},
}
profile.Sets = sets

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')

    --AshitaCore:GetChatManager():QueueCommand(-1, '/bind F9 //stun')
    --AshitaCore:GetChatManager():QueueCommand(-1, '/bind F10 //weaponbash')
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

gcmelee = gFunc.LoadFile('common\\gcmelee.lua')

local NukeObiTable = {
    ['Fire'] = 'Karin Obi',
    ['Earth'] = 'Dorin Obi',
    ['Water'] = 'Suirin Obi',
    ['Wind'] = 'Furin Obi',
    ['Ice'] = 'Hyorin Obi',
    ['Thunder'] = 'Rairin Obi',
    ['Light'] = 'Korin Obi',
    ['Dark'] = 'Anrin obi'
}

local NukeObiOwnedTable = {
    ['Fire'] = karin_obi,
    ['Earth'] = dorin_obi,
    ['Water'] = suirin_obi,
    ['Wind'] = furin_obi,
    ['Ice'] = hyorin_obi,
    ['Thunder'] = rairin_obi,
    ['Light'] = korin_obi,
    ['Dark'] = anrin_obi
}

profile.HandleAbility = function()
    local action = gData.GetAction()

    if (gcdisplay.GetToggle('Hate')) then
        gFunc.EquipSet(sets.Hate)
    end

    if (action.Name == 'Weapon Bash') then
        gFunc.EquipSet(sets.WeaponBash)
    elseif (action.Name == 'Arcane Circle') then
        gFunc.EquipSet(sets.ArcaneCircle)
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
    if (action.Name == 'Guillotine') then
        gFunc.EquipSet(sets.WS_Guillotine)
    elseif (action.Name == 'Spinning Slash') then
        gFunc.EquipSet(sets.WS_SpinningSlash)
    elseif (action.Name == 'Cross Reaper') then
        gFunc.EquipSet(sets.WS_CrossReaper)
    end

    local souleater = gData.GetBuffCount('Souleater')
    if (souleater > 0) then
        gFunc.EquipSet(sets.SoulEater)
    end
end

profile.OnLoad = function()
    gcinclude.SetAlias(T{'hate'})
    gcdisplay.CreateToggle('Hate', false)
    gcmelee.Load()
    profile.SetMacroBook()
end

profile.OnUnload = function()
    gcmelee.Unload()
    gcinclude.ClearAlias(T{'hate'})
end

profile.HandleCommand = function(args)
    if (args[1] == 'hate') then
        gcdisplay.AdvanceToggle('Hate')
        gcinclude.Message('Hate', gcdisplay.GetToggle('Hate'))
    else
        gcmelee.DoCommands(args)
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

    gcmelee.DoDefault()

    local player = gData.GetPlayer()
    local souleater = gData.GetBuffCount('Souleater')
    if (souleater > 0 and player.Status == 'Engaged' and use_chaos_burgeonet_for_tp_during_souleater) then
        gFunc.EquipSet(sets.SoulEater)
    end

    if (player.Status == 'Idle') then
        if (parade_gorget and player.HPP >= 85) then
            gFunc.Equip('Neck', 'Parade Gorget')
        end
    end

    local environment = gData.GetEnvironment()

    gcmelee.DoDefaultOverride()
    if (gcdisplay.IdleSet == 'Evasion' and fenrirs_stone and (environment.Time >= 6 and environment.Time < 18)) then
        gFunc.Equip('Ammo', 'Fenrir\'s Stone')
    end

    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))
end

profile.HandlePrecast = function()
    gcmelee.DoPrecast(fastCastValue)
end

profile.HandleMidcast = function()
    gcmelee.DoMidcast(sets)

    local action = gData.GetAction()
    if (action.Skill == 'Elemental Magic') then
        gFunc.EquipSet(sets.Nuke)
    elseif (action.Skill == 'Enfeebling Magic') then
        gFunc.EquipSet(sets.Enfeebling)
    elseif (action.Skill == 'Dark Magic') then
        gFunc.EquipSet(sets.Drain)
        if (string.contains(action.Name, 'Absorb')) then
            gFunc.EquipSet(sets.Absorb)
        end

        if (ObiCheck(action)) then
            local obi = NukeObiTable[action.Element]
            local obiOwned = NukeObiOwnedTable[action.Element]
            if (obiOwned) then
                gFunc.Equip('Waist', obi)
            end
        end
    end

    if (action.Skill ~= 'Ninjutsu' and gcdisplay.GetToggle('Hate')) then
        gFunc.EquipSet(sets.Hate)
    end

    if (string.contains(action.Name, 'Stun')) then
        gFunc.EquipSet(sets.Haste)
    end
end

local NukeObiTable = {
    ['Fire'] = 'Karin Obi',
    ['Earth'] = 'Dorin Obi',
    ['Water'] = 'Suirin Obi',
    ['Wind'] = 'Furin Obi',
    ['Ice'] = 'Hyorin Obi',
    ['Thunder'] = 'Rairin Obi',
    ['Light'] = 'Korin Obi',
    ['Dark'] = 'Anrin Obi'
}

local NukeObiOwnedTable = {
    ['Fire'] = nil,
    ['Earth'] = nil,
    ['Water'] = nil,
    ['Wind'] = nil,
    ['Ice'] = nil,
    ['Thunder'] = rairin_obi,
    ['Light'] = nil,
    ['Dark'] = anrin_obi
}

local WeakElementTable = {
    ['Fire'] = 'Water',
    ['Earth'] = 'Wind',
    ['Water'] = 'Thunder',
    ['Wind'] = 'Ice',
    ['Ice'] = 'Fire',
    ['Thunder'] = 'Earth',
    ['Light'] = 'Dark',
    ['Dark'] = 'Light'
}

function ObiCheck(action)
    local element = action.Element
    local environment = gData.GetEnvironment()
    local weakElement = WeakElementTable[element]

    if environment.WeatherElement == element then
        return environment.Weather:match('x2') or environment.DayElement ~= weakElement
    end

    return environment.DayElement == element and environment.WeatherElement ~= weakElement
end

return profile
