-- Copyright © 2008, 2009 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowui.worldofwar.net, wowinterface.com and their respective addon updaters

local TalentQuery
if LibStub then 
    TalentQuery = LibStub:GetLibrary("LibTalentQuery-1.0")
end

local playerName = UnitName("player")

local BuffNames = TotemTimers.BuffNames

-- classes: 1:melee, 2:ranged, 3:caster, 4:healer, 5:hybrid (elemental shaman)

local RaidNames = {}
local RaidClasses = {}
local RaidBuffs = {[1]={},[2]={},[3]={},[4]={}}
local RaidBuffsCount = {0,0,0,0}
local isInRaid = false
local inBattleground = false
local RaidWoWClasses = {}

local TalentTreesToTTClasses = {
    ["SHAMAN"]  = {3,5,4},
    ["PRIEST"]  = {4,4,3},
    ["DRUID"]   = {3,1,4},
    ["PALADIN"] = {4,1,1},
}

local classnames = {[0]="error", [1]="melee", [2]="ranged", [3]="caster", [4]="healer", [5]="hybrid"}

local inspectElapsed = 0

local inspectFrame = CreateFrame("Frame", "TotemTimers_InspectFrame")
inspectFrame:Hide()

local function Query(unit, immediately)
	if not LibStub or not TalentQuery then return end
	local _,r = IsInInstance()
	if immediately and (r == "raid" or r == "party") then
		TalentQuery:Query(unit)
	end
	inspectFrame:Show()
end

inspectFrame:SetScript("OnUpdate", function(self, elapsed)
    inspectElapsed = inspectElapsed + elapsed
    if inspectElapsed >= 30 then
        inspectElapsed = 0
		local _,r = IsInInstance()
		if r~="raid" and r~="party" then return end
        local added = false
        for unit,name in pairs(RaidNames) do
            if not RaidClasses[name] or RaidClasses[name] == 0 then
                TalentQuery:Query(unit)
                added = true
            end
        end
        if not added then self:Hide() end
    end
end)

local PrimarySpecSpell = GetSpellInfo(63645)
local SecondarySpecSpell = GetSpellInfo(63644)

inspectFrame:SetScript("OnEvent", function(self,event,...)
	if event == "PLAYER_REGEN_ENABLED" then
		inspectFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	elseif event == "PLAYER_REGEN_DISABLED" then
		inspectFrame:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
		local unit,spell = ...
		if (spell == PrimarySpecSpell or spell == SecondarySpecSpell) then
			local name = UnitName(unit)
			if UnitIsUnit(unit,"player") then return end
			if RaidClasses[name] ~= 0 and RaidWoWClasses[name] ~= "DRUID" and RaidWoWClasses[name] ~= "PALADIN"
				and RaidWoWClasses[name] ~= "SHAMAN" and RaidWoWClasses[name] ~= "PRIEST" then
					return
			end 
			RaidClasses[name] = 0
			Query(unit, true)
		end
	elseif "PLAYER_ENTERTING_WORLD" then
        inspectElapsed = 0
    end
end)

function TotemTimers:TalentQuery_Ready(e, name, realm, unit)
    if name == playerName then return end
    if not RaidWoWClasses[name] then return end
    if RaidWoWClasses[name] ~= "DRUID" and RaidWoWClasses[name] ~= "PALADIN"
      and RaidWoWClasses[name] ~= "SHAMAN" and RaidWoWClasses[name] ~= "PRIEST" then
        return
    end
    if RaidClasses[name] and RaidClasses[name] ~= 0 then return end
    local _, _, p1 = GetTalentTabInfo(1, true)
    local _, _, p2 = GetTalentTabInfo(2, true)
    local _, _, p3 = GetTalentTabInfo(3, true)
    local tree = 1
    if p1 and p2 and p3 and (p1 > 0 or p2 > 0 or p3 > 0) then
        if p1 >= p2 and p1 >= p2 then tree = 1 end
        if p2 >= p1 and p2 >= p3 then tree = 2 end
        if p3 >= p1 and p3 >= p2 then tree = 3 end
        RaidClasses[name] = TalentTreesToTTClasses[RaidWoWClasses[name]][tree]
        inspectFrame:Hide()
        for cname, class in pairs(RaidClasses) do
            if class == 0 then inspectFrame:Show() end
        end
        for i=1,4 do
			local timer = XiTimers.timers[i]
			if timer.timers[1] > 0 then
				TotemTimers_StartBuffCount(timer.activeTotem, timer.nr)
				if RaidBuffsCount[timer.nr] > 0 then
					timer.button.buffCount:SetText(RaidBuffsCount[timer.nr])
				else
					timer.button.buffCount:SetText("")
				end
			end
			--[[if TotemTimers_GUI_Inspect:IsVisible() then
				TotemTimers_GUI_Inspect:Hide()
				TotemTimers_GUI_Inspect:Show()
			end]]
		end
    else
        Query(unit)
    end
