ConsumeTracker = { }

function ConsumeTracker:OnInitialize()
    ClassicGuildBank:RegisterChatCommand('contra', 'ShowMainFrame')
    ContraFrameHideButton:SetScript("OnClick", function(self)
        ContraFrame:Hide()
        end
    )
    ContraFrameStartButton:SetScript("OnClick", function(self))
        self:StartTracking()
        end
    )
    ContraFrameStopButton:SetScript("OnClick", function(self))
        self:StopTracking()
        end
    )
end

function ConsumeTracker:ShowMainFrame()
    ContraFrame:Show()
end

function ConsumeTracker:StartTracking()
    print("Start")
    
end

function ConsumeTracker:StopTracking()
    print("Stop")
end