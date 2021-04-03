local sink = LibStub("LibSink-2.0")
--[[if sink then
    TotemTimers.options.args.messages = sink.GetSinkAce3OptionsDataTable(TotemTimers)
else
    TotemTimers.options.args.messages = {}
end]]

--[[for k,v in pairs(TotemTimers.options.args.messages.args) do
    if v.order and v.order < 0 then v.order = v.order - 50 end
end]]

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)

TotemTimers.options.args.messages = {
    type = "group",
    name = "messages",
    args = {
        sink = {
        	type = "group", name = "", inline = true,
			args = {
				output = sink.GetSinkAce3OptionsDataTable(TotemTimers)
			},
        },
        TotemWarningMsg = {
            order = -39,
            type = "toggle",
            name = L["Totem Expiration Warning"],
            desc = L["Totem Warning Desc"],
            set = function(info, val)
                      TotemTimers_Settings.TotemWarningMsg = val
                      TotemTimers_ProcessSetting("TotemWarningMsg")
                  end,
            get = function(info) return TotemTimers_Settings.TotemWarningMsg end,
        },
        TotemExpirationMsg = {
            order = -38,
            type = "toggle",
            name = L["Totem Expiration Message"],
            desc = L["Totem Expiration Desc"],
            set = function(info, val)
                      TotemTimers_Settings.TotemExpirationMsg = val
                      TotemTimers_ProcessSetting("TotemExpirationMsg")
                  end,
            get = function(info) return TotemTimers_Settings.TotemExpirationMsg end,
        }, 
        TotemDestroyedMsg = {
            order = -37,
            type = "toggle",
            name = L["Totem Destruction Message"],
            desc = L["Totem Desctruction Desc"],
            set = function(info, val)
                      TotemTimers_Settings.TotemDestroyedMsg = val
                      TotemTimers_ProcessSetting("TotemDestroyedMsg")
                  end,
            get = function(info) return TotemTimers_Settings.TotemDestroyedMsg end,
        },
        ShieldMsg = {
            order = -36,
            type = "toggle",
            name = L["Shield expiration warnings"],
            set = function(info, val)
                      TotemTimers_Settings.ShieldMsg = val
                      TotemTimers_ProcessSetting("ShieldMsg")
                  end,
            get = function(info) return TotemTimers_Settings.ShieldMsg end,
        },
        EarthShieldMsg = {
            order = -35,
            type = "toggle",
            name = L["EarthShield warnings"],
            set = function(info, val)
                      TotemTimers_Settings.EarthShieldMsg = val
                      TotemTimers_ProcessSetting("EarthShieldMsg")
                  end,
            get = function(info) return TotemTimers_Settings.EarthShieldMsg end,
        },
        WeaponMsg = {
            order = -34,
            type = "toggle",
            name = L["Weapon buff warnings"] ,
            set = function(info, val)
                      TotemTimers_Settings.WeaponMsg = val
                      TotemTimers_ProcessSetting("WeaponMsg")
                  end,
            get = function(info) return TotemTimers_Settings.WeaponMsg end,
        },
        MaelstromMsg = {
            order = -33,
            type = "toggle",
            name = L["Maelstrom notification"] ,
            set = function(info, val)
                      TotemTimers_Settings.MaelstromMsg = val
                      TotemTimers_ProcessSetting("MaelstromMsg")
                  end,
            get = function(info) return TotemTimers_Settings.MaelstromMsg end,
        },
        ActivateHiddenTimers = {
            order = -32,
            type = "toggle",
            name = L["Show warnings of disabled trackers"],
            desc = L["disabled warnings desc"],
            set = function(info, val)
                      TotemTimers_Settings.ActivateHiddenTimers = val
                      TotemTimers_ProcessSetting("ActivateHiddenTimers")
                  end,
            get = function(info) return TotemTimers_Settings.ActivateHiddenTimers end,
        },
    },
}


local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", L["Messages"], "TotemTimers", "messages")
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")