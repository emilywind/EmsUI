----------------
-- Player
----------------
PlayerCastingBarFrame:HookScript("OnEvent", function()
    PlayerCastingBarFrame.StandardGlow:Hide()
    PlayerCastingBarFrame.TextBorder:Hide()
    PlayerCastingBarFrame:SetSize(209, 18)
    PlayerCastingBarFrame.TextBorder:ClearAllPoints()
    PlayerCastingBarFrame.TextBorder:SetAlpha(0)
    PlayerCastingBarFrame.Text:ClearAllPoints()
    PlayerCastingBarFrame.Text:SetPoint("TOP", PlayerCastingBarFrame, "TOP", 0, -1)
    PlayerCastingBarFrame.Text:SetFont(RCUIDB.font, 12, "OUTLINE")

    PlayerCastingBarFrame.Border:SetVertexColor(0, 0, 0)
    PlayerCastingBarFrame.Background:SetVertexColor(0, 0, 0)

    PlayerCastingBarFrame.Icon:Show()
    PlayerCastingBarFrame.Icon:SetSize(20, 20)
end)

--------------
-- Target
--------------
TargetFrameSpellBar:HookScript("OnEvent", function(self)
    if self:IsForbidden() then return end
    if InCombatLockdown() then return end

    self.Icon:SetSize(16, 16)
    self.Icon:ClearAllPoints()
    self.Icon:SetPoint("TOPLEFT", self, "TOPLEFT", -20, 2)
    self.BorderShield:ClearAllPoints()
    self.BorderShield:SetPoint("CENTER", self.Icon, "CENTER", 0, -2.5)
    self:SetSize(150, 12)
    self.TextBorder:ClearAllPoints()
    self.TextBorder:SetAlpha(0)
    self.Text:ClearAllPoints()
    self.Text:SetPoint("TOP", self, "TOP", 0, 1.5)
    self.Text:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
    self.Border:SetVertexColor(0, 0, 0)
    self.Background:SetVertexColor(0, 0, 0)


    local castText = self.Text:GetText()
    if castText ~= nil then
        if (strlen(castText) > 19) then
            local newCastText = strsub(castText, 0, 19)
            self.Text:SetText(newCastText .. "...")
        end
    end
end)

--------------
-- Focus
--------------
FocusFrameSpellBar:HookScript("OnEvent", function(self)
    if self:IsForbidden() then return end
    if InCombatLockdown() then return end

    self.Icon:SetSize(16, 16)
    self.Icon:ClearAllPoints()
    self.Icon:SetPoint("TOPLEFT", FocusFrameSpellBar, "TOPLEFT", -20, 2)
    self.BorderShield:ClearAllPoints()
    self.BorderShield:SetPoint("CENTER", self.Icon, "CENTER", 0, -2.5)
    self:SetSize(150, 12)
    self.TextBorder:ClearAllPoints()
    self.TextBorder:SetAlpha(0)
    self.Text:ClearAllPoints()
    self.Text:SetPoint("TOP", self, "TOP", 0, 1.5)
    self.Text:SetFont(STANDARD_TEXT_FONT, 11, "OUTLINE")
    self.Border:SetVertexColor(0, 0, 0)
    self.Background:SetVertexColor(0, 0, 0)

    local castText = self.Text:GetText()
    if castText ~= nil then
        if (strlen(castText) > 19) then
            local newCastText = strsub(castText, 0, 19)
            self.Text:SetText(newCastText .. "...")
        end
    end
end)

---------------------
-- Timers
---------------------
local frame = CreateFrame('Frame')
frame:RegisterEvent('PLAYER_LOGIN')
frame:SetScript('OnEvent', function()
    local format = string.format
    local max = math.max
    local FONT = RCUIDB.font

    if not InCombatLockdown() then
        PlayerCastingBarFrame.timer = PlayerCastingBarFrame:CreateFontString(nil)
        PlayerCastingBarFrame.timer:SetFont(FONT, 14, "THINOUTLINE")
        PlayerCastingBarFrame.timer:SetPoint("LEFT", PlayerCastingBarFrame, "RIGHT", 5, 0)
        PlayerCastingBarFrame.update = 0.1
        TargetFrameSpellBar.timer = TargetFrameSpellBar:CreateFontString(nil)
        TargetFrameSpellBar.timer:SetFont(FONT, 11, "THINOUTLINE")
        TargetFrameSpellBar.timer:SetPoint("LEFT", TargetFrameSpellBar, "RIGHT", 4, 0)
        TargetFrameSpellBar.update = 0.1
        FocusFrameSpellBar.timer = FocusFrameSpellBar:CreateFontString(nil)
        FocusFrameSpellBar.timer:SetFont(FONT, 11, "THINOUTLINE")
        FocusFrameSpellBar.timer:SetPoint("LEFT", FocusFrameSpellBar, "RIGHT", 4, 0)
        FocusFrameSpellBar.update = 0.1
    end

    local function CastingBarFrame_OnUpdate_Hook(self, elapsed)
        if not self.timer then return end
        if self.update and self.update < elapsed then
            if self.casting then
                self.timer:SetText(format("%.1f", max(self.maxValue - self.value, 0)))
            elseif self.channeling then
                self.timer:SetText(format("%.1f", max(self.value, 0)))
            else
                self.timer:SetText("")
            end
            self.update = .1
        else
            self.update = self.update - elapsed
        end
    end

    PlayerCastingBarFrame:HookScript("OnUpdate", CastingBarFrame_OnUpdate_Hook)
    TargetFrameSpellBar:HookScript("OnUpdate", CastingBarFrame_OnUpdate_Hook)
    FocusFrameSpellBar:HookScript("OnUpdate", CastingBarFrame_OnUpdate_Hook)
end)
