-- SISTEMA MIMIHACKS COMPLETO (Anti-Fling, God Void, TP Tool, Shift Lock, Inventário Extra, Mola & Persistência Pública)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- SUPORTE A ARQUIVOS (EXPLOITS)
local function salvarArquivo(nome, dados)
	if writefile then
		pcall(function()
			if not isfolder("MimiHacksData") then makefolder("MimiHacksData") end
			writefile("MimiHacksData/" .. nome .. ".json", HttpService:JSONEncode(dados))
		end)
	end
end

local function lerArquivo(nome)
	if readfile and isfile and isfile("MimiHacksData/" .. nome .. ".json") then
		local sucesso, res = pcall(function()
			return HttpService:JSONDecode(readfile("MimiHacksData/" .. nome .. ".json"))
		end)
		if sucesso then return res end
	end
	return nil
end

local function listarArquivos()
	local lista = {}
	if listfiles and isfolder and isfolder("MimiHacksData") then
		for _, file in ipairs(listfiles("MimiHacksData")) do
			local nome = file:match("([^/]+)%.json$")
			if nome then
				table.insert(lista, nome)
			end
		end
	end
	return lista
end

-- Remove versões antigas se existirem
if PlayerGui:FindFirstChild("MimiHacksMenu") then PlayerGui.MimiHacksMenu:Destroy() end
if PlayerGui:FindFirstChild("MimiShiftLockGui") then PlayerGui.MimiShiftLockGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")

-- CONFIGURAÇÃO DA TELA
ScreenGui.Name = "MimiHacksMenu"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MENU PRINCIPAL (MimiHacks)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.08, 0, 0.12, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 420)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- BARRA DE TÍTULO
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TopBar.Size = UDim2.new(1, 0, 0, 40)

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.06, 0, 0, 0)
Title.Size = UDim2.new(0.65, 0, 1, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "⚡ MIMIHACKS"
Title.TextColor3 = Color3.fromRGB(255, 60, 60)
Title.TextSize = 18.000
Title.TextXAlignment = Enum.TextXAlignment.Left

-- BOTÃO DE SETA (Minimizar)
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = TopBar
ToggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ToggleButton.Position = UDim2.new(0.8, 0, 0.2, 0)
ToggleButton.Size = UDim2.new(0, 35, 0, 24)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "▲"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16.000

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleButton

-- SISTEMA DE ABAS (PÁGINAS)
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabBar.Position = UDim2.new(0, 0, 0, 42)
TabBar.Size = UDim2.new(1, 0, 0, 32)
local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabBar
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.Padding = UDim.new(0, 2)

local function criarAbaBotao(nome, texto)
	local btn = Instance.new("TextButton")
	btn.Name = nome
	btn.Parent = TabBar
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.Size = UDim2.new(0, 48, 1, 0)
	btn.Font = Enum.Font.SourceSansBold
	btn.Text = texto
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.TextSize = 12.000
	return btn
end

local TabPrincipal = criarAbaBotao("Tab1", "Principal")
local TabVisuais = criarAbaBotao("Tab2", "Visuais")
local TabOutros = criarAbaBotao("Tab3", "Outros")
local TabCreditos = criarAbaBotao("Tab4", "Créditos")

-- CONTEÚDOS DAS ABAS (SCROLLING FRAMES)
local function criarScrollContainer()
	local scroll = Instance.new("ScrollingFrame")
	scroll.Parent = MainFrame
	scroll.BackgroundTransparency = 1
	scroll.Position = UDim2.new(0, 0, 0, 78)
	scroll.Size = UDim2.new(1, 0, 1, -78)
	scroll.CanvasSize = UDim2.new(0, 0, 0, 650)
	scroll.ScrollBarThickness = 4
	scroll.Visible = false
	
	local layout = Instance.new("UIListLayout")
	layout.Parent = scroll
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 8)
	return scroll
end

local ScrollPrincipal = criarScrollContainer()
local ScrollVisuais = criarScrollContainer()
local ScrollOutros = criarScrollContainer()
local ScrollCreditos = criarScrollContainer()

ScrollPrincipal.Visible = true

-- FUNÇÕES DE CRIAÇÃO DE UI
local function criarBotao(parent, nome, texto, cor)
	local btn = Instance.new("TextButton")
	btn.Name = nome
	btn.Parent = parent
	btn.BackgroundColor3 = cor
	btn.Size = UDim2.new(0.9, 0, 0, 35)
	btn.Font = Enum.Font.SourceSansBold
	btn.Text = texto
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 14.000
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 6)
	c.Parent = btn
	return btn
end

local function criarCampoTexto(parent, nome, placeholder)
	local box = Instance.new("TextBox")
	box.Name = nome
	box.Parent = parent
	box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	box.Size = UDim2.new(0.9, 0, 0, 32)
	box.Font = Enum.Font.SourceSans
	box.PlaceholderText = placeholder
	box.Text = ""
	box.TextColor3 = Color3.fromRGB(255, 255, 255)
	box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
	box.TextSize = 13.000
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 6)
	c.Parent = box
	return box
end

-- ITENS DA ABA PRINCIPAL
local GodModeBtn = criarBotao(ScrollPrincipal, "GodModeBtn", "God Mode: OFF", Color3.fromRGB(180, 40, 40))
local GodModeUltraBtn = criarBotao(ScrollPrincipal, "GodModeUltraBtn", "God Ultra: OFF", Color3.fromRGB(100, 10, 10))
local AntiFlingBtn = criarBotao(ScrollPrincipal, "AntiFlingBtn", "Anti-Fling: OFF", Color3.fromRGB(40, 100, 140))
local TpToolBtn = criarBotao(ScrollPrincipal, "TpToolBtn", "Dar TP Tool", Color3.fromRGB(40, 140, 180))
local SpeedInput = criarCampoTexto(ScrollPrincipal, "SpeedInput", "Velocidade (Ex: 50)")
local SpeedBtn = criarBotao(ScrollPrincipal, "SpeedBtn", "Forçar Speed: OFF", Color3.fromRGB(40, 40, 180))
local JumpInput = criarCampoTexto(ScrollPrincipal, "JumpInput", "Pulos Extras (Ex: 2)")
local JumpBtn = criarBotao(ScrollPrincipal, "JumpBtn", "Multi-Jump: OFF", Color3.fromRGB(140, 40, 180))
local ShiftLockBtn = criarBotao(ScrollPrincipal, "ShiftLockBtn", "Botão Shift Lock (Menu): OFF", Color3.fromRGB(40, 140, 140))
local InventarioExtraBtn = criarBotao(ScrollPrincipal, "InventarioExtraBtn", "Inventário Extra", Color3.fromRGB(80, 80, 160))
local MolaBtn = criarBotao(ScrollPrincipal, "MolaBtn", "Mola", Color3.fromRGB(160, 100, 40))

-- ITENS DA ABA VISUAIS
local EspBoxBtn = criarBotao(ScrollVisuais, "EspBoxBtn", "ESP Box (Jogadores): OFF", Color3.fromRGB(50, 50, 120))
local EspNameBtn = criarBotao(ScrollVisuais, "EspNameBtn", "ESP Names: OFF", Color3.fromRGB(50, 50, 120))
local EspHealthBtn = criarBotao(ScrollVisuais, "EspHealthBtn", "Mostrar Vida: OFF", Color3.fromRGB(50, 50, 120))
local EspTracersBtn = criarBotao(ScrollVisuais, "EspTracersBtn", "ESP Tracers: OFF", Color3.fromRGB(50, 50, 120))

-- ITENS DA ABA OUTROS
local ConfigInput = criarCampoTexto(ScrollOutros, "ConfigInput", "Nome do Salvamento (Ex: config1)")
local SalvarConfigBtn = criarBotao(ScrollOutros, "SalvarConfigBtn", "Salvar Configurações", Color3.fromRGB(40, 120, 40))
local InicioRapidoBtn = criarBotao(ScrollOutros, "InicioRapidoBtn", "Início Rápido: OFF", Color3.fromRGB(120, 120, 40))
local CorRgbBtn = criarBotao(ScrollOutros, "CorRgbBtn", "Modo Cor: Sólido (Mudar)", Color3.fromRGB(140, 40, 140))

local ContainerSalvamentos = Instance.new("Frame")
ContainerSalvamentos.Name = "ContainerSalvamentos"
ContainerSalvamentos.Parent = ScrollOutros
ContainerSalvamentos.BackgroundTransparency = 1
ContainerSalvamentos.Size = UDim2.new(0.9, 0, 0, 150)
local listSalvamentos = Instance.new("UIListLayout")
listSalvamentos.Parent = ContainerSalvamentos
listSalvamentos.HorizontalAlignment = Enum.HorizontalAlignment.Center
listSalvamentos.SortOrder = Enum.SortOrder.LayoutOrder
listSalvamentos.Padding = UDim.new(0, 6)

