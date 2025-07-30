local function TurnCheck_CL()
    Client.GetPage("map1").GetControl("Turn").GetChild("Turn_num").text = turn

    Client.RunLater(TurnCheck_CL, 0.1)  -- 0.1초마다 턴 체크
end

local function StageUI()
        Client.GetPage("map1").GetControl("Stage").GetChild("Stage_num").text = stage
end

local function TurnCheck()
    Client.FireEvent("turn", turn)
    Client.RunLater(TurnCheck, 0.1)  -- 0.1초마다 턴 체크
end

Client.RunLater(StageUI, 0.1)
Client.RunLater(TurnCheck_CL, 0.1)
TurnCheck()
Client.controller.canJump = false -- 점프 비활성화