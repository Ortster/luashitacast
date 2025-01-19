local profile = {}

local fastCastValue = 0.00 -- 7% from gear

local parade_gorget = false

local hercules_ring = false
local hercules_ring_slot = 'Ring1'

-- Replace these with '' if you do not have them
local gallant_leggings = '' -- 'Glt. Leggings +1'
local valor_leggings = '' -- 'Vlr. Leggings +1'

local arco_de_velocidad = false

local warlocks_mantle = false -- Don't add 2% to fastCastValue to this as it is SJ dependant

local shadow_mantle = false

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

    Evasion = {},

    Precast = {},

    SIRD = {},

    Haste = {},

    -- Optional, provided here only if you wish to mix in SIRD or other stats over max haste
    Haste_Ichi = {},

    Hate = {},

    -- Optional, provided here only if you wish to mix in haste or other stats over max +enmity
    Hate_Flash = {},

    Cheat_C3HPDown = {},

    Cheat_C3HPUp = {},

    Cheat_C4HPDown = {},

    Cheat_C4HPUp = {},

    TP_LowAcc = {},

    TP_HighAcc = {},

    WS = {},

    WS_Spirits = {},

    Cover = {},

    Cure = {},

    -- Rampart gives VIT x2 damage shield in era
    Rampart = {},

    ShieldBash = {},

    Enhancing = {},

    -- Custom Sets - Level Sync Sets For Example
    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},
}
profile.Sets = sets

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 1')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')

    --AshitaCore:GetChatManager():QueueCommand(-1, '/bind F9 //flash')
    --AshitaCore:GetChatManager():QueueCommand(-1, '/bind F10 //shieldbash')
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

gcmelee = gFunc.LoadFile('common\\gcmelee.lua')

profile.HandleAbility = function()
    local action = gData.GetAction()

    if (action.Name == 'Chivalry') then
        return
    end

    gFunc.EquipSet(sets.Hate)

    if (action.Name == 'Holy Circle' and gallant_leggings ~= '') then
        gFunc.Equip('Legs', gallant_leggings)
    elseif (action.Name == 'Rampart') then
        gFunc.EquipSet(sets.Rampart)
        local environment = gData.GetEnvironment()
        if (shadow_mantle and environment.DayElement == 'Dark') then
            gFunc.Equip('Back', 'Shadow Mantle')
        end
    elseif (action.Name == 'Shield Bash' and valor_gauntlets ~= '') then
        gFunc.EquipSet(sets.ShieldBash)
    elseif (action.Name == 'Sentinel' and valor_leggings ~= '') then
        gFunc.Equip('Legs', valor_leggings)
    elseif (action.Name == 'Cover') then
        gFunc.EquipSet(sets.Cover)
    end
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

    gcmelee.DoFenrirsEarring()

    local action = gData.GetAction()
    if (action.Name == 'Spirits Within') then
        gFunc.EquipSet(sets.WS_Spirits)
    end
end

profile.OnLoad = function()
    gcmelee.Load()
    gcmelee.SetIsDPS(false)
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
    local cover = gData.GetBuffCount('Cover')

    if (cover >= 1) then
        gFunc.EquipSet(sets.Cover)
    end

    if (arco_de_velocidad) then
        local environment = gData.GetEnvironment()
        if (environment.Time >= 6 and environment.Time < 18 and player.HPP < 100) then
            gFunc.Equip('Range', 'Arco de Velocidad')
        end
    end

    if (parade_gorget and player.HPP >= 85) then
        gFunc.Equip('Neck', 'Parade Gorget')
    end

    if (hercules_ring and player.HPP <= 50) then
        gFunc.Equip(hercules_ring_slot, 'Hercules\' Ring')
    end

    gcmelee.DoDefaultOverride()
    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))
end

profile.HandlePrecast = function()
    local player = gData.GetPlayer()
    local target = gData.GetActionTarget()
    local action = gData.GetAction()
    local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0)

    local cheatDelay = 0
    if (player.SubJob == "RDM" and warlocks_mantle) then
        cheatDelay = gcmelee.DoPrecast(fastCastValue + 0.02)
        gFunc.Equip('Back', 'Warlock\'s Mantle')
    else
        cheatDelay = gcmelee.DoPrecast(fastCastValue)
    end

    if (cheatDelay < 0) then
        cheatDelay = 0
    end
    local function delayCheat()
        if (target.Name == me) then
            if (action.Name == 'Cure III') then
                gFunc.ForceEquipSet(sets.Cheat_C3HPDown)
            elseif (action.Name == 'Cure IV') then
                gFunc.ForceEquipSet(sets.Cheat_C4HPDown)
            end
        end
    end

    delayCheat:once(cheatDelay)
end

profile.HandleMidcast = function()
    gcmelee.DoMidcast(sets)

    local target = gData.GetActionTarget()
    local action = gData.GetAction()
    local me = AshitaCore:GetMemoryManager():GetParty():GetMemberName(0)

    if (action.Skill ~= 'Ninjutsu') then
        local sentinel = gData.GetBuffCount('Sentinel')
        if (sentinel >= 1) then
            gFunc.EquipSet(sets.Haste)
        else
            gFunc.EquipSet(sets.Hate)
            if (action.Name == 'Flash') then
                gFunc.EquipSet(sets.Hate_Flash)
            end
        end

        if (action.Skill == 'Healing Magic') then
            gFunc.EquipSet(sets.Cure)
        end
    else
        if (action.Name == 'Utusemi: Ichi') then
            gFunc.EquipSet(sets.Haste_Ichi)
        elseif (action.Name == 'Stoneskin' or action.Name == 'Phalanx') then
            gFunc.EquipSet(sets.Enhancing)
        end
    end

    if (target.Name == me) then
        if (action.Name == 'Cure III') then
            gFunc.EquipSet(sets.Cheat_C3HPUp)
        elseif (action.Name == 'Cure IV') then
            gFunc.EquipSet(sets.Cheat_C4HPUp)
        end
    end
end

return profile
