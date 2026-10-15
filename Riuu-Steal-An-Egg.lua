repeat wait() until game:IsLoaded()

if LPH_OBFUSCATED == nil then
	LPH_NO_VIRTUALIZE = function(...) return (...) end
	LPH_ENCSTR = function(...) return (...) end
	LRM_SANITIZE = function(...) return ... end
end

local cloneref = cloneref or function(o) return o end
local TweenService = cloneref(game:GetService("TweenService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local Players = cloneref(game:GetService("Players"))
local TextService = cloneref(game:GetService("TextService"))
local HttpService = cloneref(game:GetService("HttpService"))
local Lighting = cloneref(game:GetService("Lighting"))
local StarterGui = cloneref(game:GetService("StarterGui"))
local Workspace = cloneref(game:GetService("Workspace"))

local LocalPlayer = cloneref(Players.LocalPlayer)

local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled

if identifyexecutor and identifyexecutor() == "Wave" then
	getgenv().gethui = function()
		return game:GetService("CoreGui")
	end
end

local Folder_Configs = {
	Directory = "solixhub",
	Assets = "solixhub/Assets",
	Configs = "solixhub/Configs",
	Datas = "solixhub/Datas",
	Images = "solixhub/Images",
	Themes = "solixhub/Themes"
}

for _, Folder in Folder_Configs do
	if not isfolder(Folder) then
		makefolder(Folder)
	end
end

local GameId = tostring(game.GameId)
local GameConfigFolder = Folder_Configs.Configs .. "/" .. GameId

if not isfolder(GameConfigFolder) then
	makefolder(GameConfigFolder)
end

local GameList = {
	["994732206"] = { id = "ce2e40f0bc2b1720", keyless = false }, -- Blox Fruits 
	["648454481"] = { id = "a873ec9f40a25c5c", keyless = false }, -- Grand Piece Online 
	["66654135"] = { id = "e45bba6c0dc08fad", keyless = false }, -- Murder Mystery 2
    ["7219654364"] = { id = "40ae7ebdcf5a8d40", keyless = false }, -- Sheriff VS Murderer 
	["5595353122"] = { id = "d7305ba1bbb3bd7b", keyless = false }, -- Slayers 2 
	["1511883870"] = { id = "5ac16739ff2ef735", keyless = false }, -- Shindo Life
	["10563114921"] = { id = "d3b0a2eaf4a1522a", keyless = false }, -- Steal An Egg
    ["6035872082"] = { id = "9d318b57c43ebd9d", keyless = false }, -- Rivals
   	["10035204815"] = { id = "85a577643f806078", keyless = false } -- Ride A Pet
}

local LoaderBase = "https://api.polsec.net/loader"

local Config = {
	ProjectId = "7d45ec1510769529",
}

local GameConfig = GameList[GameId]

if not GameConfig then
	StarterGui:SetCore("SendNotification", {
		Title = "Solix Hub",
		Text = "This game is not supported.",
		Icon = "rbxassetid://103638617992222",
	})
	return
end

local ScriptId = GameConfig.id

local ProjectId = type(Config.ProjectId) == "string" and Config.ProjectId or ""
if type(getgenv().PolSec_ProjectId) == "string" and getgenv().PolSec_ProjectId ~= "" then
	ProjectId = getgenv().PolSec_ProjectId
end

if ProjectId == "" then
	StarterGui:SetCore("SendNotification", {
		Title = "Solix Hub",
		Text = "Set Config.ProjectId to your PolSec project ID.",
		Icon = "rbxassetid://103638617992222",
	})
	return
end

LowUnc = not (hookfunction and hookmetamethod)

local LoaderUrl = LoaderBase .. "/" .. ProjectId .. "/" .. ScriptId

local function LoadGame()
	loadstring(game:HttpGet(LoaderUrl))()
end

-- Key system removed: load directly without key validation
script_key = "trail"
getgenv().script_key = "trail"
getgenv().polsec_script_id = ScriptId
LoadGame()
return
