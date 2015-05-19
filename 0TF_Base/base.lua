-------------------------------------------
-- Author: crazy
-- QQ: 27595954
-------------------------------------------


-------------------------------------------
-- �������
-------------------------------------------
CUIBASE_NAME_INDEX = 0

CUIBase = classV2()
function CUIBase:ctor(parent)
	self.name = "CUIBASE_" .. CUIBASE_NAME_INDEX
	CUIBASE_NAME_INDEX = CUIBASE_NAME_INDEX + 1
end

-- �����������
function CUIBase:GetName()
	return self.name
end

-- �����������
function CUIBase:SetName(name)
	self.name = name
end

-- ��������ײ�����
function CUIBase:SetContainer(container)
	self.container = container
end

-- ��������
function CUIBase:GetContainer()
	return self.container
end

-- ��ʾ����
function CUIBase:Show()
	self.container:Show()
end

-- ��������
function CUIBase:Hide()
	self.container:Hide()
end

-- ���ؾ���λ��
function CUIBase:GetAbsPos()
	return self.container:GetAbsPos()
end

-- ���þ���λ��
function CUIBase:SetAbsPos(...)
	self.container:SetAbsPos(...)
end

-- �������λ��
function CUIBase:SetRelPos(...)
	self.container:SetRelPos(...)
end

-- �������λ��
function CUIBase:GetRelPos()
	return self.container:GetRelPos()
end

-- �����������
function CUIBase:SetSize(...)
	self.container:SetSize(...)
end

-- ��ȡ�������
function CUIBase:GetSize()
	return self.container:GetSize()
end

-- �����������
function CUIBase:SetParent(parent)
	assert(parent ~= nil, "parent can not be nil")
	local container = parent:GetContainer()
	local widget = self.container
	widget:ChangeRelation(container, true, true)
	Wnd.CloseWindow(self:GetName())
	self.parent = container
end

-- ����������
function CUIBase:GetParent()
	return self.parent
end


-- ����������λ��
function CUIBase:SetPoint(anchor, x, y)
	local width, height = self.parent:GetSize()
	local pos = {
		["TOPLEFT"] = { x, y },
		["TOP"] = { width / 2, y },
		["TOPRIGHT"] = { width - x, y},
		["LEFT"] = { x, height / 2 },
		["CENTER"] = { width / 2, height / 2 },
		["RIGHT"] = { x, height - y },
		["BOTTOMLEFT"] = { x, height - y },
		["BOTTOM"] = { width / 2, height - y },
		["BOTTOMRIGHT"] = { width - x, height - y },
	}
	self.container:SetRelPos(unpack(pos[anchor]))
end

-- �ͷ��¼�
function CUIBase:FireEvent(event, ...)
	if self[event] then
		self[event](...)
	end
end

-------------------------------------------
-- ����WndFrame
-------------------------------------------
CUIFrame = classV2(CUIBase)
function CUIFrame:ctor(width, height, text)
	self:Create(width, height)
	self:SetText(text)
end

function CUIFrame:Create(width, height)
	--local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndFrame.ini", self:GetName())
	--self:SetName("TFZYCJJ")
	--Output(self:GetName())
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndFrame.ini","TFZYCJJ")
	local handle = frame:Lookup("", "")
	local text = handle:Lookup("Text_Title")
	local button = frame:Lookup("Btn_Close")

	self.frame = frame
	self.handle = handle
	self.text = text
	self.button = button

	self:SetContainer(frame)
	self:SetSize(width, height)

	self.button.OnLButtonClick = function()
		self:FireEvent("OnClick")
	end
	frame:SetPoint("CENTER", 0, 0, "CENTER", 0, 0)
end

