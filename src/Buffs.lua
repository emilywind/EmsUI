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
  if consolidated then
    if select(1,UnitFactionGroup("player")) == "Alliance" then
      icon:SetTexture(select(3,C_Spell.GetSpellInfo(61573)))
    elseif select(1,UnitFactionGroup("player")) == "Horde" then
      icon:SetTexture(select(3,C_Spell.GetSpellInfo(61574)))
    end
  end

  if not icon.SetTexCoord then return end

  --border
  local border = aura:CreateTexture(aura.border, "OVERLAY")
  border:SetTexture(EUI_TEXTURES.auraBorder)

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

  border:SetAllPoints(icon)
  aura.border = border

  if aura.duration then
    aura.duration:SetDrawLayer("OVERLAY")
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
