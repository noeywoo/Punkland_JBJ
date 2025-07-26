-- 초기값 설정
local timer = 60
local interval = 10
local nextFireTime = 50
local fireX, fireY

-- [1] 메인 이벤트 시작 함수
function StartBossFireGimmick()
    Server.RunLater(1000, function()
        timer = timer - 1
        UI.ShowTimer(timer)

        if timer == nextFireTime then
            ShowBossWarning()
        end

        if timer <= 0 then
            CheckBossWinOrLose()
            return
        end

        StartBossFireGimmick()
    end)
end

-- [2] 경고 이미지 보여주기
function ShowBossWarning()
    fireX = math.random(0, 6)
    fireY = math.random(0, 6)

    Map.ShowImage("Pictures/warning", fireX, fireY)

    Server.RunLater(2000, function()
        Map.HideImage("Pictures/warning", fireX, fireY)
        SpawnBossFirePillar()
    end)

    nextFireTime = nextFireTime - interval
end

-- [3] 불기둥 생성 & 데미지 처리
function SpawnBossFirePillar()
    Map.ShowImage("Pictures/fire", fireX, fireY)

    for _, player in ipairs(Server.GetPlayers()) do
        if player.x == fireX and player.y == fireY then
            local hp = Server.GetWorldVar(0)
            Server.SetWorldVar(0, hp - 5)

            if hp - 5 <= 0 then
                ResetBossEvent(player)
                return
            end
        end
    end

    Server.RunLater(3000, function()
        Map.HideImage("Pictures/fire", fireX, fireY)
    end)
end

-- [4] 체력 0일 때 이벤트 초기화
function ResetBossEvent(player)
    UI.ShowMessage(player, "패배! 이벤트가 초기화됩니다.")
    Server.SetWorldVar(0, 15)
    timer = 60
    nextFireTime = 50
end

-- [5] 이벤트 종료 판정
function CheckBossWinOrLose()
    local hp = Server.GetWorldVar(0)
    if hp > 0 then
        for _, player in ipairs(Server.GetPlayers()) do
            UI.ShowMessage(player, "바게트가 쓰러졌습니다.")
        end
    else
        for _, player in ipairs(Server.GetPlayers()) do
            ResetBossEvent(player)
        end
    end
end