end

if TalentQuery then
    TalentQuery.RegisterCallback(TotemTimers,"TalentQuery_Ready")
end

function TotemTimers_UpdateRaid()
    isInRaid = GetNumRaidMembers() > 0
    RaidNames = {}
    inBattleground = select(2,IsInInstance()) == "pvp"
    if inBattleground or not TotemTimers_Settings.CheckRaidRange then return end
    local newgroup = {}
    local maxmembers = 40
    local changed = false
    if not isInRaid then maxmembers = 4 end
    for i=1,maxmembers do
        local unit = "raid"..i
        if not isInRaid then unit = "party"..i end
        if UnitExists(unit) and not UnitIsUnit(unit, "player") then
            local name = UnitName(unit)
            newgroup[name] = true
            if not RaidClasses[name] then 
                changed = true
            end
            RaidNames[unit] = UnitName(unit)
            if not RaidClasses[name] or RaidClasses[name] == 0 then
                local _,class = UnitClass(unit)
                if class == "WARRIOR" or class == "ROGUE" or class == "DEATHKNIGHT" then
                    RaidClasses[name] = 1
                elseif class == "HUNTER" then
                    RaidClasses[name] = 2
                elseif class == "MAGE" or class == "WARLOCK" then
                    RaidClasses[name] = 3
                else
                    RaidClasses[name] = 0
                    Query(unit)
                end
                RaidWoWClasses[RaidNames[unit]] = class
            end
        end
    end
    for name,_ in pairs(RaidClasses) do
        if not newgroup[name] then
            RaidClasses[name] = nil
            changed = true
        end
    end
    --[[if changed and TotemTimers_GUI_Inspect:IsVisible() then
            TotemTimers_GUI_Inspect:Hide()
            TotemTimers_GUI_Inspect:Show()
    end]]
    for i=1,4 do
        local timer = XiTimers.timers[i]
        if timer.timers[1] > 0 then
            TotemTimers_StartBuffCount(timer.activeTotem, timer.nr)
            if RaidBuffsCount[timer.nr] > 0 then
                timer.button.buffCount:SetText(RaidBuffsCount[timer.nr])
            else
                timer.button.buffCount:SetText("")
            end
        end
    end
end

function TotemTimers_UpdateBuff(unit,totem,element)
    if not TotemData[totem].needed then return end
    if inBattleground or not TotemTimers_Settings.CheckRaidRange then return end
    local class = RaidClasses[RaidNames[unit]]
    if class ~= 0 and not TotemData[totem].needed[class] then return end
    local buff = BuffNames[TotemData[totem].hasBuff]
    if buff then
        local b = UnitBuff(unit,buff)
        if not b and TotemData[totem].moreBuffs then
            for k,v in pairs(TotemData[totem].moreBuffs) do
                if BuffNames[v] then
                    b = UnitBuff(unit, BuffNames[v]) or b
                end
            end
        end
        if not b then
            if not RaidBuffs[element][RaidNames[unit]] then
                RaidBuffs[element][RaidNames[unit]] = true
                RaidBuffsCount[element] = RaidBuffsCount[element]+1
            end
        else
            if RaidBuffs[element][RaidNames[unit]] then
                RaidBuffs[element][RaidNames[unit]] = nil
                RaidBuffsCount[element] = RaidBuffsCount[element]-1
            end
        end
    end
end

function TotemTimers_StartBuffCount(totem, element)
    if not TotemData[totem].hasBuff then return end
    RaidBuffsCount[element] = 0 ---1*(GetNumRaidMembers()-1)
    RaidBuffs[element] = {}
    if inBattleground or not TotemTimers_Settings.CheckRaidRange then return end
    for k,v in pairs(RaidNames) do
        if v ~= playerName then
            if TotemData[totem].needed[RaidClasses[v]] or RaidClasses[v] == 0 then
                RaidBuffs[element][v] = true
                RaidBuffsCount[element] = RaidBuffsCount[element] + 1
            end
        end
    end
end

function TotemTimers_ResetBuffCount(element)
    RaidBuffsCount[element] = 0
    --RaidBuffs[element] = {}
end

function TotemTimers_GetMissingBuffs(element)
    return RaidBuffsCount[element]
end

function TotemTimers_GetMissingBuffNames(element)
    return RaidBuffs[element], RaidWoWClasses
end

function TotemTimers.GetRaidClasses()
    return RaidClasses, RaidWoWClasses
end

function TotemTimers.SetRaidClass(name, class)
    if RaidClasses[name] then RaidClasses[name] = class end
    if class == 0 and LibStub and TalentQuery then
        for unit,rname in pairs(RaidNames) do
            if rname == name then
                Query(unit)
                break
            end
        end        
    end
end