-- ���ؿ������
function CUIFrame:SetSize(width, height)
	if width < 480 then width = 480 end
	if width < 300 then width = 300 end

	self.frame:SetSize(width, height)
	self.frame:SetDragArea(0, 0, width, 50)

	if width < 772 then
		self.handle:RemoveItem(self.handle:Lookup("Image_BgTCL"))
		self.handle:RemoveItem(self.handle:Lookup("Image_BgTCR"))
		self.handle:Lookup("Image_BgTL2"):SetSize((width - 213 * 2) / 2, 70)
		self.handle:Lookup("Image_BgTR2"):SetSize((width - 213 * 2) / 2, 70)
	else
		self.handle:Lookup("Image_BgTL2"):SetSize((width - 169 * 2 - 213 * 2) / 2, 70)
		self.handle:Lookup("Image_BgTR2"):SetSize((width - 169 * 2 - 213 * 2) / 2, 70)
	end

	self.handle:Lookup("Image_BgML"):SetSize(8, height - (width * 70 / 2 / 385) - 85)
	self.handle:Lookup("Image_BgMC"):SetSize(width - 7 - 8, height - (width * 70 / 2 / 385) - 85)
	self.handle:Lookup("Image_BgMR"):SetSize(8, height - (width * 70 / 2 / 385) - 85)
	self.handle:Lookup("Image_BgBC"):SetSize(width - 123 - 8, 85)

	self.text:SetRelPos((width - 200) / 2, 10)
	self.button:SetRelPos(width - 35, 15)

	self.handle:FormatAllItemPos()
end

function CUIFrame:SetText(text)
	self.text:SetText(text or "")
end

-------------------------------------------
-- ����WndFrameEmpty���մ���
-------------------------------------------
CUIFrameEmpty = classV2(CUIBase)
function CUIFrameEmpty:ctor(width, height)
	self:Create(width, height)
end

function CUIFrameEmpty:Create(width, height)
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndFrameEmpty.ini", self:GetName())

	self:SetContainer(frame)
	self:SetSize(width, height)

	frame.OnFrameCreate = function()
		self:FireEvent("OnCreate")
	end

	frame.OnFrameBreathe = function()
		self:FireEvent("OnBreathe")
	end

	frame.OnFrameRender = function()
		self:FireEvent("OnRender")
	end

	frame.OnEvent = function(event)
		self:FireEvent("OnEvent", event)
	end
end

-------------------------------------------
-- ����WndWindow���鴰��
-------------------------------------------
CUIWindow = classV2(CUIBase)
function CUIWindow:ctor(width, height)
	self:Create(width, height)
	--self:SetParent(parent)
end

function CUIWindow:Create(width, height)
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndWindow.ini", self:GetName())
	local wnd = frame:Lookup("Wnd_Main")

	self:SetContainer(wnd)
	self.wnd = wnd

	self:SetSize(width, height)
end

-- �����鴰�ڣ����鴰���ڵĿؼ���ȫ������
function CUIWindow:Destroy()
	if self.wnd then
		self.wnd:Destroy()
	end
end

-------------------------------------------
-- ����WndButton����ť
-------------------------------------------
CUIButton = classV2(CUIBase)
function CUIButton:ctor(parent, width, height, text)
	self:Create(width, height)
	self:SetParent(parent)
	self:SetText(text)
end

function CUIButton:Create(width, height)
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndButton.ini", self:GetName())
	local wnd = frame:Lookup("Wnd_Main")

	self:SetContainer(wnd)

	local button = wnd:Lookup("Btn_Main")
	local handle = button:Lookup("", "")
	local text = handle:Lookup("Text_Btn")

	self.wnd = wnd
	self.button = button
	self.handle = handle
	self.text = text

	self:SetSize(width, height)

	self.button.OnLButtonClick = function()
		self:FireEvent("OnLClick")
	end

	self.button.OnRButtonClick = function()
		self:FireEvent("OnRClick")
	end
end

-- ���ð�ť�ı�
function CUIButton:SetText(text)
	self.text:SetText(text or "")
end

-- ���ð�ť�Ƿ���Ч
function CUIButton:SetEnabled(enabled)
	if enabled then
		self.button:Enable(true)
		self.text:SetFontColor(255, 255, 255)
	else
		self.button:Enable(false)
		self.text:SetFontColor(224, 224, 224)
	end
end

-- ���ذ�ť�Ƿ���Ч
function CUIButton:IsEnabled()
	return self.button:IsEnabled()
end

-- ���ð�ť��С
function CUIButton:SetSize(width, height)
	self.wnd:SetSize(width, height)
	self.button:SetSize(width, 26)
	self.handle:SetSize(width, 26)
	self.text:SetSize(width, 26)
end

-------------------------------------------
-- ����WndNewButton���Զ��尴ť
-------------------------------------------
CUIButtonEx = classV2(CUIBase)
function CUIButtonEx:ctor(parent, width, height, text)
	self:Create(width, height)
	self:SetParent(parent)
	self:SetText(text)
