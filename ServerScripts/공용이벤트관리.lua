Server.GetTopic("공용000").Add(function(text)
unit.StartGlobalEvent(000)
end)

Server.GetTopic("공용001").Add(function(text)
unit.StartGlobalEvent(001)
end)

Server.GetTopic("공용002").Add(function(text)
unit.StartGlobalEvent(002)
end)

Server.GetTopic("공용003").Add(function(text)
unit.StartGlobalEvent(003)
end)

Server.GetTopic("공용006").Add(function(text)
unit.StartGlobalEvent(006)
end)

Server.GetTopic("공용004").Add(function(text)
unit.StartGlobalEvent(004)
end)

Server.GetTopic("공용005").Add(function(text)
unit.StartGlobalEvent(005)
end)

Server.GetTopic("공용007").Add(function(text)
unit.StartGlobalEvent(007)
end)

local function CheckBossHP()
    if Server.GetWorldVar(8) == 1 then
        Server.FireEvent("보스hp", 1)
        Server.SetWorldVar(8, 0)  -- 보스 HP 이벤트가 발생했음을 표시
    end
    Server.RunLater(CheckBossHP, 0.5)  -- 재귀 호출로 루프
end

CheckBossHP()  -- 최초 실행
