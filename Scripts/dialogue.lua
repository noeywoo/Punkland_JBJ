local t = {}
local clickCount = 0
local dialogue = nil

-- 대화 큐 관련
local dialogueQueue = {}
local dialogueActive = false

function DialogueQueue(...)
    for _, line in ipairs({...}) do
        table.insert(dialogueQueue, line)
    end
    if not dialogueActive then
        StartDialogueQueue()
    end
end

function StartDialogueQueue()
    if #dialogueQueue == 0 then
        dialogueActive = false
        return
    end
    dialogueActive = true
    Dialogue(unpack(dialogueQueue))
    dialogueQueue = {}
end

-- 대화창 초기화
function ResetDialogue()
    if t[1] then
        for i, v in pairs(t) do
            v.Destroy()
            t[i] = nil
        end
    end

    if dialogue ~= nil then
        dialogue.Destroy()
        dialogue = nil
    end
end

-- 대화창 생성
function Dialogue(...)
    ResetDialogue()
    clickCount = 0

    for _, v in ipairs({...}) do
        table.insert(t, v)
    end

    dialogue = Button('', Rect(0, 0, Client.width, Client.height * 0.3))
    dialogue.showOnTop = true
    dialogue.color = Color(0, 0, 0, 150)
    dialogue.pivotY = 1
    dialogue.anchor = 6

    dialogue.AddChild(Text(t[1], Rect(15, 15, dialogue.width * 0.7, dialogue.height * 0.7)))
    dialogue.children[1].textSize = 18
    dialogue.children[1].textAlign = 0

    dialogue.AddChild(Button('스킵하기', Rect(0, 0, 100, 30)))
    dialogue.children[2].pivotX = 1
    dialogue.children[2].pivotY = 1
    dialogue.children[2].textColor = Color(0, 0, 0)
    dialogue.children[2].anchor = 2

    dialogue.children[2].onClick.Add(function()
        Client.GetPage("story").Destroy()
        dialogue.Destroy()
        dialogue = nil
        dialogueActive = false
        dialogueQueue = {}
    end)

       dialogue.onClick.Add(function()
        clickCount = clickCount + 1

        if clickCount == 1 then
            Client.GetPage("story").GetControl("Scene2").visible = true
        elseif clickCount == 2 then
            Client.GetPage("story").GetControl("Scene3").visible = true
        elseif clickCount == 3 then
            Client.GetPage("story").GetControl("Scene4").visible = true
        elseif clickCount == 4 then
            Client.GetPage("story").GetControl("Scene5").visible = true
        elseif clickCount == 5 then
            Client.GetPage("story").GetControl("Scene6").visible = true
        elseif clickCount == 6 then
            Client.GetPage("story").GetControl("Scene7").visible = true
        elseif clickCount == 7 then
            Client.GetPage("story").GetControl("Scene8").visible = true
        elseif clickCount == 8 then
            Client.GetPage("story").GetControl("Scene9").visible = true
        elseif clickCount == 9 then
            Client.GetPage("story").GetControl("Scene10").visible = true
        elseif clickCount == 10 then
            Client.GetPage("story").GetControl("Scene11").visible = true
        elseif clickCount == 11 then
            Client.GetPage("story").GetControl("Scene12").visible = true
            
        end

        table.remove(t, 1)

        if t[1] then
            dialogue.children[1].text = t[1]
        else
            Client.GetPage("story").Destroy()
            dialogue.Destroy()
            dialogue = nil
            StartDialogueQueue()  -- 다음 대화 큐 실행
        end
    end)
end

-- ✅ 예시 실행
DialogueQueue( 
    "전체사진1",
    "Scene1", 
    "Scene2",
    "Scene3", 
    "전체사진2",
    "Scene4", 
    "Scene5", 
    "Scene6", 
    "전체사진3", 
    "Scene7", 
    "Scene8",
    "Scene9")

Client.GetTopic("보스hp").Add(function(x)
    if x == 1 then
        DialogueQueue("빵 더 없나", "맛있게 먹겠습니다!")
    end
end)
