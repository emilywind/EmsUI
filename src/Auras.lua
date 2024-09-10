----------------------------------
-- Buffs/Debuffs on Unit Frames --
----------------------------------
function applyAuraSkin(aura)
  if aura.border and aura.Border then
    aura.Border:SetAlpha(1)
    aura.border:SetVertexColor(aura.Border:GetVertexColor())
    aura.Border:SetAlpha(0)
  end

  if aura.euiClean then return end

  --icon
  local icon = aura.Icon

  icon:SetTexCoord(0.1,0.9,0.1,0.9)
  icon:ClearAllPoints()
  icon:SetPoint("TOPLEFT", aura, "TOPLEFT", 2, -2)
  icon:SetPoint("BOTTOMRIGHT", aura, "BOTTOMRIGHT", -2, 2)

  --border
  local border = aura:CreateTexture(aura.border, "BACKGROUND", nil, -7)
  border:SetTexture(SQUARE_TEXTURE)
  border:SetTexCoord(0,1,0,1)
  border:SetDrawLayer("BACKGROUND",-7)

  if aura.Border then
    border:SetVertexColor(aura.Border:GetVertexColor())
    aura.Border:SetAlpha(0)
  else
    border:SetVertexColor(0,0,0)
  end

  border:ClearAllPoints()
  border:SetAllPoints(aura)
  aura.border = border

  aura.euiClean = true
end
