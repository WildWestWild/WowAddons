﻿if(GetLocale() == "ruRU") then
_G["BINDING_HEADER_TOTEMTIMERSHEADER"] = "TotemTimers"
_G["BINDING_NAME_TOTEMTIMERSAIR"] = "Создать активный тотем воздуха"
_G["BINDING_NAME_TOTEMTIMERSAIRMENU"] = "Открыть меню тотемов воздуха"
_G["BINDING_NAME_TOTEMTIMERSEARTH"] = "Создать активный тотем земли"
_G["BINDING_NAME_TOTEMTIMERSEARTHMENU"] = "Открыть меню тотемов земли"
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDLEFT"] = "Щит земли ЛевыйКлик"
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDMIDDLE"] = "Щит земли СреднийКлик"
_G["BINDING_NAME_TOTEMTIMERSEARTHSHIELDRIGHT"] = "Щит земли ПравыйКлик"
_G["BINDING_NAME_TOTEMTIMERSFIRE"] = "Создать активный тотем огня"
_G["BINDING_NAME_TOTEMTIMERSFIREMENU"] = "Открыть меню тотемов огня"
_G["BINDING_NAME_TOTEMTIMERSWATER"] = "Создать активный тотем воды"
_G["BINDING_NAME_TOTEMTIMERSWATERMENU"] = "Открыть меню тотемов воды"
_G["BINDING_NAME_TOTEMTIMERSWEAPONBUFF1"] = "Усиление оружия 1"
_G["BINDING_NAME_TOTEMTIMERSWEAPONBUFF2"] = "Усиление оружия 2"

end


local L = LibStub("AceLocale-3.0"):NewLocale("TotemTimers", "ruRU")
if not L then return end

L["Air Button"] = "Кнопки Воздуха"
L["Ctrl-Leftclick to remove weapon buffs"] = "[Ctrl+Левый клик] - снять усиление с оружия"
L["Delete Set"] = "Удалить набор тотемов %u?"
L["Earth Button"] = "Кнопки Земли"
L["Fire Button"] = "Кнопки Огня"
L["Leftclick to cast %s"] = "[Левый клик] - применить %s"
L["Leftclick to cast spell"] = "[Левый клик] - применить заклинание"
L["Leftclick to load totem set to %s"] = "[Левый клик] - загрузить набор тотемов %s" -- Needs review
L["Leftclick to open totem set menu"] = "[Левый клик] - открыть меню набора тотемов" -- Needs review
L["Maelstrom Notifier"] = "Водоворот готов!"
L["Middleclick to cast %s"] = "[Средний клик] - применить %s"
L["Next leftclick casts %s"] = "Следующий [Левый клик] - применить %s"
L["Reset"] = "TotemTimers сброшен!"
L["Rightclick to assign both %s and %s to leftclick"] = "[Правый клик] - назначить %s и %s на [левый клик]"
L["Rightclick to assign spell to leftclick"] = "[Правый клик] - назначить заклинание на [левый клик]"
L["Rightclick to cast %s"] = "[Правый клик] - применить %s"
L["Rightclick to delete totem set"] = "[Правый клик] - удалить набор тотемов"
L["Rightclick to save active totem configuration as set"] = "[Правый клик] - сохранить активную конфигурацию тотемов как набор"
L["Rightclick to set %s as active multicast spell"] = "Rightclick to set %s as active multicast spell" -- Requires localization
L["Shield removed"] = "%s снят"
L["Shift-Rightclick to assign spell to middleclick"] = "[Shift+Правый клик] назначить заклинание на [средний клик]"
L["Shift-Rightclick to assign spell to rightclick"] = "[Shift+Правый клик] назначить заклинание на [правый клик]"
L["Totem Destroyed"] = "%s разрушен"
L["Totem Expired"] = "%s исчез" -- Needs review
L["Totem Expiring"] = "%s скоро исчезнет"
L["Water Button"] = "Кнопки Воды"
