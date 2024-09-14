function init()
  TimerTracker:HookScript("OnEvent", function(self, event, timerType, timeSeconds, totalTime)
    if event ~= "START_TIMER" then return; end

    for i = 1, #self.timerList do
      local prefix = 'TimerTrackerTimer'..i
      local timer = _G[prefix]
      local statusBar = _G['TimerTrackerTimer'..i..'StatusBar']
      if statusBar and not timer.isFree and not timer.euiClean then
        _G[prefix..'StatusBarBorder']:Hide()
        skinProgressBar(statusBar)
      end
    end
  end)

  MirrorTimerContainer:HookScript("OnEvent", function(self, event, timerType, timeSeconds, totalTime)
    if event ~= 'MIRROR_TIMER_START' then return end

    for _, timer in pairs(self.activeTimers) do
      timer.TextBorder:Hide()
      timer.Text:ClearAllPoints()
      timer.Text:SetPoint("CENTER", timer.StatusBar, "CENTER")
      timer.Text:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
      timer.Border:SetVertexColor(0, 0, 0)
    end
  end)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", init)
