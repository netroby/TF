YCBank={
isShowed=false,
BankMaxCount=6, --�ֿ���󱳰�����  1���̶� 5������
INVENTORY_INDEX__BANK=7, --�ֿ���ʼIDX
INVENTORY_INDEX_EQUIP=0,
EQUIPMENT_INVENTORY_BANK_PACKAGE1=18,
RBkFreeSize=0,
RBkFS={},
}

function YCBank.OnFrameCreate()
	this:RegisterEvent("UI_SCALED")
 end
function YCBank.ShowBankItems(frame)				--Alt���ţ�������ʾ Զ�ֿ̲�ͬ��
	if frame then
		local showName=nil
		local N=GetClientPlayer()
		local chk = frame:Lookup("CheckBox_Compact")
		if chk and not chk:IsCheckBoxChecked() then	chk:Check(true)	end
		local handle = frame:Lookup("", "Handle_Bag_Compact")
		if not handle then return end
		for i=0,handle:GetItemCount()-1 do
			local a = handle:Lookup(i)
			if a then
				local box = a:Lookup(1)
				if box and ( not box:IsEmpty()) then
					if box:IsObjectMouseOver() then
						local item = GetPlayerItem(N, box.dwBox, box.dwX)
						showName=item.szName
						break
					end
				end
			end
		end
		if showName then
			YCBank.doShowItems(showName)
		end
	end
end
function YCBank.OnFrameBreathe()
	if GetLogicFrameCount() % 2 == 0 then
 		local f = Station.Lookup("Normal/BigBankPanel")
 		if f and f:IsVisible() then --�����Ĳֿ���֡�����������ٵġ�����ȻҪ��ʧ��
 			Wnd.CloseWindow("YCBank")
 		end
 		if IsAltKeyDown() then												--Alt���ţ�������ʾ Զ�ֿ̲�ͬ��
 			local f = Station.Lookup("Normal/BigBagPanel")
 			if f and f:IsVisible() then
 				YCBank.ShowBankItems(f)
 			end
 		else
 			if YCBank.bShowed then					--ʲô���أ�
 				YCBank.bShowed=false
				local frame = Station.Lookup("Normal/YCBank")
				local handle = frame:Lookup("", "")
				local hBox = handle:Lookup("Handle_Box")
				local nCount = hBox:GetItemCount() - 1		--�ֿ�һ�����ٸ���
				for i = 0, nCount, 1 do
					local box = hBox:Lookup(i)
					if box then --box.szname ��updateitem ����ӵ�
						box:SetAlpha(255)
					end
				end
 			end
 		end
	end
end 
function YCBank.OnEvent(event)
	if event=="UI_SCALED" then
	end
 end

-----------------------------

function YCBank.BankIndexToInventoryIndex(nIndex)
	return YCBank.INVENTORY_INDEX__BANK + nIndex - 1
end

function YCBank.InventoryIndexToBankIndex(nIndex)
	return nIndex - YCBank.INVENTORY_INDEX__BANK + 1
end
function YCBank.GetBankSize()
	local dwSize = 0
	local player = GetClientPlayer()
	for i = 1, 6, 1 do 
		local dwSizeT = player.GetBoxSize(YCBank.BankIndexToInventoryIndex(i))--�������һ��5����װ��4�ˡ��Դ�1����SO���ֿ��Ǵӵ�6����ʼ��
		dwSize = dwSize + dwSizeT
	end
	return dwSize
end

function YCBank.UpdateBagCount(box)
		local player = GetClientPlayer()
		local dwSize = player.GetBoxSize(box.nInventoryIndex)	--�ֿ���7-12
		local dwSizeFree = player.GetBoxFreeRoomSize(box.nInventoryIndex)	--���Ҳ��Ҫ���Ųֿ���ܵõ���- -��Ԥ�Ȼ���ɡ�
		--local =YCBank.RBkFS(box.nInventoryIndex-7)	--����� table(0)Ϊ��һ��Ԫ�أ���Ҫ-7
		--Output(dwSizeFree)
		if true then--if YCBank.bCompact then  --��ʡ����ʡ����~
			if not dwSize or dwSize == 0 then
				box:SetOverText(0, "")		--�ձ�������ʾ����
			else
				box:SetOverText(0, (dwSize - dwSizeFree).."/"..dwSize)   
			end
		end
