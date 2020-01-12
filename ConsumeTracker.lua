ConsumeTracker = LibStub("AceAddon-3.0"):NewAddon("ConsumeTracker", "AceConsole-3.0", "AceEvent-3.0")
local playerGUID = UnitGUID("player")
local outputString = ""

function ConsumeTracker:ShowMainFrame()
    ContraFrame:Show()
end

function ContraFrame:COMBAT_LOG_EVENT_UNFILTERED(selfevent, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, _spellSCHOOL, auraTYPE_failTYPE)
    timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, _spellSCHOOL, auraTYPE_failTYPE = CombatLogGetCurrentEventInfo()
    if sourceGUID == playerGUID and event == "SPELL_CAST_SUCCESS" then
        outputString = outputString .. timestamp .. "\n" .. sourceName .. "\n".. spellName .. "\n\n"
        ContraFrameScrollText:SetText(outputString)
    end
end

function ConsumeTracker:StartTracking()
    print("start")
end

function ConsumeTracker:StopTracking()
    print("Stop")
end

function ConsumeTracker:OnInitialize()
    ConsumeTracker:RegisterChatCommand('contra', 'ShowMainFrame')
    ContraFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") 
    ContraFrame:SetScript("OnEvent", function(self, event, ...) 
        if self[event] then 
            return self[event](self, event, ...) 
        end 
    end);

    ContraFrameHideButton:SetScript("OnClick", function(self)
        ContraFrame:Hide()
        end
    )
    ContraFrameStartButton:SetScript("OnClick", function(self)
        ConsumeTracker:StartTracking()
        end
    )
    ContraFrameStopButton:SetScript("OnClick", function(self)
        ConsumeTracker:StopTracking()
        end
    )
end