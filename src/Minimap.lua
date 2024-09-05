local f = CreateFrame('Frame')
f:RegisterEvent('PLAYER_LOGIN')
f:SetScript('OnEvent', function()
  local compass = MinimapCompassTexture
  compass:SetDesaturated(true)
  compass:SetVertexColor(0, 0, 0)
end)
