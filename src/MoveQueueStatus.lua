local frame = CreateFrame('Frame')
frame:RegisterEvent('PLAYER_LOGIN')
frame:SetScript('OnEvent', function()
  local LEM = LibStub('LibEditMode')

  local db = EUIDB

  -- Queue Status Icon
  local function queueIconPos(frame, layoutName, point, x, y)
    db.queueicon.point = point
    db.queueicon.x = x
    db.queueicon.y = y
  end

  LEM:AddFrame(QueueStatusButton, queueIconPos)

  LEM:RegisterCallback('enter', function()
    if QueueStatusButton:IsVisible() then
      inQueue = true
    else
      inQueue = false
    end
    QueueStatusButton:Show()
  end)

  LEM:RegisterCallback('exit', function()
    if not inQueue then
      QueueStatusButton:Hide()
    end
  end)

  LEM:RegisterCallback('layout', function(layoutName)
    QueueStatusButton:SetPoint(db.queueicon.point, UIParent, db.queueicon.point, db.queueicon.x, db.queueicon.y)
  end)
end)
