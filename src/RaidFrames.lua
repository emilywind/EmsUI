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

      local roleIcon = _G[name..'RoleIcon']
      if roleIcon then
        roleIcon:SetTexture(EUI_TEXTURES.lfg.portraitRoles)
      end

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