end
function YCBank.UpdateItem(box)
	local player = GetClientPlayer()
	local item = GetPlayerItem(player, box.dwBox, box.dwX)
	if item then
		UpdataItemBoxObject(box, box.dwBox, box.dwX, item)
		box.szName=item.szName --ΪBOX�����Ʒ����
	end
	if box:IsObjectMouseOver() then
		local thisSave = this
		this = box
 
	--	YCBank.OnItemMouseEnter()
		this = thisSave
	end	
end
function YCBank.UpdateBag(box)
	local player = GetClientPlayer()
	if box.nBagIndex == 1 then
		box:SetObject(UI_OBJECT_NOT_NEED_KNOWN, box.nBagIndex)
		box:SetObjectIcon(374)
	else
		local item = GetPlayerItem(player, box.dwBox, box.dwX)
		UpdataItemBoxObject(box, box.dwBox, box.dwX, item)
	end
		box:SetObjectSelected(true)--YCBank.aOpen[box.nBagIndex] ͨͨչ��~
		YCBank.UpdateBagCount(box)
end

function YCBank.UpdateTotalBagCount(frame,RBkFreeSize)		--�ڶ�������Ϊ�˸��²ֿ��freesize...
	local text = frame:Lookup("", "Text_Title")
	if true then
		local dwSize, dwFreeSize = 0, 0
		local player = GetClientPlayer()
		for i = 1, YCBank.BankMaxCount, 1 do
			local nIndex = YCBank.BankIndexToInventoryIndex(i)
			local dw1 = player.GetBoxSize(nIndex)
			if dw1 and dw1 ~= 0 then
				dwSize = dwSize + dw1			--���������ڹص��ֿ��ʱ���ȡ����
				--local dw2 = player.GetBoxFreeRoomSize(nIndex)	--ֻ�д򿪲ֿ�ʱ���ܻ�ȡ�����֣�����Ӧ�ô򿪹��ֿ�󣬴�������С�initʱ��ֱ�Ӷ�ȡ�ϴεı�����
				--dwFreeSize = dwFreeSize + dw2
			end
		end
		if dwSize == 0 then
			text:SetText("�ֿ�")
		else
			text:SetText("Զ�ֿ̲�" .. "("..(dwSize - RBkFreeSize).."/"..dwSize..")")	
		end
 	end
end

function YCBank.doShowItems(showName)		--Ҳ����Alt���� ��ͬ��ʱ���õ�
	local frame = Station.Lookup("Normal/YCBank")
	local handle = frame:Lookup("", "")
	local hBox = handle:Lookup("Handle_Box")
	local nCount = hBox:GetItemCount() - 1
	for i = 0, nCount, 1 do
		local box = hBox:Lookup(i)
		if box then --box.szname ��updateitem ����ӵ�
			if box.szName and box.szName==showName then
				box:SetAlpha(255)
				YCBank.bShowed=true
			else
				box:SetAlpha(30)
			end
		end
	end
