----------------------------------
-- Buffs/Debuffs on Unit Frames --
----------------------------------
local auraBorder = {
  bgFile = nil,
  edgeFile = SQUARE_TEXTURE,
  tile = false,
  tileSize = 32,
  edgeSize = 2,
  insets = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
  },
}

function applyAuraSkin(aura)
  if aura.border and aura.Border then
    aura.Border:SetAlpha(1)
    aura.border:SetBackdropBorderColor(aura.Border:GetVertexColor())
    aura.Border:SetAlpha(0)
  end

  if aura.euiClean then return end

  --icon
  local icon = aura.Icon
  styleIcon(icon)

  --border
  local border = CreateFrame('Frame', nil, aura, "BackdropTemplate")
  border:SetAllPoints(aura)
  border:SetFrameLevel(aura:GetFrameLevel() - 1)
  border.backdropInfo = auraBorder
  border:ApplyBackdrop()
  border:SetBackdropBorderColor(0,0,0,1)
  border:SetPoint("TOPLEFT", icon, "TOPLEFT", -1, 1)
  border:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 1, -1)
  aura.border = border

  if aura.Border then
    border:SetBackdropBorderColor(aura.Border:GetVertexColor())
    aura.Border:SetAlpha(0)
  else
    border:SetBackdropBorderColor(0,0,0)
  end

  aura.euiClean = true
end
