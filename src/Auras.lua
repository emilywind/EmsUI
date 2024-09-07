function applyAuraSkin(b)
  if not b or (b and b.euiClean) then return end

  --icon
  local icon = b.Icon
  if consolidated then
    if select(1,UnitFactionGroup("player")) == "Alliance" then
      icon:SetTexture(select(3,C_Spell.GetSpellInfo(61573)))
    elseif select(1,UnitFactionGroup("player")) == "Horde" then
      icon:SetTexture(select(3,C_Spell.GetSpellInfo(61574)))
    end
  end

  icon:SetTexCoord(0.1,0.9,0.1,0.9)
  icon:ClearAllPoints()
  icon:SetPoint("TOPLEFT", b, "TOPLEFT", 2, -2)
  icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -2, 2)
  -- icon:SetDrawLayer("BACKGROUND",-8)

  --border
  local border = b:CreateTexture(b.border, "BACKGROUND", nil, -7)
  border:SetTexture(SQUARE_TEXTURE)
  border:SetTexCoord(0,1,0,1)
  border:SetDrawLayer("BACKGROUND",-7)
  if tempenchant then
    border:SetVertexColor(0.7,0,1)
  elseif not debuff then
    border:SetVertexColor(0,0,0)
  end
  border:ClearAllPoints()
  border:SetAllPoints(b)
  b.border = border

  --shadow
  local back = CreateFrame("Frame", b.back, b, "BackdropTemplate")
  back:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
  back:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 0, 0)
  back:SetFrameLevel(b:GetFrameLevel() - 1)
  back.backdropInfo = EUI_BUFF_BORDER
  back:ApplyBackdrop()
  back:SetBackdropBorderColor(0,0,0,1)

  b.euiClean = true
end

-- local CF=CreateFrame("Frame")
-- CF:RegisterEvent("PLAYER_LOGIN")
-- CF:SetScript("OnEvent", function(self, event)
--   --apply aura frame texture func
--     local function skinPartyAuras(self)
-- 		for i = 1, 4 do
-- 			local prefix = ("PartyMemberFrame"..i)

-- 			_G[prefix .. "Texture"]:SetTexture(TextureDir .. "\\UI-PartyFrame")
-- 			_G[prefix.."Flash"]:SetTexture(TextureDir .. "\\UI-PARTYFRAME-FLASH")
-- 			_G[prefix.."HealthBar"]:SetStatusBarTexture(EUIDB.statusBarTexture)
-- 			_G[prefix.."HealthBar"]:SetHeight(6)
-- 			_G[prefix.."ManaBar"]:SetStatusBarTexture(EUIDB.statusBarTexture)
-- 			_G[prefix.."ManaBar"]:SetHeight(6)

-- 			for i = 1, 20 do
-- 				local b = _G[prefix .. "Buff" .. i]
--         if b and not b.euiClean then
--           local name = b:GetName()

--           --icon
--           local icon = _G[name.."Icon"]

--           icon:SetTexCoord(0.1,0.9,0.1,0.9)
--           icon:ClearAllPoints()
--           icon:SetPoint("TOPLEFT", b, "TOPLEFT", 2, -2)
--           icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -2, 2)

--           -- --border
--           -- local border = _G[name.."Border"] or b:CreateTexture(name.."Border", "BACKGROUND", b, -7)
--           -- border:SetTexture(SQUARE_TEXTURE)
--           -- border:SetTexCoord(0,1,0,1)
--           -- border:SetDrawLayer("BACKGROUND",-7)
--           -- border:SetVertexColor(0,0,0)

--           -- --shadow
--           -- local back = CreateFrame("Frame", name.."Shadow", b, "BackdropTemplate")
--           -- back:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
--           -- back:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 0, 0)
--           -- back:SetFrameLevel(b:GetFrameLevel() - 1)
--           -- back.backdropInfo = EUI_BUFF_BORDER
--           -- back:ApplyBackdrop()
--           -- back:SetBackdropBorderColor(0,0,0,1)

--           b.euiClean = true
--         end
--       end
--     end
--   end

--   hooksecurefunc("PartyMemberFrame_UpdateMember", skinPartyAuras)
-- end)
