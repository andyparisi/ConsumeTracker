ConsumeTracker = { }
SLASH_CONSUMETRACKER1 = '/contra'

function ConsumeTracker:ShowMainFrame()
    ContraFrame:Show()
end

function ConsumeTracker:StartTracking()
    ContraFrame:SetScript("OnEvent", function(self, event, ...)
        if event == "UNIT_AURA" then
            print("AURA" .. event) 
            end
        end
    )    
end

function ConsumeTracker:StopTracking()
    print("Stop")
end

function SlashCmdList.CONSUMETRACKER(msg, editBox) -- 4.
    ConsumeTracker:ShowMainFrame()
end

function ConsumeTracker:Initialize()
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

ConsumeTracker:Initialize()