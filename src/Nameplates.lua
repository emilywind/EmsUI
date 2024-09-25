OnPlayerLogin(function()
  local defaultFriendlyWidth, defaultFriendlyHeight = C_NamePlate.GetNamePlateFriendlySize()

  function SetFriendlyNameplateSize(isChange)
    if EUIDB.nameplateFriendlySmall then
      C_NamePlate.SetNamePlateFriendlySize((0.5 * defaultFriendlyWidth), defaultFriendlyHeight)
    elseif isChange then
      C_NamePlate.SetNamePlateFriendlySize(defaultFriendlyWidth, defaultFriendlyHeight)
    end
  end
  SetFriendlyNameplateSize()

  -------------------------------------------------------
  -- Red color when below 30% on Personal Resource Bar --
  -------------------------------------------------------
  hooksecurefunc("CompactUnitFrame_UpdateHealth", function(frame)
    if frame:IsForbidden() then return end

    local healthPercentage = ceil((UnitHealth(frame.displayedUnit) / UnitHealthMax(frame.displayedUnit) * 100))
    local isPersonal = C_NamePlate.GetNamePlateForUnit(frame.unit) == C_NamePlate.GetNamePlateForUnit("player")

    if isPersonal then
      if not frame.emsUISkinned then
        local healthTex = EUI_TEXTURES.newBlizzHealthBar
        local powerTex = EUI_TEXTURES.newBlizzPowerBar
        if EUIDB.uiStyle == "RillyClean" then
          healthTex = EUIDB.statusBarTexture
          powerTex = EUIDB.statusBarTexture
        end
        frame.healthBar:SetStatusBarTexture(healthTex)
        ClassNameplateManaBarFrame:SetStatusBarTexture(powerTex)
        ClassNameplateManaBarFrame.FeedbackFrame.BarTexture:SetTexture(powerTex)
        ClassNameplateManaBarFrame.FeedbackFrame.LossGlowTexture:SetTexture(powerTex)
        frame.emsUISkinned = true
      end
      if frame.optionTable.colorNameBySelection and not frame:IsForbidden() then
        if healthPercentage <= 100 and healthPercentage >= 30 then
          frame.healthBar:SetStatusBarColor(0, 1, 0)
        elseif healthPercentage < 30 then
          frame.healthBar:SetStatusBarColor(1, 0, 0)
        end
      end
    end

    if not frame.isNameplate then return end

    if not frame.healthPercentage then
      frame.healthPercentage = frame.healthBar:CreateFontString(frame.healthPercentage, "OVERLAY", "GameFontNormalSmall")
      setDefaultFont(frame.healthPercentage, EUIDB.nameplateNameFontSize - 1)
      frame.healthPercentage:SetTextColor( 1, 1, 1 )
      frame.healthPercentage:SetPoint("CENTER", frame.healthBar, "CENTER", 0, 0)
    end

    if EUIDB.nameplateHealthPercent and healthPercentage ~= 100 then
      frame.healthPercentage:SetText(healthPercentage .. '%')
    else
      frame.healthPercentage:SetText('')
    end
  end)

  -- Keep nameplates on screen
  SetCVar("nameplateOtherBottomInset", 0.1)
  SetCVar("nameplateOtherTopInset", 0.08)

  function abbrev(str, length)
    if ( not str ) then
        return UNKNOWN
    end

    length = length or 20

    str = (string.len(str) > length) and string.gsub(str, "%s?(.[\128-\191]*)%S+%s", "%1. ") or str
    return str
  end

  hooksecurefunc(NamePlateDriverFrame, "AcquireUnitFrame", function(_, nameplate)
    if (nameplate.UnitFrame) then
      nameplate.UnitFrame.isNameplate = true
    end
  end)

  local function setTrue(table, member)
    TextureLoadingGroupMixin.AddTexture(
      { textures = table }, member
    )
  end

  local function modifyNamePlates(frame, options)
    if ( frame:IsForbidden() ) then return end

    local healthBar = frame.healthBar
    if EUIDB.uiStyle == "BetterBlizz" then
      healthBar:SetStatusBarTexture(EUI_TEXTURES.newBlizzHealthBar)
    else
      healthBar:SetStatusBarTexture(EUIDB.statusBarTexture)
    end

    local castBar = frame.castBar
    if (castBar) then
      if EUIDB.nameplateHideCastText then
        castBar.Text:Hide()
      end

      if (castBar.euiClean) then return end

      setDefaultFont(castBar.Text, EUIDB.nameplateNameFontSize - 1)

      applyEuiBackdrop(castBar.Icon, castBar)

      castBar.euiClean = true
    end

    if (frame.ClassificationFrame) then
      frame.ClassificationFrame:SetPoint('CENTER', frame.healthBar, 'LEFT', 0, 0)
    end
  end

  hooksecurefunc("DefaultCompactNamePlateFrameSetup", modifyNamePlates)

  hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
    if not frame.unit or not frame.isNameplate then return end

    local isFriendlyPlayer = UnitIsPlayer(frame.unit) and UnitIsFriend("player", frame.unit)
    if isFriendlyPlayer and EUIDB.nameplateHideFriendlyHealthbars then
      setTrue(DefaultCompactNamePlateFrameSetUpOptions, 'hideHealthbar')
    end

    if frame:IsForbidden() then return end

    local isPersonal = UnitIsUnit(frame.displayedUnit, "player")
    if ( isPersonal ) then
      if ( frame.levelText ) then
        frame.levelText:SetText('')
      end
      return
    end

    setDefaultFont(frame.name, EUIDB.nameplateNameFontSize)

    local hasArenaNumber = false

    if EUIDB.arenaNumbers and IsActiveBattlefieldArena() and UnitIsPlayer(frame.unit) and UnitIsEnemy("player", frame.unit) then -- Check to see if unit is a player to avoid needless checks on pets
      for i = 1, 5 do
        if UnitIsUnit(frame.unit, "arena" .. i) then
          frame.name:SetText(i)
          hasArenaNumber = true
          break
        end
      end
    end

    -- if C_AddOns.IsAddOnLoaded("Details") then
    --   local isEnemyPlayer = UnitIsPlayer(frame.unit)
    --   if isEnemyPlayer then
    --     local guid = UnitGUID(frame.unit)
    --     local specId = Details:GetSpecByGUID(guid)
    --     if specId then
    --       local role = GetSpecializationRole(specId)

    --       if not frame.roleIcon then
    --         frame.roleIcon = frame.healthBar:CreateTexture(nil, "OVERLAY")
    --         frame.roleIcon:SetPoint("LEFT", frame.healthBar, "LEFT", 1, 0)
    --         frame.roleIcon:SetTexture(EUI_TEXTURES.lfg.portraitRoles)
    --       end

    --       frame.roleIcon:Show()

    --       if role == "DAMAGE" then
    --         frame.roleIcon:SetTexCoord(0.33, 0.58, 0.36, 0.61)
    --       elseif role == "HEALER" then
    --         frame.roleIcon:SetTexCoord(0.33, 0.58, 0.03, 0.28)
    --       elseif role == "TANK" then
    --         frame.roleIcon:SetTexCoord(0.16, 0.47, 0.36, 0.61)
    --       else
    --         frame.roleIcon:Hide()
    --       end
    --     end
    --   end
    -- end

    if EUIDB.nameplateFriendlyNamesClassColor and UnitIsPlayer(frame.unit) and UnitIsFriend("player", frame.displayedUnit) then
      local _,className = UnitClass(frame.displayedUnit)
      local classR, classG, classB = GetClassColor(className)

      frame.name:SetTextColor(classR, classG, classB, 1)
    end

    if (EUIDB.nameplateShowLevel) then
      if not frame.levelText then
        frame.levelText = frame.healthBar:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        local isLargeNameplates = tonumber(GetCVar("nameplateVerticalScale")) >= 2.7
        frame.levelText:SetPoint("RIGHT", frame.healthBar, "RIGHT", -1, 0)
      end
      frame.unitLevel = UnitEffectiveLevel(frame.unit)
      local c = GetCreatureDifficultyColor(frame.unitLevel)
      local unitClassification = UnitClassification(frame.unit)
      if unitClassification == 'rare' or unitClassification == 'rareelite' then
        c = {
          r = 0.8,
          g = 0.8,
          b = 0.8
        }
      end

      local levelText = frame.unitLevel
      local levelSuffix = ''
      if (levelText < 0) then
        levelText = '|TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:12|t'
      else
        if (unitClassification == 'elite') then
          levelSuffix = '+'
        elseif (unitClassification == 'rareelite') then
          levelSuffix = '*+'
        elseif (unitClassification == 'worldboss') then
          levelSuffix = '++'
        elseif (unitClassification == 'rare') then
          levelSuffix = '*'
        elseif (unitClassification == 'minus') then
          levelSuffix = '-'
        end
      end
      frame.levelText:SetTextColor( c.r, c.g, c.b )
      frame.levelText:SetText(levelText .. levelSuffix)
      frame.levelText:Show()
    elseif (not EUIDB.nameplateShowLevel) then
      if (frame.levelText) then
        frame.levelText:SetText('')
        frame.levelText:Hide()
      end
    end

    if not hasArenaNumber and (EUIDB.nameplateHideServerNames or EUIDB.nameplateNameLength > 0) then
      local name, realm = UnitName(frame.displayedUnit) or UNKNOWN

      if not EUIDB.nameplateHideServerNames and realm then
        name = name.." - "..realm
      end

      if EUIDB.nameplateNameLength > 0 then
        name = abbrev(name, EUIDB.nameplateNameLength)
      end

      frame.name:SetText(name)
    end
  end)
end)
