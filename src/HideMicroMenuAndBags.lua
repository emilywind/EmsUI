function setMicroMenuVisibility()
    local micromenuVisible = not EUIDB.hideMicroMenu
    for _, button in pairs({
        CharacterMicroButton, SpellbookMicroButton, TalentMicroButton,
        QuestLogMicroButton, GuildMicroButton, LFDMicroButton,
        EJMicroButton, StoreMicroButton, MainMenuMicroButton,
        CollectionsMicroButton, HelpMicroButton, AchievementMicroButton
    }) do
        button:SetShown(micromenuVisible)
    end

    StoreMicroButton:SetShown(micromenuVisible)
    StoreMicroButton:GetParent():SetShown(micromenuVisible)
end

function setBagBarVisibility()
    local bagsVisible = not EUIDB.hideBags
    MainMenuBarBackpackButton:SetShown(bagsVisible)
    BagBarExpandToggle:SetShown(bagsVisible)
    for i = 0, 3 do
      _G['CharacterBag' .. i .. 'Slot']:SetShown(bagsVisible)
    end
    CharacterReagentBag0Slot:SetShown(bagsVisible)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent('EDIT_MODE_LAYOUTS_UPDATED')
frame:SetScript("OnEvent", function(self)
  setMicroMenuVisibility()
  setBagBarVisibility()
end)
