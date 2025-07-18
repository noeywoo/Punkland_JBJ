-- local inputCooldown = 0
-- local cooldownTime = 0.5
-- local lastX, lastY = nil, nil

-- local function inputLoop()
--     local me = Client.myPlayerUnit
--     if not me then
--         Client.RunLater(inputLoop, 0.05)
--         return
--     end

--     -- 이동 중이면 이동 명령 무시
--     if lastX and lastY and (me.x ~= lastX or me.y ~= lastY) then
--         print(string.format("이동중: 현재좌표 (%.1f, %.1f)", me.x, me.y))
--         lastX, lastY = me.x, me.y
--         Client.RunLater(inputLoop, 0.05)
--         return
--     end

--     local dx, dy = 0, 0

--     if Input.GetKey(Input.KeyCode.W) then
--         dy = 20
--         print("UpArrow 눌림")
--     elseif Input.GetKey(Input.KeyCode.S) then
--         dy = -20
--         print("DownArrow 눌림")
--     elseif Input.GetKey(Input.KeyCode.A) then
--         dx = -20
--         print("LeftArrow 눌림")
--     elseif Input.GetKey(Input.KeyCode.D) then
--         dx = 20
--         print("RightArrow 눌림")
--     end

--     if dx ~= 0 or dy ~= 0 then
--         local beforeX, beforeY = me.x, me.y
--         print(string.format("이동명령: Go(%d, %d) | 이전좌표 (%.1f, %.1f)", dx, dy, beforeX, beforeY))
--         me:Go(dx, dy)
--         inputCooldown = cooldownTime
--         lastX, lastY = me.x, me.y
--     end

--     Client.RunLater(inputLoop, 0.05)
-- end

-- Client.RunLater(inputLoop, 0.05)