end

   
--���������YCBag.lua�У�һ����ť���ͻ���á�
function YCBank.InitBank(frame)
	frame.bDisable = true
	
	local player = GetClientPlayer()
	local aOpen = {true, true, true, true, true, true}
	
	local wB, wS = 42, 1 --���ӱ�����ȣ����Ӹ���������������
	local nW = 10	--һ��ӵ�еĸ�������
	local nSize = YCBank.GetBankSize()
	local nLine = math.ceil(nSize / nW)
	if nLine > 12 then
		nW = math.ceil(nSize / 12)
	end
		
	local wBox = wB - 2 * wS --���ӿ��
	local wAll = wB * nW
	if wAll < 313 then
		wAll = 313
	end
	
	local wBB = 42
	local nBagCount = player.GetBankPackageCount()
	local btnBuy = frame:Lookup("Btn_Buy")
	if nBagCount >=YCBank.BankMaxCount -1 then --ȥ���Դ����Ǹ�
		btnBuy:Hide()
	else
		btnBuy:Show()
		btnBuy:SetSize(wBB, wBB)
		btnBuy:SetRelPos(13 + (nBagCount + 1) * wBB, 58)
	end
	local handle = frame:Lookup("", "")
	for i =1, YCBank.BankMaxCount, 1 do
		local img = handle:Lookup("Image_BagBox"..i)
		local box = handle:Lookup("Box_Bag"..i)
		
		local x = 13 + (i - 1) * wBB
		local y = 58
		img:SetSize(wBB + 2, wBB + 2)
		img:SetRelPos(x, y)
		box:SetSize(wBB - 2 * wS, wBB - 2 * wS)
		box:SetRelPos(x + wS, y + wS)
		
		box:SetOverTextPosition(0, ITEM_POSITION.RIGHT_BOTTOM)
		box:SetOverTextFontScheme(0, 15)
		box.bBag = true
		box.nBagIndex = i
		box.nInventoryIndex = YCBank.BankIndexToInventoryIndex(i)
		if i ~= 1 then
			box.dwBox = YCBank.INVENTORY_INDEX_EQUIP
			box.dwX = YCBank.EQUIPMENT_INVENTORY_BANK_PACKAGE1 + i - 2
			if i <= nBagCount + 1 then
				box:Show()
				img:Show()
			else
				box:Hide()
				img:Hide()
			end
		end
		YCBank.UpdateBag(box)
	end
	
	local hBg = handle:Lookup("Handle_BG")
	local hBox = handle:Lookup("Handle_Box")
	local bAdd = false
	local nIndex = 0
	local x, y = 16, 66 + wBB
	for i = 1, YCBank.BankMaxCount, 1 do
		local dwBox = YCBank.BankIndexToInventoryIndex(i)
		local dwSize = player.GetBoxSize(dwBox)
		
		local img = handle:Lookup("Image_Bg"..i)
		local imgB = handle:Lookup("Image_BgB"..i)
		local textB = handle:Lookup("Text_Bag"..i)
		local check = frame:Lookup("CheckBox_C"..i)
		img:SetSize(0,0)
		img:SetRelPos(0,0)
		img:Hide()
		imgB:SetSize(0,0)
		imgB:SetRelPos(0,0)
		imgB:Hide()
		textB:SetSize(0,0)
		textB:SetRelPos(0,0)
		textB:Hide()
		check:Hide()
		
		
		local aFrame = {29, 28, 13, 27}
		local nBT =0--- GetBagContainType(dwBox) ����¡����������ɡ�
		local nFrame = aFrame[nBT] or 13
		dwSize = dwSize - 1
		for dwX = 0, dwSize, 1 do
			local img = hBg:Lookup(nIndex)
			if not img then			-- AppendItemFromString ��ӿؼ������ַ����ж�ȡ
				hBg:AppendItemFromString("<image>w=48 h=48 path=\"ui/Image/LootPanel/LootPanel.UITex\" frame=13 lockshowhide=1 </image>")
				img = hBg:Lookup(nIndex)
			end
			local box = hBox:Lookup(nIndex)
			if not box then
				hBox:AppendItemFromString("<box>w=44 h=44 eventid=524607 lockshowhide=1 </box>")
				box = hBox:Lookup(nIndex)
			end
			img:SetFrame(nFrame)
			img:Show()
			box:Show()
			box:SetName(dwBox.."_"..dwX)
			img:SetSize(wB, wB)
			img:SetRelPos(x, y)
			box:SetSize(wBox, wBox)
			box:SetRelPos(x + wS - 1, y + wS - 1)

			box:SetOverTextPosition(0, ITEM_POSITION.RIGHT_BOTTOM)
			box:SetOverTextFontScheme(0, 15)
			box.dwBox = dwBox
			box.dwX = dwX
			
			YCBank.UpdateItem(box)
			
			if nIndex % nW == nW - 1 then
				x, y = 16, y + wB + 2
				bAdd = false
			else
				x = x + wB
				bAdd = true
			end
			
			nIndex = nIndex + 1
		end
	end
	
	if bAdd then
		x, y = 16, y + wB + 2
	end	
		
	hBox.nCount = nIndex
	local nCount = hBox:GetItemCount() - 1
	for i = nIndex, nCount, 1 do
		local img = hBg:Lookup(i)
		local box = hBox:Lookup(i)
		img:Hide()
		img:SetRelPos(0, 0)
		img:SetSize(0, 0)
		box:Hide()
		box:SetRelPos(0, 0)
		box:SetSize(0, 0)
	end
	hBg:FormatAllItemPos()
	hBg:SetSizeByAllItemSize()
	hBox:FormatAllItemPos()
	hBox:SetSizeByAllItemSize()
	
	--frame:Lookup("Btn_CU"):SetRelPos(wAll / 2-120,8)
	frame:Lookup("Btn_CU"):SetRelPos(15, y + 8)	--���ƶ����������ĵط�
	frame:Lookup("Btn_CU"):SetAlpha(0)  --"����"û�ã��ص�
	frame:Lookup("Btn_Close"):SetRelPos(wAll - 10, 8)
	
	--handleû����ɣ������޷���ʾ ����ͭ��������������
	local xM, yM = wAll - 150, y + 10
	handle:Lookup("Image_Gold"):SetRelPos(xM + 66, yM)		--���߱���Ҳ������
	handle:Lookup("Image_Silver"):SetRelPos(xM + 106, yM)
	handle:Lookup("Image_Copper"):SetRelPos(xM + 144, yM)
	handle:Lookup("Text_Gold"):SetRelPos(xM, yM)
	handle:Lookup("Text_Silver"):SetRelPos(xM + 86, yM)
	handle:Lookup("Text_Copper"):SetRelPos(xM + 124, yM)
	
	handle:Lookup("Text_Title"):SetRelPos(wAll / 2 - 20, 6)
	
	handle:Lookup("Image_Bg1C"):SetSize(wAll - 311, 52)
	handle:Lookup("Image_Bg2L"):SetSize(8, y - 88)
	handle:Lookup("Image_Bg2C"):SetSize(wAll + 14, y - 88)
	handle:Lookup("Image_Bg2R"):SetSize(8, y - 88)
	handle:Lookup("Image_Bg3C"):SetSize(wAll - 102, 85)
	
	handle:FormatAllItemPos()
	handle:SetSizeByAllItemSize()
	local w, h = handle:GetSize()
	frame:SetSize(w, h)
	--CorrectAutoPosFrameAfterClientResize()
	--YCBank.UpdateTotalBagCount(frame,RBkFreeSize)	--���洫�������Ļ�
	YCBank.UpdateTotalBagCount(frame,YCBank.RBkFreeSize)
	frame:Lookup("CheckBox_Compact"):Check(true)
	frame.bDisable = false