end

function CUIButtonEx:Create(width, height)
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndButtonEx.ini", self:GetName())
	local wnd = frame:Lookup("Wnd_Main")

	self:SetContainer(wnd)

	local button = wnd:Lookup("Btn_Main")
	local handle = button:Lookup("", "")
	local image = handle:Lookup("Image_Btn")
	local text = handle:Lookup("Text_Btn")

	self.wnd = wnd
	self.button = button
	self.handle = handle
	self.image = image
	self.text = text

	self:SetSize(width, height)

	self.button.OnLButtonDown = function()
		if self:IsEnabled() and (self.style == "NORMAL" or self.style == "ICON") then
			self:UpdateDown()
		end
	end

	self.button.OnLButtonUp = function()
		if self:IsEnabled() and (self.style == "NORMAL" or self.style == "ICON") then
			self:UpdateOver()
		end
	end

	self.button.OnRButtonDown = function()
		if self:IsEnabled() and (self.style == "NORMAL" or self.style == "ICON") then
			self:UpdateDown()
		end
	end

	self.button.OnRButtonUp = function()
		if self:IsEnabled() and (self.style == "NORMAL" or self.style == "ICON") then
			self:UpdateOver()
		end
	end

	self.button.OnMouseEnter = function()
		if self:IsEnabled() and (self.style == "NORMAL" or self.style == "ICON") then
			self:UpdateOver()
		end
		self:FireEvent("OnEnter")
	end

	self.button.OnMouseLeave = function()
		if self:IsEnabled() and (self.style == "NORMAL" or self.style == "ICON") then
			self:UpdateNormal()
		end
		self:FireEvent("OnLeave")
	end

	self.button.OnLButtonClick = function()
		self:FireEvent("OnLClick")
	end

	self.button.OnRButtonClick = function()
		self:FireEvent("OnRClick")
	end
end

function CUIButtonEx:SetStyle(style)
	if style == "NORMAL" then			-- ������ť
		self.image:Show()
		self.text:Show()
	elseif style == "TEXT" then			-- ���ְ�ť
		self.image:Hide()
		self.text:Show()
	elseif style == "ICON" then			-- ͼ�갴ť
		self.image:Show()
		self.text:Hide()
	elseif style == "NONE" then			-- �鰴ť
		self.image:Hide()
		self.text:Hide()
	end
	self.style = style
end

function CUIButtonEx:SetNormal(image, frame)
	self.normal = { image, frame }
	self:UpdateNormal()
end

function CUIButtonEx:SetOver(image, frame)
	self.over = { image, frame }
end

function CUIButtonEx:SetDown(image, frame)
	self.down = { image, frame }
end

function CUIButtonEx:SetDisable(image, frame)
	self.disable = { image, frame }
end

function CUIButtonEx:UpdateNormal()
	if self.normal then
		if type(self.normal[1]) == "string" then
			if self.normal[2] then
				self.image:FromUITex(self.normal[1], self.normal[2])
			else
				self.image:FromTextureFile(self.normal[1])
			end
		elseif type(self.normal[1]) == "number" then
			self.image:FromIconID(self.normal[1])
		end
	end
end

function CUIButtonEx:UpdateOver()
	if self.over then
		if type(self.over[1]) == "string" then
			if self.over[2] then
				self.image:FromUITex(self.over[1], self.over[2])
			else
				self.image:FromTextureFile(self.over[1])
			end
		elseif type(self.over[1] == "number") then
			self.image:FromIconID(self.over[1])
		end
	end
end

function CUIButtonEx:UpdateDown()
	if self.down then
		if type(self.down[1]) == "string" then
			if self.down[2] then
				self.image:FromUITex(self.down[1], self.down[2])
			else
				self.image:FromTextureFile(self.down[1])
			end
		elseif type(self.down[1] == "number") then
			self.image:FromIconID(self.down[1])
		end
	end
end

function CUIButtonEx:UpdateDisable()
	if self.disable then
		if type(self.disable[1]) == "string" then
			if self.disable[2] then
				self.image:FromUITex(self.disable[1], self.disable[2])
			else
				self.image:FromTextureFile(self.disable[1])
			end
		elseif type(self.disable[1]) == "number" then
			self.image:FromIconID(self.disable[1])
		end
	end
end

