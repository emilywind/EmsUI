----------------------------------
-- Buffs/Debuffs on Unit Frames --
----------------------------------
function applyAuraSkin(aura)
  if aura.border and aura.Border then
    aura.Border:SetAlpha(1)
    setEuiBorderColor(aura.border, aura.Border:GetVertexColor())
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
    setEuiBorderColor(border, aura.Border:GetVertexColor())
    aura.Border:SetAlpha(0)
  else
    if EUIDB.uiStyle == "BetterBlizz" then
      setEuiBorderColor(border, unpack(EUIDB.frameColor))
    else
      setEuiBorderColor(border, 0, 0, 0)
    end
  end

  aura.euiClean = true
end
