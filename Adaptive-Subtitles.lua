--[[
ScriptName:Adapitive Subtitles
Version 1.1.0
Put this script on/将此脚本放在：ReplicatedStorage
Made by Aidaren - 究极挨打人
QQ:3026297142
--]]

function AdaptiveSubtitle(Text , DisapperTime , TweenTime , MoveTime , PrintMessage , DevMode)
	local G_Text --<字幕文本>--
	local G_DisapperTime --<字幕开始消失的时间-默认3>--
	local G_TweenTime --<字幕彻底消失的时间-默认0.1>--
	local G_MoveTime --<字幕移动的时间-默认0.08>--
	local G_PrintMessage --<是否要打印消息-默认false>--
	local G_DevMode --<是否要开启开发者调试模式-默认false>--
	if Text then
		G_Text = Text
	else
		G_Text = "You must give a Text to the function"
	end
	if DisapperTime then
		G_DisapperTime = DisapperTime
	else
		G_DisapperTime = 3
	end
	if TweenTime then
		G_TweenTime = TweenTime
	else
		G_TweenTime = 0.1
	end
	if MoveTime then
		G_MoveTime = MoveTime
	else
		G_MoveTime = 0.08
	end
	if PrintMessage then
		G_PrintMessage = PrintMessage
	else
		G_PrintMessage = false
	end
	if G_DevMode then
		G_DevMode = DevMode
	else
		G_PrintMessage = false
	end

	local function CreateSubtitle(Text)

		--<获取本地玩家>--
		local Player = game:GetService("Players")
		local LocalPlayer = Player.LocalPlayer

		--<获取服务>--
		local Tween = game:GetService("TweenService")

		--<创建Tween>--
		local SubtitlesInfo = TweenInfo.new(G_TweenTime , Enum.EasingStyle.Linear , Enum.EasingDirection.Out , 0 , false)
		local SubtitleMoveInfo = TweenInfo.new(G_MoveTime , Enum.EasingStyle.Sine , Enum.EasingDirection.Out , 0 , false)

		--<创建字幕GUI>--
		local Gui = Instance.new("ScreenGui" , LocalPlayer:FindFirstChild("PlayerGui"))
		local GuiFrame = Instance.new("Frame" , Gui)
		local UiCornerForFrame = Instance.new("UICorner" , GuiFrame) --|UI圆角|--

		--<判断值>--
		if LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("CheckFolder") then
			--<如果已经有文件夹则不新建>--
			if G_PrintMessage == true then
				print("Already Have CheckFolder")
			end
		else --<如果没有检查文件夹则新建一个>--
			local InstanceFolder = Instance.new("Folder" , LocalPlayer:FindFirstChild("PlayerGui")) 
			InstanceFolder.Name = "CheckFolder"
		end

		local Folder =  LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("CheckFolder") --|索引表|--
		local FolderValue =Folder:GetChildren() --|获取表内值|--

		--<在表内插入值,检测是否已经存在值>--
		if table.getn(FolderValue) == 0 then
			local InstanceCheckValue1 = Instance.new("StringValue" , Folder)
			InstanceCheckValue1.Name = "CheckValue1"
			InstanceCheckValue1.Value = "nil"

			local InstanceCheckValue2 = Instance.new("StringValue" , Folder)
			InstanceCheckValue2.Name = "CheckValue2"
			InstanceCheckValue2.Value = "nil"

			local InstanceCheckValue3 = Instance.new("StringValue" , Folder)
			InstanceCheckValue3.Name = "CheckValue3"
			InstanceCheckValue3.Value = "nil"

			local InstanceCheckValue3 = Instance.new("IntValue" , Folder)
			InstanceCheckValue3.Name = "CountNumber"

		else
			if G_PrintMessage == true then
				print("Already Have Value")
			end
		end

		--<字母背景>--
		local GuiBackGround = Instance.new("ImageLabel" , GuiFrame)
		local UiCornerForPattern = Instance.new("UICorner" , GuiBackGround) --|UI圆角|--

		--<字幕文字>--
		local GuiText = Instance.new("TextLabel" , GuiFrame)
		local UiTextSizeConstraint = Instance.new("UITextSizeConstraint" , GuiText) --|UI圆角|--

		--<数组排序>--
		local ValueNumber = table.getn(FolderValue) --|获取表中值数|--
		local PositionValue

		local CheckValue1 = Folder:FindFirstChild("CheckValue1")
		local CheckValue2 = Folder:FindFirstChild("CheckValue2")
		local CheckValue3 = Folder:FindFirstChild("CheckValue3")
		local CountNumber = Folder:FindFirstChild("CountNumber")

		if CheckValue1.Value == "nil" then --|检查第一个位置是否有字幕在占用|--
			CountNumber.Value += 1 --|加计数|--
			CheckValue1.Value = tostring("Subtitle" .. CountNumber.Value)

		elseif CheckValue1.Value ~= "nil" then --|如果第一个位置有字幕在占用则下移其他字幕|--
			if CheckValue2.Value == "nil" then
				if CheckValue3.Value == "nil" then --|只有第一个位置被占用的情况|--
					local TemporaryCheckValue1 = LocalPlayer.PlayerGui:FindFirstChild(CheckValue1.Value).Frame --|索引值1所在Frame|--
					CheckValue2.Value = tostring("Subtitle" .. CountNumber.Value)
					CountNumber.Value += 1 --|加计数|--
					CheckValue1.Value = tostring("Subtitle" .. CountNumber.Value) --|将当前字幕编号添加到值1中|--
					Tween:Create(TemporaryCheckValue1 , SubtitleMoveInfo , {Position = UDim2.new(0.5,0,0.78 + 0.06,0)}):Play() --|创建Tween1并移动|--

				end

			elseif CheckValue2.Value ~= "nil" then
				if CheckValue3.Value == "nil" then --|有2个位置被占用的情况|--
					local TemporaryCheckValue1 = LocalPlayer.PlayerGui:FindFirstChild(CheckValue1.Value).Frame --|索引值1所在Frame|--
					local TemporaryCheckValue2 = LocalPlayer.PlayerGui:FindFirstChild(CheckValue2.Value).Frame --|索引值2所在Frame|--
					CheckValue2.Value = tostring("Subtitle" .. CountNumber.Value)
					CheckValue3.Value =tostring("Subtitle" .. CountNumber.Value - 1)
					CountNumber.Value += 1 --|加计数|--
					CheckValue1.Value = tostring("Subtitle" .. CountNumber.Value) --|将当前字幕编号添加到值1中|--
					Tween:Create(TemporaryCheckValue1 , SubtitleMoveInfo , {Position = UDim2.new(0.5,0,0.78 + 0.06,0)}):Play() --|创建Tween1并移动|--
					Tween:Create(TemporaryCheckValue2 , SubtitleMoveInfo , {Position = UDim2.new(0.5,0,0.78 + 0.12,0)}):Play() --|创建Tween2并移动|--

				elseif CheckValue3.Value ~= "nil" then
					local TemporaryCheckValue1 = LocalPlayer.PlayerGui:FindFirstChild(CheckValue1.Value).Frame --|索引值1所在Frame|--
					local TemporaryCheckValue2 = LocalPlayer.PlayerGui:FindFirstChild(CheckValue2.Value).Frame --|索引值2所在Frame|--
					local TemporaryCheckValue3 = LocalPlayer.PlayerGui:FindFirstChild(CheckValue3.Value).Frame --|索引值3所在Frame|--
					CheckValue2.Value = tostring("Subtitle" .. CountNumber.Value)
					CheckValue3.Value =tostring("Subtitle" .. CountNumber.Value - 1)
					CountNumber.Value += 1 --|加计数|--
					CheckValue1.Value = tostring("Subtitle" .. CountNumber.Value) --|将当前字幕编号添加到值1中|--
					Tween:Create(TemporaryCheckValue1 , SubtitleMoveInfo , {Position = UDim2.new(0.5,0,0.78 + 0.06,0)}):Play() --|创建Tween1并移动|--
					Tween:Create(TemporaryCheckValue2 , SubtitleMoveInfo , {Position = UDim2.new(0.5,0,0.78 + 0.12,0)}):Play() --|创建Tween2并移动|--
					Tween:Create(TemporaryCheckValue3 , SubtitleMoveInfo , {Position = UDim2.new(0.5,0,0.78 + 1,0)}):Play() --|创建Tween3并移动|--

				end
			end	
		end

		local TemporaryCount = CountNumber.Value

		--<改变杂项属性>--
		UiCornerForFrame.CornerRadius = UDim.new(0.1,0)
		UiCornerForPattern.CornerRadius = UDim.new(0.1,0)
		UiTextSizeConstraint.MaxTextSize = 24
		UiTextSizeConstraint.MinTextSize = 1

		--<改变Gui属性>--
		Gui.Enabled = false
		Gui.Name = "Subtitle" .. CountNumber.Value
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
		GuiFrame.AnchorPoint = Vector2.new(0.5,0)
		GuiFrame.BackgroundColor3 = Color3.new(0, 0, 0)
		GuiFrame.BackgroundTransparency = 0.45
		GuiFrame.Position= UDim2.new(0.5,0,0.78,0) --|Frame坐标|--
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

		local AbsoluteScalConsult1 = math.modf(AbsoluteScale/8) --|求大小并乘以总数|--
		AbsoluteScalConsult1 = AbsoluteScalConsult1 * 0.004

		local ASCFinal = AbsoluteScalConsult1 + AbsoluteScalLost --|求和|--

		GuiFrame.Size = UDim2.new(math.max(MinX , ASCFinal), 0 , 0.045 , 0) --|根据X画幅动态改变|--

		Gui.Enabled = true

		--<等待时间>--
		wait(G_DisapperTime)

		--<创建Tween>--
		local FrameAnimation = Tween:Create(GuiFrame , SubtitlesInfo , {Size = UDim2.new(GuiFrame.Size.X,0,0,0)})
		local TransparensyAnimation = Tween:Create(GuiText , SubtitlesInfo , {TextTransparency = 1})

		FrameAnimation:Play()
		TransparensyAnimation:Play()

		wait(G_TweenTime)

		if CheckValue1.Value == "Subtitle" .. TemporaryCount then
			CheckValue1.Value = "nil"

		elseif CheckValue2.Value == "Subtitle" .. TemporaryCount then
			CheckValue2.Value = "nil"

		elseif CheckValue3.Value == "Subtitle" .. TemporaryCount then
			CheckValue3.Value = "nil"

		end

		Gui:Destroy()

	end

	--<测试>--
	local Player = game:GetService("Players")
	local LocalPlayer = Player.LocalPlayer

	if G_DevMode == true then
		LocalPlayer.Chatted:Connect(function(Message)
			CreateSubtitle(Message)
		end)
	else
		CreateSubtitle(Text) --|输入你想出现的文字 / Type your message here|--
	end


end

return AdaptiveSubtitle