function CUIButtonEx:SetEnabled(enabled)
	if enabled then
		self.button:Enable(true)
		self.text:SetFontColor(255, 255, 255)
		if self.style == "NORMAL" or self.style == "TEXT" or self.style == "ICON" then
			self:UpdateNormal()
		end
	else
		self.button:Enable(false)
		self.text:SetFontColor(224, 224, 224)
		if self.style == "NORMAL" or self.style == "TEXT" or self.style == "ICON" then
			self:UpdateDisable()
		end
	end
end

function CUIButtonEx:IsEnabled()
	return self.button:IsEnabled()
end

function CUIButtonEx:SetText(text)
	self.text:SetText(text or "")
end

function CUIButtonEx:SetTextVAlign(align)
	if align == "TOP" then
		self.text:SetVAlign(0)
	elseif align == "CENTER" then
		self.text:SetVAlign(1)
	elseif align == "BOTTOM" then
		self.text:SetVAlign(2)
	end
end

function CUIButtonEx:SetTextHAlign(align)
	if align == "LEFT" then
		self.text:SetHAlign(0)
	elseif align == "CENTER" then
		self.text:SetHAlign(1)
	elseif align == "RIGHT" then
		self.text:SetHAlign(2)
	end
end

function CUIButtonEx:SetSize(width, height)
	self.wnd:SetSize(width, height)
	self.handle:SetSize(width, height)
	self.button:SetSize(width, height)
	self.image:SetSize(width, height)
	self.text:SetSize(width, height)
end

-------------------------------------------
-- ����WndCheckBox����ѡ��
-------------------------------------------
CUICheckBox = classV2(CUIBase)
function CUICheckBox:ctor(parent, width, height, text)
	self:Create(width, height)
	self:SetParent(parent)
	self:SetText(text)
end

function CUICheckBox:Create(width, height)
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndCheckBox.ini", self:GetName())
	local wnd = frame:Lookup("Wnd_Main")

	self:SetContainer(wnd)

	local checkbox = wnd:Lookup("CheckBox_Main")
	local handle = checkbox:Lookup("", "")
	local text = handle:Lookup("Text_CheckBox")

	self.wnd = wnd
	self.checkbox = checkbox
	self.handle = handle
	self.text = text

	self:SetSize(width, height)

	self.checkbox.OnCheckBoxCheck = function()
		self:FireEvent("OnCheck", true)
	end

	self.checkbox.OnCheckBoxUncheck = function()
		self:FireEvent("OnCheck", false)
	end
end

-- ���ø�ѡ���Ƿ�ѡ
function CUICheckBox:SetChecked(checked)
	self.checkbox:Check(checked)
end

-- ���ø�ѡ���Ƿ���Ч
function CUICheckBox:SetEnabled(enabled)
	if enabled then
		self.checkbox:Enable(true)
		self.text:SetFontColor(255, 255, 255)
	else
		self.checkbox:Enable(false)
		self.text:SetFontColor(192, 192, 192)
	end
end

-- ���ظ�ѡ���Ƿ񱻹�ѡ
function CUICheckBox:IsChecked()
	return self.checkbox:IsCheckBoxChecked()
end

-- ���ظ�ѡ���Ƿ���Ч
function CUICheckBox:IsEnabled()
	return self.checkbox:IsCheckBoxActive()
end

-- ���ø�ѡ���ı�
function CUICheckBox:SetText(text)
	self.text:SetText(text)
end

-- ���ø�ѡ���С
function CUICheckBox:SetSize(width, height)
	self.wnd:SetSize(width, height)
	self.checkbox:SetSize(25, 25)
	self.handle:SetSize(width, 25)
	self.text:SetSize(width - 28, 25)
end


-------------------------------------------
-- ����WndRadioBox����ѡ��
-------------------------------------------
local CUIRadioBoxGroups = {}

CUIRadioBox = classV2(CUIBase)
function CUIRadioBox:ctor(parent, width, height, text, group)
	self:Create(width, height)
	self:SetParent(parent)
	self:SetText(text)
	self:SetGroup(group)
end