end


function YCBank.EditBox_AppendLinkItem(dwItemIDOrdwBox, dwX)
			local frame = Station.Lookup("Lowest2/EditBox")
			if frame then
				local item=nil
				if dwX then
					item=GetPlayerItem(GetClientPlayer(),dwItemIDOrdwBox,dwX)
				else
					item=GetItem(dwItemIDOrdwBox)
				end
				if not item then
					return false
				end
				--local szName = "["..GetItemNameByItem(item).."]"
				local szName = "["..item.szName.."]"
				local edit = Station.Lookup("Lowest2/EditBox/Edit_Input")
				edit:InsertObj(szName, {type = "item", text = szName, item = item.dwID})
				Station.SetFocusWindow(edit)
				return true
			end
		end
		
function YCBank.OnItemLButtonDown()	--������������Ҳ���ܹص�ĳ��������������ʵ�ֵ�ô
		
	local szName = this:GetName()
	if szName == "Image_Bg1" then
		return
	elseif szName == "Image_Bg2" then
		return
	elseif szName == "Image_Bg3" then
		return
	elseif szName == "Image_Bg4" then
		return
	elseif szName == "Image_Bg5" then
		return
	elseif szName == "Image_Bg6" then
		return
	elseif szName == "Image_Bg7" then
		return
	end
	this.bIgnoreClick = nil
	if IsCtrlKeyDown() and not this:IsEmpty() and this.dwBox and this.dwX then		--ctrl
			YCBank.EditBox_AppendLinkItem(this.dwBox, this.dwX)
		this.bIgnoreClick = true
	end
	this:SetObjectStaring(false)
	this:SetObjectPressed(1)
