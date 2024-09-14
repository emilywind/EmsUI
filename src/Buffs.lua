local buffBorder = {
  bgFile = nil,
  edgeFile = SQUARE_TEXTURE,
  tile = false,
  tileSize = 32,
  edgeSize = 2,
  insets = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
  },
}

local function applySkin(aura, isDebuff)
  if isDebuff and aura.border then
    aura.DebuffBorder:SetAlpha(1)
    aura.border:SetBackdropBorderColor(aura.DebuffBorder:GetVertexColor())
    aura.DebuffBorder:SetAlpha(0)
  end

  if aura.euiClean then return end

  if aura.TempEnchantBorder then aura.TempEnchantBorder:Hide() end

  --icon
  local icon = aura.Icon
  styleIcon(icon)

  if not icon.SetTexCoord then return end

  --border
  local border = CreateFrame('Frame', nil, aura, "BackdropTemplate")
  border:SetAllPoints(aura)
  border:SetFrameLevel(aura:GetFrameLevel() - 1)
  border.backdropInfo = buffBorder
  border:ApplyBackdrop()
  border:SetBackdropBorderColor(0,0,0,1)
  border:SetBackdropColor(0,0,0,1)
  border:SetPoint("TOPLEFT", icon, "TOPLEFT", -2, 2)
  border:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 2, -2)
  aura.border = border

  if aura.Border then
    border:SetVertexColor(aura.Border:GetVertexColor())
    aura.Border:Hide()
  else
    border:SetBackdropBorderColor(0,0,0)
  end

  if isDebuff then
    border:SetBackdropBorderColor(aura.DebuffBorder:GetVertexColor())
    aura.DebuffBorder:SetAlpha(0)
  end

  local duration = aura.Duration
  if duration then
    duration:SetDrawLayer("OVERLAY")
  end

  --set button styled variable
  aura.euiClean = true
end

local function updateAuras(self, isDebuff)
  local auras = self.auraFrames

  for index, aura in pairs(auras) do
    local frame = select(index, self.AuraContainer:GetChildren())
    if not frame then return end

    applySkin(frame, isDebuff)
  end
end

hooksecurefunc(BuffFrame, "UpdateAuraButtons", function(self) updateAuras(self, false) end)
hooksecurefunc(DebuffFrame, "UpdateAuraButtons", function(self) updateAuras(self, true) end)
