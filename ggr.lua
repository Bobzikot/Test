local function obfuscate(code)
  local obfuscated_code = ""
  for i = 1, #code do
    local char = code:sub(i,i)
    local ascii = string.byte(char)
    obfuscated_code = obfuscated_code .. string.char(ascii + 3)
  end
  return obfuscated_code
end

local code = [[
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local uiListLayout = Instance.new("UIListLayout")
local teleportButton = Instance.new("TextButton")
local selectedPlayerLabel = Instance.new("TextLabel")
local refreshButton = Instance.new("TextButton")

screenGui.Parent = player:WaitForChild("PlayerGui")

frame.Parent = screenGui
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Size = UDim2.new(0, 150, 0, 150)
frame.Position = UDim2.new(0.5, -75, 0.5, -75)
frame.Active = true
frame.Draggable = true

uiListLayout.Parent = frame
uiListLayout.FillDirection = Enum.FillDirection.Vertical
uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

selectedPlayerLabel.Parent = frame
selectedPlayerLabel.Text = "Выберите игрока"
selectedPlayerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
selectedPlayerLabel.BackgroundTransparency = 1
selectedPlayerLabel.Size = UDim2.new(1, 0, 0, 30)

local selectedPlayer
local previousButton
local highlight
local function updatePlayerList()
    for _, child in ipairs(frame:GetChildren()) do
        if child:IsA("TextButton") and child ~= teleportButton and child ~= refreshButton then
            child:Destroy()
        end
    end

    for _, v in ipairs(Players:GetPlayers()) do
        if v ~= player then
            local button = Instance.new("TextButton")
            button.Parent = frame
            button.Text = v.Name
            button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            button.TextColor3 = Color3.fromRGB(0, 0, 0)
            button.Size = UDim2.new(1, 0, 0, 30)
            button.LayoutOrder = #frame:GetChildren()
            button.Name = v.Name
            button.MouseButton1Click:Connect(function()
                if selectedPlayer then
                    if previousButton then
                        previousButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    end
                    
                    if highlight and selectedPlayer.Character then
                        highlight:Destroy()
                    end
                end
                
                selectedPlayer = v
                selectedPlayerLabel.Text = "Выбран: " .. v.Name
                button.TextColor3 = Color3.fromRGB(0, 255, 0)
                previousButton = button
                if selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    highlight = Instance.new("Highlight")
                    highlight.Parent = selectedPlayer.Character
                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                    highlight.OutlineColor = Color3.fromRGB(0, 255, 0)
                    highlight.Adornee = selectedPlayer.Character
                    highlight.Name = "Highlight"
                end
            end)
        end
    end
end

teleportButton.Parent = frame
teleportButton.Text = "Телепорт"
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.Size = UDim2.new(1, 0, 0, 30)
teleportButton.LayoutOrder = #frame:GetChildren() + 1
teleportButton.MouseButton1Click:Connect(function()
    if selectedPlayer and selectedPlayer.Character and selectedPlayer.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = selectedPlayer.Character.HumanoidRootPart.CFrame
        if highlight then
            highlight:Destroy()
        end
    end
end)

refreshButton.Parent = frame
refreshButton.Text = "Обновить"
refreshButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
refreshButton.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshButton.Size = UDim2.new(1, 0, 0, 30)
refreshButton.LayoutOrder = #frame:GetChildren() + 1
refreshButton.MouseButton1Click:Connect(updatePlayerList)

updatePlayerList()
]]

local obfuscated_code = obfuscate(code)
print(obfuscated_code)