function CUIRadioBox:Create(width, height)
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndRadioBox.ini", self:GetName())
	local wnd = frame:Lookup("Wnd_Main")

	self:SetContainer(wnd)

	local radiobox = wnd:Lookup("RadioBox_Main")
	local handle = radiobox:Lookup("", "")
	local text = handle:Lookup("Text_RadioBox")

	self.wnd = wnd
	self.radiobox = radiobox
	self.handle = handle
	self.text = text

	self:SetSize(width, height)

	self.radiobox.OnCheckBoxCheck = function()
		if self.group then
			for k, v in pairs(CUIRadioBoxGroups[self.group]) do
				if v ~= self then
					v:SetChecked(false)
				end
			end
			self:FireEvent("OnCheck", self:IsChecked())
		end
	end

	self.radiobox.OnCheckBoxUncheck = function()
		self:FireEvent("OnCheck", false)
	end
end

-- ���õ�ѡ���Ƿ�ѡ��
function CUIRadioBox:SetChecked(checked)
	self.radiobox:Check(checked)
end

-- ���õ�ѡ���Ƿ���Ч
function CUIRadioBox:SetEnabled(enabled)
	self.radiobox:Enable(enabled)
end

-- ���ص�ѡ���Ƿ�ѡ��
function CUIRadioBox:IsChecked()
	return self.radiobox:IsCheckBoxChecked()
end

-- ���ص�ѡ���Ƿ���Ч
function CUIRadioBox:IsEnabled()
	return self.radiobox:IsCheckBoxActive()
end

-- ���õ�ѡ���ı�
function CUIRadioBox:SetText(text)
	self.text:SetText(text)
end

-- ���õ�ѡ�����
function CUIRadioBox:SetGroup(group)
	if self.group then
		for k, v in pairs(CUIRadioBoxGroups[self.group]) do
			if v == self then
				table.remove(CUIRadioBoxGroups[self.group], k)
			end
		end
	end
	if group then
		if not CUIRadioBoxGroups[group] then
			CUIRadioBoxGroups[group] = {}
		end
		table.insert(CUIRadioBoxGroups[group], self)
	end
	self.group = group
end

-- ���ص�ѡ�����
function CUIRadioBox:GetGroup()
	return CUIRadioBoxGroups[self.group]
end

-- ���õ�ѡ���С
function CUIRadioBox:SetSize(width, height)
	self.wnd:SetSize(width, height)
	self.radiobox:SetSize(25, 25)
	self.handle:SetSize(width, 25)
	self.text:SetSize(width - 28, 25)
end

-------------------------------------------
-- ����WndComboBox��������
-------------------------------------------
CUIComboBox = classV2(CUIBase)
function CUIComboBox:ctor(parent, width, height, text)
	self:Create(width, height)
	self:SetParent(parent)
	self:SetText(text)
end

function CUIComboBox:Create(width, height)
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndComboBox.ini", self:GetName())
	local wnd = frame:Lookup("Wnd_Main")

	self:SetContainer(wnd)

	local button = wnd:Lookup("Btn_ComboBox")
	local handle = wnd:Lookup("", "")
	local image = handle:Lookup("Image_ComboBoxBg")
	local text = handle:Lookup("Text_ComboBox")

	self.wnd = wnd
	self.button = button
	self.handle = handle
	self.image = image
	self.text = text

	self:SetSize(width, height)

	self.button.OnLButtonClick = function()
		self:FireEvent("OnLClick")
	end

	self.button.OnRButtonClick = function()
		self:FireEvent("OnRClick")
	end
end

function CUIComboBox:GetAbsPos()
	return self.text:GetAbsPos()
end

function CUIComboBox:GetSize()
	return self.text:GetSize()
end

-- �����������ı�
function CUIComboBox:SetText(text)
	self.text:SetText(text)
end

-- �����������С
function CUIComboBox:SetSize(width,height)
	self.wnd:SetSize(width, height)
	self.image:SetSize(width - 2, 25)
	self.handle:SetSize(width, 25)
	self.text:SetSize(width - 20, 25)

	self.button:SetRelPos(width - 25, 4)
end

-------------------------------------------
-- ����WndColorBox����ɫѡ���
-------------------------------------------
CUIColorBox = classV2(CUIBase)
function CUIColorBox:ctor(parent, width, height, text)
	self:Create(width, height)
	self:SetParent(parent)
	self:SetText(text)
end

