SQUARE_TEXTURE = "Interface\\BUTTONS\\WHITE8X8"

AddonDir = "Interface\\AddOns\\EmsUI"
MediaDir = AddonDir.."\\media"
FontsDir = MediaDir.."\\fonts"
TextureDir = MediaDir.."\\textures"

EUI_TEXTURES = {
  buttons = {
    normal = TextureDir.."\\button-normal",
    pushed = TextureDir.."\\buttons\\button-pressed",
    hover = TextureDir.."\\buttons\\ButtonHilight-Square",
    checked = TextureDir.."\\buttons\\button-checked"
  },

  statusBar = TextureDir.."\\status-bar",

  auraBorder = TextureDir.."\\aura-border",

  classCircles = TextureDir.."\\class\\fabled",

  circleTexture = TextureDir.."\\Portrait-ModelBack",
  portraitModelFront = TextureDir.."\\portrait-modelfront",

  minimap = {
    dungeonDifficulty = TextureDir.."\\minimap\\UI-DungeonDifficulty-Button"
  },

  lfg = {
    portraitRoles = TextureDir.."\\lfgframe\\UI-LFG-ICON-PORTRAITROLES",
    roles = TextureDir.."\\lfgframe\\UI-LFG-ICON-ROLES"
  },
}

FABLED_CLASS_CIRCLES_DATA = {
  class = {
		path = [[Interface\AddOns\EmsUI\media\textures\class\]],
		styles = {
			fabled = {
				name = 'Fabled',
				artist = 'Royroyart',
				site = 'https://www.fiverr.com/royyanikhwani',
			},
			fabledrealm = {
				name = 'Fabled Realm',
				artist = 'Handclaw',
				site = 'https://handclaw.artstation.com/',
			},
			fabledpixels = {
				name = 'Fabled Pixels',
				artist = 'Dragumagu',
				site = 'https://www.artstation.com/dragumagu',
			},
		},
    WARRIOR	= {
      texString = '0:128:0:128',
      texCoords = { 0, 0, 0, 0.125, 0.125, 0, 0.125, 0.125 },
    },
    MAGE = {
      texString = '128:256:0:128',
      texCoords = { 0.125, 0, 0.125, 0.125, 0.25, 0, 0.25, 0.125 },
    },
    ROGUE = {
      texString = '256:384:0:128',
      texCoords = { 0.25, 0, 0.25, 0.125, 0.375, 0, 0.375, 0.125 },
    },
      DRUID = {
      texString = '384:512:0:128',
      texCoords = { 0.375, 0, 0.375, 0.125, 0.5, 0, 0.5, 0.125 },
    },
    EVOKER = {
      texString = '512:640:0:128',
      texCoords = { 0.5, 0, 0.5, 0.125, 0.625, 0, 0.625, 0.125 },
    },
    HUNTER = {
      texString = '0:128:128:256',
      texCoords = { 0, 0.125, 0, 0.25, 0.125, 0.125, 0.125, 0.25 },
    },
    SHAMAN = {
      texString = '128:256:128:256',
      texCoords = { 0.125, 0.125, 0.125, 0.25, 0.25, 0.125, 0.25, 0.25 },
    },
    PRIEST = {
      texString = '256:384:128:256',
      texCoords = { 0.25, 0.125, 0.25, 0.25, 0.375, 0.125, 0.375, 0.25 },
    },
    WARLOCK = {
      texString = '384:512:128:256',
      texCoords = { 0.375, 0.125, 0.375, 0.25, 0.5, 0.125, 0.5, 0.25 },
    },
    PALADIN = {
      texString = '0:128:256:384',
      texCoords = { 0, 0.25, 0, 0.375, 0.125, 0.25, 0.125, 0.375 },
    },
    DEATHKNIGHT = {
      texString = '128:256:256:384',
      texCoords = { 0.125, 0.25, 0.125, 0.375, 0.25, 0.25, 0.25, 0.375 },
    },
    MONK = {
      texString = '256:384:256:384',
      texCoords = { 0.25, 0.25, 0.25, 0.375, 0.375, 0.25, 0.375, 0.375 },
    },
    DEMONHUNTER = {
      texString = '384:512:256:384',
      texCoords = { 0.375, 0.25, 0.375, 0.375, 0.5, 0.25, 0.5, 0.375 },
    },
  },
}

CLASS_PORTRAIT_PACKS = {}
local classInfo = FABLED_CLASS_CIRCLES_DATA.class

for iconStyle, data in next, classInfo.styles do
  CLASS_PORTRAIT_PACKS[format('%s%s', classInfo.path, iconStyle)] = format('%s (by %s)', data.name, data.artist)
end

EUI_FONTS = {
  Andika = FontsDir.."\\Andika.ttf",
  Fira = FontsDir.."\\FiraSans.ttf",
  SourceSans = FontsDir.."\\SourceSans3.ttf",
  Marmelad = FontsDir.."\\Marmelad.ttf",
  Bangers = FontsDir.."\\Bangers-Regular.ttf",
}

