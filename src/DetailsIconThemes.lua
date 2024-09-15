OnPlayerLogin(function()
  if not C_AddOns.IsAddOnLoaded('Details') then return end

  local classInfo = FABLED_CLASS_CIRCLES_DATA.class

  for iconStyle, data in next, classInfo.styles do
    _G.Details:AddCustomIconSet(format('%s%s', classInfo.path, iconStyle), format('%s (Class)', data.name), false)
  end
end)
