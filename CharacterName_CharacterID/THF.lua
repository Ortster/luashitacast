local profile = {}

local fastCastValue = 0.00 -- 0% from gear

local evasion_master_casters_mitts = false

local sets = {
    Idle_Priority = {
        Main =  { 'Bone Knife +1', 'Federation Knife', 'Mercenary\'s Knife', 'Federation Baghnakhs', 'Dagger +1' },
        Sub =   { 'Bone Knife +1', 'Federation Knife', 'Mercenary\'s Knife' },
        Range = { 'Rogetsurin' },
        Ammo =  { '' },
        --Ammo =  { 'Civet Sachet', 'Happy Egg' },
        Head =  { 'Walkure Mask', 'Empress Hairpin', 'Ryl.Ftm. Bandana' },
        Neck =  { 'Peacock Amulet','Spike Necklace', 'Wing Pendant' },
        Ear1 =  { 'Spike Earring', 'Beetle Earring +1', 'Bone Earring +1' },
        Ear2 =  { 'Spike Earring', 'Beetle Earring +1', 'Bone Earring +1' },
        Body =  { 'Scorpion Harness', 'Brigandine', 'Mrc.Cpt. Doublet', 'Beetle Harness +1', 'Bone Harness +1' },
        Hands = { 'Battle Gloves' },
        Ring1 = { 'Woodsman Ring', 'Deft Ring +1', 'Balance Ring +1' },
        Ring2 = { 'Woodsman Ring', 'Venerer Ring', 'Balance Ring +1' },
        Back =  { 'Amemet Mantle', 'Nomad\'s Mantle', 'Traveler\'s Mantle' },
        Waist = { 'Life Belt', 'Tilt Belt', 'Warrior\'s Belt +1' },
        Legs =  { 'Republic Subligar', 'Bone Subligar +1' },
        Feet =  { 'Bounding Boots' },
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
    
    Evasion = {},

    Precast = {},
    
    SIRD = {},
    
    -- Used for Utsusemi cooldown
    Haste = {},

    TP_LowAcc = {},
    
    TP_HighAcc = {},
    
    TP_NIN = {},

    TP_Mjollnir_Haste = {},

    WS = {},

    WS_HighAcc = {},

    WS_Evisceration = {},
    
    WS_SharkBite = {},

    SA = {},
    
    TA = {},
    
    SATA = {},

    Flee = {},
    
    Hide = {},
    
    Steal = {},
    
    Mug = {},

    TH = {},

    Ranged = {},
    
    Ranged_INT = {},
    
    -- Custom Sets - Level Sync Sets For Example
    LockSet1 = {},
    LockSet2 = {},
    LockSet3 = {},
}
profile.Sets = sets

profile.SetMacroBook = function()
    AshitaCore:GetChatManager():QueueCommand(1, '/macro book 6')
    AshitaCore:GetChatManager():QueueCommand(1, '/macro set 1')
end

--[[
--------------------------------
Everything below can be ignored.
--------------------------------
]]

local ammo = T{'aacid','asleep','abloody','ablind','avenom'}

local AmmoTable1 = {
    [1] = 'Acid',
    [2] = 'Sleep',
    [3] = 'Bloody',
    [4] = 'Blind',
    [5] = 'Venom',
}
local AmmoTable2 = {
    ['acid'] = 1,
    ['sleep'] = 2,
    ['bloody'] = 3,
    ['blind'] = 4,
    ['venom'] = 5,
}

local saOverride = 0
local taOverride = 0
local taggedMobs = {}

gcmelee = gFunc.LoadFile('common\\gcmelee.lua')
actionpacket = gFunc.LoadFile('common\\actionpacket.lua')

profile.HandleAbility = function()
    local action = gData.GetAction()
    if (action.Name == 'Flee') then
        gFunc.EquipSet(sets.Flee)
    elseif (action.Name == 'Hide') then
        gFunc.EquipSet(sets.Hide)
    elseif (action.Name == 'Steal') then
        gFunc.EquipSet(sets.Steal)
    elseif (action.Name == 'Mug') then
        gFunc.EquipSet(sets.Mug)
    elseif (action.Name == 'Sneak Attack') then
        saOverride = os.clock() + 2
    elseif (action.Name == 'Trick Attack') then
        taOverride = os.clock() + 2
    end

    if (profile.NeedTH()) then
        gFunc.EquipSet(sets.TH)
    end
end

profile.HandleItem = function()
    gcinclude.DoItem()
end

profile.HandlePreshot = function()
	gFunc.EquipSet(sets[gcdisplay.GetCycle('Ammo')]);
end

profile.HandleMidshot = function()
    gFunc.EquipSet(sets.Ranged)

    local ammo = gData.GetEquipment().Ammo
    if (ammo ~= nil and ammo.Name == 'Bloody Bolt') then
        gFunc.EquipSet(sets.Ranged_INT)
    end

    if (profile.NeedTH()) then
        gFunc.EquipSet(sets.TH)
    end
end

profile.HandleWeaponskill = function()
    gcmelee.DoWS()

    local action = gData.GetAction()
    if (action.Name == 'Evisceration') then
        gFunc.EquipSet(sets.WS_Evisceration)
    elseif (action.Name == 'Shark Bite') then
        gFunc.EquipSet(sets.WS_SharkBite)
    elseif (action.Name == 'Dancing Edge') then
        gFunc.EquipSet(sets.WS_DancingEdge)
    elseif (action.Name == 'Mercy Stroke') then
        gFunc.EquipSet(sets.WS_MercyStroke)
    end

    local sa = gData.GetBuffCount('Sneak Attack')
    local ta = gData.GetBuffCount('Trick Attack')

    if (sa == 1 and ta == 1) or (os.clock() < saOverride and os.clock() < taOverride) then
        if (action.Name == 'Shark Bite') then
            gFunc.EquipSet(sets.WS_SATA_SharkBite)
        end
    elseif (ta == 1) or (os.clock() < taOverride) then
        gFunc.EquipSet(sets.WS_TA)
        if (action.Name == 'Shark Bite') then
            gFunc.EquipSet(sets.WS_TA_SharkBite)
        elseif (action.Name == 'Mercy Stroke') then
            gFunc.EquipSet(sets.WS_TA_MercyStroke)
        end
    end

    if (profile.NeedTH()) then
        gFunc.EquipSet(sets.TH)
    end
end

profile.OnLoad = function()
    gcinclude.SetAlias(ammo)
    gcdisplay.CreateCycle('Ammo', AmmoTable1)
    gcinclude.SetAlias(T{'ammo'})
    gcinclude.SetAlias(T{'th'})
    gcdisplay.CreateCycle('TH', {[1] = 'Auto', [2] = 'On', [3] = 'Off'})
    gcmelee.Load()
    profile.SetMacroBook()
    profile.WatchTreasureHunter()
end

profile.OnUnload = function()
    gcmelee.Unload()
    gcinclude.ClearAlias(ammo)
    gcinclude.ClearAlias(T{'ammo'})
    gcinclude.ClearAlias(T{'th'})
    ashita.events.unregister('packet_in', 'watch_treasure_hunter');
end

profile.HandleCommand = function(args)
    if (args[1] == 'th') then
        gcdisplay.AdvanceCycle('TH')
        gcinclude.Message('TH', gcdisplay.GetCycle('TH'))
    elseif (args[1] == 'ammo') then
        gcdisplay.AdvanceCycle('Ammo')
        gcinclude.Message('Ammo', gcdisplay.GetCycle('Ammo'))
    elseif (ammo:contains(args[1])) then
        gcdisplay.SetCycleIndex('Ammo', AmmoTable2[args[1]:sub(2)])
        gcinclude.Message('Ammo', gcdisplay.GetCycle('Ammo'))
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
    if (player.SubJob == 'NIN' and player.Status == 'Engaged') then
        gFunc.EquipSet('TP_NIN')
    end

    gcmelee.DoDefaultOverride()

    if (conquest:GetOutsideControl() and evasion_master_casters_mitts and gcdisplay.IdleSet == 'Evasion') then
        gFunc.Equip('Hands', 'Mst.Cst. Mitts')
    end

    local sa = gData.GetBuffCount('Sneak Attack')
    local ta = gData.GetBuffCount('Trick Attack')

    if (sa == 1 and ta == 1) or (os.clock() < saOverride and os.clock() < taOverride) then
        gFunc.EquipSet(sets.SATA)
    elseif (sa == 1) or (os.clock() < saOverride) then
        gFunc.EquipSet(sets.SA)
    elseif (ta == 1) or (os.clock() < taOverride) then
        gFunc.EquipSet(sets.TA)
    end

    gFunc.EquipSet(gcinclude.BuildLockableSet(gData.GetEquipment()))

    if (player.Status == 'Engaged' and profile.NeedTH()) then
        gFunc.EquipSet(sets.TH)
    end
end

profile.HandlePrecast = function()
    gcmelee.DoPrecast(fastCastValue)
	gFunc.EquipSet(sets[gcdisplay.GetCycle('Ammo')]);
end

profile.HandleMidcast = function()
    gcmelee.DoMidcast(sets)

    local action = gData.GetAction()
    if (action.Skill ~= 'Ninjutsu' and profile.NeedTH()) then
        gFunc.EquipSet(sets.TH)
    end
end

profile.NeedTH = function()
    if (gcdisplay.GetCycle('TH') == 'Auto') then
        local targetId
        local actionTarget = gData.GetActionTarget()

        if (actionTarget ~= nil) then
            targetId = actionTarget.Id
        else
            local targetIndex = gData.GetTargetIndex()
            if (targetIndex == 0) then
                return false
            end

            targetId = AshitaCore:GetMemoryManager():GetEntity():GetServerId(targetIndex)
        end

        if bit.band(targetId, 0xFF000000) ~= 0 then  --isMob
            return taggedMobs[targetId] == nil
        end

        return false
    end

    return gcdisplay.GetCycle('TH') == 'On'
end

profile.WatchTreasureHunter = function()
    ashita.events.register('packet_in', 'watch_treasure_hunter', function(e)
        local playerEntity = GetPlayerEntity();
        if (not playerEntity) then
            return
        end

        if (e.id == 0x28) then
            local type = T { 1, 2, 4, 6 };
            local packet = actionpacket:parse(e);
            if (packet.UserId == playerEntity.ServerId) then
                if (type:contains(packet.Type)) then
                    local reaction = T { 0, 8, 
                        9, -- melee/range attack missed, comment out for pedantic TH mode
                    }
                    for _, target in ipairs(packet.Targets) do
                        for i = 1, #target.Actions do
                            local action = target.Actions[1]
                            if bit.band(target.Id, 0xFF000000) ~= 0 then -- isMob, also triggers on NPC but it's benign
                                if reaction:contains(action.Reaction) and target.Id then
                                    taggedMobs[target.Id] = true;
                                end
                            end
                        end
                    end
                end
            end
        elseif (e.id == 0x29) then
            local deathMes = T { 6, 20, 97, 113, 406, 605, 646 };
            -- Mob died, clear from table
            local message = struct.unpack('i2', e.data, 0x18 + 1);
            if (deathMes:contains(message)) then
                local target = struct.unpack('i4', e.data, 0x08 + 1);
                taggedMobs[target] = nil;
            end
        elseif (e.id == 0x0A or e.id == 0x0B) then
            -- Changed zone, clear all TH
            taggedMobs = {};
        end
    end)
end

return profile
