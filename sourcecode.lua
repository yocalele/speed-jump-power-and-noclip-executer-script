local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid.WalkSpeed, humanoid.JumpPower = 16, 50

local ScreenGui, MainFrame = Instance.new("ScreenGui"), Instance.new("Frame")
ScreenGui.Parent = player:WaitForChild("PlayerGui")
MainFrame.Size, MainFrame.Position = UDim2.new(0, 240, 0, 256), UDim2.new(0.5, -120, 0.5, -128) -- Reduced by 20%
MainFrame.BackgroundColor3, MainFrame.Active, MainFrame.Draggable = Color3.new(0.3, 0.3, 0.3), true, true
MainFrame.Parent = ScreenGui

local function createButton(parent, text, position, size, bgColor)
    local button = Instance.new("TextButton")
    button.Size, button.Position, button.Text, button.BackgroundColor3 = size, position, text, bgColor
    button.Parent = parent
    return button
end

local SpeedDisplay = Instance.new("TextLabel", MainFrame)
SpeedDisplay.Size, SpeedDisplay.Position = UDim2.new(0, 224, 0, 24), UDim2.new(0, 8, 0, 8)
SpeedDisplay.Text, SpeedDisplay.BackgroundColor3, SpeedDisplay.TextColor3 = "Speed: " .. humanoid.WalkSpeed, Color3.new(0.1, 0.1, 0.1), Color3.new(1, 1, 1)

local IncreaseSpeedButton = createButton(MainFrame, "Increase Speed", UDim2.new(0, 8, 0, 38), UDim2.new(0, 224, 0, 32), Color3.new(0.2, 0.7, 0.2)) -- Reduced by 20%
local DecreaseSpeedButton = createButton(MainFrame, "Decrease Speed", UDim2.new(0, 8, 0, 78), UDim2.new(0, 224, 0, 32), Color3.new(0.7, 0.2, 0.2)) -- Reduced by 20%

local JumpPowerDisplay = Instance.new("TextLabel", MainFrame)
JumpPowerDisplay.Size, JumpPowerDisplay.Position = UDim2.new(0, 224, 0, 24), UDim2.new(0, 8, 0, 118) -- Reduced by 20%
JumpPowerDisplay.Text, JumpPowerDisplay.BackgroundColor3, JumpPowerDisplay.TextColor3 = "Jump Power: " .. humanoid.JumpPower, Color3.new(0.1, 0.1, 0.1), Color3.new(1, 1, 1)

local IncreaseJumpPowerButton = createButton(MainFrame, "Increase Jump Power", UDim2.new(0, 8, 0, 148), UDim2.new(0, 224, 0, 32), Color3.new(0.2, 0.7, 0.2)) -- Reduced by 20%
local DecreaseJumpPowerButton = createButton(MainFrame, "Decrease Jump Power", UDim2.new(0, 8, 0, 188), UDim2.new(0, 224, 0, 32), Color3.new(0.7, 0.2, 0.2)) -- Reduced by 20%

local NoclipToggleButton, noclipEnabled = createButton(MainFrame, "Toggle Noclip", UDim2.new(0, 8, 0, 228), UDim2.new(0, 224, 0, 32), Color3.new(0.2, 0.7, 0.2)), false -- Reduced by 20%

local function updateDisplay(display, text, value)
    display.Text = text .. value
end

IncreaseSpeedButton.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = humanoid.WalkSpeed + 2
    updateDisplay(SpeedDisplay, "Speed: ", humanoid.WalkSpeed)
end)

DecreaseSpeedButton.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = humanoid.WalkSpeed - 2
    updateDisplay(SpeedDisplay, "Speed: ", humanoid.WalkSpeed)
end)

IncreaseJumpPowerButton.MouseButton1Click:Connect(function()
    humanoid.JumpPower = humanoid.JumpPower + 5
    updateDisplay(JumpPowerDisplay, "Jump Power: ", humanoid.JumpPower)
end)

DecreaseJumpPowerButton.MouseButton1Click:Connect(function()
    humanoid.JumpPower = humanoid.JumpPower - 5
    updateDisplay(JumpPowerDisplay, "Jump Power: ", humanoid.JumpPower)
end)

NoclipToggleButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    NoclipToggleButton.Text = noclipEnabled and "Noclip Enabled" or "Noclip Disabled"
end)

game:GetService("RunService").Stepped:Connect(function()
    if noclipEnabled then
        local ray = Ray.new(character.Head.Position, character.Head.CFrame.LookVector * 5)
        local hit = game.Workspace:FindPartOnRay(ray, character)
        if hit and hit.CanCollide then hit.CanCollide = false end
    end
end)
