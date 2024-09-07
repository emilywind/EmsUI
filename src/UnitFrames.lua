EmsUIUnitFrames = CreateFrame("Frame", "EmsUIUnitFrames")
EmsUIUnitFrames:RegisterEvent("PLAYER_LOGIN")

EmsUIUnitFrames:SetScript("OnEvent", function()
	-------------------------
	-- Hide Alt Power bars --
	-------------------------
	if (EUIDB.hideAltPower) then
		local altPowerBars = {
			PaladinPowerBarFrame,
			PlayerFrameAlternateManaBar,
			MageArcaneChargesFrame,
			MonkHarmonyBarFrame,
			MonkStaggerBar,
			RuneFrame,
			ComboPointPlayerFrame,
			WarlockPowerFrame,
			TotemFrame
		}

		for _, altPowerBar in pairs(altPowerBars) do
			altPowerBar:SetAlpha(0)
			RegisterStateDriver(altPowerBar, "visibility", "hide")
		end
	end

  local function healthTexture(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        self.healthbar:SetStatusBarTexture(EUI_TEXTURES.statusBar)
        self.healthbar:GetStatusBarTexture():SetDrawLayer("BORDER")
        self.healthbar.AnimatedLossBar:SetStatusBarTexture(EUI_TEXTURES.statusBar)
        self.healthbar.AnimatedLossBar:GetStatusBarTexture():SetDrawLayer("BORDER")
    end
  end

  local function manaTexture(self)
    if self and self.manabar then
      -- Get Power Color
      local powerColor = PowerBarColor[self.manabar.powerType]

      -- Set Texture
      self.manabar.texture:SetTexture(EUI_TEXTURES.statusBar)

      -- Set Power Color
      if self.manabar.powerType == 0 then
          self.manabar:SetStatusBarColor(0, 0.5, 1)
      else
          self.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
      end
    end
  end

  PlayerFrame:HookScript("OnEvent", function(self, event)
    healthTexture(self, event)
    manaTexture(self, event)
  end)

  PetFrame:HookScript("OnEvent", function(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
      self.healthbar:SetStatusBarTexture(EUI_TEXTURES.statusBar)
      self.healthbar:GetStatusBarTexture():SetDrawLayer("BORDER")
    end
  end)

  ------------------
  -- Target Frame --
  ------------------
  local function targetHealthTexture(self)
    if self:IsForbidden() then return end

    -- Set Textures
    self.healthbar:SetStatusBarTexture(EUI_TEXTURES.statusBar)
    self.healthbar:GetStatusBarTexture():SetDrawLayer("BORDER")
    if self.myHealPrediction then
        self.myHealPredictionBar:SetTexture(EUI_TEXTURES.statusBar)
    end
  end

  hooksecurefunc(TargetFrame, "OnEvent", function(self)
      targetHealthTexture(self)

      -- Style Buffs & Debuffs
      for aura, _ in self.auraPools:EnumerateActive() do
        applyAuraSkin(aura)
      end
    end)

    hooksecurefunc(FocusFrame, "OnEvent", function(self)
        -- Set Health Texture
        targetHealthTexture(self)

        -- Style Buffs & Debuffs
        for aura, _ in self.auraPools:EnumerateActive() do
            applyAuraSkin(aura)
        end
    end)

    hooksecurefunc(TargetFrameToT, "Update", function(self)
      targetHealthTexture(self)
    end)

    hooksecurefunc(FocusFrameToT, "Update", function(self)
      targetHealthTexture(self)
    end)

  -----------------
  -- Boss Frames --
  -----------------
  function SkinBossFrames(self, event)
      if self then
          if self.healthbar then
              self.healthbar:SetStatusBarTexture(EUI_TEXTURES.statusBar)
          end

          if self.TargetFrameContent.TargetFrameContentMain.ReputationColor then
              self.TargetFrameContent.TargetFrameContentMain.ReputationColor:SetVertexColor(0, 0, 0)
          end
      end
    end

    --hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", SUIBossFramesText)
    Boss1TargetFrame:HookScript("OnEvent", function(self, event)
      SkinBossFrames(self, event)
    end)

    Boss2TargetFrame:HookScript("OnEvent", function(self, event)
      SkinBossFrames(self, event)
    end)

    Boss3TargetFrame:HookScript("OnEvent", function(self, event)
      SkinBossFrames(self, event)
    end)

    Boss4TargetFrame:HookScript("OnEvent", function(self, event)
      SkinBossFrames(self, event)
    end)

    Boss5TargetFrame:HookScript("OnEvent", function(self, event)
      SkinBossFrames(self, event)
    end)

    ----------
    -- Misc --
    ----------
    local function unitManaTexture(self)
      if self and self.powerType then
        if self.unit ~= 'player' then
          -- Get Power Color
          local powerColor = PowerBarColor[self.powerType]

          -- Set Texture
          self.texture:SetTexture(EUI_TEXTURES.statusBar)

          -- Set Power Color
          if self.unitFrame and self.unitFrame.manabar then
            if self.powerType == 0 then
              self.unitFrame.manabar:SetStatusBarColor(0, 0.5, 1)
            else
              self.unitFrame.manabar:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
            end
          end
      end
    end
  end

  local function alternatePowerTexture(self)
    if self then
      local powerColor = PowerBarColor[self.powerType]
      self:SetStatusBarTexture(EUI_TEXTURES.statusBar)
      if self.powerType and self.powerType == 0 then
        self:SetStatusBarColor(0, 0.5, 1)
      elseif self.powerType and self.powerType ~= 0 then
        self:SetStatusBarColor(powerColor.r, powerColor.g, powerColor.b)
      end
    end
  end

  hooksecurefunc("UnitFrameManaBar_Update", function(self)
    unitManaTexture(self)
  end)

  AlternatePowerBar:HookScript("OnEvent", alternatePowerTexture)

    -------------------
    -- Class Colours --
    -------------------
    TargetFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:Hide()
    FocusFrame.TargetFrameContent.TargetFrameContentMain.ReputationColor:Hide()

    function SetUnitColour(healthbar, unit)
        healthbar:SetStatusBarDesaturated(1)
        if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
            _, class = UnitClass(unit)
            local color = RAID_CLASS_COLORS[class]
            healthbar:SetStatusBarColor(color.r, color.g, color.b)
        elseif UnitIsPlayer(unit) and (not UnitIsConnected(unit)) then
            healthbar:SetStatusBarColor(0.5, 0.5, 0.5);
        else
            if UnitExists(unit) then
                if (UnitIsTapDenied(unit)) and not UnitPlayerControlled(unit) then
                    healthbar:SetStatusBarColor(0.5, 0.5, 0.5)
                elseif (not UnitIsTapDenied(unit)) then
                    local reaction = FACTION_BAR_COLORS[UnitReaction(unit, "player")];
                    if reaction then
                        healthbar:SetStatusBarColor(reaction.r, reaction.g, reaction.b);
                    end
                end
            end
        end
    end

    hooksecurefunc("UnitFrameHealthBar_Update", function(self)
        SetUnitColour(self, self.unit)
    end)
    hooksecurefunc("HealthBar_OnValueChanged", function(self)
        SetUnitColour(self, self.unit)
    end)
end)
