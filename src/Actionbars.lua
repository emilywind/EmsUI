local function init()
  if not EUIDB.skinActionBars then
    return
  end

  local dominos = C_AddOns.IsAddOnLoaded("Dominos")
  local bartender4 = C_AddOns.IsAddOnLoaded("Bartender4")

  ---------------------------------------
  -- FUNCTIONS
  ---------------------------------------

  if C_AddOns.IsAddOnLoaded("Masque") and (dominos or bartender4) then
    return
  end

  local function skinButton(bu, icon, isLeaveButton)
    applyEuiButtonSkin(bu, icon, isLeaveButton)
  end

  --style extraactionbutton
  local function styleExtraActionButton(bu)
    if not bu or (bu and bu.euiClean) then
      return
    end
    local name = bu:GetName() or bu:GetParent():GetName()
    local style = bu.style or bu.Style
    local icon = bu.icon or bu.Icon
    local cooldown = bu.cooldown or bu.Cooldown
    local ho = _G[name .. "HotKey"]

    --icon
    styleIcon(icon, bu)

    --cooldown
    cooldown:SetAllPoints(icon)

    --hotkey
    if EUIDB.hideHotkeys and ho then
      ho:Hide()
    end

    --apply background
    skinButton(bu, icon)
  end

  --initial style func
  local function styleActionButton(bu)
    if not bu or (bu and bu.euiClean) then
      return
    end
    local action = bu.action
    local name = bu:GetName()
    local ic = _G[name .. "Icon"]
    local co = _G[name .. "Count"]
    local bo = _G[name .. "Border"]
    local ho = _G[name .. "HotKey"]
    local cd = _G[name .. "Cooldown"]
    local na = _G[name .. "Name"]
    local fl = _G[name .. "Flash"]
    local nt = _G[name .. "NormalTexture"]
    local fbg = _G[name .. "FloatingBG"]
    local fob = _G[name .. "FlyoutBorder"]
    local fobs = _G[name .. "FlyoutBorderShadow"]


    if fbg then
      fbg:Hide()
    end --floating background
    --flyout border stuff
    if fob then
      fob:SetTexture(nil)
    end
    if fobs then
      fobs:SetTexture(nil)
    end

    bo:SetTexture(nil) --hide the border (plain ugly, sry blizz)

    --hotkey
    ho:SetTextColor(1, 1, 1, 1)
    if EUIDB.hideHotkeys then
      ho:Hide()
    end

    -- Macro name
    if (EUIDB.hideMacroText) then
      na:Hide()
    end

    if not nt then
      --fix the non existent texture problem (no clue what is causing this)
      nt = bu:GetNormalTexture()
    end

    skinButton(bu, ic)

    if bartender4 then --fix the normaltexture
      nt:SetTexCoord(0, 1, 0, 1)
      nt.SetTexCoord = function()
        return
      end
      bu.SetNormalTexture = function()
        return
      end
    end
  end

  -- style leave button
  local function styleLeaveButton(bu)
    if not bu or (bu and bu.euiClean) then
      return
    end

    skinButton(bu, nil, true)
  end

  --style pet buttons
  local function stylePetButton(bu)
    if not bu or (bu and bu.euiClean) then
      return
    end
    local name = bu:GetName()
    local ic = _G[name .. "Icon"]
    local fl = _G[name .. "Flash"]
    local nt = _G[name .. "NormalTexture2"]
    local cd = _G[name .. "Cooldown"]

    --adjust the cooldown frame
    cd:SetPoint("TOPLEFT", bu, "TOPLEFT", 1, -1)
    cd:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -1, 1)

    skinButton(bu, ic)
  end

  -- Style stance buttons
  local function styleStanceButton(bu)
    if not bu or (bu and bu.euiClean) then
      return
    end
    local name = bu:GetName()
    local ic = _G[name .. "Icon"]
    local fl = _G[name .. "Flash"]
    local nt = _G[name .. "NormalTexture2"]

    skinButton(bu, ic)
  end

  for i = 1, StanceBar.numButtons do
    styleStanceButton(_G["StanceButton" .. i])
  end

  -- Style possess buttons
  local function stylePossessButton(bu)
    if not bu or (bu and bu.euiClean) then
      return
    end
    local name = bu:GetName()
    local ic = _G[name .. "Icon"]
    local fl = _G[name .. "Flash"]
    local nt = _G[name .. "NormalTexture"]
    nt:SetAllPoints(bu)

    skinButton(bu, ic)
  end

  --update hotkey func
  local function updateHotkey(self, actionButtonType)
    local ho = _G[self:GetName() .. "HotKey"]
    if ho and ho:IsShown() then
      ho:Hide()
    end
  end

  if not dominos and not bartender and (EUIDB.hideHotkeys) then
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("UPDATE_BINDINGS")
    frame:RegisterEvent("PLAYER_LOGIN")
    frame:SetScript("OnEvent", function()
        for i = 1, 12 do
            updateHotkey(_G["ActionButton"..i])
            updateHotkey(_G["MultiBarBottomLeftButton"..i])
            updateHotkey(_G["MultiBarBottomRightButton"..i])
            updateHotkey(_G["MultiBarLeftButton"..i])
            updateHotkey(_G["MultiBarRightButton"..i])
        end
        for i = 1, 10 do
            updateHotkey(_G["StanceButton"..i])
            updateHotkey(_G["PetActionButton"..i])
        end
        updateHotkey(ExtraActionButton1)
    end)
  end

  --style the actionbar buttons
  for i = 1, NUM_ACTIONBAR_BUTTONS do
    styleActionButton(_G["ActionButton" .. i])
    styleActionButton(_G["MultiBarBottomLeftButton" .. i])
    styleActionButton(_G["MultiBarBottomRightButton" .. i])
    styleActionButton(_G["MultiBarRightButton" .. i])
    for k = 5, 7 do
      styleActionButton(_G["MultiBar" .. k .. "Button" .. i])
    end
    styleActionButton(_G["MultiBarLeftButton" .. i])
  end

  for i = 1, 6 do
    styleActionButton(_G["OverrideActionBarButton" .. i])
  end
  --style leave button
  styleLeaveButton(MainMenuBarVehicleLeaveButton)
  styleLeaveButton(rABS_LeaveVehicleButton)
  --petbar buttons
  for i = 1, NUM_PET_ACTION_SLOTS do
    stylePetButton(_G["PetActionButton" .. i])
  end
  --possess buttons
  for i = 1, NUM_POSSESS_SLOTS do
    stylePossessButton(_G["PossessButton" .. i])
  end

  --extraactionbutton1
  styleExtraActionButton(ExtraActionButton1)

  --dominos styling
  if dominos then
    print("Dominos found")
    for i = 1, 60 do
      styleActionButton(_G["DominosActionButton" .. i])
    end
  end
  --bartender4 styling
  if bartender4 then
    --print("Bartender4 found")
    for i = 1, 120 do
      styleActionButton(_G["BT4Button" .. i])
      stylePetButton(_G["BT4PetButton" .. i])
    end
  end
end

local a = CreateFrame("Frame")
a:RegisterEvent("PLAYER_LOGIN")
a:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
a:RegisterEvent("EDIT_MODE_LAYOUTS_UPDATED")
a:SetScript("OnEvent", init)
