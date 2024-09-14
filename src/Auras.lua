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
  styleIcon(icon)

  --border
  local border = applyEuiBackdrop(icon, aura)
  aura.border = border

  if aura.Border then
    border:SetVertexColor(aura.Border:GetVertexColor())
    aura.Border:SetAlpha(0)
  else
    border:SetVertexColor(0,0,0)
  end

  aura.euiClean = true
end