end
function YCBank.OnItemLButtonUp()
	this:SetObjectPressed(0)
end


function YCBank.OnItemMouseEnter()	--�����ͣ����item��Ϣ����ctrl�ɻ�ȡ��
	this:SetObjectMouseOver(1)
	if not this:IsEmpty() then
		local x, y = this:GetAbsPos()
		local w, h = this:GetSize()
		if this.bBag and this.nBagIndex == 1 then
			local player = GetClientPlayer()
			local szTip = "<text>text="..EncodeComponentsString(g_tStrings.BANK).." font=60 "..GetItemFontColorByQuality(1, true)..
				" </text><text>text="..EncodeComponentsString(g_tStrings.BANK_FIXED1).." font=106 </text><text>text="
				..EncodeComponentsString(FormatString(g_tStrings.STR_ITEM_H_BAG_SIZE, player.GetBoxSize(this.nInventoryIndex))).."font=106</text>"
			OutputTip(szTip, 335, {x, y, w, h})
		else
			local _, dwBox, dwX = this:GetObjectData()
			OutputItemTip(UI_OBJECT_ITEM, dwBox, dwX, nil, {x, y, w, h})
		end		
	end
---ֻ���������ͣ��������
end

function YCBank.OnItemMouseLeave()
	this:SetObjectMouseOver(0)
	HideTip()
	
	if UserSelect.IsSelectItem() then
		UserSelect.SatisfySelectItem(-1, -1, true)
		return
	end
	
	if Cursor.GetCurrentIndex() == CURSOR.UNABLESPLIT then
		Cursor.Switch(CURSOR.SPLIT)
	elseif Cursor.GetCurrentIndex() == CURSOR.UNABLEREPAIRE then
		Cursor.Switch(CURSOR.REPAIRE)
	elseif not IsCursorInExclusiveMode() then
		Cursor.Switch(CURSOR.NORMAL)
	end
end

function YCBank.OnLButtonClick()	--�ر�Զ�ֿ̲�
	local szName = this:GetName()
	--Output(szName)
	if szName == "Btn_Close" then
		Wnd.CloseWindow("YCBank")
	end
end

function openbank()			--�򿪲ֿ�  ��¼ freesize
local dwSize, dwFreeSize = 0, 0					
	local player = GetClientPlayer()				
	for i = 1, YCBank.BankMaxCount, 1 do
		local nIndex = YCBank.BankIndexToInventoryIndex(i)
		local dw1 = player.GetBoxSize(nIndex)
		if dw1 and dw1 ~= 0 then	
		--dwSize = dwSize + dw1
		--YCBank.RBkFS={}			--ÿ�δ򿪶����һ�°�
		local dw2 = player.GetBoxFreeRoomSize(nIndex)	
			dwFreeSize = dwFreeSize + dw2
			--table.insert(YCBank.RBkFS,dw2)
			end
		end
		YCBank.RBkFreeSize=dwFreeSize		
--Output(YCBank.RBkFS)
end
RegisterEvent("OPEN_BANK",openbank)

function bagbankitemup()                    		  				
	if arg0>=7 and arg0<=12 then 			--ʵ�⻹���ԣ�����û�п�֡ʲô��
		openbank()			
	end
end
RegisterEvent("BAG_ITEM_UPDATE",bagbankitemup)
