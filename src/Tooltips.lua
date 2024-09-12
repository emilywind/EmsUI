local function GetDifficultyLevelColor(level)
	level = (level - tt.playerLevel);
	if (level > 4) then
		return "|cffff2020"; -- red
	elseif (level > 2) then
		return "|cffff8040"; -- orange
	elseif (level >= -2) then
		return "|cffffff00"; -- yellow
	elseif (level >= -GetQuestGreenRange()) then
		return "|cff40c040"; -- green
	else
		return "|cff808080"; -- gray
	end
end

local function getUnitHealthColor(unit)
	local r, g, b

	if (UnitIsPlayer(unit)) then
		r, g, b = GetClassColor(select(2,UnitClass(unit)))
	else
		r, g, b = GameTooltip_UnitColor(unit)
		if (g == 0.6) then g = 0.9 end
		if (r==1 and g==1 and b==1) then r, g, b = 0, 0.9, 0.1 end
	end

	return r, g, b
end

local colours = {
  guildColour = { 0.74, 0.55, 0.95 },
}

local CF=CreateFrame("Frame")
CF:RegisterEvent("PLAYER_LOGIN")
CF:SetScript("OnEvent", function(self, event)
	if C_AddOns.IsAddOnLoaded('TinyTooltip') or C_AddOns.IsAddOnLoaded('TipTac') then
		return
	end

	-- Tooltips anchored on mouse
	hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self, parent)
		if (InCombatLockdown() or EUIDB.tooltipAnchor == 'DEFAULT') then
	    self:SetOwner(parent, "ANCHOR_NONE")
		else
			self:SetOwner(parent, EUIDB.tooltipAnchor)
		end
	end)

	local bar = GameTooltipStatusBar
	bar.bg = bar:CreateTexture('GameTooltipStatusBarBackground', "BACKGROUND")
	bar.bg:SetAllPoints(bar)
	bar.bg:SetTexture(SQUARE_TEXTURE)
	bar.bg:SetVertexColor(0.2, 0.2, 0.2)

	bar.TextString = bar:CreateFontString('GameToolTipTextStatus', "OVERLAY", "TextStatusBar")
	bar.TextString:SetPoint("CENTER")
	setDefaultFont(bar.TextString, 11)
	bar.TextString.capNumericDisplay = true
	bar.TextString.lockShow = 1

	-- Gametooltip statusbar
	bar:SetStatusBarTexture(EUIDB.statusBarTexture)
	bar:ClearAllPoints()
	bar:SetPoint("LEFT", 3, 0)
	bar:SetPoint("RIGHT", -3, 0)
	bar:SetPoint("BOTTOM", 0, -7)
	bar:SetHeight(10)

	-- Class colours
	function onTooltipSetUnit(self)
    if self ~= GameTooltip then return end

    skinNineSlice(GameTooltip.NineSlice)
    GameTooltip.NineSlice:SetCenterColor(0.08, 0.08, 0.08)
	  GameTooltip.NineSlice:SetBorderColor(0, 0, 0, 0)

    local tooltip = GameTooltip
		local _, unit = tooltip:GetUnit()
		if  not unit then return end
		local level = UnitEffectiveLevel(unit)
		local r, g, b = getUnitHealthColor(unit)

		if UnitIsPlayer(unit) then
			local className, class = UnitClass(unit)
			local race = UnitRace(unit)

			if (level < 0) then
				level = "??"
			end

			local text = GameTooltipTextLeft1:GetText()
			GameTooltipTextLeft1:SetFormattedText("|cff%02x%02x%02x%s|r", r * 255, g * 255, b * 255, text:match("|cff\x\x\x\x\x\x(.+)|r") or text)

			local guildName, guildRank = GetGuildInfo(unit)
			if (guildName) then
				guildLine = GameTooltipTextLeft2
				guildLine:SetText(guildName .. ' - ' .. guildRank)
        guildLine:SetTextColor(unpack(colours.guildColour))
			end
		end

		local family = UnitCreatureFamily(unit)
		if (family) then -- UnitIsBattlePetCompanion(unit);
			GameTooltipTextLeft2:SetText(level .. " " .. family)
		end
	end

  TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, onTooltipSetUnit)

	GameTooltipStatusBar:HookScript("OnValueChanged", function(self, hp)
		local unit = "mouseover"
	  local focus = GetMouseFoci()
	  if (focus and focus.unit) then
      unit = focus.unit
	  end

		local value = UnitHealth(unit)
		local valueMax = UnitHealthMax(unit)

    local textString = self.TextString
		textString:UpdateTextStringWithValues(textString, value, 0, valueMax)

	  local r, g, b = getUnitHealthColor(unit)

	  self:SetStatusBarColor(r, g, b)
	end)
end)
