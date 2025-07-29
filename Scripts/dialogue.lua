local t = {}
local clickCount = 0
local dialogue = nil

-- 대화 큐 관련
local dialogueQueue = {}
local dialogueActive = false

function DialogueQueue(pageName, ...)
    table.insert(dialogueQueue, {page = pageName, lines = {...}})
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
    local nextDialogue = table.remove(dialogueQueue, 1)
    Dialogue(nextDialogue.page, unpack(nextDialogue.lines))
end

-- 대화창 초기화
function ResetDialogue()
    if t[1] then
        for i, v in pairs(t) do
            if type(v) == "userdata" and v.Destroy then
                v.Destroy()
            end
            t[i] = nil
        end
    end

    if dialogue ~= nil then
        dialogue.Destroy()
        dialogue = nil
    end
end

-- 대화창 생성
function Dialogue(pageName, ...)
    ResetDialogue()
    clickCount = 0
    local currentPage = Client.GetPage(pageName)

    for _, v in ipairs({...}) do
        table.insert(t, v)
    end

    if currentPage.GetControl("Scene1") then
        currentPage.GetControl("Scene1").visible = true
    end

    dialogue = Button('', Rect(0, 0, Client.width, Client.height * 0.3))
    dialogue.showOnTop = true
    dialogue.color = Color(0, 0, 0, 150)
    dialogue.pivotY = 1
    dialogue.anchor = 6
    
    local faceImage = Image('Pictures/표정4.png', Rect(15, 15, 80, 80)) -- 파일명은 프로젝트 내에 존재하는 이미지 리소스명이어야 함
    -- faceImage.raycastTarget = false
    dialogue.AddChild(faceImage)
    

    -- 👇 대사 텍스트 추가 (이미지 오른쪽으로 약간 이동)
    local textBox = Text(t[1], Rect(110, 15, dialogue.width * 0.7, dialogue.height * 0.7))
    textBox.textSize = 18
    textBox.textAlign = 0
    -- textBox.raycastTarget = false
    dialogue.AddChild(textBox)

    -- dialogue.AddChild(Text(t[1], Rect(15, 15, dialogue.width * 0.7, dialogue.height * 0.7)))
    -- dialogue.children[1].textSize = 18
    -- dialogue.children[1].textAlign = 0

    local skipButton = Button('스킵하기', Rect(0, 0, 100, 30))
    skipButton.pivotX = 1
    skipButton.pivotY = 1
    skipButton.textColor = Color(0, 0, 0)
    skipButton.anchor = 2
    skipButton.onClick.Add(function()
        currentPage.Destroy()
        ResetDialogue()
        dialogueActive = false
        dialogueQueue = {}
        -- if Client.GetPage("StandTurn").GetControl("Stand_Turn").visible == false then
        --     Client.GetPage("StandTurn").GetControl("Stand_Turn").visible = true
        -- end
    end)
    dialogue.AddChild(skipButton)

    -- dialogue.AddChild(Button('스킵하기', Rect(0, 0, 100, 30)))
    -- dialogue.children[2].pivotX = 1
    -- dialogue.children[2].pivotY = 1
    -- dialogue.children[2].textColor = Color(0, 0, 0)
    -- dialogue.children[2].anchor = 2

    -- dialogue.children[2].onClick.Add(function()
    --     currentPage.Destroy()
    --     ResetDialogue()
    --     dialogueActive = false
    --     dialogueQueue = {}
    -- end)

    dialogue.onClick.Add(function()
        clickCount = clickCount + 1
        local sceneName = "Scene" .. tostring(clickCount + 1) -- Scene2부터 시작
        if currentPage.GetControl(sceneName) then
            currentPage.GetControl(sceneName).visible = true
        end

        table.remove(t, 1)

        if t[1] then
            -- dialogue.children[1].text = t[1]
            textBox.text = t[1]
        else
            currentPage.Destroy()
            dialogue.Destroy()
            dialogue = nil
            if #dialogueQueue == 0 then
                -- 모든 대화가 끝났을 때 실행됨
                -- if Client.GetPage("StandTurn").GetControl("Stand_Turn").visible == false then
                --     Client.GetPage("StandTurn").GetControl("Stand_Turn").visible = true
                -- end
                Client.FireEvent("방향키 대사")  -- 서버에 이벤트 전달
            end
            StartDialogueQueue()
        end
    end)
end

-- ✅ 예시 실행


-- Client.RunLater(function()
--     DialogueQueue( 
--         "story",
--         "전체사진1",
--         "Scene1",
--         "Scene2",
--         "Scene3", 
--         "전체사진2",
--         "Scene4", 
--         "Scene5", 
--         "Scene6", 
--         "전체사진3",
--         "Scene7",
--         "Scene8",
--         "Scene9"
--     )
-- end, 0.2)  -- 페이지가 완전히 뜰 시간을 약간 준다

Client.GetTopic("보스hp").Add(function(x)
    if x == 1 then
        DialogueQueue("story2", "빵 더 없나", "맛있게 먹겠습니다!")
    end
end)
