local LSM = LibStub("LibSharedMedia-3.0")

-- This table defines the addon's default settings:
local name, EUI = ...
EUIDBDefaults = {
  hideHotkeys = true,
  hideMacroText = true,
  arenaNumbers = false,
  skinActionBars = true,
  darkMinimap = false,
  hideMicroMenu = false,
  hideBagBar = false,

  statusBarTexture = EUI_TEXTURES.statusBar,

  hideAltPower = false,
  lootSpecDisplay = true, -- Display loot spec icon in the player frame

  damageFont = true, -- Change damage font to something cooler
  damageFontChosen = EUI_FONTS.Bangers,
  customFonts = true, -- Update all fonts to something cooler
  font = EUI_FONTS.Andika,

  tooltipAnchor = "ANCHOR_CURSOR_LEFT",

  -- Nameplate Settings
  nameplateNameFontSize = 9,
  nameplateHideServerNames = true,
  nameplateNameLength = 20,
  nameplateFriendlyNamesClassColor = true,
  nameplateFriendlySmall = true,
  nameplateHideCastText = false,
  nameplateShowLevel = true,
  nameplateHealthPercent = true,
  nameplateTotems = true,
  nameplateHideFriendlyHealthbars = false,

  portraitStyle = "3D", -- 3D, 2D, or class (for class icons)
  classPortraitPack = EUI_TEXTURES.classCircles,

  -- PvP Settings
  safeQueue = true,
  tabBinder = true,
  dampeningDisplay = true,
  hideObjectiveTracker = true,

  queueicon = {
    point = 'TOPRIGHT',
    x = -300,
    y = 0,
  },
}

-- This function copies values from one table into another
local function copyDefaults(src, dst)
  -- If no source (defaults) is specified, return an empty table:
  if type(src) ~= "table" then return {} end
  -- If no target (saved variable) is specified, create a new table:
  if type(dst) ~= "table" then dst = {} end
  -- Loop through the source (defaults):
  for k, v in pairs(src) do
    -- If the value is a sub-table:
    if type(v) == "table" then
      -- Recursively call the function:
      dst[k] = copyDefaults(v, dst[k])
    -- Or if the default value type doesn't match the existing value type:
    elseif type(v) ~= type(dst[k]) then
      -- Overwrite the existing value with the default one:
      dst[k] = v
    end
  end
  -- Return the destination table:
  return dst
end

local function euiDefaults()
  -- Copy the values from the defaults table into the saved variables table
  -- if it exists, and assign the result to the saved variable:
  EUIDB = copyDefaults(EUIDBDefaults, EUIDB)

  eui = {}
end

local function resetToDefaults()
  EUIDB = {}
  EUIDB = copyDefaults(EUIDBDefaults, EUIDB)
end

OnPlayerLogin(euiDefaults)

local makePanel = function(frameName, mainpanel, panelName)
  local panel = CreateFrame("Frame", frameName, mainpanel)
  panel.name, panel.parent = panelName, name
  local category = Settings.GetCategory("EmsUI")
  Settings.RegisterCanvasLayoutSubcategory(category, panel, panelName)
end

local function openEuiConfig()
  Settings.OpenToCategory('EmsUI')
end

