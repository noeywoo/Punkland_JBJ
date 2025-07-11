local inputCooldown = 0
local cooldownTime = 0.5 -- 쿨타임(초)

Client.onTick:Add(function(t)
    if inputCooldown > 0 then
        inputCooldown = inputCooldown - t
        return
    end

    local me = Client.myPlayerUnit
    if not me then return end

    if Input.GetKey(Input.KeyCode.W) then
        print("UpArrow 눌림")
        me:MoveToPosition(me.x, me.y + 20)
        inputCooldown = cooldownTime
    elseif Input.GetKey(Input.KeyCode.S) then
        print("DownArrow 눌림")
        me:MoveToPosition(me.x, me.y - 20)
        inputCooldown = cooldownTime
    elseif Input.GetKey(Input.KeyCode.A) then
        print("LeftArrow 눌림")
        me:MoveToPosition(me.x - 20, me.y)
        inputCooldown = cooldownTime
    elseif Input.GetKey(Input.KeyCode.D) then
        print("RightArrow 눌림")
        me:MoveToPosition(me.x + 20, me.y)
        inputCooldown = cooldownTime
    end
end)