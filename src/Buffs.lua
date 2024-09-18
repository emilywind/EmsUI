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
  local border = applyEuiBackdrop(icon, aura)

  aura.border = border

  if aura.Border then
    border:SetBackdropBorderColor(aura.Border:GetVertexColor())
    aura.Border:Hide()
  else
    border:SetBackdropBorderColor(unpack(EUIDB.frameColor))
  end

  if isDebuff then
    border:SetBackdropBorderColor(aura.DebuffBorder:GetVertexColor())
    aura.DebuffBorder:SetAlpha(0)
  end

  local duration = aura.Duration
  if duration then
    -- duration:SetDrawLayer("OVERLAY")
    local point, relativeTo, relativePoint, xOfs = duration:GetPoint()
    local yOfs = point == "TOP" and -2 or 2
    duration:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs)
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
