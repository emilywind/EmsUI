---------------------
-- Skinning Frames --
---------------------
local function updateTextures(self)
  if self:IsForbidden() then return end
  if self and self:GetName() then
    local name = self:GetName()
    if name and name:match("^Compact") then
      if self:IsForbidden() then return end

      local healthTex = EUIDB.healthBarTex
      local powerTex = EUIDB.powerBarTex

      self.healthBar:SetStatusBarTexture(healthTex)
      self.healthBar:GetStatusBarTexture():SetDrawLayer("BORDER")
      self.powerBar:SetStatusBarTexture(powerTex)
      self.powerBar:GetStatusBarTexture():SetDrawLayer("BORDER")
      self.myHealPrediction:SetTexture(healthTex)
      self.otherHealPrediction:SetTexture(healthTex)

      self.vertLeftBorder:Hide()
      self.vertRightBorder:Hide()
      self.horizTopBorder:Hide()
      self.horizBottomBorder:Hide()
      self.background:SetTexture(SQUARE_TEXTURE)
      self.background:SetVertexColor(0.15, 0.15, 0.15, 0.9)

      if self.CcRemoverFrame then
        applyEuiBackdrop(self.CcRemoverFrame.Icon, self.CcRemoverFrame)
      end

      local debuffFrame = self.DebuffFrame
      if debuffFrame then
        if not debuffFrame.euiBorder then
          local border = applyEuiBackdrop(debuffFrame.Icon, debuffFrame)
          debuffFrame.euiBorder = border
        end

        if debuffFrame.Border then
          debuffFrame.Border:SetAlpha(1)
          setEuiBorderColor(debuffFrame.euiBorder, debuffFrame.Border:GetVertexColor())
          debuffFrame.Border:SetAlpha(0)
        end
      end
    end
  end
end

hooksecurefunc("CompactUnitFrame_UpdateAll", updateTextures)
