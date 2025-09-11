local Players = game:GetService("Players")

local function simpleHasher(id)
    return tostring(id * 1337 % 100000)
end

local boostData = {
    ["123456"] = {color = Color3.fromRGB(255,0,0), icon = "⭐"},
    ["654321"] = {color = Color3.fromRGB(0,255,0), icon = "🔥"},
}

local function getBoost(player)
    local data = boostData[tostring(player.UserId)] or {color = Color3.fromRGB(255,255,255), icon = ""}
    return data.color, data.icon
end

local function applyBoosts()
    for _, player in pairs(Players:GetPlayers()) do
        local color, icon = getBoost(player)
        if player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local billboard = head:FindFirstChild("BillboardGui")
            if billboard and billboard:FindFirstChild("Frame") and billboard.Frame:FindFirstChild("TextLabel") then
                local label = billboard.Frame.TextLabel
                label.TextColor3 = color
                label.Text = player.Name .. " " .. icon
            end
        end
    end
end

Players.PlayerAdded:Connect(applyBoosts)
Players.PlayerRemoving:Connect(applyBoosts)
applyBoosts()
