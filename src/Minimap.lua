OnPlayerLogin(function()
  if not EUIDB.darkMinimap then return end

  local compass = MinimapCompassTexture
  compass:SetDesaturated(true)
  compass:SetVertexColor(unpack(EUIDB.frameColor))
end)
