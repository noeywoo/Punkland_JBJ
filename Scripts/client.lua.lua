-- local t = {}

-- --대화창 초기화

-- function ResetDialogue(dialogue)

-- if t[1] then

-- for i, v in pairs(t) do

-- v.Destroy()

-- t[i] = nil

-- end

-- end

-- if dialogue ~= nil then

-- print('다이얼로그')

-- dialogue.Destroy()

-- dialogue = nil

-- end

-- end



-- --대화창 함수

-- function Dialogue(...)

-- --초기화

-- ResetDialogue()

-- --대화 내용 테이블에 넣기

-- for _, v in pairs({...})do

-- table.insert(t,v)

-- end



-- --대화 버튼

-- dialogue = Button('',Rect(0,0,Client.width,Client.height*0.3))

-- dialogue.showOnTop = true

-- dialogue.color = Color(0,0,0,150)

-- dialogue.pivotY = 1

-- dialogue.anchor = 6



-- --대화 내용

-- dialogue.AddChild(Text(t[1],Rect(15,15,dialogue.width*0.7,dialogue.height*0.7)))

-- dialogue.children[1].textSize = 18

-- dialogue.children[1].textAlign = 0



-- --스킵 버튼

-- dialogue.AddChild(Button('스킵하기',Rect(0,0,100,30)))

-- dialogue.children[2].pivotX = 1

-- dialogue.children[2].pivotY = 1

-- dialogue.children[2].textColor = Color(0,0,0)

-- dialogue.children[2].anchor = 2



-- dialogue.children[2].onClick.Add(function()

-- dialogue.Destroy()

-- dialogue = nil

-- end)



-- -- 대화 갱신 온클릭

-- dialogue.onClick.Add(function()

-- if t[1] then

-- table.remove(t,1)

-- dialogue.children[1].text = t[1]

-- end

-- if #t < 1 then

-- dialogue.Destroy()

-- dialogue = nil

-- end

-- end)

-- end

-- Dialogue('안녕하세요','장발장입니다','빵을 먹겠습니다,')