ConsumeTracker = LibStub("AceAddon-3.0"):NewAddon("ConsumeTracker", "AceConsole-3.0", "AceEvent-3.0")
local playerGUID = UnitGUID("player")
local outputString = ""
local buffs = {}

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function ConsumeTracker:ShowMainFrame()
    ContraFrame:Show()
end

function ConsumeTracker:AddBuff(sourceGUID, spellName, timestamp)
    if spellName == "Fire Protection" or spellName == "Arcane Protection" then
        buffs[sourceGUID]["flags"][timestamp .. " - " .. spellName] = true
    end
end

function ConsumeTracker:CreateReport()
    local reportString = ""

    for index, source in ipairs(buffs) do
        reportString = reportString .. "\n" .. "Player: " .. source["name"]
        reportString = reportString .. "\n" .. "Buffs: "

        for i = 1, #source do
            reportString = reportString .. source[i] .. ", "
        end

        reportString = reportString .. "\n\n"
    end

    ContraFrameScrollText:SetText(reportString)
end

function ContraFrame:COMBAT_LOG_EVENT_UNFILTERED(selfevent, timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, _spellSCHOOL, auraTYPE_failTYPE)
    timestamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellID, spellName, _spellSCHOOL, auraTYPE_failTYPE = CombatLogGetCurrentEventInfo()
    if UnitIsPlayer(sourceGUID) and UnitInRaid(sourceGUID) and event == "SPELL_CAST_SUCCESS" then
        local ts = date("%Y/%m/%d %H:%M:%S", timestamp)
        outputString = outputString .. ts .. "\n" .. sourceName .. "\n".. spellName .. spellID .. "\n\n"
        ContraFrameScrollText:SetText(outputString)

        -- Build the table of buffs for the player
        if buffs[sourceGUID] == nil then
            buffs[sourceGUID] = {
                ["name"] = sourceName,
                ["flags"] = {}
            }
        end

        ConsumeTracker:AddBuff(sourceGUID, spellName, ts)
    end
end

function ConsumeTracker:StartTracking()
    ContraFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") 
end

function ConsumeTracker:StopTracking()
    ContraFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED") 
end

function ConsumeTracker:OnInitialize()
    ConsumeTracker:RegisterChatCommand('contra', 'ShowMainFrame')
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