function tableToWowDropdown(table)
  local wowTable = {}
  for k, v in pairs(table) do
    wowTable[v] = k
  end

  return wowTable
end

EUI_DAMAGE_FONT = FontsDir.."\\Bangers-Regular.ttf"

EUI_BORDER = {
  bgFile = nil,
  edgeFile = SQUARE_TEXTURE,
  tile = false,
  tileSize = 32,
  edgeSize = 2,
  insets = {
    left = 1,
    right = -1,
    top = 1,
    bottom = -1
  },
}

EUI_BUFF_BORDER = {
  bgFile = nil,
  edgeFile = SQUARE_TEXTURE,
  tile = false,
  tileSize = 32,
  edgeSize = 1,
  insets = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
  },
}

function skinNineSlice(ns)
  local nsPoints = {
    "TopLeftCorner",
    "TopRightCorner",
    "BottomLeftCorner",
    "BottomRightCorner",
    "TopEdge",
    "BottomEdge",
    "LeftEdge",
    "RightEdge",
    "Center"
  }

  for _, nsPoint in pairs(nsPoints) do
    ns[nsPoint]:SetTexture(SQUARE_TEXTURE)
  end
end

function styleIcon(ic, bu)
  ic:SetTexCoord(0.1, 0.9, 0.1, 0.9)
end

function applyEuiButtonSkin(bu, icon, isLeaveButton)
  if not bu then return end
  if (bu and bu.rillyClean) then return bu.border end

  -- Icon
  local name = bu:GetName()
  icon = icon or bu.icon or bu.Icon or _G[name.."Icon"]

  bu:SetHighlightTexture(EUI_TEXTURES.buttons.hover)

  local nt = bu:GetNormalTexture()

  if not nt then return end
  nt:SetAllPoints(bu)

  if (isLeaveButton) then
    nt:SetTexCoord(0.2, 0.8, 0.2, 0.8)
  else
    -- Simple button border
    nt:SetTexture(EUI_TEXTURES.buttons.normal)
    nt:SetDrawLayer("ARTWORK")

    local pt = bu:GetPushedTexture()
    pt:SetAllPoints(bu)
    pt:SetTexture(EUI_TEXTURES.buttons.pushed)
    pt:SetDrawLayer("OVERLAY")

    if bu.SetCheckedTexture ~= nil then
      local ct = bu:GetCheckedTexture()
      ct:SetAllPoints(bu)
      ct:SetTexture(EUI_TEXTURES.buttons.checked)
      ct:SetDrawLayer("OVERLAY")
    end
  end

  return border, icon
end

function applyEuiBackdrop(b, frame)
  if (b.rillyClean) then return end

  local frame = CreateFrame("Frame", nil, (frame or b))

  -- Icon
  local name = b:GetName()
  local icon = b.icon or b.Icon or (name and _G[name.."Icon"]) or b
  styleIcon(icon, b)

  -- border
  local back = CreateFrame("Frame", nil, frame, "BackdropTemplate")
  back:SetPoint("TOPLEFT", b, "TOPLEFT", -2, 2)
  back:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 2, -2)
  back:SetFrameLevel(frame:GetFrameLevel())
  back.backdropInfo = EUI_BORDER
  back:ApplyBackdrop()
  back:SetBackdropBorderColor(0,0,0,1)
  b.bg = back

  b.rillyClean = true
  return back, icon
end

function setDefaultFont(textObject, size, outlinestyle)
  if not textObject then return end
  local _, currSize = textObject:GetFont()
  if not size then size = currSize end
  if not outlinestyle then outlinestyle = "THINOUTLINE" end

  textObject:SetFont(EUIDB.font, size, outlinestyle)
end

local cleanBarBackdrop = {
  bgFile = SQUARE_TEXTURE,
  edgeFile = SQUARE_TEXTURE,
  tile = false,
  tileSize = 0,
  edgeSize = 3,
  insets = {
    left = -2,
    right = -2,
    top = -2,
    bottom = -2
  }
}

function skinProgressBar(bar)
  if not bar then return end

  if bar.BorderMid then
    bar.BorderMid:SetAlpha(0)
    bar.BorderLeft:SetAlpha(0)
    bar.BorderRight:SetAlpha(0)
  end

  bar:SetStatusBarTexture(EUI_TEXTURES.statusBar)

  if bar.BarBG then
    bar.BarBG:Hide()
    bar.BarFrame:Hide()
  end

  -- Rilly Clean Border
  if not bar.back then
    local back = CreateFrame("Frame", nil, bar, "BackdropTemplate")
    back:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
    back:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 0, 0)
    back:SetFrameLevel(bar:GetFrameLevel() - 1)
    back.backdropInfo = cleanBarBackdrop
    back:ApplyBackdrop()
    back:SetBackdropBorderColor(0,0,0,1)
    back:SetBackdropColor(0,0,0,1)

    bar.back = back
  end

  bar.rillyClean = true
end
