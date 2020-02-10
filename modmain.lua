Assets=
{
    Asset("ATLAS", "images/inventoryimages/path_light.xml"),
}

PrefabFiles = 
{
	"path_light",
}

STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
TUNING = GLOBAL.TUNING
--Action = GLOBAL.Action

GLOBAL.STRINGS.NAMES.PATH_LIGHT = "落地路灯"
STRINGS.RECIPE_DESC.PATH_LIGHT = "照亮你回家的路。"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.PATH_LIGHT = "一盏灯。"

local recipe = GetModConfigData("recipe")
local firefly = GetModConfigData("recipe_use_firefly")

if recipe == "easy" then
	local path_lightrecipe = GLOBAL.Recipe("path_light", 
	{Ingredient("rocks", 1), Ingredient("twigs", 3), Ingredient("rope", 1), firefly and Ingredient("fireflies", 1) or Ingredient("lightbulb", 1)},
	RECIPETABS.LIGHT, TECH.NONE, "path_light_placer")                     
    path_lightrecipe.atlas = "images/inventoryimages/path_light.xml"
elseif recipe == "normal" then
	local path_lightrecipe = GLOBAL.Recipe("path_light", 
	{Ingredient("moonrocknugget", 1), Ingredient("twigs", 3), Ingredient("rope", 1), firefly and Ingredient("fireflies", 1) or Ingredient("lightbulb", 1)},
	RECIPETABS.LIGHT, TECH.SCIENCE_ONE, "path_light_placer")                     
    path_lightrecipe.atlas = "images/inventoryimages/path_light.xml"
elseif recipe == "hard" then
	local path_lightrecipe = GLOBAL.Recipe("path_light", 
	{Ingredient("moonrocknugget", 2), Ingredient("twigs", 3), Ingredient("rope", 2), firefly and Ingredient("fireflies", 1) or Ingredient("lightbulb", 1)},
	RECIPETABS.LIGHT, TECH.SCIENCE_TWO, "path_light_placer")                     
    path_lightrecipe.atlas = "images/inventoryimages/path_light.xml"
else
	local path_lightrecipe = GLOBAL.Recipe("path_light", 
	{Ingredient("rocks", 1), Ingredient("twigs", 3), Ingredient("rope", 1), firefly and Ingredient("fireflies", 1) or Ingredient("lightbulb", 1)},
	RECIPETABS.LIGHT, TECH.NONE, "path_light_placer")                     
    path_lightrecipe.atlas = "images/inventoryimages/path_light.xml"  
end

TUNING.PATHLIGHTS_FRAGILE = GetModConfigData("fragile")
TUNING.PATHLIGHTS_RADIUS = GetModConfigData("light_radius")
TUNING.PATHLIGHTS_R = 0
TUNING.PATHLIGHTS_G = 0
TUNING.PATHLIGHTS_B = 0
TUNING.PATHLIGHTS_INTENSITY = GetModConfigData("light_intensity")
if GetModConfigData("light_custom") then
	-- local R = GetModConfigData("custom_R")
	-- local G = GetModConfigData("custom_G")
	-- local B = GetModConfigData("custom_B")
	-- TUNING.PATHLIGHTS_R = R
	-- TUNING.PATHLIGHTS_G = G
	-- TUNING.PATHLIGHTS_B = B
	-- TUNING.PATHLIGHTS_INTENSITY = 0.299 * R + 0.587 * G + 0.114 * B
	TUNING.PATHLIGHTS_R = GetModConfigData("custom_R")
	TUNING.PATHLIGHTS_G = GetModConfigData("custom_G")
	TUNING.PATHLIGHTS_B = GetModConfigData("custom_B")
else
	local color = GetModConfigData("light_color")
	if color == 1 then
		TUNING.PATHLIGHTS_R = 70
		TUNING.PATHLIGHTS_G = 100
		TUNING.PATHLIGHTS_B = 245
	elseif color == 2 then
		TUNING.PATHLIGHTS_R = 245
		TUNING.PATHLIGHTS_G = 100
		TUNING.PATHLIGHTS_B = 70
	elseif color == 3 then
		TUNING.PATHLIGHTS_R = 70
		TUNING.PATHLIGHTS_G = 245
		TUNING.PATHLIGHTS_B = 100
	elseif color == 4 then
		TUNING.PATHLIGHTS_R = 245
		TUNING.PATHLIGHTS_G = 85
		TUNING.PATHLIGHTS_B = 245
	else
		TUNING.PATHLIGHTS_R = 70
		TUNING.PATHLIGHTS_G = 100
		TUNING.PATHLIGHTS_B = 245
	end
--TUNING.PATHLIGHTS_INTENSITY = GetModConfigData("light_intensity")
end
GLOBAL.FueledtLight = GetModConfigData("FueledLights")

AddAction("SWITCHMODE", "切换", function(act)
	if act.doer ~= nil and act.target ~= nil and act.doer:HasTag("player") and act.target:HasTag("path_light") then
		act.target:PushEvent("switchmode")
		return true
	end
end)
AddComponentAction("SCENE", "inspectable", function(inst, doer, actions, right)
        if right then
            if inst:HasTag("path_light") then
                table.insert(actions, GLOBAL.ACTIONS.SWITCHMODE)
            end
        end
    end
)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SWITCHMODE, "give"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SWITCHMODE, "give"))