-- ITENS DA ABA CRÉDITOS
local CreditosLabel = Instance.new("TextLabel")
CreditosLabel.Parent = ScrollCreditos
CreditosLabel.BackgroundTransparency = 1
CreditosLabel.Size = UDim2.new(0.9, 0, 0, 150)
CreditosLabel.Font = Enum.Font.SourceSansBold
CreditosLabel.Text = "Feito por xeleco para melhor jogabilidade"
CreditosLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditosLabel.TextSize = 20.000
CreditosLabel.TextWrapped = true

-- NAVEGAÇÃO ENTRE ABAS
local function trocarAba(abaAtiva)
	ScrollPrincipal.Visible = (abaAtiva == ScrollPrincipal)
	ScrollVisuais.Visible = (abaAtiva == ScrollVisuais)
	ScrollOutros.Visible = (abaAtiva == ScrollOutros)
	ScrollCreditos.Visible = (abaAtiva == ScrollCreditos)
	
	TabPrincipal.BackgroundColor3 = (abaAtiva == ScrollPrincipal) and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(35, 35, 35)
	TabVisuais.BackgroundColor3 = (abaAtiva == ScrollVisuais) and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(35, 35, 35)
	TabOutros.BackgroundColor3 = (abaAtiva == ScrollOutros) and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(35, 35, 35)
	TabCreditos.BackgroundColor3 = (abaAtiva == ScrollCreditos) and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(35, 35, 35)
end

TabPrincipal.MouseButton1Click:Connect(function() trocarAba(ScrollPrincipal) end)
TabVisuais.MouseButton1Click:Connect(function() trocarAba(ScrollVisuais) end)
TabOutros.MouseButton1Click:Connect(function() trocarAba(ScrollOutros) end)
TabCreditos.MouseButton1Click:Connect(function() trocarAba(ScrollCreditos) end)

-- VARIÁVEIS DOS SISTEMAS
local godNormal = false
local godUltra = false
local antiFlingAtivo = false
local speedAtivo = false
local jumpAtivo = false
local shiftLockAtivo = false
local espBoxAtivo = false
local espNameAtivo = false
local espHealthAtivo = false
local espTracersAtivo = false
local rgbAtivo = false
local inicioRapidoAtivo = false

local conexaoGodHealth, loopGodUltra, loopAntiFling, loopSpeed, conexaoJump, loopRgb

-- CARREGAR CONFIGURAÇÃO GLOBAL DE INÍCIO RÁPIDO AO INICIAR
local globalSettings = lerArquivo("MimiGlobalSettings")
if globalSettings then
	inicioRapidoAtivo = globalSettings.inicioRapido or false
	if inicioRapidoAtivo then
		InicioRapidoBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
		InicioRapidoBtn.Text = "Início Rápido: ON"
		if globalSettings.ultimaConfig then
			local dadosUltima = lerArquivo(globalSettings.ultimaConfig)
			if dadosUltima then
				SpeedInput.Text = dadosUltima.speed or ""
				JumpInput.Text = dadosUltima.jump or ""
			end
		end
	end
end

-- MINIMIZAR MENU
local minimizado = false
local tamanhoOriginal = MainFrame.Size
ToggleButton.MouseButton1Click:Connect(function()
	minimizado = not minimizado
	if minimizado then
		MainFrame:TweenSize(UDim2.new(0, 260, 0, 40), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
		ToggleButton.Text = "▼"
		TabBar.Visible = false
		ScrollPrincipal.Visible = false
		ScrollVisuais.Visible = false
		ScrollOutros.Visible = false
		ScrollCreditos.Visible = false
	else
		MainFrame:TweenSize(tamanhoOriginal, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
		ToggleButton.Text = "▲"
		task.wait(0.1)
		TabBar.Visible = true
		trocarAba(ScrollPrincipal)
	end
end)

-- AURA NORMAL & ULTRA PÚBLICA (Visível para todos no servidor)
local function aplicarAuraNormal(character)
	if character:FindFirstChild("AuraPadraoMimi") then character.AuraPadraoMimi:Destroy() end
	local forceField = Instance.new("ForceField")
	forceField.Name = "AuraPadraoMimi"
	forceField.Parent = character
end

local function aplicarAuraUltraPreta(character)
	if character:FindFirstChild("AuraUltraPreta") then character.AuraUltraPreta:Destroy() end
	local modelAura = Instance.new("Model")
	modelAura.Name = "AuraUltraPreta"
	modelAura.Parent = character
	
	local highlight = Instance.new("Highlight")
	highlight.Name = "EfeitoUltraPreto"
	highlight.FillColor = Color3.fromRGB(5, 5, 5)
	highlight.FillTransparency = 0.4
	highlight.OutlineColor = Color3.fromRGB(70, 0, 120)
	highlight.OutlineTransparency = 0.1
	highlight.Parent = modelAura
	
	local partRaiz = character:FindFirstChild("HumanoidRootPart")
	if partRaiz then
		if partRaiz:FindFirstChild("RaiosUltraPretos") then partRaiz.RaiosUltraPretos:Destroy() end
		local particles = Instance.new("ParticleEmitter")
		particles.Name = "RaiosUltraPretos"
		particles.Color = ColorSequence.new(Color3.fromRGB(20, 20, 20), Color3.fromRGB(120, 0, 255))
		particles.Size = NumberSequence.new(0.6, 0.1)
		particles.Texture = "rbxassetid://258124463"
		particles.Rate = 35
		particles.Speed = NumberRange.new(6, 12)
		particles.Parent = partRaiz
	end
end

-- ANTI-FLING
AntiFlingBtn.MouseButton1Click:Connect(function()
	antiFlingAtivo = not antiFlingAtivo
	if antiFlingAtivo then
		AntiFlingBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
		AntiFlingBtn.Text = "Anti-Fling: ON"
		loopAntiFling = task.spawn(function()
			while antiFlingAtivo do
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					local hrp = LocalPlayer.Character.HumanoidRootPart
					hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
					if hrp.AssemblyLinearVelocity.Magnitude > 60 then
						hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					end
					for _, p in pairs(Players:GetPlayers()) do
						if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
							local outroHrp = p.Character.HumanoidRootPart
							if (hrp.Position - outroHrp.Position).Magnitude < 10 then
								outroHrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
							end
						end
					end
				end
				task.wait(0.01)
			end
		end)
	else
		AntiFlingBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 140)
		AntiFlingBtn.Text = "Anti-Fling: OFF"
		if loopAntiFling then task.cancel(loopAntiFling) end
	end
end)

-- GOD MODE NORMAL
GodModeBtn.MouseButton1Click:Connect(function()
	godNormal = not godNormal
	if godNormal then
		GodModeBtn.BackgroundColor3 = Color3.fromRGB(40, 150, 40)
		GodModeBtn.Text = "God Mode: ON"
		if LocalPlayer.Character then aplicarAuraNormal(LocalPlayer.Character) end
		
		local function blindarHumanoide(hum)
			if conexaoGodHealth then conexaoGodHealth:Disconnect() end
			hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
			conexaoGodHealth = hum.HealthChanged:Connect(function(novoHealth)
				if godNormal then
					if novoHealth < hum.MaxHealth then
						hum.Health = hum.MaxHealth
					end
				end
			end)
			hum.Health = hum.MaxHealth
		end
		
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
			blindarHumanoide(LocalPlayer.Character.Humanoid)
		end
		
		task.spawn(function()
			while godNormal do
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
					local hrp = LocalPlayer.Character.HumanoidRootPart
					local hum = LocalPlayer.Character.Humanoid
					if hrp.Position.Y < -350 then
						hrp.CFrame = CFrame.new(hrp.Position.X, 60, hrp.Position.Z)
						hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					end
					if hum.Health < hum.MaxHealth then
						hum.Health = hum.MaxHealth
					end
				end
				task.wait(0.2)
			end
		end)
	else
		GodModeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
		GodModeBtn.Text = "God Mode: OFF"
		if conexaoGodHealth then conexaoGodHealth:Disconnect() end
		if LocalPlayer.Character then
			local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
			if hum then hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true) end
			if LocalPlayer.Character:FindFirstChild("AuraPadraoMimi") then
				LocalPlayer.Character.AuraPadraoMimi:Destroy()
			end
		end
	end
end)

