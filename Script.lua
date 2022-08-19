if getgenv == nil then
	getgenv = function()
		return _G
	end
end

if getgenv().Loaded ~= nil and getgenv().Loaded == true then
	return pcall(warn, "Chams were already loaded!")
end

getgenv().Loaded = true

local Settings = {
	ChamColor = Color3.fromRGB(255, 0, 0),
	ChamTransparency = 0.7,
	OutlineColor = Color3.fromRGB(255, 255, 255),
	OutlineTransparency = 0,
	DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
	AliveCheck = true,
	RainbowChamColor = true,
	RainbowOutlineColor = true,
	EnableChams = true,
	Speed = 5, -- 1 for default
	SelfCheck = true, -- Check if the player is you
	SelfCheckDebug = true, -- Set this to true if u wan-t to debug if the player is u
	Debug = true, -- Set this to true if u want to warn if the script loaded
	FindParts = true, -- Set this to true if u wan't to find parts (THE GAME MIGHT LAG IF THE MAP IS TOO BIG!)
	PartsToFind = {}, -- Names here
	-- ↑ "Head", "LowerTorso", "Torso", etc...
	FindPartsChamsEnabled = false,
}

if Settings.FindParts then
	for i,v in pairs(workspace:GetDescendants()) do
		if string.lower(v.ClassName):find("part") and table.find(Settings.PartsToFind, v.Name) then
			local Highlight = Instance.new("Highlight", v)
			Highlight.FillColor = Settings.ChamColor
			Highlight.FillTransparency = Settings.ChamTransparency
			Highlight.OutlineColor = Settings.OutlineColor
			Highlight.OutlineTransparency = Settings.OutlineTransparency
			Highlight.DepthMode = Settings.DepthMode
			local i = game:GetService("RunService").RenderStepped:Connect(function(delta)
				pcall(function()
					Highlight.FillColor = Settings.ChamColor
					Highlight.FillTransparency = Settings.ChamTransparency
					Highlight.OutlineColor = Settings.OutlineColor
					Highlight.OutlineTransparency = Settings.OutlineTransparency
					Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
					Highlight.Enabled = Settings.FindPartsChamsEnabled
				end)
			end)
			repeat wait() until v == nil
			i:Disconnect()
		end
	end
	workspace.DescendantAdded:Connect(function(v)
		if string.lower(v.ClassName):find("part") and table.find(Settings.PartsToFind, v.Name) then
			wait(1)
			local Highlight = Instance.new("Highlight", v)
			Highlight.FillColor = Settings.ChamColor
			Highlight.FillTransparency = Settings.ChamTransparency
			Highlight.OutlineColor = Settings.OutlineColor
			Highlight.OutlineTransparency = Settings.OutlineTransparency
			Highlight.DepthMode = Settings.DepthMode
			local i = game:GetService("RunService").RenderStepped:Connect(function(delta)
				pcall(function()
					Highlight.FillColor = Settings.ChamColor
					Highlight.FillTransparency = Settings.ChamTransparency
					Highlight.OutlineColor = Settings.OutlineColor
					Highlight.OutlineTransparency = Settings.OutlineTransparency
					Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
					Highlight.Enabled = Settings.FindPartsChamsEnabled
				end)
			end)
			repeat wait() until v == nil
			i:Disconnect()
		end
	end)
end

function cham(plr)
	if Settings.SelfCheck == true and plr == game.Players.LocalPlayer then -- simple :D
		if Settings.SelfCheckDebug then
			pcall(warn, "Attempted to run \"cham\" function on LocalPlayer, successfuly returned!")
		end

		return nil -- do not run rest of the code :D
	end

	local Highlight = Instance.new("Highlight", plr.Character)
	Highlight.FillColor = Settings.ChamColor
	Highlight.FillTransparency = Settings.ChamTransparency
	Highlight.OutlineColor = Settings.OutlineColor
	Highlight.OutlineTransparency = Settings.OutlineTransparency
	Highlight.DepthMode = Settings.DepthMode
	local i = game:GetService("RunService").RenderStepped:Connect(function(delta)
		pcall(function()
			Highlight.FillColor = Settings.ChamColor
			Highlight.FillTransparency = Settings.ChamTransparency
			Highlight.OutlineColor = Settings.OutlineColor
			Highlight.OutlineTransparency = Settings.OutlineTransparency
			Highlight.DepthMode = Settings.DepthMode
			Highlight.Enabled = Settings.EnableChams
		end)
	end)
	plr.CharacterRemoving:Connect(function(m)
		i:Disconnect()
		if Settings.AliveCheck == true then
			Highlight:Destroy()
		end
	end)
	plr.CharacterAdded:Connect(function(m)
		local Highlight = Instance.new("Highlight", plr.Character)
		Highlight.FillColor = Settings.ChamColor
		Highlight.FillTransparency = Settings.ChamTransparency
		Highlight.OutlineColor = Settings.OutlineColor
		Highlight.OutlineTransparency = Settings.OutlineTransparency
		Highlight.DepthMode = Settings.DepthMode
		local i = game:GetService("RunService").RenderStepped:Connect(function(delta)
			pcall(function()
				Highlight.FillColor = Settings.ChamColor
				Highlight.FillTransparency = Settings.ChamTransparency
				Highlight.OutlineColor = Settings.OutlineColor
				Highlight.OutlineTransparency = Settings.OutlineTransparency
				Highlight.DepthMode = Settings.DepthMode
				Highlight.Enabled = Settings.EnableChams
			end)
		end)
		plr.CharacterRemoving:Connect(function(m)
			i:Disconnect()
			if Settings.AliveCheck == true then
				Highlight:Destroy()
			end
		end)
	end)
end

for i, v in pairs(game.Players:GetPlayers()) do
	pcall(cham, v)
end

game.Players.PlayerAdded:Connect(function(v)
	if v.Character == nil then
		repeat wait() until v.Character ~= nil and v.Character:FindFirstChild("Head")
	end

	pcall(cham, v)
end)

getgenv().HighlightSettings = Settings

while wait() do
	for i = 1, Settings.Speed do
		if Settings.RainbowChamColor then
			Settings.ChamColor = Color3.fromHSV(tick() % 20/20, 1, 1)
		end
		if Settings.RainbowOutlineColor then
			Settings.OutlineColor = Color3.fromHSV(tick() % 20/20, 1, 1)
		end
		game:GetService("RunService").Heartbeat:wait()
	end
end
