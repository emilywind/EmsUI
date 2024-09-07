function applyAuraSkin(aura)
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
  border:SetVertexColor(0,0,0)
  border:ClearAllPoints()
  border:SetAllPoints(aura)
  aura.border = border

  aura.euiClean = true
end
