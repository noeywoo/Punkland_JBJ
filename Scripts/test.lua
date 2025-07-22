local inputCooldown = 0
local cooldownTime = 0.5
local lastX, lastY = nil, nil
local fireEventThreshold = 5.0

local prevMoveX, prevMoveY = nil, nil
local pendingFire = false

local function fireServerEvents()
    Client.FireEvent("공용004")
    Client.FireEvent("공용006")
    Client.FireEvent("공용007")
end

local function hasMovedEnough(x1, y1, x2, y2, threshold)
    local dx = math.abs(x1 - x2)
    local dy = math.abs(y1 - y2)
    -- print(string.format("이동 거리 체크: dx=%.2f, dy=%.2f", dx, dy))
    return dx > threshold or dy > threshold
end

local function inputLoop()
    local me = Client.myPlayerUnit
    if not me then
        Client.RunLater(inputLoop, 0.05)
        return
    end

    -- 이동 중인지 확인
    if lastX and lastY and (me.x ~= lastX or me.y ~= lastY) then
        print(string.format("이동중: 현재좌표 (%.1f, %.1f)", me.x, me.y))
        lastX, lastY = me.x, me.y
        Client.RunLater(inputLoop, 0.05)
        return
    end

    -- 이동 후 위치 도착했을 때 fire 조건 확인
    if pendingFire and hasMovedEnough(prevMoveX, prevMoveY, me.x, me.y, fireEventThreshold) then
        fireServerEvents()
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
        prevMoveX, prevMoveY = me.x, me.y
        print(string.format("이동명령: Go(%d, %d) | 이전좌표 (%.1f, %.1f)", dx, dy, prevMoveX, prevMoveY))
        me:Go(dx, dy)
        inputCooldown = cooldownTime
        lastX, lastY = me.x, me.y
        pendingFire = true
    end

    Client.RunLater(inputLoop, 0.05)
end

Client.RunLater(inputLoop, 0.05)
