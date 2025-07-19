-- 예: 유닛 변수 197번에 턴 수 18 저장
Server.GetTopic("턴설정").Add(function()
    local turnCount = 18
    unit:SetVar(197, turnCount)

    -- 서버 콘솔 출력
    print("SetVar[197] = " .. turnCount)

    -- 클라이언트 채팅창 출력
    unit:SendSay("남은 턴: " .. turnCount)
end)