function CUIColorBox:Create(width, height)
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndColorBox.ini", self:GetName())
	local wnd = frame:Lookup("Wnd_Main")

	self:SetContainer(wnd)

	local handle = wnd:Lookup("", "")
	local text = handle:Lookup("Text_Color")
	local color = handle:Lookup("Shadow_Color")

	self.wnd = wnd
	self.handle = handle
	self.text = text
	self.color = color

	self:SetSize(width, height)

	self.color.OnItemLButtonClick = function()
		local fnChangeColor = function(arg0, arg1, arg2)
			self:SetColor(arg0, arg1, arg2)
			r, g, b = arg0, arg1, arg2
			self:FireEvent("OnChanged", {arg0, arg1, arg2})
		end
		OpenColorTablePanel(fnChangeColor)
	end
end

-- ������ɫѡ����ı�
function CUIColorBox:SetText(text)
	self.text:SetText(text)
end

-- ������ɫѡ������ɫ
function CUIColorBox:SetColor(r, g, b)
	self.color:SetColorRGB(r, g, b)
	self.text:SetFontColor(r, g, b)
end

-- ������ɫѡ������ɫ
function CUIColorBox:GetColor()
	return self.color:GetColorRGB()
end

-- ������ɫѡ����С
function CUIColorBox:SetSize(width, height)
	self.wnd:SetSize(width, height)
	self.color:SetSize(18, 18)
	self.text:SetSize(width - 20, 22)
end

-------------------------------------------
-- ����WndEditBox
-------------------------------------------
CUIEditBox = classV2(CUIBase)
function CUIEditBox:ctor(parent, width, height, text)
	self:Create(width, height)
	self:SetParent(parent)
	self:SetText(text)
end

function CUIEditBox:Create(width, height)
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndEditBox.ini", self:GetName())
	local wnd = frame:Lookup("Wnd_Main")

	self:SetContainer(wnd)

	local editbox = wnd:Lookup("Edit_Main")
	local handle = wnd:Lookup("", "")
	local image = handle:Lookup("Image_EditBg")

	self.wnd = wnd
	self.editbox= editbox
	self.handle = handle
	self.image = image

	self:SetSize(width, height)

	self.editbox.OnEditChanged = function()
		local text = self:GetText()
		self:FireEvent("OnChanged", text)
	end
end

-- ���ñ༭���ı�
function CUIEditBox:SetText(text)
	self.editbox:SetText(text or "")
end

-- ���ر༭���ı�
function CUIEditBox:GetText()
	return self.editbox:GetText()
end

-- ���ñ༭����ɫ
function CUIEditBox:SetFontColor(r, g, b)
	self.editbox:SetFontColor(r, g, b)
end

-- ���ñ༭�����볤��
function CUIEditBox:SetLimit(limit)
	self.editbox:SetLimit(limit or 50)
end

-- ���ñ༭���Ƿ���б༭
function CUIEditBox:SetMultiLine(multi)
	self.editbox:SetMultiLine(multi or false)
end

-- ���ñ༭���Ƿ���Ч
function CUIEditBox:SetEnabled(enabled)
	if enabled then
		self.editbox:SetFontColor(255, 255, 255)
		self.editbox:Enable(true)
	else
		self.editbox:SetFontColor(192, 192, 192)
		self.editbox:Enable(false)
	end
end

-- ѡ��༭����ȫ���ı�
function CUIEditBox:SelectAll()
	self.editbox:SelectAll()
end

-- ���ñ༭���С
function CUIEditBox:SetSize(width, height)
	self.wnd:SetSize(width, height)
	self.editbox:SetSize(width - 6, height - 6)
	self.handle:SetSize(width, height)
	self.image:SetSize(width, height)
end

-------------------------------------------
-- ����WndTextBox
-------------------------------------------
CUITextBox = classV2(CUIBase)
function CUITextBox:ctor(parent, width, height, text)
	self:Create(width, height, text)
	self:SetParent(parent)
	self:SetText(text)
end

function CUITextBox:Create(width, height)
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndTextBox.ini", self:GetName())
	local wnd = frame:Lookup("Wnd_Main")

	self:SetContainer(wnd)

	local handle = wnd:Lookup("", "")
	local text = handle:Lookup("Text_TextBox")

	self.wnd = wnd
	self.handle = handle
	self.text = text

	self:SetSize(width, height)
end

-- �����ı����ı�
function CUITextBox:SetText(text)
	self.text:SetText(text)
end

-- �����ı����ı�
function CUITextBox:GetText()
	return self.text:GetText()
