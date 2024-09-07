---------------------
-- Skinning Frames --
---------------------
local function updateTextures(self)
  if self:IsForbidden() then return end
  if self and self:GetName() then
    local name = self:GetName()
    if name and name:match("^Compact") then
      if self:IsForbidden() then return end
      self.healthBar:SetStatusBarTexture(EUI_TEXTURES.statusBar)
      self.healthBar:GetStatusBarTexture():SetDrawLayer("BORDER")
      self.powerBar:SetStatusBarTexture(EUI_TEXTURES.statusBar)
      self.powerBar:GetStatusBarTexture():SetDrawLayer("BORDER")
      self.myHealPrediction:SetTexture(EUI_TEXTURES.statusBar)
      self.otherHealPrediction:SetTexture(EUI_TEXTURES.statusBar)

      self.vertLeftBorder:Hide()
      self.vertRightBorder:Hide()
      self.horizTopBorder:Hide()
      self.horizBottomBorder:Hide()
    end
  end
end

hooksecurefunc("CompactUnitFrame_UpdateAll", function(self)
  updateTextures(self)
end)

-- Hide Titles
CompactPartyFrameTitle:Hide()
