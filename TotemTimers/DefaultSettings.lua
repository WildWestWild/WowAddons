-- Copyright © 2008, 2009 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowui.worldofwar.net, wowinterface.com and their respective addon updaters

if not TotemTimers_Settings then TotemTimers_Settings = {} end
if not TotemTimers_SpecSettings then TotemTimers_SpecSettings = {[1] = {}, [2] = {}} end

 Default_Settings = {
	Version = 10.0,
    
    Show = true,    
    Lock = false,
	FlashRed = true,
	ShowTimerBars = true,
    HideBlizzTimers = true,
    Tooltips = true,
    TooltipsAtButtons = true,
    TimeFont = "Friz Quadrata TT",
    TimeColor = {r=1,g=1,b=1},
   	TimerBarTexture = "Blizzard",
    TimerBarColor = {r=0.5,g=0.5,b=1.0,a=1.0},
    ShowKeybinds = true,
    HideInVehicle = true,
    
    Order = {1,2,3,4,},
    Arrange = "horizontal",
 	TimeStyle = "mm:ss",
    TimerTimePos = "BOTTOM",   
	CastBarDirection = "auto",
	TimerSize = 32,
    TimerTimeHeight = 12,	
	TimerSpacing = 5,
	TimerTimeSpacing = 0,
	TotemTimerBarWidth = 36,
    TotemMenuSpacing = 0,
    OpenOnRightclick = false,
    MenusAlwaysVisible = false,
    BarBindings = true,
    ReverseBarBindings = false,    
    MiniIcons = true,
    ProcFlash = true,
    ColorTimerBars = false,
    ShowCooldowns = true,
    CheckPlayerRange = true,
    CheckRaidRange = true,	
    ShowRaidRangeTooltip = true,
    CastButtonPosition = "AUTO",
    CastButtonSize = 0.5,

	TrackerArrange = "horizontal",
	TrackerTimePos = "BOTTOM",
	TrackerSize = 30,
	TrackerTimeHeight=12,
    TrackerSpacing = 5,
	TrackerTimeSpacing = 0,
    TrackerTimerBarWidth = 36,
	ShieldTracker = true,
    AnkhTracker = true,
    EarthShieldTracker = true,
    WeaponTracker = true,
    WeaponBarDirection = "auto",
    WeaponMenuOnRightclick = false,

	EarthShieldLeftButton = "recast", 
	EarthShieldRightButton = "target",
	EarthShieldMiddleButton = "targettarget",
	EarthShieldButton4 = "player",
	ShieldLeftButton = TotemTimers.SpellNames[TotemTimers.SpellIDs.LightningShield],
	ShieldRightButton = TotemTimers.SpellNames[TotemTimers.SpellIDs.WaterShield],
	ShieldMiddleButton = TotemTimers.SpellNames[TotemTimers.SpellIDs.TotemicCall],
    
	
	Msg = "tt",
	TotemWarningMsg = true,
	TotemExpirationMsg = true,
	TotemDestroyedMsg = true,
	ShieldMsg = true,
	EarthShieldMsg = true,
	WeaponMsg = true,
    MaelstromMsg = true,
    ActivateHiddenTimers = false,    
    
	LastMainEnchants = {},
	LastOffEnchants = {},
                      
	TotemOrder = {},
    TimerPositions = { 
        [1] = {"CENTER", nil, "CENTER", -50,-40},
        [2] = {"CENTER", nil, "CENTER", -70,0},
        [3] = {"CENTER", nil, "CENTER", -30, 0},
        [4] = {"CENTER", nil, "CENTER", -50, 40}, 
    },
    TotemSets = {},

    Sink = {},
    
    FramePositions = {
        TotemTimersFrame = {"CENTER", nil, "CENTER", -200,0},
        TotemTimers_TrackerFrame = {"CENTER", nil, "CENTER", 50,0},
        TotemTimers_EnhanceCDsFrame = {"CENTER", nil, "CENTER", -30.5, -120},
        TotemTimers_MultiSpellFrame = {"CENTER", nil, "CENTER", -250,0},
        TotemTimers_CastBar1 = {"CENTER", nil, "CENTER", -200,-190},
        TotemTimers_CastBar2  = {"CENTER", nil, "CENTER", -200,-225},
        TotemTimers_CastBar3  = {"CENTER", nil, "CENTER", 50, -190},
        TotemTimers_CastBar4  = {"CENTER", nil, "CENTER", 50, -225}, 
    },
    
    LastMultiCastSpell = TotemTimers.SpellIDs.CallofElements,
    EnableMultiSpellButton = true,
    MultiSpellSize = 30,
    MultiSpellBarDirection = "sameastimers",
    HideDefaultTotemBar = true,
    MultiSpellBarOnRightclick = false,
    MultiSpellBarBinds = true,
    MultiSpellReverseBarBinds = false,
    
    RaidTotemsToCall = 66842,
    TimersOnButtons = false,
    
    Warnings = {
        ["TotemWarning"] = {r=1,g=1,b=1},
        ["TotemExpired"] = {r=1,g=1,b=1},
        ["TotemDeath"]   = {r=1,g=1,b=1},
    },
}


