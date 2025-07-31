local inputCooldown = 0
local cooldownTime = 0.2
local lastX, lastY = nil, nil
local fireEventThreshold = 5.0

local prevMoveX, prevMoveY = nil, nil
local pendingFire = false

turn = 0 -- 턴 수
stage = 0 -- 현재 스테이지
talkTrigger = 0 -- 대사 트리거
Trigger1_3a = 0 -- 트리거 1-3a
Trigger1_3b = 0 -- 트리거 1-3b
Trigger1_3c = 0 -- 트리거 1-3c
Trigger1_4a = 0 -- 트리거 1-4a
Trigger1_4b = 0 -- 트리거 1-4b

MyGame = {}

-- local function fireServerEvents()
--     Client.FireEvent("공용004")
--     -- Client.FireEvent("공용006")
--     Client.FireEvent("공용007")
-- end

local function hasMovedEnough(x1, y1, x2, y2, threshold)
    local dx = math.abs(x1 - x2)
    local dy = math.abs(y1 - y2)
    -- print(string.format("이동 거리 체크: dx=%.2f, dy=%.2f", dx, dy))
    return dx > threshold or dy > threshold
end

function MyGame.movePlayer(dx, dy)
    local me = Client.myPlayerUnit
    if not me then return end

    if inputCooldown > 0 then return end

    prevMoveX, prevMoveY = me.x, me.y
    me:Go(dx, dy)
    inputCooldown = cooldownTime
    lastX, lastY = me.x, me.y
    pendingFire = true
end

local function inputLoop()
    local me = Client.myPlayerUnit
    if not me then
        Client.RunLater(inputLoop, 0.05)
        return
    end

    -- 이동 중인지 확인
    if lastX and lastY and (me.x ~= lastX or me.y ~= lastY) then
        -- print(string.format("이동중: 현재좌표 (%.1f, %.1f)", me.x, me.y))
        lastX, lastY = me.x, me.y
        Client.RunLater(inputLoop, 0.05)
        return
    end

    -- 이동 후 위치 도착했을 때 fire 조건 확인
    if pendingFire and hasMovedEnough(prevMoveX, prevMoveY, me.x, me.y, fireEventThreshold) then
        -- fireServerEvents()
        turn = turn - 1
        me:PlaySE("Concrete Footsteps 2.wav", 4)

        if (stage == 2 or stage == 4) and (turn % 2 == 1) then
            me:PlaySE("Sword Sound 2.wav", 3)
        elseif (stage == 3) then
            me:PlaySE("Sword Sound 2.wav", 3)
        end
        pendingFire = false
    end

    -- 쿨다운 감소
    if inputCooldown > 0 then
        inputCooldown = inputCooldown - 0.05
        Client.RunLater(inputLoop, 0.05)
        return
    end

    local dx, dy = 0, 0
    if Input.GetKey(Input.KeyCode.W) then dy = 16
    elseif Input.GetKey(Input.KeyCode.S) then dy = -16
    elseif Input.GetKey(Input.KeyCode.A) then dx = -16
    elseif Input.GetKey(Input.KeyCode.D) then dx = 16 end

    if dx ~= 0 or dy ~= 0 then
        MyGame.movePlayer(dx, dy)
    end

    Client.RunLater(inputLoop, 0.05)
end

Client.RunLater(inputLoop, 0.05)