-- GOD MODE ULTRA
GodModeUltraBtn.MouseButton1Click:Connect(function()
	godUltra = not godUltra
	if godUltra then
		GodModeUltraBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		GodModeUltraBtn.Text = "God Ultra: ATIVADO"
		if LocalPlayer.Character then aplicarAuraUltraPreta(LocalPlayer.Character) end
		
		loopGodUltra = task.spawn(function()
			while godUltra do
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
					local hum = LocalPlayer.Character.Humanoid
					hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
					hum.Health = hum.MaxHealth
				end
				task.wait(0.005)
			end
		end)
	else
		GodModeUltraBtn.BackgroundColor3 = Color3.fromRGB(100, 10, 10)
		GodModeUltraBtn.Text = "God Ultra: OFF"
		if loopGodUltra then task.cancel(loopGodUltra) end
		if LocalPlayer.Character then
			local hum = LocalPlayer.Character:FindFirstChild("Humanoid")
			if hum then hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true) end
			if LocalPlayer.Character:FindFirstChild("AuraUltraPreta") then LocalPlayer.Character.AuraUltraPreta:Destroy() end
			local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if hrp and hrp:FindFirstChild("RaiosUltraPretos") then hrp.RaiosUltraPretos:Destroy() end
		end
	end
end)

-- BOTÃO DE TP TOOL
TpToolBtn.MouseButton1Click:Connect(function()
	if LocalPlayer.Character and LocalPlayer.Backpack then
		if not LocalPlayer.Backpack:FindFirstChild("MimiTPTool") and not LocalPlayer.Character:FindFirstChild("MimiTPTool") then
			local tool = Instance.new("Tool")
			tool.Name = "MimiTPTool"
			tool.RequiresHandle = false
			tool.Parent = LocalPlayer.Backpack
			
			tool.Activated:Connect(function()
				local mouse = LocalPlayer:GetMouse()
				local pos = mouse.Hit
				if pos and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.Position + Vector3.new(0, 3, 0))
				end
			end)
			TpToolBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
			TpToolBtn.Text = "TP Tool Adicionado!"
			task.wait(1.5)
			TpToolBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 180)
			TpToolBtn.Text = "Dar TP Tool"
		end
	end
end)

-- SPEED FORÇADO
SpeedBtn.MouseButton1Click:Connect(function()
	speedAtivo = not speedAtivo
	if speedAtivo then
		local val = tonumber(SpeedInput.Text) or 50
		SpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
		SpeedBtn.Text = "Speed Forçado: ON"
		loopSpeed = task.spawn(function()
			while speedAtivo do
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
					LocalPlayer.Character.Humanoid.WalkSpeed = val
				end
				task.wait(0.01)
			end
		end)
	else
		speedAtivo = false
		SpeedBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 180)
		SpeedBtn.Text = "Forçar Speed: OFF"
		if loopSpeed then task.cancel(loopSpeed) end
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
			LocalPlayer.Character.Humanoid.WalkSpeed = 16
		end
	end
end)

-- MULTI-JUMP
JumpBtn.MouseButton1Click:Connect(function()
	jumpAtivo = not jumpAtivo
	if jumpAtivo then
		local maxPulos = tonumber(JumpInput.Text) or 2
		local pulosRes = maxPulos
		local noAr = false
		JumpBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
		JumpBtn.Text = "Multi-Jump: ON"
		
		if conexaoJump then conexaoJump:Disconnect() end
		conexaoJump = UserInputService.JumpRequest:Connect(function()
			if jumpAtivo and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = LocalPlayer.Character.HumanoidRootPart
				local hum = LocalPlayer.Character.Humanoid
				if hum:GetState() == Enum.HumanoidStateType.Running or hum:GetState() == Enum.HumanoidStateType.Landed then
					pulosRes = maxPulos
					noAr = false
				else
					if pulosRes > 0 and noAr then
						pulosRes = pulosRes - 1
						hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, 50, hrp.AssemblyLinearVelocity.Z)
						noAr = false
						task.wait(0.15)
					end
				end
			end
		end)
		
		task.spawn(function()
			while jumpAtivo do
				if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
					local hum = LocalPlayer.Character.Humanoid
					if hum:GetState() == Enum.HumanoidStateType.Freefall or hum:GetState() == Enum.HumanoidStateType.Jumping then
						task.wait(0.2)
						noAr = true
					end
				end
				task.wait(0.1)
			end
		end)
	else
		JumpBtn.BackgroundColor3 = Color3.fromRGB(140, 40, 180)
		JumpBtn.Text = "Multi-Jump: OFF"
		if conexaoJump then conexaoJump:Disconnect() end
	end
end)

-- SHIFT LOCK FLUTUANTE
local shiftLockGui = Instance.new("ScreenGui")
shiftLockGui.Name = "MimiShiftLockGui"
shiftLockGui.Parent = PlayerGui
shiftLockGui.ResetOnSpawn = false
shiftLockGui.Enabled = false

local floatLockBtn = Instance.new("ImageButton")
floatLockBtn.Parent = shiftLockGui
floatLockBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
floatLockBtn.BackgroundTransparency = 0.4
floatLockBtn.Position = UDim2.new(0.85, 0, 0.48, 0)
floatLockBtn.Size = UDim2.new(0, 48, 0, 48)
local fCorner = Instance.new("UICorner")
fCorner.CornerRadius = UDim.new(1, 0)
fCorner.Parent = floatLockBtn

local fIcon = Instance.new("ImageLabel")
fIcon.Parent = floatLockBtn
fIcon.BackgroundTransparency = 1
fIcon.Position = UDim2.new(0.2, 0, 0.2, 0)
fIcon.Size = UDim2.new(0.6, 0, 0.6, 0)
fIcon.Image = "rbxassetid://6071578114"

local camera = workspace.CurrentCamera
local shiftLockAtivoJogo = false

floatLockBtn.MouseButton1Click:Connect(function()
	shiftLockAtivoJogo = not shiftLockAtivoJogo
	floatLockBtn.BackgroundColor3 = shiftLockAtivoJogo and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(0, 0, 0)
end)

ShiftLockBtn.MouseButton1Click:Connect(function()
	shiftLockAtivo = not shiftLockAtivo
	if shiftLockAtivo then
		ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
		ShiftLockBtn.Text = "Shift Lock (Botão): ON"
		shiftLockGui.Enabled = true
	else
		ShiftLockBtn.BackgroundColor3 = Color3.fromRGB(40, 140, 140)
		ShiftLockBtn.Text = "Shift Lock (Botão): OFF"
		shiftLockGui.Enabled = false
		shiftLockAtivoJogo = false
		floatLockBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	end
end)

RunService.RenderStepped:Connect(function()
	if shiftLockAtivoJogo and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = LocalPlayer.Character.HumanoidRootPart
		local camVector = camera.CFrame.LookVector
		local newLook = Vector3.new(camVector.X, 0, camVector.Z).Unit
		hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + newLook)
	end
end)

