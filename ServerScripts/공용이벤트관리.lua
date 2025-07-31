Server.GetTopic("짝수턴").Add(function(text)
unit.StartGlobalEvent(001)
end)

Server.GetTopic("홀수턴").Add(function(text)
unit.StartGlobalEvent(002)
end)

Server.GetTopic("피격음출력").Add(function(text)
unit.StartGlobalEvent(004)
end)

Server.GetTopic("위로 이동").Add(function(text)
unit.StartGlobalEvent(022)
end)

Server.GetTopic("아래로 이동").Add(function(text)
unit.StartGlobalEvent(023)
end)

Server.GetTopic("오른쪽으로 이동").Add(function(text)
unit.StartGlobalEvent(024)
end)

Server.GetTopic("왼쪽으로 이동").Add(function(text)
unit.StartGlobalEvent(025)
end)

Server.GetTopic("방향키 대사").Add(function(text)
unit.StartGlobalEvent(036)
end)

Server.GetTopic("다시시작").Add(function(text)
unit.StartGlobalEvent(042)
end)

-- local function timer(second)
--     SetWorldVar(31, Server.GetWorldVar(031) + 1)
--     Server.RunLater(timer, second)
-- end


-- local function TurnCheck()
--     Server.FireEvent("turn", Server.GetWorldVar(0))
--     Server.RunLater(TurnCheck, 0.1)  -- 0.1초마다 턴 체크
-- end

-- local function CheckBossHP()
--     if Server.GetWorldVar(8) == 1 then
--         Server.FireEvent("보스hp", 1)
--         Server.SetWorldVar(8, 0)  -- 보스 HP 이벤트가 발생했음을 표시
--     end
--     Server.RunLater(CheckBossHP, 0.5)  -- 재귀 호출로 루프
-- end

-- local function StageCheck()
--     Server.FireEvent("Stage", Server.GetWorldVar(11))
--     Server.RunLater(StageCheck, 0.1)  -- 0.1초마다 턴 체크
-- end

Server.RunLater(TurnCheck_SV, 0.1)
-- TurnCheck()
-- -- CheckBossHP()  -- 최초 실행
-- StageCheck()
-- timer(1)