local function setupEuiOptions()
  LSM_STATUSBAR = tableToWowDropdown(LSM:HashTable('statusbar'))
  LSM_FONTS = tableToWowDropdown(LSM:HashTable('font'))
  -- Creation of the options menu
  eui.panel = CreateFrame( "Frame", "euiPanel", UIParent )
  eui.panel.name = "EmsUI";
  local category = Settings.RegisterCanvasLayoutCategory(eui.panel, "Em's UI")
  category.ID = "EmsUI"
  Settings.RegisterAddOnCategory(category)

  local function newCheckbox(label, description, initialValue, onChange, relativeEl, frame)
    if ( not frame ) then
      frame = eui.panel
    end

    local check = CreateFrame("CheckButton", "RCUICheck" .. label, frame, "InterfaceOptionsCheckButtonTemplate")
    check:SetScript("OnClick", function(self)
      local tick = self:GetChecked()
      onChange(self, tick and true or false)
      if tick then
        PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
      else
        PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
      end
    end)
    check.label = _G[check:GetName() .. "Text"]
    check.label:SetText(label)
    check.tooltipText = label
    check.tooltipRequirement = description
    check:SetChecked(initialValue)
    if (relativeEl) then
      check:SetPoint("TOPLEFT", relativeEl, "BOTTOMLEFT", 0, -8)
    else
      check:SetPoint("TOPLEFT", 16, -16)
    end
    return check
  end

  local function newDropdown(label, options, initialValue, width, onChange)
    local dropdownText = eui.panel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    dropdownText:SetText(label)

    local dropdown = CreateFrame("Frame", "RCUIDropdown" .. label, eui.panel, "UIDropdownMenuTemplate")
    _G[dropdown:GetName() .. "Middle"]:SetWidth(width)
    dropdown:SetPoint("TOPLEFT", dropdownText, "BOTTOMLEFT", 0, -8)
    local displayText = _G[dropdown:GetName() .. "Text"]
    displayText:SetText(options[initialValue])

    dropdown.initialize = function()
      local selected, info = displayText:GetText(), {}
      info.func = function(v)
        displayText:SetText(v:GetText())
        onChange(v.value)
      end
      for value, label in pairs(options) do
        info.text = label
        info.value = value
        info.checked = info.text == selected
        UIDropDownMenu_AddButton(info)
      end
    end
    return dropdownText, dropdown
  end

  local function newSlider(frameName, label, configVar, min, max, relativeEl, frame, onChanged)
    local slider = CreateFrame("Slider", frameName, frame, "OptionsSliderTemplate")
    slider:SetMinMaxValues(min, max)
    slider:SetValue(EUIDB[configVar])
    slider:SetValueStep(1)
    slider:SetWidth(110)
    local textFrame = (frameName .. 'Text')
    slider:SetScript("OnValueChanged", function(_, v)
      v = floor(v)
      _G[textFrame]:SetFormattedText(label, v)
      EUIDB[configVar] = v
      if onChanged ~= nil and type(onChanged) == "function" then
        onChanged(v)
      end
    end)
    _G[(frameName .. 'Low')]:SetText(min)
    _G[(frameName .. 'High')]:SetText(max)
    _G[textFrame]:SetFormattedText(label, EUIDB[configVar])
    slider:SetPoint("TOPLEFT", relativeEl, "BOTTOMLEFT", 0, -24)

    return slider
  end

  local version = C_AddOns.GetAddOnMetadata("EmsUI", "Version")

  local rcuiTitle = eui.panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
  rcuiTitle:SetPoint("TOPLEFT", 16, -16)
  rcuiTitle:SetText("Em's UI ("..version..")")

  local portraitSelect, portraitDropdown = newDropdown(
    "Portrait Style",
    {["3D"] = "3D", ["class"] = "Class", ["default"] = "Default"},
    EUIDB.portraitStyle,
    50,
    function(value)
      EUIDB.portraitStyle = value
    end
  )
  portraitSelect:SetPoint("TOPLEFT", rcuiTitle, "BOTTOMLEFT", 0, -16)

  local classPortraitPack = newDropdown(
    "Class Portrait Pack",
    CLASS_PORTRAIT_PACKS,
    EUIDB.classPortraitPack,
    200,
    function(value)
      EUIDB.classPortraitPack = value
    end
  )
  classPortraitPack:SetPoint("LEFT", portraitSelect, "RIGHT", 50, 0)

  local tooltipAnchor, tooltipDropdown = newDropdown(
    "Tooltip Cursor Anchor",
    {["ANCHOR_CURSOR_LEFT"] = "Bottom Right", ["ANCHOR_CURSOR_RIGHT"] = "Bottom Left", ['DEFAULT'] = 'Disabled'},
    EUIDB.tooltipAnchor,
    100,
    function(value)
      EUIDB.tooltipAnchor = value
    end
  )
  tooltipAnchor:SetPoint("TOPLEFT", portraitDropdown, "BOTTOMLEFT", 0, -16)

  local lootSpecDisplay = newCheckbox(
    "Display Loot Spec Indicator",
    "Display loot spec icon in your player portrait.",
    EUIDB.lootSpecDisplay,
    function(self, value)
      EUIDB.lootSpecDisplay = value
    end,
    tooltipDropdown
  )

  local statusBarChooser = newDropdown(
    "Status Bar Texture",
    LSM_STATUSBAR,
    EUIDB.statusBarTexture,
    200,
    function(value)
      EUIDB.statusBarTexture = value
    end
  )
  statusBarChooser:SetPoint("LEFT", lootSpecDisplay, "RIGHT", 300, 32)

  local hideAltPower = newCheckbox(
    "Hide Alt Power (Requires reload)",
    "Hides alt power bars on character frame such as combo points or holy power to clean it up, when preferring WeakAura or etc.",
    EUIDB.hideAltPower,
    function(self, value)
      EUIDB.hideAltPower = value
    end,
    lootSpecDisplay
  )

  local customFonts = newCheckbox(
    "Use Custom Fonts (Requires Reload)",
    "Use custom fonts with support for Cyrillic and other character sets",
    EUIDB.customFonts,
    function(self, value)
      EUIDB.customFonts = value
    end,
    hideAltPower
  )

  local fontChooser = newDropdown(
    "Font",
    LSM_FONTS,
    EUIDB.font,
    200,
    function(value)
      EUIDB.font = value
    end
  )
  fontChooser:SetPoint("LEFT", hideAltPower, "RIGHT", 300, 0)

  local damageFont = newCheckbox(
    "Use Custom Damage Font",
    "Use custom damage font, Bangers.",
    EUIDB.damageFont,
    function(self, value)
      EUIDB.damageFont = value
    end,
    customFonts
  )

  local damageFontChooser = newDropdown(
    "Damage Font",
    LSM_FONTS,
    EUIDB.damageFontChosen,
    200,
    function(value)
      EUIDB.damageFontChosen = value
    end
  )
  damageFontChooser:SetPoint("LEFT", damageFont, "RIGHT", 300, 0)

  local hideMicroMenu = newCheckbox(
    'Hide Micro Menu',
    'Hides the micro menu, preserving the queue status icon',
    EUIDB.hideMicroMenu,
    function(self, value)
      EUIDB.hideMicroMenu = value
      setMicroMenuVisibility()
    end,
    damageFont
  )

  local hideBagBar = newCheckbox(
    'Hide Bag Bar',
    'Hides the bag bar',
    EUIDB.hideBagBar,
    function(self, value)
      EUIDB.hideBagBar = value
      setBagBarVisibility()
    end,
    hideMicroMenu
  )

  local darkMinimap = newCheckbox(
    "Dark Minimap",
    "Make the outline of the Minimap dark",
    EUIDB.darkMinimap,
    function(self, value)
      EUIDB.darkMinimap = value
    end,
    hideBagBar
  )

  ----------------
  -- Action Bars --
  ----------------
  makePanel("EUI_ActionBars", eui.panel, "Action Bars")

  local actionbarText = EUI_ActionBars:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  actionbarText:SetText("Action Bars")
  actionbarText:SetPoint("TOPLEFT", 16, -16)

  local skinActionBars = newCheckbox(
    "Skin Action Bars",
    "Applies various skins to action bars.",
    EUIDB.skinActionBars,
    function(self, value)
      EUIDB.skinActionBars = value
    end,
    actionbarText,
    EUI_ActionBars
  )

  local hideHotkeys = newCheckbox(
    "Hide Hotkeys on Action Bars",
    "Hides keybinding text on your action bar buttons.",
    EUIDB.hideHotkeys,
    function(self, value)
      EUIDB.hideHotkeys = value
    end,
    skinActionBars,
    EUI_ActionBars
  )

  local hideMacroText = newCheckbox(
    "Hide Macro Text on Action Bars",
    "Hides macro text on your action bar buttons.",
    EUIDB.hideMacroText,
    function(self, value)
      EUIDB.hideMacroText = value
    end,
    hideHotkeys,
    EUI_ActionBars
  )

  ----------------
  -- Nameplates --
  ----------------
  makePanel("EUI_Nameplates", eui.panel, "Nameplates")

  local nameplateText = EUI_Nameplates:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  nameplateText:SetText("Nameplates")
  nameplateText:SetPoint("TOPLEFT", 16, -16)

  local nameplateFontSlider = newSlider(
    "RCUI_NameplateFontSlider",
    FONT_SIZE.." "..FONT_SIZE_TEMPLATE,
    "nameplateNameFontSize",
    6,
    20,
    nameplateText,
    EUI_Nameplates
  )

  local nameplateNameLength = newCheckbox(
    "Abbreviate Unit Names",
    "Abbreviate long NPC names on nameplates.",
    EUIDB.nameplateNameLength > 0,
    function(self, value)
      if value == true then
        EUIDB.nameplateNameLength = 20
      else
        EUIDB.nameplateNameLength = 0
      end
    end,
    nameplateFontSlider,
    EUI_Nameplates
  )

  local nameplateHideServerNames = newCheckbox(
    "Hide Server Names (Must rezone to see change).",
    "Hide server names for players from different servers to reduce clutter.",
    EUIDB.nameplateHideServerNames,
    function(self, value)
      EUIDB.nameplateHideServerNames = value
    end,
    nameplateNameLength,
    EUI_Nameplates
  )

  local nameplateFriendlyNamesClassColor = newCheckbox(
    "Class Colour Friendly Names",
    "Colours friendly players' names on their nameplates.",
    EUIDB.nameplateFriendlyNamesClassColor,
    function(self, value)
      EUIDB.nameplateFriendlyNamesClassColor = value
    end,
    nameplateHideServerNames,
    EUI_Nameplates
  )

  local nameplateFriendlySmall = newCheckbox(
    "Smaller Friendly Nameplates",
    "Reduce size of friendly nameplates to more easily distinguish friend from foe",
    EUIDB.nameplateFriendlySmall,
    function(self, value)
      EUIDB.nameplateFriendlySmall = value
      SetFriendlyNameplateSize(true)
    end,
    nameplateFriendlyNamesClassColor,
    EUI_Nameplates
  )

  local nameplateShowLevel = newCheckbox(
    "Show Level",
    "Show player/mob level on nameplate",
    EUIDB.nameplateShowLevel,
    function(self, value)
      EUIDB.nameplateShowLevel = value
    end,
    nameplateFriendlySmall,
    EUI_Nameplates
  )

  local nameplateShowHealth = newCheckbox(
    "Show Health Percentage",
    "Show percentages of health on nameplates",
    EUIDB.nameplateHealthPercent,
    function(self, value)
      EUIDB.nameplateHealthPercent = value
    end,
    nameplateShowLevel,
    EUI_Nameplates
  )

  local nameplateTotems = newCheckbox(
    "Show icon above Totems, Warbanner, Psyfied, and Demonic Tyrant",
    "Show icon above key NPCs",
    EUIDB.nameplateTotems,
    function(self, value)
      EUIDB.nameplateTotems = value
    end,
    nameplateShowHealth,
    EUI_Nameplates
  )

  local nameplateHideCastText = newCheckbox(
    "Hide Cast Text",
    "Hide cast text from nameplate castbars.",
    EUIDB.nameplateHideCastText,
    function(self, value)
      EUIDB.nameplateHideCastText = value
    end,
    nameplateTotems,
    EUI_Nameplates
  )

  local nameplateHideFriendlyHealthbars = newCheckbox(
    "Hide Friendly Health Bars",
    "Hide health bars for friendly players.",
    EUIDB.nameplateHideFriendlyHealthbars,
    function(self, value)
      EUIDB.nameplateHideFriendlyHealthbars = value
    end,
    nameplateHideCastText,
    EUI_Nameplates
  )

  ----------------
  --     PvP    --
  ----------------
  makePanel("EUI_PvP", eui.panel, "PvP")

  local pvpText = EUI_PvP:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  pvpText:SetText("PvP")
  pvpText:SetPoint("TOPLEFT", 16, -16)

  local safeQueue = newCheckbox(
    "Safe Queue",
    "Hide Leave Queue button and show timer for Arena/RBG queues.",
    EUIDB.safeQueue,
    function(self, value)
      EUIDB.safeQueue = value
    end,
    pvpText,
    EUI_PvP
  )

  local dampeningDisplay = newCheckbox(
    "Dampening Display",
    "Display Dampening % under remaining time at the top of the screen in arenas.",
    EUIDB.dampeningDisplay,
    function(self, value)
      EUIDB.dampeningDisplay = value
    end,
    safeQueue,
    EUI_PvP
  )

  local tabBinder = newCheckbox(
    "Tab Binder",
    "Tab-target only between players in Arenas and BGs.",
    EUIDB.tabBinder,
    function(self, value)
      EUIDB.tabBinder = value
    end,
    dampeningDisplay,
    EUI_PvP
  )

  local arenaNumbers = newCheckbox(
    "Show Arena Numbers on nameplates in arenas",
    "Show Arena number (i.e. 1, 2, 3 etc) on top of nameplates in arenas instead of player names to assist with macro use awareness",
    EUIDB.arenaNumbers,
    function(self, value)
      EUIDB.arenaNumbers = value
    end,
    tabBinder,
    EUI_PvP
  )

  local hideObjectiveTracker = newCheckbox(
    "Hide Objective Tracker in Battlegrounds",
    "",
    EUIDB.hideObjectiveTracker,
    function(self, value)
      EUIDB.hideObjectiveTracker = value
    end,
    arenaNumbers,
    EUI_PvP
  )

  ------------------
  --Reload Button --
  ------------------
  local reload = CreateFrame("Button", "resettodefaults", eui.panel, "UIPanelButtonTemplate")
  reload:SetPoint("BOTTOMLEFT", eui.panel, "BOTTOMLEFT", 10, 10)
  reload:SetSize(120,22)
  reload:SetText("Reset to Defaults")
  reload:SetScript("OnClick", function()
    resetToDefaults()
    ReloadUI()
  end)

  local reload = CreateFrame("Button", "reload", eui.panel, "UIPanelButtonTemplate")
  reload:SetPoint("BOTTOMRIGHT", eui.panel, "BOTTOMRIGHT", -10, 10)
  reload:SetSize(100,22)
  reload:SetText("Reload")
  reload:SetScript("OnClick", function()
    ReloadUI()
  end)

  SLASH_emsui1 = "/emsui"

  SlashCmdList["emsui"] = function()
    openEuiConfig()
  end

  local function EmsUIGameMenuButton(self)
    self:AddSection()
    self:AddButton("Em's UI", openEuiConfig)
  end
  hooksecurefunc(GameMenuFrame, "InitButtons", EmsUIGameMenuButton)
end

OnPlayerLogin(etupEuiOptions)