-- BOTÃO INVENTÁRIO EXTRA
InventarioExtraBtn.MouseButton1Click:Connect(function()
	if PlayerGui:FindFirstChild("Custom Inventory") then
		PlayerGui["Custom Inventory"]:Destroy()
	end
	
	local G2L = {};
	G2L["1"] = Instance.new("ScreenGui", PlayerGui);
	G2L["1"]["Name"] = [[Custom Inventory]];
	G2L["1"]["ResetOnSpawn"] = false;

	G2L["2"] = Instance.new("ImageLabel", G2L["1"]);
	G2L["2"]["Active"] = true;
	G2L["2"]["ZIndex"] = 0;
	G2L["2"]["BorderSizePixel"] = 0;
	G2L["2"]["SliceCenter"] = Rect.new(5, 5, 945, 612);
	G2L["2"]["ScaleType"] = Enum.ScaleType.Slice;
	G2L["2"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["2"]["AnchorPoint"] = Vector2.new(0.5, 1);
	G2L["2"]["Size"] = UDim2.new(0.52177, 0, 0.39941, 0);
	G2L["2"]["Visible"] = false;
	G2L["2"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
	G2L["2"]["BackgroundTransparency"] = 0.5;
	G2L["2"]["Name"] = [[Inventory]];
	G2L["2"]["Position"] = UDim2.new(0.5, 0, 0.925, -20);

	G2L["3"] = Instance.new("ScrollingFrame", G2L["2"]);
	G2L["3"]["Active"] = true;
	G2L["3"]["ScrollingDirection"] = Enum.ScrollingDirection.Y;
	G2L["3"]["BorderSizePixel"] = 0;
	G2L["3"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
	G2L["3"]["ElasticBehavior"] = Enum.ElasticBehavior.Never;
	G2L["3"]["TopImage"] = [[]];
	G2L["3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["3"]["Name"] = [[Frame]];
	G2L["3"]["ScrollBarImageTransparency"] = 0.4;
	G2L["3"]["BottomImage"] = [[]];
	G2L["3"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["3"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
	G2L["3"]["Size"] = UDim2.new(0.98, 0, 0.86193, 0);
	G2L["3"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["3"]["Position"] = UDim2.new(0.50106, 0, 0.54904, 0);
	G2L["3"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
	G2L["3"]["ScrollBarThickness"] = 5;
	G2L["3"]["BackgroundTransparency"] = 1;

	G2L["4"] = Instance.new("UIGridLayout", G2L["3"]);
	G2L["4"]["CellSize"] = UDim2.new(0, 83, 0, 83);
	G2L["4"]["Name"] = [[Grid]];
	G2L["4"]["CellPadding"] = UDim2.new(0, 15, 0, 15);

	G2L["5"] = Instance.new("UIPadding", G2L["3"]);
	G2L["5"]["PaddingTop"] = UDim.new(0, 5);
	G2L["5"]["PaddingLeft"] = UDim.new(0, 5);

	G2L["6"] = Instance.new("TextBox", G2L["2"]);
	G2L["6"]["LineHeight"] = 1.1;
	G2L["6"]["Name"] = [[SearchBox]];
	G2L["6"]["PlaceholderColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["6"]["TextWrapped"] = true;
	G2L["6"]["TextSize"] = 14;
	G2L["6"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["6"]["TextScaled"] = true;
	G2L["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["6"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
	G2L["6"]["AnchorPoint"] = Vector2.new(0.5, 0);
	G2L["6"]["PlaceholderText"] = [[SEARCH]];
	G2L["6"]["Size"] = UDim2.new(0.36276, 0, 0.04893, 20);
	G2L["6"]["Position"] = UDim2.new(0.80953, 0, 0.01854, 0);
	G2L["6"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
	G2L["6"]["Text"] = [[]];
	G2L["6"]["BackgroundTransparency"] = 0.5;

	G2L["7"] = Instance.new("UICorner", G2L["6"]);
	G2L["7"]["CornerRadius"] = UDim.new(0.2, 0);

	G2L["8"] = Instance.new("UICorner", G2L["2"]);
	G2L["8"]["CornerRadius"] = UDim.new(0.05, 0);

	G2L["9"] = Instance.new("Frame", G2L["1"]);
	G2L["9"]["ZIndex"] = 0;
	G2L["9"]["BorderSizePixel"] = 0;
	G2L["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["9"]["AnchorPoint"] = Vector2.new(0.5, 1);
	G2L["9"]["Size"] = UDim2.new(0.45209, 0, 0.05, 20);
	G2L["9"]["Position"] = UDim2.new(0.5, 0, 0.99, -5);
	G2L["9"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
	G2L["9"]["Name"] = [[hotBar]];
	G2L["9"]["BackgroundTransparency"] = 1;

	G2L["a"] = Instance.new("UIGridLayout", G2L["9"]);
	G2L["a"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
	G2L["a"]["CellSize"] = UDim2.new(0, 70, 0, 70);
	G2L["a"]["Name"] = [[Grid]];
	G2L["a"]["CellPadding"] = UDim2.new(0.01, 5, 0, 5);

	G2L["b"] = Instance.new("ImageButton", G2L["1"]);
	G2L["b"]["BorderSizePixel"] = 0;
	G2L["b"]["BackgroundTransparency"] = 1;
	G2L["b"]["BackgroundColor3"] = Color3.fromRGB(52, 52, 52);
	G2L["b"]["ZIndex"] = 6;
	G2L["b"]["AnchorPoint"] = Vector2.new(0.5, 1);
	G2L["b"]["Size"] = UDim2.new(0.3, 0, 0.04313, 0);
	G2L["b"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["b"]["Name"] = [[openButton]];
	G2L["b"]["Position"] = UDim2.new(0.5, 0, 0.92, -20);

	G2L["c"] = Instance.new("TextLabel", G2L["b"]);
	G2L["c"]["TextWrapped"] = true;
	G2L["c"]["ZIndex"] = 6;
	G2L["c"]["BorderSizePixel"] = 0;
	G2L["c"]["TextSize"] = 14;
	G2L["c"]["TextScaled"] = true;
	G2L["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
	G2L["c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["c"]["BackgroundTransparency"] = 1;
	G2L["c"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["c"]["Size"] = UDim2.new(1, 0, 0.70945, 0);
	G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["c"]["Text"] = [[(') open inventory]];
	G2L["c"]["Name"] = [[info]];
	G2L["c"]["Position"] = UDim2.new(0.498, 0, 0.5, 0);

	G2L["d"] = Instance.new("UIStroke", G2L["c"]);
	G2L["d"]["LineJoinMode"] = Enum.LineJoinMode.Miter;
	G2L["d"]["Thickness"] = 3;

	G2L["e"] = Instance.new("LocalScript", G2L["1"]);
	G2L["e"]["Name"] = [[InventoryController]];

	G2L["f"] = Instance.new("ModuleScript", G2L["e"]);
	G2L["f"]["Name"] = [[SETTINGS]];

	G2L["10"] = Instance.new("ImageButton", G2L["e"]);
	G2L["10"]["SizeConstraint"] = Enum.SizeConstraint.RelativeYY;
	G2L["10"]["BorderSizePixel"] = 0;
	G2L["10"]["SliceCenter"] = Rect.new(5, 11, 942, 606);
	G2L["10"]["ScaleType"] = Enum.ScaleType.Slice;
	G2L["10"]["AutoButtonColor"] = false;
	G2L["10"]["BackgroundTransparency"] = 0.5;
	G2L["10"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["10"]["Size"] = UDim2.new(1, 0, 1, 0);
	G2L["10"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
	G2L["10"]["Name"] = [[toolButton]];
	G2L["10"]["Position"] = UDim2.new(0.44899, 0, 0.40652, 0);

	G2L["11"] = Instance.new("TextLabel", G2L["10"]);
	G2L["11"]["TextWrapped"] = true;
	G2L["11"]["ZIndex"] = 2;
	G2L["11"]["BorderSizePixel"] = 0;
	G2L["11"]["TextSize"] = 14;
	G2L["11"]["TextTransparency"] = 0.5;
	G2L["11"]["TextScaled"] = true;
	G2L["11"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["11"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
	G2L["11"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["11"]["BackgroundTransparency"] = 1;
	G2L["11"]["Size"] = UDim2.new(0.343, 0, 0.288, 0);
	G2L["11"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
	G2L["11"]["Text"] = [[1]];
	G2L["11"]["Name"] = [[toolNumber]];

	G2L["12"] = Instance.new("TextLabel", G2L["10"]);
	G2L["12"]["TextWrapped"] = true;
	G2L["12"]["ZIndex"] = 3;
	G2L["12"]["BorderSizePixel"] = 0;
	G2L["12"]["TextSize"] = 16;
	G2L["12"]["TextScaled"] = true;
	G2L["12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["12"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
	G2L["12"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["12"]["BackgroundTransparency"] = 1;
	G2L["12"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["12"]["Size"] = UDim2.new(0.8, 0, 0.518, 0);
	G2L["12"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
	G2L["12"]["Text"] = [[N/A]];
	G2L["12"]["Name"] = [[toolName]];
	G2L["12"]["Position"] = UDim2.new(0.515, 0, 0.47079, 0);

	G2L["13"] = Instance.new("UIStroke", G2L["12"]);
	G2L["13"]["Thickness"] = 3;

	G2L["14"] = Instance.new("UITextSizeConstraint", G2L["12"]);
	G2L["14"]["MaxTextSize"] = 20;
	G2L["14"]["MinTextSize"] = 5;

	G2L["15"] = Instance.new("TextLabel", G2L["10"]);
	G2L["15"]["TextWrapped"] = true;
	G2L["15"]["ZIndex"] = 3;
	G2L["15"]["BorderSizePixel"] = 0;
	G2L["15"]["TextSize"] = 14;
	G2L["15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["15"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.SemiBold, Enum.FontStyle.Normal);
	G2L["15"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["15"]["BackgroundTransparency"] = 1;
	G2L["15"]["Size"] = UDim2.new(1.13, 0, 0.17, 0);
	G2L["15"]["BorderColor3"] = Color3.fromRGB(28, 43, 54);
	G2L["15"]["Text"] = [[]];
	G2L["15"]["Name"] = [[toolAmount]];
	G2L["15"]["Position"] = UDim2.new(-0.065, 0, 0.725, 0);

	G2L["16"] = Instance.new("UIStroke", G2L["15"]);
	G2L["16"]["Thickness"] = 3;

	G2L["17"] = Instance.new("ImageLabel", G2L["10"]);
	G2L["17"]["BorderSizePixel"] = 0;
	G2L["17"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["17"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
	G2L["17"]["Image"] = [[rbxassetid://10202636594]];
	G2L["17"]["Size"] = UDim2.new(1, 0, 1, 0);
	G2L["17"]["Visible"] = false;
	G2L["17"]["BorderColor3"] = Color3.fromRGB(255, 255, 255);
	G2L["17"]["BackgroundTransparency"] = 1;
	G2L["17"]["Selectable"] = true;
	G2L["17"]["Name"] = [[toolIcon]];
	G2L["17"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

	G2L["18"] = Instance.new("UIAspectRatioConstraint", G2L["17"]);
	G2L["19"] = Instance.new("UIStroke", G2L["10"]);
	G2L["19"]["Thickness"] = 5;
	G2L["1a"] = Instance.new("UICorner", G2L["10"]);
	G2L["1a"]["CornerRadius"] = UDim.new(0.1, 0);

	local G2L_REQUIRE = require;
	local G2L_MODULES = {};
	local function require(Module:ModuleScript)
		local ModuleState = G2L_MODULES[Module];
		if ModuleState then
			if not ModuleState.Required then
				ModuleState.Required = true;
				ModuleState.Value = ModuleState.Closure();
			end
			return ModuleState.Value;
		end;
		return G2L_REQUIRE(Module);
	end

	G2L_MODULES[G2L["f"]] = {
		Closure = function()
			local script = G2L["f"];local module = {OBJECTS = {}, SETTINGS = {}, slotAmount = 6}
			module.OBJECTS.HotBar = {}
			module.OBJECTS.Inventory = {}

			local SETTINGS = module.SETTINGS
			SETTINGS.DEFAULT_COLOR = Color3.fromRGB(0, 0, 0)
			SETTINGS.EQUIPPED_COLOR = Color3.fromRGB(128, 128, 128)
			SETTINGS.DISABLED_COLOR = Color3.fromRGB(128, 64, 65)
			SETTINGS.DEFAULT_IMAGEID = ""
			SETTINGS.EQUIPPED_IMAGEID = ""
			SETTINGS.DISABLED_IMAGEID = ""
			SETTINGS.INVENTORY_KEYBIND = Enum.KeyCode.Backquote
			SETTINGS.DRAG_OUTSIDE_TO_DROP = false
			SETTINGS.SHOW_EMPTY_TOOL_FRAMES_IN_HOTBAR = false
			SETTINGS.SCROLL_HOTBAR_WITH_WHEEL = false
			SETTINGS.EQUIP_TOUCH_SENSITIVITY = 60
			SETTINGS.OPEN_BUTTON = true
			SETTINGS.ALWAYS_SHOW_TOOL_NAME = true

			local ContextActionService = game:GetService("ContextActionService")
			local TextService = game:GetService("TextService")
			local UserInputService = game:GetService("UserInputService")
			local RunService = game:GetService("RunService")

			local player = game:GetService("Players").LocalPlayer
			local playerGui = player:WaitForChild("PlayerGui")
			local mouse = player:GetMouse()

			local inventoryGui = script.Parent.Parent
			local hotbar = inventoryGui.hotBar
			local inventoryFrame = inventoryGui.Inventory
			local toolButton = script.Parent.toolButton

			local EnumKeys = {
				Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three,
				Enum.KeyCode.Four, Enum.KeyCode.Five, Enum.KeyCode.Six,
				Enum.KeyCode.Seven, Enum.KeyCode.Eight, Enum.KeyCode.Nine,
			}

			local toolObjectMetatable = {}
			toolObjectMetatable.__index = toolObjectMetatable

			function toolObjectMetatable:isEquipped()
				local character = player.Character
				if character then
					return self.Tool.Parent == player.Character
				else
					return false
				end
			end

			function toolObjectMetatable:DisconnectAll()
				for _, v in pairs(self.CONNECTIONS) do
					v:Disconnect()
				end
				self.didRemoval = true

				if (inventoryFrame.Visible or module.SETTINGS.SHOW_EMPTY_TOOL_FRAMES_IN_HOTBAR) and self.Frame.Parent ~= inventoryGui and self.Frame.Parent ~= inventoryFrame.Frame then
					local toolName = self.Frame:FindFirstChild("toolName")
					local toolAmount = self.Frame:FindFirstChild("toolAmount")
					local toolIcon = self.Frame:FindFirstChild("toolIcon")

					if toolName and toolAmount and toolIcon then
						toolName.Text = ""
						toolAmount.Text = ""
						toolIcon.Image = ""
					end
					self.Frame.BackgroundColor3 = SETTINGS.DEFAULT_COLOR
					self.Frame.Image = SETTINGS.DEFAULT_IMAGEID
				else
					self.Frame:Destroy()
				end

				if self.Parent == "HotBar" and self.Position then
					ContextActionService:UnbindAction(self.Position .. "hotBar")
					module.OBJECTS.HotBar[self.Position] = nil
				elseif self.Parent == "Inventory" then
					module.OBJECTS.Inventory[self.Tool.Name] = nil
				end
				self = nil
			end

			function toolObjectMetatable:updateIcon()
				local tool = self.Tool
				local frame = self.Frame
				local textureId = tool.TextureId

				if textureId == "" or textureId == nil then
					frame.toolName.Visible = true
					frame.toolIcon.Visible = false
					frame.toolIcon.Image = ""
				else
					frame.toolName.Visible = SETTINGS.ALWAYS_SHOW_TOOL_NAME
					frame.toolIcon.Visible = true
					frame.toolIcon.Image = textureId
				end
			end

			function toolObjectMetatable:getParentInstance()
				return self.Parent == "Inventory" and inventoryFrame.Frame or hotbar
			end

			function toolObjectMetatable:showDescription()
				local toolDescription = self.Tool.ToolTip
				local frame = self.Frame
				if toolDescription == "" then return end

				local descriptionFrame = Instance.new("TextLabel")
				descriptionFrame.Name = "descriptionFrame"
				descriptionFrame.AnchorPoint = Vector2.new(0.5, 0)
				descriptionFrame.Font = Enum.Font.SourceSansSemibold
				descriptionFrame.TextColor = BrickColor.Black()
				descriptionFrame.TextSize = 14
				descriptionFrame.BorderSizePixel = 0
				descriptionFrame.BackgroundColor = BrickColor.White()
				descriptionFrame.ZIndex = 99
				descriptionFrame.TextWrapped = true
				descriptionFrame.Parent = inventoryGui

				local corner = Instance.new("UICorner")
				corner.Parent = descriptionFrame
				corner.CornerRadius = UDim.new(0.12, 0)

				local textBounds = TextService:GetTextSize(toolDescription, descriptionFrame.TextSize, descriptionFrame.Font, Vector2.new(400, 1000)) + Vector2.new(10, 4)
				descriptionFrame.Size = UDim2.new(0, textBounds.X, 0, textBounds.Y)
				descriptionFrame.Position = UDim2.new(0, frame.AbsolutePosition.X + (frame.AbsoluteSize.X / 2), 0, frame.AbsolutePosition.Y - textBounds.Y - 2 + 57)
				descriptionFrame.Text = toolDescription
				self.DescriptionFrame = descriptionFrame
				game:GetService("Debris"):AddItem(descriptionFrame, 15)
			end

			function toolObjectMetatable:removeDescription()
				if self.DescriptionFrame then self.DescriptionFrame:Destroy() end
			end

			function module:removeCurrentDescription()
				local descriptionFrame = inventoryGui:FindFirstChild("descriptionFrame")
				if descriptionFrame then descriptionFrame:Destroy() end
			end

			function module:getObjectFromTool(tool: Tool)
				local function searchToolObject(toolParent)
					for _, toolObject in pairs(toolParent) do
						if toolObject.Tool == tool then return toolObject end
					end
				end
				return searchToolObject(self.OBJECTS.HotBar) or searchToolObject(self.OBJECTS.Inventory)
			end

			function module:getToolPosition(tool: Tool)
				local toolObject = self:getObjectFromTool(tool)
				return toolObject and toolObject.Position
			end

			function module:searchTool()
				local toolName: string = inventoryFrame.SearchBox.Text
				if toolName == "" then
					for _, toolObject in pairs(self.OBJECTS["Inventory"]) do
						toolObject.Frame.Visible = true
					end
				elseif toolName then
					for _, toolObject in pairs(self.OBJECTS["Inventory"]) do
						toolObject.Frame.Visible = string.find(toolObject.Name:lower(), toolName:lower()) and true or false
					end
				end
			end

			function module:lockSlots(unequipCurrentTool: boolean)
				self.slotsLocked = true
				if unequipCurrentTool then
					local character = player.Character
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")
					if humanoid then humanoid:UnequipTools() end
				end
			end
			function module:unlockSlots() self.slotsLocked = false end
			function module:lockSlotsPosition() self.slotsPositionLocked = true end
			function module:unlockSlotsPosition() self.slotsPositionLocked = false end

			function module:newTool(tool: Tool)
				if tool:GetAttribute("toolAdded") or not tool:IsA("Tool") then return end
				local length = 0
				for _, _ in pairs(module.OBJECTS.HotBar) do length += 1 end
				module:addTool(tool, length == self.slotAmount and "Inventory" or "HotBar", tool:GetAttribute("position"))
			end

			function module:addTool(tool: Tool, parent: string, position: number)
				tool:SetAttribute("position", nil)
				if position == -1 then
					parent = "Inventory"
					position = nil
				end

				if not position and parent == "HotBar" then
					for index = 1, self.slotAmount do
						if self.OBJECTS.HotBar[index] == nil then
							position = index
							break
						end
					end
				end

				if position and hotbar:FindFirstChild(position) then
					hotbar:FindFirstChild(position):Destroy()
				end

				local frame = toolButton:Clone()
				local amount = tool:GetAttribute("amount") or 1
				if amount > 1 then frame.toolAmount.Text = "x" .. amount end
				frame.toolName.Text = tool.Name
				frame.Parent = parent == "Inventory" and inventoryFrame.Frame or hotbar
				frame.Name = parent == "Inventory" and tool.Name or position
				frame.toolNumber.Text = parent == "Inventory" and "" or position

				local object = {}
				setmetatable(object, toolObjectMetatable)

				object.Tool = tool
				object.Frame = frame
				object.Parent = parent
				object.Position = position
				object.Name = tool.Name
				self.OBJECTS[parent][position == nil and frame.Name or position] = object

				local function manageTool(_, inputState, inputObject)
					if inputObject and inputObject.UserInputType ~= Enum.UserInputType.Keyboard and inputObject.UserInputType ~= Enum.UserInputType.Touch then return end
					local character = player.Character
					local humanoid = character and character:FindFirstChildOfClass("Humanoid")
					if not humanoid or humanoid.Health <= 0 or not tool.Parent or inputState == Enum.UserInputState.End or self.slotsLocked then return end

					if object:isEquipped() then
						humanoid:UnequipTools()
						frame.BackgroundColor3 = SETTINGS.DEFAULT_COLOR
						frame.Image = SETTINGS.DEFAULT_IMAGEID
						module.currentlyEquipped = nil
					elseif tool.Enabled then
						humanoid:EquipTool(tool)
						if module.currentlyEquipped and module.currentlyEquipped.Parent then
							module.currentlyEquipped.BackgroundColor3 = SETTINGS.DEFAULT_COLOR
							module.currentlyEquipped.Image = SETTINGS.DEFAULT_IMAGEID
						end
						module.currentlyEquipped = frame
						frame.BackgroundColor3 = SETTINGS.EQUIPPED_COLOR
						frame.Image = SETTINGS.EQUIPPED_IMAGEID
					end
				end

				local function updateEquipped()
					if object:isEquipped() and tool.Enabled then
						if module.currentlyEquipped and module.currentlyEquipped.Parent then
							module.currentlyEquipped.BackgroundColor3 = SETTINGS.DEFAULT_COLOR
							module.currentlyEquipped.Image = SETTINGS.DEFAULT_IMAGEID
						end
						module.currentlyEquipped = frame
						frame.BackgroundColor3 = SETTINGS.EQUIPPED_COLOR
						frame.Image = SETTINGS.EQUIPPED_IMAGEID
					else
						frame.BackgroundColor3 = SETTINGS.DEFAULT_COLOR
						frame.Image = SETTINGS.DEFAULT_IMAGEID
						module.currentlyEquipped = nil
					end
				end

				local function updateEnabled()
					if tool.Enabled then
						frame.Image = SETTINGS.DEFAULT_IMAGEID
						frame.BackgroundColor3 = SETTINGS.DEFAULT_COLOR
						frame.ImageTransparency = 0
						frame.toolIcon.ImageTransparency = 0
						frame.toolName.TextTransparency = 0
						frame.toolNumber.TextTransparency = 0
						frame.toolAmount.TextTransparency = 0
						frame.toolAmount.UIStroke.Transparency = 0
						frame.toolName.UIStroke.Transparency = 0
					else
						frame.Image = SETTINGS.DISABLED_IMAGEID
						frame.BackgroundColor3 = SETTINGS.DISABLED_COLOR
						frame.ImageTransparency = 0.35
						frame.toolIcon.ImageTransparency = 0.5
						frame.toolName.TextTransparency = 0.6
						frame.toolNumber.TextTransparency = 0.6
						frame.toolAmount.TextTransparency = 0.6
						frame.toolAmount.UIStroke.Transparency = 0.6
						frame.toolName.UIStroke.Transparency = 0.6
					end
				end
				updateEnabled()
				updateEquipped()
				object:updateIcon()

				object.CONNECTIONS = {}
				object.CONNECTIONS.EnabledConn = tool:GetPropertyChangedSignal("Enabled"):Connect(updateEnabled)
				object.CONNECTIONS.ToolRemoved = tool.AncestryChanged:Connect(function(_, newParent)
					if player and (newParent == nil or (newParent ~= player.Backpack and newParent ~= player.Character)) then
						object:DisconnectAll()
						tool:SetAttribute("toolAdded", false)
					end
					updateEquipped()
				end)
				object.CONNECTIONS.NameChanged = tool:GetPropertyChangedSignal("Name"):Connect(function()
					frame.toolName.Text = tool.Name
					object.Name = tool.Name
				end)
				object.CONNECTIONS.TextureIdChanged = tool:GetPropertyChangedSignal("TextureId"):Connect(function() object:updateIcon() end)
				object.CONNECTIONS.AmountChanged = tool:GetAttributeChangedSignal("amount"):Connect(function()
					amount = tool:GetAttribute("amount") or 1
					if amount > 1 then frame.toolAmount.Text = "x" .. amount else frame.toolAmount.Text = "" end
				end)
				object.CONNECTIONS.MouseEnter = frame.MouseEnter:Connect(function()
					if object.isGrabbed then return end
					object:showDescription()
				end)
				object.CONNECTIONS.MouseLeave = frame.MouseLeave:Connect(function() object:removeDescription() end)
				
				object.CONNECTIONS.GrabConn = frame.MouseButton1Down:Connect(function()
					if self.slotsPositionLocked then return end
					local mouseEnd, mouseConn, newFrame
					local CellSize = inventoryFrame.Frame.Grid.CellSize
					local frameStartPosition = frame.AbsolutePosition
					object:removeDescription()

					local function endGrab()
						mouseEnd:Disconnect()
						mouseConn:Disconnect()
						object.isGrabbed = false

						local droppedGuis = playerGui:GetGuiObjectsAtPosition(mouse.X, mouse.Y)
						local wasSwapped = false
						local dropTool = true
						for _, newSlot in pairs(droppedGuis) do
							if newSlot:IsA("ImageButton") and (newSlot.Parent == hotbar or newSlot.Parent == inventoryFrame.Frame) then
								local newSlotObject = self.OBJECTS[newSlot.Parent == hotbar and "HotBar" or "Inventory"][newSlot.Parent == hotbar and tonumber(newSlot.Name) or newSlot.Name]
								if newSlotObject == object then
									dropTool = false
									if newFrame then newFrame:Destroy() end
									continue
								end

								if newSlotObject then
									wasSwapped = true
									object:DisconnectAll()
									newSlotObject:DisconnectAll()
									self:addTool(newSlotObject.Tool, parent, position)
									self:addTool(tool, newSlotObject.Parent, newSlotObject.Position)
									if newFrame then newFrame:Destroy() end
								elseif newSlot.Parent == hotbar then
									wasSwapped = true
									object:DisconnectAll()
									self:addTool(tool, "HotBar", tonumber(newSlot.Name))
									if parent == "Inventory" and newFrame then newFrame:Destroy() end
									newSlot:Destroy()
								end
								if newSlotObject then newSlotObject:removeDescription() end
								if object then object:removeDescription() end
							elseif newSlot:IsA("ImageLabel") and newSlot == inventoryFrame and not wasSwapped and parent == "HotBar" then
								wasSwapped = true
								object:DisconnectAll()
								self:addTool(tool, "Inventory")
								self:searchTool()
								break
							end
						end
						
						if not wasSwapped then
							if newFrame then newFrame:Destroy() end
							frame.Parent = object:getParentInstance()
							if SETTINGS.DRAG_OUTSIDE_TO_DROP and dropTool and tool.CanBeDropped then
								local character = player.Character
								if character then
									tool.Parent = character
									RunService.RenderStepped:Wait()
									tool.Parent = workspace
								end
							end
							if (frameStartPosition - Vector2.new(mouse.X, mouse.Y)).Magnitude <= SETTINGS.EQUIP_TOUCH_SENSITIVITY then
								manageTool()
							end
						end
					end

					mouseEnd = UserInputService.InputEnded:Connect(function(inputObject)
						if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
							endGrab()
						end
					end)

					local function updateFramePos()
						if not object.isGrabbed then
							object.isGrabbed = true
							newFrame = toolButton:Clone()
							newFrame.toolName.Text = ""
							newFrame.toolAmount.Text = ""
							newFrame.toolNumber.Text = position or ""
							newFrame.Name = frame.Name
							newFrame.Size = frame.Size
							newFrame.Parent = object:getParentInstance()

							frame.Size = CellSize
							frame.Parent = inventoryGui
						end
						local mousePos = Vector2.new(mouse.X, mouse.Y)
						frame.Position = UDim2.new(0, mousePos.X - (CellSize.X.Offset / 2), 0, mousePos.Y - (CellSize.Y.Offset / 2) + 57)
					end
					mouseConn = mouse.Move:Connect(updateFramePos)
				end)

				tool:SetAttribute("toolAdded", true)
				if parent == "HotBar" and position then
					ContextActionService:BindAction(position .. "hotBar", manageTool, false, EnumKeys[position])
				end
			end

			return module
		end
	};

	local function C_e()
		local StarterGui = game:GetService("StarterGui")
		local ContextActionService = game:GetService("ContextActionService")
		local UserInputService = game:GetService("UserInputService")
		
		local player = game:GetService("Players").LocalPlayer
		local backpack = player:WaitForChild("Backpack")
		local camera = workspace.CurrentCamera
		
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		
		local CustomInventoryGUI = G2L["1"]
		local hotBar = CustomInventoryGUI.hotBar
		local Inventory = CustomInventoryGUI.Inventory
		local toolButton = G2L["10"]
		
		local inventoryHandler = require(G2L["f"])
		
		local function showSlots()
			for index = 1, inventoryHandler.slotAmount do
				local toolObject = inventoryHandler.OBJECTS.HotBar[index]
				if not toolObject and not hotBar:FindFirstChild(index) and index <= inventoryHandler.slotAmount then
					local frame = toolButton:Clone()
					frame.toolName.Text = ""
					frame.toolAmount.Text = ""
					frame.toolNumber.Text = index
					frame.Name = index
					frame.Parent = hotBar
				end
			end
		end

		local function removeEmptySlots()
			for index = 1, 9 do
				local toolObject = inventoryHandler.OBJECTS.HotBar[index]
				local toolFrame = hotBar:FindFirstChild(index)
				if not toolObject and toolFrame then
					toolFrame:Destroy()
					if hotBar:FindFirstChild(index) then removeEmptySlots() end
				end
			end
		end
		
		local function manageInventory (_, inputState)
			if inputState == Enum.UserInputState.Begin then
				Inventory.Visible = not Inventory.Visible
				local currentState = Inventory.Visible
				inventoryHandler:removeCurrentDescription()
				if currentState then
					showSlots()
					CustomInventoryGUI.openButton.Position = UDim2.fromScale(0.5,0.5)
					CustomInventoryGUI.openButton.info.Text = "(') close Inventory"
				else
					if not inventoryHandler.SETTINGS.SHOW_EMPTY_TOOL_FRAMES_IN_HOTBAR then removeEmptySlots() end
					CustomInventoryGUI.openButton.Position = UDim2.new(0.5, 0, 0.92, -20)
					CustomInventoryGUI.openButton.info.Text = "(') open inventory"
				end
			end
		end
		
		local function searchTool() inventoryHandler:searchTool() end
		local function newTool(tool) if tool:IsA("Tool") then inventoryHandler:newTool(tool) end end
		
		local function reloadInventory(character)
			inventoryHandler.currentlyEquipped = nil
			backpack = player:WaitForChild("Backpack")
			for _, tool in pairs(backpack:GetChildren()) do
				if tool:IsA("Tool") then newTool(tool) end
			end
			backpack.ChildAdded:Connect(newTool)
			character.ChildAdded:Connect(newTool)
		end

		local function updateHudPosition()
			local slotSize = UDim2.fromOffset(hotBar.AbsoluteSize.Y, hotBar.AbsoluteSize.Y)
			Inventory.Frame.Grid.CellSize = slotSize
			hotBar.Grid.CellSize = slotSize
			manageInventory()
		end
		
		updateHudPosition(); updateHudPosition()
		reloadInventory(player.Character or player.CharacterAdded:Wait())
		camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateHudPosition)
		player.CharacterAdded:Connect(reloadInventory)
		Inventory.SearchBox:GetPropertyChangedSignal("Text"):Connect(searchTool)
		if inventoryHandler.SETTINGS.SHOW_EMPTY_TOOL_FRAMES_IN_HOTBAR then showSlots() end
		if inventoryHandler.SETTINGS.INVENTORY_KEYBIND then ContextActionService:BindAction("manageInventory", manageInventory, false, inventoryHandler.SETTINGS.INVENTORY_KEYBIND) end
		if inventoryHandler.SETTINGS.OPEN_BUTTON then
			CustomInventoryGUI.openButton.MouseButton1Down:Connect(function()
				Inventory.Visible = not Inventory.Visible
				local currentState = Inventory.Visible
				inventoryHandler:removeCurrentDescription()
				if currentState then
					showSlots()
					CustomInventoryGUI.openButton.Position = UDim2.fromScale(0.5,0.5)
					CustomInventoryGUI.openButton.info.Text = "(') close Inventory"
				else
					if not inventoryHandler.SETTINGS.SHOW_EMPTY_TOOL_FRAMES_IN_HOTBAR then removeEmptySlots() end
					CustomInventoryGUI.openButton.Position = UDim2.new(0.5, 0, 0.92, -20)
					CustomInventoryGUI.openButton.info.Text = "(') open inventory"
				end
			end)
		else
			CustomInventoryGUI.openButton.Visible = false
		end
	end
	task.spawn(C_e)
	
	InventarioExtraBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
	InventarioExtraBtn.Text = "Inventário Aberto!"
	task.wait(1.5)
	InventarioExtraBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 160)
	InventarioExtraBtn.Text = "Inventário Extra"
end)

-- BOTÃO MOLA (Executa o loadstring correto da mola)
MolaBtn.MouseButton1Click:Connect(function()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/ECCSco/ECCS-V3/main/Coils"))()
	end)
	MolaBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
	MolaBtn.Text = "Mola Ativada!"
	task.wait(1.5)
	MolaBtn.BackgroundColor3 = Color3.fromRGB(160, 100, 40)
	MolaBtn.Text = "Mola"
end)

-- ESP COMPLETO
EspBoxBtn.MouseButton1Click:Connect(function()
	espBoxAtivo = not espBoxAtivo
	EspBoxBtn.BackgroundColor3 = espBoxAtivo and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(50, 50, 120)
	EspBoxBtn.Text = espBoxAtivo and "ESP Box: ON" or "ESP Box: OFF"
end)

EspNameBtn.MouseButton1Click:Connect(function()
	espNameAtivo = not espNameAtivo
	EspNameBtn.BackgroundColor3 = espNameAtivo and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(50, 50, 120)
	EspNameBtn.Text = espNameAtivo and "ESP Names: ON" or "ESP Names: OFF"
end)

EspHealthBtn.MouseButton1Click:Connect(function()
	espHealthAtivo = not espHealthAtivo
	EspHealthBtn.BackgroundColor3 = espHealthAtivo and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(50, 50, 120)
	EspHealthBtn.Text = espHealthAtivo and "Mostrar Vida: ON" or "Mostrar Vida: OFF"
end)

EspTracersBtn.MouseButton1Click:Connect(function()
	espTracersAtivo = not espTracersAtivo
	EspTracersBtn.BackgroundColor3 = espTracersAtivo and Color3.fromRGB(40, 180, 40) or Color3.fromRGB(50, 50, 120)
	EspTracersBtn.Text = espTracersAtivo and "ESP Tracers: ON" or "ESP Tracers: OFF"
end)

RunService.RenderStepped:Connect(function()
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
			local char = p.Character
			local hrp = char.HumanoidRootPart
			local hum = char.Humanoid
			
			if espBoxAtivo then
				if not char:FindFirstChild("MimiEspBox") then
					local h = Instance.new("Highlight")
					h.Name = "MimiEspBox"
					h.FillColor = Color3.fromRGB(255, 0, 0)
					h.FillTransparency = 0.7
					h.OutlineColor = Color3.fromRGB(255, 255, 255)
					h.Parent = char
				end
			else
				if char:FindFirstChild("MimiEspBox") then char.MimiEspBox:Destroy() end
			end
			
			if espNameAtivo then
				if not char:FindFirstChild("MimiEspName") then
					local bg = Instance.new("BillboardGui")
					bg.Name = "MimiEspName"
					bg.Size = UDim2.new(0, 100, 0, 40)
					bg.StudsOffset = Vector3.new(0, 3, 0)
					bg.AlwaysOnTop = true
					bg.Parent = char
					
					local txt = Instance.new("TextLabel")
					txt.Parent = bg
					txt.BackgroundTransparency = 1
					txt.Size = UDim2.new(1, 0, 1, 0)
					txt.Font = Enum.Font.SourceSansBold
					txt.Text = p.Name
					txt.TextColor3 = Color3.fromRGB(255, 255, 255)
					txt.TextSize = 14
					txt.TextStrokeTransparency = 0
				end
			else
				if char:FindFirstChild("MimiEspName") then char.MimiEspName:Destroy() end
			end
			
			if espHealthAtivo then
				local vidaTag = char:FindFirstChild("MimiEspHealth")
				if not vidaTag then
					vidaTag = Instance.new("BillboardGui")
					vidaTag.Name = "MimiEspHealth"
					vidaTag.Size = UDim2.new(0, 120, 0, 30)
					vidaTag.StudsOffset = Vector3.new(0, 4.2, 0)
					vidaTag.AlwaysOnTop = true
					vidaTag.Parent = char
					
					local txtHp = Instance.new("TextLabel")
					txtHp.Name = "TextoVida"
					txtHp.Parent = vidaTag
					txtHp.BackgroundTransparency = 1
					txtHp.Size = UDim2.new(1, 0, 1, 0)
					txtHp.Font = Enum.Font.SourceSansBold
					txtHp.TextColor3 = Color3.fromRGB(0, 255, 100)
					txtHp.TextSize = 13
					txtHp.TextStrokeTransparency = 0
				end
				local labelHp = vidaTag:FindFirstChild("TextoVida")
				if labelHp then
					labelHp.Text = "HP: " .. math.floor(hum.Health) .. " / " .. math.floor(hum.MaxHealth)
				end
			else
				if char:FindFirstChild("MimiEspHealth") then char.MimiEspHealth:Destroy() end
			end
		end
	end
end)

-- GERENCIADOR DE SALVAMENTOS (COM PERSISTÊNCIA EM ARQUIVO)
local function atualizarListaSalvamentos()
	for _, child in pairs(ContainerSalvamentos:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end
	
	local alturaTotal = 0
	local arquivos = listarArquivos()
	
	for _, nomeCfg in ipairs(arquivos) do
		if nomeCfg ~= "MimiGlobalSettings" then
			alturaTotal = alturaTotal + 42
			
			local itemFrame = Instance.new("Frame")
			itemFrame.Name = nomeCfg
			itemFrame.Parent = ContainerSalvamentos
			itemFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			itemFrame.Size = UDim2.new(1, 0, 0, 38)
			local ic = Instance.new("UICorner")
			ic.CornerRadius = UDim.new(0, 6)
			ic.Parent = itemFrame
			
			local labelNome = Instance.new("TextLabel")
			labelNome.Parent = itemFrame
			labelNome.BackgroundTransparency = 1
			labelNome.Position = UDim2.new(0.04, 0, 0, 0)
			labelNome.Size = UDim2.new(0.45, 0, 1, 0)
			labelNome.Font = Enum.Font.SourceSansBold
			labelNome.Text = nomeCfg
			labelNome.TextColor3 = Color3.fromRGB(220, 220, 220)
			labelNome.TextSize = 13
			labelNome.TextXAlignment = Enum.TextXAlignment.Left
			
			local btnCarregar = Instance.new("TextButton")
			btnCarregar.Parent = itemFrame
			btnCarregar.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
			btnCarregar.Position = UDim2.new(0.52, 0, 0.15, 0)
			btnCarregar.Size = UDim2.new(0, 52, 0, 26)
			btnCarregar.Font = Enum.Font.SourceSansBold
			btnCarregar.Text = "Carregar"
			btnCarregar.TextColor3 = Color3.fromRGB(255, 255, 255)
			btnCarregar.TextSize = 11
			local bc = Instance.new("UICorner")
			bc.CornerRadius = UDim.new(0, 4)
			bc.Parent = btnCarregar
			
			local btnExcluir = Instance.new("TextButton")
			btnExcluir.Parent = itemFrame
			btnExcluir.BackgroundColor3 = Color3.fromRGB(160, 40, 40)
			btnExcluir.Position = UDim2.new(0.79, 0, 0.15, 0)
			btnExcluir.Size = UDim2.new(0, 42, 0, 26)
			btnExcluir.Font = Enum.Font.SourceSansBold
			btnExcluir.Text = "Excluir"
			btnExcluir.TextColor3 = Color3.fromRGB(255, 255, 255)
			btnExcluir.TextSize = 11
			local ec = Instance.new("UICorner")
			ec.CornerRadius = UDim.new(0, 4)
			ec.Parent = btnExcluir
			
			btnCarregar.MouseButton1Click:Connect(function()
				local dados = lerArquivo(nomeCfg)
				if dados then
					SpeedInput.Text = dados.speed or ""
					JumpInput.Text = dados.jump or ""
					if inicioRapidoAtivo then
						salvarArquivo("MimiGlobalSettings", {inicioRapido = true, ultimaConfig = nomeCfg})
					end
				end
				btnCarregar.Text = "OK!"
				task.wait(1)
				btnCarregar.Text = "Carregar"
			end)
			
			btnExcluir.MouseButton1Click:Connect(function()
				if delfile and isfile("MimiHacksData/" .. nomeCfg .. ".json") then
					delfile("MimiHacksData/" .. nomeCfg .. ".json")
				end
				atualizarListaSalvamentos()
			end)
		end
	end
	ContainerSalvamentos.Size = UDim2.new(0.9, 0, 0, alturaTotal)
	ScrollOutros.CanvasSize = UDim2.new(0, 0, 0, 200 + alturaTotal)
end

SalvarConfigBtn.MouseButton1Click:Connect(function()
	local nomeConfig = ConfigInput.Text
	if nomeConfig ~= "" then
		local dados = {
			speed = SpeedInput.Text,
			jump = JumpInput.Text
		}
		salvarArquivo(nomeConfig, dados)
		if inicioRapidoAtivo then
			salvarArquivo("MimiGlobalSettings", {inicioRapido = true, ultimaConfig = nomeConfig})
		end
		SalvarConfigBtn.Text = "Salvo com Sucesso!"
		atualizarListaSalvamentos()
		task.wait(1.5)
		SalvarConfigBtn.Text = "Salvar Configurações"
	end
end)

-- BOTÃO DE INÍCIO RÁPIDO
InicioRapidoBtn.MouseButton1Click:Connect(function()
	inicioRapidoAtivo = not inicioRapidoAtivo
	if inicioRapidoAtivo then
		InicioRapidoBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
		InicioRapidoBtn.Text = "Início Rápido: ON"
		local nomeCfg = ConfigInput.Text
		if nomeCfg == "" then nomeCfg = listarArquivos()[1] or "config1" end
		salvarArquivo("MimiGlobalSettings", {inicioRapido = true, ultimaConfig = nomeCfg})
	else
		InicioRapidoBtn.BackgroundColor3 = Color3.fromRGB(120, 120, 40)
		InicioRapidoBtn.Text = "Início Rápido: OFF"
		salvarArquivo("MimiGlobalSettings", {inicioRapido = false, ultimaConfig = nil})
	end
end)

atualizarListaSalvamentos()

-- SISTEMA DE CORES (RGB)
CorRgbBtn.MouseButton1Click:Connect(function()
	rgbAtivo = not rgbAtivo
	if rgbAtivo then
		CorRgbBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		CorRgbBtn.Text = "Modo Cor: RGB ATIVO"
		loopRgb = task.spawn(function()
			while rgbAtivo do
				for i = 0, 1, 0.005 do
					if not rgbAtivo then break end
					local cor = Color3.fromHSV(i, 1, 1)
					MainFrame.BackgroundColor3 = cor
					TopBar.BackgroundColor3 = Color3.fromRGB(cor.R*100, cor.G*100, cor.B*100)
					task.wait(0.05)
				end
			end
		end)
	else
		if loopRgb then task.cancel(loopRgb) end
		MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
		CorRgbBtn.BackgroundColor3 = Color3.fromRGB(140, 40, 140)
		CorRgbBtn.Text = "Modo Cor: Sólido (Mudar)"
	end
end)

-- RESPAWN
LocalPlayer.CharacterAdded:Connect(function(character)
	task.wait(0.6)
	if shiftLockAtivo and not PlayerGui:FindFirstChild("MimiShiftLockGui") then
		shiftLockGui.Parent = PlayerGui
		shiftLockGui.Enabled = true
	end
end)
