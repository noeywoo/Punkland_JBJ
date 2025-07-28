local function TurnCheck_CL()
    Client.GetTopic("turn").Add(function(x)
    Client.GetPage("map1").GetControl("Turn").GetChild("Turn_num").text = x
end)
    Client.RunLater(TurnCheck_CL, 0.1)  -- 0.1초마다 턴 체크
end

local function StageUI()
    Client.GetTopic("Stage").Add(function(x)
        Client.GetPage("map1").GetControl("Stage").GetChild("Stage_num").text = x
    end)
end

Client.RunLater(StageUI, 0.1)
Client.RunLater(TurnCheck_CL, 0.1)

Client.controller.canJump = false -- 점프 비활성화