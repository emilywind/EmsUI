local function applySkin(aura, isDebuff)
  if isDebuff and aura.border then
    aura.DebuffBorder:SetAlpha(1)
    aura.border:SetVertexColor(aura.DebuffBorder:GetVertexColor())
    aura.DebuffBorder:SetAlpha(0)
  end

  if aura.euiClean then return end

  if aura.TempEnchantBorder then aura.TempEnchantBorder:Hide() end

  --icon
  local icon = aura.Icon
  styleIcon(icon)

  if not icon.SetTexCoord then return end

  --border
  local border = aura:CreateTexture(nil, "BACKGROUND")
  border:SetTexture(EUI_TEXTURES.auraBorder)
  border:SetPoint("TOPLEFT", icon, "TOPLEFT", -3, 3)
  border:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 3, -3)
  aura.border = border

  local background = aura:CreateTexture(nil, "BACKGROUND")
  background:SetAllPoints(icon)
  background:SetTexture(SQUARE_TEXTURE)

  if aura.Border then
    border:SetVertexColor(aura.Border:GetVertexColor())
    aura.Border:Hide()
  else
    border:SetVertexColor(0,0,0)
  end

  if isDebuff then
    border:SetVertexColor(aura.DebuffBorder:GetVertexColor())
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
