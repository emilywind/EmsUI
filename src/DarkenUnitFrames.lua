OnPlayerLogin(function()
  -- Alternate Power Bar
  for i, v in ipairs({
      PlayerFrameAlternateManaBarBorder,
      PlayerFrameAlternateManaBarLeftBorder,
      PlayerFrameAlternateManaBarRightBorder,
      PetFrameTexture
  }) do
      v:SetDesaturated(true)
      v:SetVertexColor(unpack(EUIDB.frameColor))
  end

  -- Player Frame
  PlayerFrame:HookScript("OnUpdate", function()
      PlayerFrame.PlayerFrameContainer.FrameTexture:SetVertexColor(unpack(EUIDB.frameColor))
      PlayerFrame.PlayerFrameContent.PlayerFrameContentContextual.PlayerPortraitCornerIcon:SetVertexColor(unpack(EUIDB.frameColor))
      PlayerFrame.PlayerFrameContainer.AlternatePowerFrameTexture:SetVertexColor(unpack(EUIDB.frameColor))
  end)

  -- Pet Frame
  PetFrame:HookScript("OnUpdate", function()
      PetFrameTexture:SetVertexColor(unpack(EUIDB.frameColor))
  end)

  -- Target Frame
  TargetFrame:HookScript("OnUpdate", function()
      TargetFrame.TargetFrameContainer.FrameTexture:SetVertexColor(unpack(EUIDB.frameColor))
      TargetFrameToT.FrameTexture:SetVertexColor(unpack(EUIDB.frameColor))
  end)

  -- Focus Frame
  FocusFrame:HookScript("OnUpdate", function()
      FocusFrame.TargetFrameContainer.FrameTexture:SetVertexColor(unpack(EUIDB.frameColor))
      FocusFrameToT.FrameTexture:SetVertexColor(unpack(EUIDB.frameColor))
  end)

  -- Totem Bar
  TotemFrame:HookScript("OnEvent", function(self)
      for totem, _ in self.totemPool:EnumerateActive() do
          totem.Border:SetVertexColor(unpack(EUIDB.frameColor))
      end
  end)

  for i = 1, 5 do
    local bossFrame = _G['Boss'..i..'TargetFrame']
    bossFrame:HookScript('OnEvent', function()
      bossFrame.TargetFrameContainer.FrameTexture:SetVertexColor(unpack(EUIDB.frameColor))
    end)
  end

  -- Class Resource Bars
  local _, playerClass = UnitClass("player")

  if (playerClass == 'ROGUE') then
      -- Rogue
      hooksecurefunc(RogueComboPointBarFrame, "UpdatePower", function()
          for bar, _ in RogueComboPointBarFrame.classResourceButtonPool:EnumerateActive() do
              bar.BGActive:SetVertexColor(unpack(EUIDB.frameColor))
              bar.BGInactive:SetVertexColor(unpack(EUIDB.frameColor))
              bar.BGShadow:SetVertexColor(unpack(EUIDB.frameColor))
              if (bar.isCharged) then
                  bar.ChargedFrameActive:SetVertexColor(unpack(EUIDB.frameColor))
              end
          end

          for bar, _ in ClassNameplateBarRogueFrame.classResourceButtonPool:EnumerateActive() do
              bar.BGActive:SetVertexColor(unpack(EUIDB.frameColor))
              bar.BGInactive:SetVertexColor(unpack(EUIDB.frameColor))
              bar.BGShadow:SetVertexColor(unpack(EUIDB.frameColor))
              if (bar.isCharged) then
                  bar.ChargedFrameActive:SetVertexColor(unpack(EUIDB.frameColor))
              end
          end
      end)
  elseif (playerClass == 'MAGE') then
      -- Mage
      hooksecurefunc(MagePowerBar, "UpdatePower", function()
          for bar, _ in MageArcaneChargesFrame.classResourceButtonPool:EnumerateActive() do
              bar.ArcaneBG:SetVertexColor(unpack(EUIDB.frameColor))
              bar.ArcaneBGShadow:SetVertexColor(unpack(EUIDB.frameColor))
          end

          for bar, _ in ClassNameplateBarMageFrame.classResourceButtonPool:EnumerateActive() do
              bar.ArcaneBG:SetVertexColor(unpack(EUIDB.frameColor))
              bar.ArcaneBGShadow:SetVertexColor(unpack(EUIDB.frameColor))
          end
      end)
  elseif (playerClass == 'WARLOCK') then
      -- Warlock
      hooksecurefunc(WarlockPowerFrame, "UpdatePower", function()
          for bar, _ in WarlockPowerFrame.classResourceButtonPool:EnumerateActive() do
              bar.Background:SetVertexColor(unpack(EUIDB.frameColor))
          end

          for bar, _ in ClassNameplateBarWarlockFrame.classResourceButtonPool:EnumerateActive() do
              bar.Background:SetVertexColor(unpack(EUIDB.frameColor))
          end
      end)
  elseif (playerClass == 'DRUID') then
      -- Druid
      hooksecurefunc(DruidComboPointBarFrame, "UpdatePower", function()
          for bar, _ in DruidComboPointBarFrame.classResourceButtonPool:EnumerateActive() do
              bar.BG_Active:SetVertexColor(unpack(EUIDB.frameColor))
              bar.BG_Inactive:SetVertexColor(unpack(EUIDB.frameColor))
              bar.BG_Shadow:SetVertexColor(unpack(EUIDB.frameColor))
          end

          for bar, _ in ClassNameplateBarFeralDruidFrame.classResourceButtonPool:EnumerateActive() do
              bar.BG_Active:SetVertexColor(unpack(EUIDB.frameColor))
              bar.BG_Inactive:SetVertexColor(unpack(EUIDB.frameColor))
              bar.BG_Shadow:SetVertexColor(unpack(EUIDB.frameColor))
          end
      end)
  elseif (playerClass == 'MONK') then
      -- Monk
      hooksecurefunc(MonkHarmonyBarFrame, "UpdatePower", function()
        for bar, _ in MonkHarmonyBarFrame.classResourceButtonPool:EnumerateActive() do
          bar.Chi_BG:SetVertexColor(unpack(EUIDB.frameColor))
          bar.Chi_BG_Active:SetVertexColor(unpack(EUIDB.frameColor))
        end

        for bar, _ in ClassNameplateBarWindwalkerMonkFrame.classResourceButtonPool:EnumerateActive() do
          bar.Chi_BG:SetVertexColor(unpack(EUIDB.frameColor))
          bar.Chi_BG_Active:SetVertexColor(unpack(EUIDB.frameColor))
        end
      end)
  elseif (playerClass == 'DEATHKNIGHT') then
    -- Death Knight
    hooksecurefunc(RuneFrame, "UpdateRunes", function()
      for _, bar in ipairs({
        RuneFrame.Rune1.BG_Active,
        RuneFrame.Rune1.BG_Inactive,
        RuneFrame.Rune1.BG_Shadow,
        RuneFrame.Rune2.BG_Active,
        RuneFrame.Rune2.BG_Inactive,
        RuneFrame.Rune2.BG_Shadow,
        RuneFrame.Rune3.BG_Active,
        RuneFrame.Rune3.BG_Inactive,
        RuneFrame.Rune3.BG_Shadow,
        RuneFrame.Rune4.BG_Active,
        RuneFrame.Rune4.BG_Inactive,
        RuneFrame.Rune4.BG_Shadow,
        RuneFrame.Rune5.BG_Active,
        RuneFrame.Rune5.BG_Inactive,
        RuneFrame.Rune5.BG_Shadow,
        RuneFrame.Rune6.BG_Active,
        RuneFrame.Rune6.BG_Inactive,
        RuneFrame.Rune6.BG_Shadow,
        DeathKnightResourceOverlayFrame.Rune1.BG_Active,
        DeathKnightResourceOverlayFrame.Rune1.BG_Inactive,
        DeathKnightResourceOverlayFrame.Rune1.BG_Shadow,
        DeathKnightResourceOverlayFrame.Rune2.BG_Active,
        DeathKnightResourceOverlayFrame.Rune2.BG_Inactive,
        DeathKnightResourceOverlayFrame.Rune2.BG_Shadow,
        DeathKnightResourceOverlayFrame.Rune3.BG_Active,
        DeathKnightResourceOverlayFrame.Rune3.BG_Inactive,
        DeathKnightResourceOverlayFrame.Rune3.BG_Shadow,
        DeathKnightResourceOverlayFrame.Rune4.BG_Active,
        DeathKnightResourceOverlayFrame.Rune4.BG_Inactive,
        DeathKnightResourceOverlayFrame.Rune4.BG_Shadow,
        DeathKnightResourceOverlayFrame.Rune5.BG_Active,
        DeathKnightResourceOverlayFrame.Rune5.BG_Inactive,
        DeathKnightResourceOverlayFrame.Rune5.BG_Shadow,
        DeathKnightResourceOverlayFrame.Rune6.BG_Active,
        DeathKnightResourceOverlayFrame.Rune6.BG_Inactive,
        DeathKnightResourceOverlayFrame.Rune6.BG_Shadow
      }) do
        bar:SetVertexColor(unpack(EUIDB.frameColor))
      end
    end)
  elseif (playerClass == 'EVOKER') then
    -- Evoker
    hooksecurefunc(EssencePlayerFrame, "UpdatePower", function()
      for bar, _ in EssencePlayerFrame.classResourceButtonPool:EnumerateActive() do
        bar.EssenceFillDone.CircBG:SetVertexColor(unpack(EUIDB.frameColor))
        bar.EssenceFillDone.CircBGActive:SetVertexColor(unpack(EUIDB.frameColor))
      end

      for bar, _ in ClassNameplateBarDracthyrFrame.classResourceButtonPool:EnumerateActive() do
        bar.EssenceFillDone.CircBG:SetVertexColor(unpack(EUIDB.frameColor))
        bar.EssenceFillDone.CircBGActive:SetVertexColor(unpack(EUIDB.frameColor))
      end
    end)
  elseif (playerClass == 'PALADIN') then
    -- Paladin
    hooksecurefunc(PaladinPowerBar, "UpdatePower", function()
      PaladinPowerBarFrame.Background:SetVertexColor(unpack(EUIDB.frameColor))
      PaladinPowerBarFrame.ActiveTexture:Hide()
      ClassNameplateBarPaladinFrame.Background:SetVertexColor(unpack(EUIDB.frameColor))
      ClassNameplateBarPaladinFrame.ActiveTexture:Hide()
    end)
  end
end)
