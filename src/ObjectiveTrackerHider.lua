local frame = CreateFrame('Frame')
frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:SetScript('OnEvent', function()
  if not EUIDB.hideObjectiveTracker then return end

  local instanceType = select(2, IsInInstance())

  if instanceType == 'pvp' then
    ObjectiveTrackerFrame:SetAlpha(0)
    RegisterStateDriver(ObjectiveTrackerFrame, 'visibility', 'hide')
  else
    ObjectiveTrackerFrame:SetAlpha(1)
    RegisterStateDriver(ObjectiveTrackerFrame, 'visibility', 'show')
  end
end)
