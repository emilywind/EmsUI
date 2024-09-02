-- Fix for SUI not exposing RaidFrame texture selection --

local function init()
  if C_AddOns.IsAddOnLoaded("SUI") then
    SUI.db.profile.raidframes.texture = SUI.db.profile.general.texture
  end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", init)