end

-- �����ı�����ɫ
function CUITextBox:SetFontColor(r, g, b)
	self.text:SetFontColor(r, g, b)
end

-- �����ı�����ɫ
function CUITextBox:GetFontColor()
	return self.text:GetFontColor()
end

-- �����ı�������
function CUITextBox:SetFontScheme(scheme)
	self.text:SetFontScheme(scheme)
end

-- �����ı�����������
function CUITextBox:GetFontScheme()
	return self.text:GetFontScheme()
end

-- �����ı������ֱ߿�
function CUITextBox:SetFontBorder(size, r, g, b)
	self.text:SetFontBorder(size, r, g, b)
end

-- �����ı������ֱ߿�
function CUITextBox:GetFontBorder()
	return self.text:GetFontBorder()
end

-- �����ı����������ŵȼ�
function CUITextBox:SetFontScale(scale)
	self.text:SetFontScale(scale)
end

-- �����ı����������ŵȼ�
function CUITextBox:GetFontScale()
	return self.text:GetFontScale()
end

-- �����Ƿ����
function CUITextBox:SetMultiLine(multi)
	self.text:SetFontScale(multi)
end

-- ����ˮƽ���뷽ʽ
function CUITextBox:SetHAlign(align)
	if align == "LEFT" then
		self.text:SetHAlign(0)
	elseif align == "RIGHT" then
		self.text:SetHAlign(2)
	elseif align == "CENTER" then
		self.text:SetHAlign(1)
	end
end

-- ���ô�ֱ���뷽ʽ
function CUITextBox:SetVAlign(align)
	if align == "TOP" then
		self.text:SetVAlign(0)
	elseif align == "BOTTOM" then
		self.text:SetVAlign(2)
	elseif align == "CENTER" then
		self.text:SetVAlign(1)
	end
end

-- �������ּ��
function CUITextBox:SetFontSpacing(spacing)
	self.text:SetFontSpacing(spacing)
end

-- ���������о�
function CUITextBox:SetRowSpacing(spacing)
	self.text:SetRowSpacing(spacing)
end

-- �����ı����С
function CUITextBox:SetSize(width, height)
	self.wnd:SetSize(width, height)
	self.text:SetSize(width, height)
end

-------------------------------------------
-- ����WndTextBox��ͼ��
-------------------------------------------
CUIImage = classV2(CUIBase)
function CUIImage:ctor(parent, width, height, image, frame, type)
	self:Create(width, height)
	self:SetParent(parent)
	self:SetImage(image, frame)
	self:SetImageType(type)
end

function CUIImage:Create(width, height)
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndImage.ini", self:GetName())
	local wnd = frame:Lookup("Wnd_Main")

	self:SetContainer(wnd)

	local handle = wnd:Lookup("", "")
	local image = handle:Lookup("Image_Main")

	self.wnd = wnd
	self.handle = handle
	self.image = image

	self:SetSize(width, height)
end

-- ����ͼ��
function CUIImage:SetImage(image, frame)
	if type(image) == "string" then
		if frame then
			self.image:FromUITex(image, frame)
		else
			self.image:FromTextureFile(image)
		end
	elseif type(image) == "number" then
		self.image:FromIconID(image)
	end
end

-- ����ͼ��֡��
function CUIImage:SetFrame(frame)
	self.image:SetFrame(frame)
end

-- ����ͼ��֡��
function CUIImage:GetFrame()
	return self.image:GetFrame()
end

-- ����ͼ��͸����
function CUIImage:SetAlpha(alpha)
	self.image:SetAlpha(alpha)
end

-- ����ͼ��͸����
function CUIImage:GetAlpha()
	return self.image:GetAlpha()
end

-- ����ͼ��ٷֱ�
function CUIImage:SetPercentage(percentage)
	self.image:SetPercentage(percentage)
end

-- ����ͼ��ٷֱ�
function CUIImage:GetPercentage()
	return self.image:GetPercentage()
end

-- ����ͼ����ת��
function CUIImage:SetRotate(angle)
	self.image:SetRotate(angle)
end

-- ����ͼ����ת��
function CUIImage:GetRotate()
	return self.image:GetRotate()
end

