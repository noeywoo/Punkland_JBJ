Client.RunLater(function()
    local me = Client.myPlayerUnit
    if me then
        print(me.x)
        -- 실제 이동 메서드 사용 예시
        me.go(10, 0)
    end
end, 0.5)