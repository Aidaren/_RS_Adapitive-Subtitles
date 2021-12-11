--[[
ScriptName:Adapitive Subtitles
Version 0.2.1
Put this script on/将此脚本放在：
StarterPlayer\StarterCharacterScript |-|-or-|-| StarterPlayer\StarterPlayerScript

Made by Aidaren - 究极挨打人
QQ:3026297142
--]]
local DisapperTime = 3 --<字幕开始消失的时间>--
local TweenTime = 0.5 --<字幕彻底消失的时间>--

local function CreateSubtitle(Text)

	--<获取本地玩家>--
	local Player = game:GetService("Players")
	local LocalPlayer = Player.LocalPlayer
	--<获取服务>--
	local Tween = game:GetService("TweenService")

	--<创建字幕GUI并隐藏>--
	local Gui = Instance.new("ScreenGui" , LocalPlayer:FindFirstChild("PlayerGui"))
	local GuiFrame = Instance.new("Frame" , Gui)
	local UiCornerForFrame = Instance.new("UICorner" , GuiFrame)

	local GuiBackGround = Instance.new("ImageLabel" , GuiFrame)
	local UiCornerForPattern = Instance.new("UICorner" , GuiBackGround)

	local GuiText = Instance.new("TextLabel" , GuiFrame)
	local UiTextSizeConstraint = Instance.new("UITextSizeConstraint" , GuiText)

	--<改变杂项属性>--
	UiCornerForFrame.CornerRadius = UDim.new(0.1,0)
	UiCornerForPattern.CornerRadius = UDim.new(0.1,0)
	UiTextSizeConstraint.MaxTextSize = 24
	UiTextSizeConstraint.MinTextSize = 1

	--<改变Gui属性>--
	Gui.Enabled = false
	Gui.Name = "Subtitle2"
	GuiBackGround.Name = "Pattern"
	GuiText.Name = "Text"
	Gui.IgnoreGuiInset = true
	Gui.ZIndexBehavior = "Sibling"
	Gui.ResetOnSpawn = false

	--<改变Text属性>--
	GuiText.BackgroundTransparency = 1
	GuiText.Size = UDim2.new(1,0,1,0)
	GuiText.ZIndex = 10
	GuiText.Font = Enum.Font.GothamBold
	GuiText.Text = Text
	GuiText.TextSize = 24
	GuiText.TextColor3=Color3.new(240, 240, 240)
	GuiText.TextScaled = true

	--<改变Frame属性>--
	local MinX = 0.05 --|最小字幕X轴画幅|--
	GuiFrame.AnchorPoint = Vector2.new(0.5,1)
	GuiFrame.BackgroundColor3 = Color3.new(0, 0, 0)
	GuiFrame.BackgroundTransparency = 0.45
	GuiFrame.Position= UDim2.new(0.5,0,0.82,0)
	GuiFrame.Size= UDim2.new(1, 0 , 0.045 , 0) --|给文本计算创建环境|--

	--<改变Pattern属性>--
	GuiBackGround.AnchorPoint = Vector2.new(0, 0)
	GuiBackGround.BackgroundTransparency = 1
	GuiBackGround.Size = UDim2.new(1, 0,1, 0)
	GuiBackGround.Image = "rbxassetid://300134974"
	GuiBackGround.ResampleMode = Enum.ResamplerMode.Default
	GuiBackGround.ScaleType = Enum.ScaleType.Tile
	GuiBackGround.SliceScale = 1
	GuiBackGround.TileSize = UDim2.new(0, 30,0, 30)
	GuiBackGround.ImageTransparency = 0.975

	local AbsoluteScale = GuiText.TextBounds.X

	local AbsoluteScalLost = math.fmod(AbsoluteScale , 8) --|求余数并加上对应缩放比例|--
	if AbsoluteScalLost == 1 then
		AbsoluteScalLost = 0.001
	elseif AbsoluteScalLost == 2 or 3 then
		AbsoluteScalLost = 0.002
	elseif AbsoluteScalLost == 4 or 5 then
		AbsoluteScalLost = 0.003
	elseif AbsoluteScalLost ==6 then
		AbsoluteScalLost = 0.004
	elseif AbsoluteScalLost == 7 or 8 then
		AbsoluteScalLost = 0.005
	end

	local AbsoluteScalConsult1 , AbsoluteScalConsult2  = math.modf(AbsoluteScale/8) --|求大小并乘以总数|--
	AbsoluteScalConsult1 = AbsoluteScalConsult1 * 0.004

	local ASCFinal = AbsoluteScalConsult1 + AbsoluteScalLost

	GuiFrame.Size= UDim2.new(math.max(MinX , ASCFinal), 0 , 0.045 , 0) --|根据X画幅动态改变|--


	Gui.Enabled = true

	--<等待时间>--
	wait(DisapperTime)

	--<创建Tween>--
	local SubtitlesInfo = TweenInfo.new(TweenTime , Enum.EasingStyle.Linear , Enum.EasingDirection.Out , 0 , false)
	local FrameAnimation = Tween:Create(GuiFrame , SubtitlesInfo , {Size = UDim2.new(GuiFrame.Size.X,0,0,0)})
	local TransparensyAnimation = Tween:Create(GuiText , SubtitlesInfo , {TextTransparency = 1})
	
	FrameAnimation:Play()
	TransparensyAnimation:Play()
	
	wait(TweenTime)

	Gui:Destroy()

end

--<测试>--
local Player = game:GetService("Players")
local LocalPlayer = Player.LocalPlayer

LocalPlayer.Chatted:Connect(function(Message)
	CreateSubtitle(Message)
end)