Default_SpecSettings = {
    LastWeaponEnchant = TotemTimers.SpellNames[TotemTimers.SpellIDs.RockbiterWeapon],
    LastWeaponEnchant2 = TotemTimers.SpellNames[TotemTimers.SpellIDs.FlametongueWeapon],
    HiddenTotems = {},
    CastButtons = {},
    EnhanceCDs_Spells = {
        ["melee"] = {
            [1] = true, --SpellIDs.StormStrike
            [2] = true, --SpellIDs.EarthShock
            [3] = true, --SpellIDs.LavaLash
            [4] = true, --SpellIDs.FireNova
            [5] = true, --SpellIDs.Magma
            [6] = true, --SpellIDs.ShamanisticRage
            [7] = true, --SpellIDs.WindShear
            [8] = true, --SpellIDs.LightningShield
            [9] = true, --SpellIDs.FlameShock
            [10] = true, --SpellIDs.FeralSpirit
            [11] = true, --SpellIDs.Maelstrom
        },
        ["ele"] = {
            [1] = true, --SpellIDs.FlameShock,
            [2] = true, --SpellIDs.LavaBurst,
            [3] = true, --SpellIDs.ChainLightning,
            [4] = true, --SpellIDs.Thunderstorm,
            [5] = true, --SpellIDs.ElementalMastery,
            [6] = true, -- FlameShock duration
        },
    },
    EnhanceCDs_Order = {
        ["melee"] = {
            [1] = 1, --SpellIDs.StormStrike
            [2] = 2, --SpellIDs.EarthShock
            [3] = 3, --SpellIDs.LavaLash
            [4] = 4, --SpellIDs.FireNova
            [5] = 5, --SpellIDs.Magma
            [6] = 6, --SpellIDs.ShamanisticRage
            [7] = 7, --SpellIDs.WindShear
        },
        ["ele"] = {
            [1] = 1, --SpellIDs.FlameShock,
            [2] = 2, --SpellIDs.LavaBurst,
            [3] = 3, --SpellIDs.ChainLightning,
            [4] = 4, --SpellIDs.Thunderstorm,
            [5] = 5, --SpellIDs.ElementalMastery,
        },
    },
    EnhanceCDs = true,
    EnhanceCDsSize = 30,
    EnhanceCDsTimeHeight = 12,
    EnhanceCDsMaelstromHeight = 14,
    ShowOmniCCOnEnhanceCDs = true,
    EnhanceCDsOOCAlpha = 0.1,
    CDTimersOnButtons = true,
}

local function copy(object)
    if type(object) ~= table then
        return object
    else
        local newtable = {}
        for k,v in pairs(object) do
            newtable[k] = copy(v)
        end
        return newtable
    end
end

TotemTimers.Default_Settings = Default_Settings
TotemTimers.Default_SpecSettings = Default_SpecSettings
	
function TotemTimers_LoadDefaultSettings()
	local TotemTimers_Settings = TotemTimers_Settings
    if not TotemTimers_SpecSettings[1] then TotemTimers_SpecSettings[1] = {} end --needed if pressed "reset all"-button
    if not TotemTimers_SpecSettings[2] then TotemTimers_SpecSettings[2] = {} end

	for k,v in pairs(Default_Settings) do
		if TotemTimers_Settings[k] == nil then
			TotemTimers_Settings[k] = copy(v)
		end
	end	
    
    for k,v in pairs(Default_SpecSettings) do
        for i = 1,2 do
            if TotemTimers_SpecSettings[i][k] == nil then
                TotemTimers_SpecSettings[i][k] = copy(v)
            end
        end
        TotemTimers_Settings[k] = nil
    end
    
	if #TotemTimers_Settings.TotemOrder == 0 then
		for i=1,4 do
			TotemTimers_Settings.TotemOrder[i] = {}
		end
		for k,v in pairs(TotemData) do
			table.insert(TotemTimers_Settings.TotemOrder[v.element], k)
		end
	end
end