-- ����ͼ������
function CUIImage:SetImageType(type)
	local t = {
		["NORMAL"] = IMAGE.NORMAL,
		["LEFT_RIGHT"] = IMAGE.LEFT_RIGHT,
		["RIGHT_LEFT"] = IMAGE.RIGHT_LEFT,
		["TOP_BOTTOM"] = IMAGE.TOP_BOTTOM,
		["BOTTOM_TOP"] = IMAGE.BOTTOM_TOP,
		["TIMER"] = IMAGE.TIMER,
		["FLIP_HORIZONTAL"] = IMAGE.FLIP_HORIZONTAL,
		["FLIP_VERTICAL"] = IMAGE.FLIP_VERTICAL,
		["FLIP_CENTRAL"] = IMAGE.FLIP_CENTRAL,
		["NINE_PART"] = IMAGE.NINE_PART,
		["LEFT_CENTER_RIGHT"] = IMAGE.LEFT_CENTER_RIGHT,
		["TOP_CENTER_BOTTOM"] = IMAGE.TOP_CENTER_BOTTOM,
	}
	self.image:SetImageType(t[type] or t["NORMAL"])
end

-- ����ͼ���С
function CUIImage:SetSize(width, height)
	self.wnd:SetSize(width, height)
	self.image:SetSize(width, height)
end

-------------------------------------------
-- ����WndScrollBar��������
-------------------------------------------
CUIScrollBar = classV2(CUIBase)
function CUIScrollBar:ctor(parent, width, height)
	self:Create(width, height, unit)
	self:SetParent(parent)
end

function CUIScrollBar:Create(width, height)
	local frame = Wnd.OpenWindow("Interface\\TF\\0TF_Base\\ini\\WndScrollBar.ini", self:GetName())
	local wnd = frame:Lookup("Wnd_Main")

	self:SetContainer(wnd)

	local handle = wnd:Lookup("", "")
	local image = handle:Lookup("Image_Scroll")
	local text = handle:Lookup("Text_Scroll")
	local scroll = wnd:Lookup("Scroll_Main")
	local button = scroll:Lookup("Btn_Scroll")

	self.wnd = wnd
	self.handle = handle
	self.image = image
	self.text = text
	self.scroll = scroll
	self.button = button

	self.unit = ""

	self:SetSize(width, height)

	self.scroll.OnScrollBarPosChanged = function()
		local pos = self:GetScrollPos()
		local value = self:GetValue(pos)
		self.text:SetText(value .. self.unit)
		self:FireEvent("OnChanged", value)
	end
end

-- step����������ÿ����һ�μӶ���
function CUIScrollBar:SetArea(min, max, step)
	step = (max - min) / step
	self.min, self.max, self.step = min, max, step
	self:SetStepCount(step)
end

-- ��ȡ��ֵ
function CUIScrollBar:GetValue(step)
	return self.min + (step - 0) * (self.max - self.min) / (self.step - 0)
end

-- ��ֵ��ȡ����
function CUIScrollBar:GetStep(value)
	return 0 + (value - self.min) * (self.step - 0) / (self.max - self.min)
end

-- ����Ĭ�ϲ�ֵ
function CUIScrollBar:SetDefaultValue(default)
	if type(default) == "number" then
		local pos = self:GetStep(default)
		self:SetScrollPos(pos)
		self.text:SetText(default)
	elseif type(default) == "string" then
		local value, unit = string.match(default, "(%d+)(.+)")
		self.unit = unit
		local pos = self:GetStep(value)
		self:SetScrollPos(pos)
		self.text:SetText(value .. self.unit)
	end
end

-- ���û�����λ��
function CUIScrollBar:SetScrollPos(pos)
	self.scroll:SetScrollPos(pos)
end

-- ���ػ�����λ��
function CUIScrollBar:GetScrollPos()
	return self.scroll:GetScrollPos()
end

-- �����ܲ���
function CUIScrollBar:SetStepCount(step)
	self.scroll:SetStepCount(step)
end

-- ��ȡ�ܲ���
function CUIScrollBar:GetStepCount()
	return self.scroll:GetStepCount()
end

-- ���û�������С
function CUIScrollBar:SetSize(width, height)
	self.wnd:SetSize(width + 44, height)
	self.image:SetSize(width, 10)
	self.scroll:SetSize(width, 12)
	self.text:SetSize(40, height)
	self.text:SetRelPos(width + 4, -3)

	self.handle:FormatAllItemPos()
end
