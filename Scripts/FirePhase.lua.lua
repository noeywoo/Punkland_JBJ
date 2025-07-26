local timer = 60          -- 60초 카운트
local interval = 10       -- 불기둥 주기
local fireDuration = 3    -- 불기둥 유지 시간
local warningDuration = 2 -- 경고 이미지 유지 시간
local nextFireTime = 50   -- 다음 불기둥 경고 시작 시점 (60-10)
local fireX, fireY        -- 불기둥 좌표

function HandleTriggerEnter(actor)
    if actor.type == "player" then
        Server.SetWorldVar(0, 15)  -- 유저 var 15로 초기화
        timer = 60
        nextFireTime = 50
        StartFireGimmick()         -- 이벤트 시작 함수 호출
    end
end

function StartFireGimmick()
    Server.RunLater(1000, function()  -- 1초마다 반복
        timer = timer - 1
        UI.ShowTimer(timer)          -- 타이머 표시 (UI에서 사용 가능하면)

        -- 불기둥 경고/생성 처리
        if timer == nextFireTime then
            ShowWarning()
        end

        -- 종료 조건 체크
        if timer <= 0 then
            CheckWinOrLose()
            return
        end

        -- 재귀 호출로 루프 유지
        StartFireGimmick()
    end)
end

function ShowWarning()
    fireX = math.random(0, 6)
    fireY = math.random(0, 6)

    -- 경고 이미지 표시
    Map.ShowImage("Warning", fireX, fireY)

    Server.RunLater(warningDuration * 1000, function()
        Map.HideImage("Warning", fireX, fireY)
        SpawnFire()
    end)

    nextFireTime = nextFireTime - interval -- 다음 경고 타이밍 계산
end

function SpawnFire()
    Map.ShowImage("FirePillar", fireX, fireY)

    -- 유저 위치와 불기둥 위치 비교
    for _, player in ipairs(Server.GetPlayers()) do
        local px, py = player.x, player.y
        if px == fireX and py == fireY then
            local currentVar = Server.GetWorldVar(0)
            Server.SetWorldVar(0, currentVar - 5)

            -- var가 0 이하이면 이벤트 리셋
            if currentVar - 5 <= 0 then
                ResetEvent(player)
                return
            end
        end
    end

    Server.RunLater(fireDuration * 1000, function()
        Map.HideImage("FirePillar", fireX, fireY)
    end)
end


function ResetEvent(player)
    UI.ShowMessage(player, "패배! 이벤트가 초기화됩니다.")
    Server.SetWorldVar(0, 15)
    timer = 60
    nextFireTime = 50
    -- 필요시 위치 초기화 또는 강제 이동 등 추가 가능
end


function CheckWinOrLose()
    local currentVar = Server.GetWorldVar(0)
    if currentVar > 0 then
        for _, player in ipairs(Server.GetPlayers()) do
            UI.ShowMessage(player, "바게트가 쓰러졌습니다.")
        end
    else
        for _, player in ipairs(Server.GetPlayers()) do
            ResetEvent(player)
        end
    end
end