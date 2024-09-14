---------------------
-- Skinning Frames --
---------------------
local function updateTextures(self)
  if self:IsForbidden() then return end
  if self and self:GetName() then
    local name = self:GetName()
    if name and name:match("^Compact") then
      if self:IsForbidden() then return end
      self.healthBar:SetStatusBarTexture(EUIDB.statusBarTexture)
      self.healthBar:GetStatusBarTexture():SetDrawLayer("BORDER")
      self.powerBar:SetStatusBarTexture(EUIDB.statusBarTexture)
      self.powerBar:GetStatusBarTexture():SetDrawLayer("BORDER")
      self.myHealPrediction:SetTexture(EUIDB.statusBarTexture)
      self.otherHealPrediction:SetTexture(EUIDB.statusBarTexture)

      self.vertLeftBorder:Hide()
      self.vertRightBorder:Hide()
      self.horizTopBorder:Hide()
      self.horizBottomBorder:Hide()
      self.background:SetTexture(SQUARE_TEXTURE)
      self.background:SetVertexColor(0.15, 0.15, 0.15, 0.9)

      if self.CcRemoverFrame then
        applyEuiBackdrop(self.CcRemoverFrame)
      end
    end
  end
end

hooksecurefunc("CompactUnitFrame_UpdateAll", updateTextures)
