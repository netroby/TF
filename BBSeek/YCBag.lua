--2012.12.25 Сͽ��ʥ�������� �������� �͸�������ı����Ʒ
--����һ�����뷨.���������������д��С���...�����о���̫����...��ӭ�޸�
YCBag={
IsOn=true,
Resettime=0,
bNeedCheckBankEdt=false,		--�������������
History={},
STAllF=true,STDrugF=false,STEnchF=false,
HistoryList={"ϴ��","�ٶ�","��������","������ϯ����"},
XyMsTH={"T-4Сҩ","����-4Сҩ"},
XyMsDps={"����-4Сҩ","�����⹦��ؤ���Ѫ������","���⹦���ؽ�����������ɽ","Ԫ���ڹ������䣬��Ӱ���׽�","�����ڹ������������ģ�����",},
CSpveF=true,
CSpvpF=true,
CSTList={
	{"������,ϴ��,��Ӱ,����",{33660,33600},{nil},},
},
CSHpsList={
	{"���ԣ�����",{33312},{33324},},
	{"��Ԫ���뾭",{33294},{33306},},
	{"���ԣ�����",{33330},{33342},},
},
CSDpsList={
	{"����������,�׽�,��Ӱ",{34872,34860},{34890,34884},},
	{"��Ԫ������,��ϼ",{31692,31704},{31716,31722},},
	{"���ԣ�����",{31794,31782,31800,31812},{31818,31824},},
	{"���ޣ���_��",{34464,34452,34416,34386},{34452},},
	{"�⹦����Ѫ,����,ؤ��,�ؽ�,̫��,��ɽ",{30432,30444},{30462,30474},},
},
ColorStone={},
bSaveLastChange=false,
bLastCloseBag=0,
bNeedReSet=false,
ChangeList={},
BagIsHide=false,
BankCache={},
BagCache={}, 
HideBtn={},
tNid2Attr={										 
	[2]="�ƶ��ٶ�",
	[36]="��Ѫ����",
	[75]="��ʽ������в",
	[88]="�����ȼ�",
	[91]="�����ȼ�",
	[104]="���к�͵ȡĿ�������˺�2.05%����Ѫ",
	[117]="��ս�����˺�",
	[129]="�⹦����",
	[132]="�⹦����",
	[134]="�⹦����",
	[138]="�⹦�Ʒ�",
	[155]="�ڹ�����",
	[157]="�ڹ�����",
	[162]="�ڹ��Ʒ�",
	[164]="�ڹ�����",
	[257]="���Ƴ�Ч",
	}
}
YCBag.ColorStone={{"T",YCBag.CSTList},{"����",YCBag.CSHpsList},{"���",YCBag.CSDpsList},}
YCBag.SFType={{YCBag.STAllF,"ȫ��"},{YCBag.STDrugF,"Сҩ"},{YCBag.STEnchF,"��ħ"},}--SearchType

RegisterCustomData("YCBag.IsOn")  
RegisterCustomData("YCBag.SFType")
RegisterCustomData("YCBag.History") 
RegisterCustomData("YCBag.bSaveLastChange") 
RegisterCustomData("YCBag.CSpveF") 
RegisterCustomData("YCBag.CSpvpF") 

function YCBag.m(str)
	OutputMessage("MSG_SYS", str .. "\n")
end

function YCBag.OnFrameCreate()
	YCBag.bNeedReSet=true
	this:RegisterEvent("UI_SCALED")
	this:RegisterEvent("ON_SET_BAG_COMPACT_MODE")
	this:RegisterEvent("BAG_ITEM_UPDATE")
	this:RegisterEvent("SYNC_ROLE_DATA_END")
	this:RegisterEvent("HELP_EVENT")
	
end

function YCBag.OnItemLButtonClick()
Output("Hello")
	local szName = this:GetName()
	Output(szName)
end

function YCBag.GetSth(box,x,id)
		local boxHand, nHandCount = Hand_Get()
		Output(boxHand,nHandCount)
		--YCBag.OnExchangeBoxItem(this, boxHand, nHandCount, true)
end

function YCBag.AddChangeList(box,x,id)
	if box and x and id then	
		YCBag.ChangeList[box.."/"..x]=GetTime()
	end
end

function YCBag.CheckChangeList()
	local nTime=GetTime()
	for k,v in pairs(YCBag.ChangeList or {}) do
		if nTime-v>30000 then
			YCBag.ChangeList[k]=nil
		end
	end
end

function YCBag.UpdateChangeItems(f)
	YCBag.CheckChangeList()
	local handle = f:Lookup("", "Handle_Bag_Compact")
	if handle then
		local hBox = handle:Lookup("Handle_Box")
		YCBag.ReSetCache()
		for i,Data in pairs(YCBag.BagCache) do
			for j,v in pairs(Data) do
				local a = handle:Lookup(v.idx)
				if a then
					local box = a:Lookup(1)
					if box then
						if YCBag.ChangeList[box.dwBox.."/"..box.dwX] then
							box.xrb=true
							box:SetObjectInUse(true)
							--������ʱ����� 
							box.OnItemMouseEnter=function() YCBag.ChangeList[box.dwBox.."/"..box.dwX]=nil  end
							--box.OnItemLButtonDown=function() Output("lb downr") end
						else
							if box.xrb then
								box.xrb=false
								box:SetObjectInUse(false)
							end
						end
					end
				end
			end
		end
	end
end

function YCBag.BtnMouseMove(str)
	local nX, nY = this:GetAbsPos()
	local nW, nH = this:GetSize()
	OutputTip(str, 400, {nX, nY, nW, nH})
end

function YCBag.ReSetCache(n)
	--if n==3 then
	if YCBag.bNeedReSet then
		YCBag.bNeedReSet=false
		if GetTime()-YCBag.Resettime >300 then
			YCBag.Resettime=GetTime()
			YCBag.BagCache={}
			local player = GetClientPlayer()
			local nidx=0
			for i=1,6,1 do
				local dw1 = player.GetBoxSize(i)
				YCBag.BagCache[i]={}
				for j=0,dw1-1,1 do
					local item = GetPlayerItem(player, i,j)  
					if item then
						--YCBag.m(i.."/"..j.." "..item.szName)
						if item.bCanStack then nCount=item.nStackNum else nCount=1 end 	
						YCBag.BagCache[i][j]={szName=item.szName,dwBox=i,dwX=j,itm=item,idx=nidx,nUiId=item.nUiId,nGenre=item.nGenre,nSub=item.nSub,nCount}	
					end
					nidx=nidx+1
				end
			end
			--Output('���ã�')
		end
	end
end

function YCBag.BtnClick(str) --�鿴Զ�ֿ̲�
	local f=Station.Lookup("Normal/YCBank")
	if not f then
		Wnd.OpenWindow("Interface\\TF\\BBSeek\\YCBank.ini", "YCBank")
		f=Station.Lookup("Normal/YCBank")
		f:Show()
		f:BringToTop()
		YCBank.InitBank(f)		
		YCBag.bNeedCheckBankEdt=true	 
	else
		Wnd.CloseWindow("YCBank")
	end
end

function YCBag.BtnClick2(str) --�л����߱���
end

function YCBag.AddEditHistory(str)		--���������ʷ
	if not str or str=="" then return end
	local idx=nil
	for k,v in pairs(YCBag.History) do
		if v==str then
			idx=k 
			break
		end
	end
	if idx then table.remove(YCBag.History,idx) end
	table.insert(YCBag.History,str)
	if #YCBag.History>10 then
		table.remove(YCBag.History,1) 
	end
end

function YCBag.OnBankEditChange(f,str,bClear) --�༭��ı�
	if not bClear then
		YCBag.AddEditHistory(str)
	end

	if not str or str=="" then return end		--����Ҫ����
	local nfound=0

	local player = GetClientPlayer()
	local nidx=0
	for i=7,12,1 do  
		local dw1 = player.GetBoxSize(i)
		YCBag.BankCache[i]={}
		for j=0,dw1-1,1 do
			local item = GetPlayerItem(player, i,j)
			if item then
				--YCBag.m(i.."/"..j.." "..item.szName)
				if item.bCanStack then nCount=item.nStackNum else nCount=1 end 		
				YCBag.BankCache[i][j]={szName=item.szName,dwBox=i,dwX=j,itm=item,idx=nidx,nUiId=item.nUiId,nGenre=item.nGenre,nSub=item.nSub,nCount}	
			end
			nidx=nidx+1
		end
	end

	if not f or not f:IsVisible() then return end
	local handle = f:Lookup("", "")
	if not handle then return end
	local hBox = handle:Lookup("Handle_Box")
	StrGr=YCBag.ExpandStr(str)		--��չstr���� �����   e.g.  ��Ч=����Ч			
	--Output(StrGr)

	for i,Data in pairs(YCBag.BankCache) do
		for j,v in pairs(Data) do
			local box = hBox:Lookup(v.idx)
			if not box then break end
			if bClear then		--��ԭ����
				box:SetAlpha(255) 
			else
				--��� ����Ҫ����Сҩ				&	          ��item(box)��Сҩ                     
				local NotinField= (not YCBag.SFType[2][1] and YCBag.IsXiaoyao(v.nGenre,v.nSub) ) or
									(not YCBag.SFType[3][1] and YCBag.IsFuMo(v.szName) )
				if NotinField then box:SetAlpha(30)
				else
					szDesc=YCBag.GetDesc(v.nGenre,v.nSub,v.nUiId,v.szName)	--��ȡ��ʵ��������desc
					flag=0
					for si=1,#StrGr do 
						if string.find(v.szName,StrGr[si]) or string.find(szDesc,StrGr[si]) then	
							nfound=nfound+1
							box:SetAlpha(255)  
								flag=1			
							break		
						end
					end											
					if flag ==0 then 							
						box:SetAlpha(30)  		
					end								

				end
			end
		end
	end

	if nfound>0 then
		OutputMessage("MSG_ANNOUNCE_YELLOW",'���ҵ�'..nfound..'����Ʒ.��')
	else
		if bClear then
			OutputMessage("MSG_ANNOUNCE_YELLOW",'��ȡ������.��')
		else
			OutputMessage("MSG_ANNOUNCE_RED",'��û���κ���Ʒ����Ҫ���')
		end
	end
	
end


function YCBag.ExpandStr(str)
	if	str=="��Ч" then StrGr={str,"����Ч"} 					--���޵��Ż���
	elseif str=="�ڻ�" then StrGr={str,"�ڹ���" }	
	elseif str=="���" then StrGr={str,"�⹦��" }
	elseif str=="����" then StrGr={str,"�ڹ���" }
	elseif str=="����" then StrGr={str,"�⹦��" }
	elseif str=="��в" then StrGr={str,"���"}
	elseif str=="���" then StrGr={str,"��в"}	
	elseif str=="T" then StrGr={"����","��в","���","����","�м�","����","Ѫ"} 	
	elseif str=="��" or str=="����" then StrGr={"����","����","����","�ڻ�","�ڹ���","����"}			
	elseif str=="Ѫ��" then StrGr={"��Ѫ","����"}
	elseif str=="��" or str=="����" then StrGr={"����"}
	elseif str=="Ѫ" or str=="��ҩ" then StrGr={"��Ѫ"}
	elseif str=="����" then StrGr={"�屡����","��������"} 		
	elseif str=="������ϯ����" then StrGr={"�屡����","��������","ܽ�س�ˮ��","����"} 
	elseif str=="��������" then StrGr={"����","����"}
	elseif str=="T-4Сҩ" then StrGr={"����","���","��в","����"}
	elseif str=="����-4Сҩ" then StrGr={"����","����","�ڻ�","�ڻ�Ч","�ڹ���","����"}
	elseif str=="����-4Сҩ" then StrGr={"Ԫ��","���Ч","�⹦��","����"}
	elseif str=="�����⹦��ؤ���Ѫ������" then StrGr={"����","���Ч","�⹦��","����","�⹦��"}
	elseif str=="���⹦���ؽ�����������ɽ" then StrGr={"��","���Ч","�⹦��","����","�⹦��"}
	elseif str=="Ԫ���ڹ������䣬��Ӱ���׽�" then StrGr={"Ԫ��","�ڻ�Ч","�ڹ���","����","�ڹ���"}
	elseif str=="�����ڹ������������ģ�����" then StrGr={"����","�ڻ�Ч","�ڹ���","����","�ڹ���"}
	--elseif string.find(str,"��") then table.insert(StrGr,"�ڹ�")   
	--pvp �� ��   pvp�������Ҳ�����������������������
	else StrGr={str}
	end			
	return StrGr
end				

function YCBag.ItemType(nGenre,nSub,szDes,szName)		
		--nGenre   1 ҩƷ or 14ʳƷ	  --nSub 1 �ظ��ࣨdes��   2������ 3��ǿ��  4����ҩƷ����ңbuff ����des�� 6 ��ϯ(des��      
	if  (nGenre==1 or nGenre==14) and (nSub==2 or nSub==3) then return "4Сҩ" 
		elseif nGenre==10 then return "����ʯ"				-- nSub 0�� 1ľ 2ˮ 3�� 4��   --nDetail  6 7 8��
		elseif nGenre==11 then return "���ʯ"
	end
	if nGenre==7 then return "90��ħ" end
	if nGenre==3 and nSub==0 and string.find(szDes,"<ENCHANT") then return "80��ħ" end
	if nGenre==3 and nSub==5 then return "�ؼ�" end
	return "other"		--δ���ǡ���
end

function YCBag.IsXiaoyao(nGenre,nSub)		
	if (nGenre==1 or nGenre==14) and (nSub==2 or nSub==3) then return true
	else return false
	end
end

function YCBag.Is30MoShi(szName)			
	if string.find(szName,"���۶�") then return true
	else return false
	end
end

function YCBag.IsMoShi(szName)			--pve 80��Ѫ 80��� 90����  uiidɸѡ
	if string.find(szName,"ĥʯ") then return true
	else return false
	end
end

function YCBag.Is90FuMo(szName)
	local strGr={"����","����","����","��Ⱦ","����","��ӡ",}
	for i=1,#strGr do
		if string.find(szName,strGr[i]) then return true end
	end
	return false
end

function YCBag.Is80FuMo(szName)
	local strGr={"�壨","Ⱦ��","��Ƭ��",}
	for i=1,#strGr do
		if string.find(szName,strGr[i]) then return true end
	end
	return false
end

function YCBag.IsFuMo(szName)
	if YCBag.Is90FuMo(szName) or YCBag.Is80FuMo(szName) or YCBag.IsMoShi(szName) then return true 
	else return false 
	end	
end

function YCBag.GetDesc(nGenre,nSub,nUiId,szName)				
	des=Table_GetItemDesc(nUiId)		 	
	---------------------------------------------------------
	--Сҩ
 	--------------------------------------------------------
	--if  (nGenre==1 or nGenre==14) and (nSub==2 or nSub==3) or nUiId==673 then			--673��ң
	if YCBag.ItemType(nGenre,nSub,des,szName)=="4Сҩ" or nUiId==673 then
		local x1,y1=string.find(des,"<BUFF ")			--�������� <BUFF 2903 4 desc>
		local x2,y2=string.find(des," desc>")
		buffIdLv=string.sub(des,y1+1,x2-1)
		local x3,y3=string.find(buffIdLv," ")			--�ָ� 2903 4
		buffId=tonumber(string.sub(buffIdLv,1,x3-1))		--�ַ���ת ���֣�
		buffLV=tonumber(string.sub(buffIdLv,y3+1))	
		szDesc=Table_GetBuffDesc(buffId,buffLV)	--���buff��desc		
	---------------------------------------------------------
	--��ǰ�ĸ�ħ
	--------------------------------------------------------
	--elseif  nGenre==3 and nSub==0 and string.find(des,"<ENCHANT") then			
	elseif YCBag.ItemType(nGenre,nSub,des,szName)=="80��ħ" then 
		if nUiId==3752  then FMid=38  else 	 
			local x1,y1=string.find(des,"<ENCHANT ")	
			local x2,y2=string.find(des,">\" font")
			FMid=tonumber(string.sub(des,y1+1,x2-1))	
		end	
		t=GetItemEnchantAttrib(FMid)
		nID=t[1]["nID"]
		szDesc=YCBag.tNid2Attr[nID]  
	else
		szDesc=des			  
	end
	--Output(szDesc)	
	return szDesc
end

function YCBag.OnEditChange(f,str,bClear)  
	if not bClear then
		YCBag.AddEditHistory(str)
	end
	if not str or str=="" then return end	 
	local nfound=0
	
	if not f or not f:IsVisible() then return end
	local chk = f:Lookup("CheckBox_Compact")
	if chk and not chk:IsCheckBoxChecked() then			  chk:Check(true)			end
	local handle = f:Lookup("", "Handle_Bag_Compact")
	if not handle then return end
	YCBag.ReSetCache()
	StrGr=YCBag.ExpandStr(str)		 
 

	for i,Data in pairs(YCBag.BagCache) do
		for j,v in pairs(Data) do
		local a = handle:Lookup(v.idx)
			if not a then break end
			local box = a:Lookup(1)
			if not box then break end
			if bClear then		 
				box:SetAlpha(255) 
			else
			     
				local NotinField= (not YCBag.SFType[2][1] and YCBag.IsXiaoyao(v.nGenre,v.nSub) ) or
									(not YCBag.SFType[3][1] and YCBag.IsFuMo(v.szName) )
				if NotinField then box:SetAlpha(30)
				else
					szDesc=YCBag.GetDesc(v.nGenre,v.nSub,v.nUiId,v.szName)	
					flag=0
					for si=1,#StrGr do 
						if string.find(v.szName,StrGr[si]) or string.find(szDesc,StrGr[si]) then		
							nfound=nfound+1
							box:SetAlpha(255) 
								flag=1			
							break		
						end
					end												
					if flag ==0 then 							
						box:SetAlpha(30)  		
					end																
				end
			end
		end
	end

	if nfound>0 then
		OutputMessage("MSG_ANNOUNCE_YELLOW",'���ҵ�'..nfound..'����Ʒ.��')
	else
		if bClear then
			OutputMessage("MSG_ANNOUNCE_YELLOW",'��ȡ������.��')
		else
			OutputMessage("MSG_ANNOUNCE_RED",'��û���κ���Ʒ����Ҫ���')
		end
	end
	
end


function YCBag.ShowBagItems(k)
	local frame = Station.Lookup("Normal/BigBagPanel")
	if frame then
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
					local item = GetPlayerItem(N, box.dwBox, box.dwX)
					if item then
						if k=="Book" and	item.nGenre==4 then
							box:SetAlpha(255)
						elseif k=="Grey" and item.nQuality==0 then
							box:SetAlpha(255)
						elseif item.szName and item.szName==k then
							box:SetAlpha(255)
						else
							box:SetAlpha(30)
						end
					end
				end
			end
		end
	end
end

function YCBag.SearchbyUiid(tCSlist)
	local f = Station.Lookup("Normal/BigBagPanel")
	if not f or not f:IsVisible() then return end
	local chk = f:Lookup("CheckBox_Compact")
	if chk and not chk:IsCheckBoxChecked() then			  chk:Check(true)			end
	local handle = f:Lookup("", "Handle_Bag_Compact")
	if not handle then return end
	YCBag.ReSetCache()
	nfound=0		  
	for i,Data in pairs(YCBag.BagCache) do	 
		for j,v in pairs(Data) do
			local a = handle:Lookup(v.idx)
			if not a then break end
			local box = a:Lookup(1)
			if not box then break end
			flag=0
			for si=1,#tCSlist do 
				if v.nUiId==tCSlist[si] then		 
					table.remove(tCSlist,si)	 
					nfound=nfound+1			
					box:SetAlpha(255) 
					flag=1
					break	 
				end
			end				
			if flag==0 then box:SetAlpha(30) end		
		end
	end
	if nfound>0 then
		OutputMessage("MSG_ANNOUNCE_YELLOW",'���ҵ�'..nfound..'����Ʒ.��')
	else
		OutputMessage("MSG_ANNOUNCE_RED",'��û���κ���Ʒ����Ҫ���')
	end
end

function YCBag.ColorStoneClass(vep)
	local tCSlist={}
	if	YCBag.CSpveF then 
		for _,v in pairs(vep[2]) do	
			table.insert(tCSlist,v) 
		end
	end
	if	YCBag.CSpvpF then  
		for i=1,#vep[3] do
			table.insert(tCSlist,vep[3][i]) 
		end
	end
 
	YCBag.SearchbyUiid(tCSlist)
end

function  YCBag.MenuTip(hItem,str)
	local szText="<text>text=" ..EncodeComponentsString(str).." font=101 </text>"
	if not hItem then return end
	local x, y = hItem:GetAbsPos()
	local w, h = hItem:GetSize()
	OutputTip(szText, 435, {x, y, w, h})	
end

function YCBag.BagEditBtn_OnLBDown(f,func) 
--[=[Сҩĥʯ]=]
	local mXYMS={szOption="Сҩĥʯ",rgb={255,255,0},}

		for k,v in pairs(YCBag.XyMsTH) do
			table.insert(mXYMS,{szOption=v,rgb={0,255,0},
				fnAction=function()  
					YCBag.SFType[2][1]=true 
					YCBag.SFType[3][1]=false
					f=Station.Lookup("Normal/BigBagPanel")
					f2=Station.Lookup("Normal/BigBankPanel")						
					YCBag.OnEditChange(f,v,false)
					YCBag.OnBankEditChange(f2,v,false)
				end,
			})
		end
		table.insert(mXYMS,{bDevide=true})
		for k,v in pairs(YCBag.XyMsDps) do
			table.insert(mXYMS,{szOption=v,rgb={0,255,255},
				fnAction=function()  
					YCBag.SFType[2][1]=true 
					YCBag.SFType[3][1]=false
					f=Station.Lookup("Normal/BigBagPanel")
					f2=Station.Lookup("Normal/BigBankPanel")					
					YCBag.OnEditChange(f,v,false)
					YCBag.OnBankEditChange(f2,v,false)
				end,
			})				
		end

--[=[���ʯ]=]		
	local mst={}
	for i=1,#YCBag.ColorStone do
		mst[i]={szOption=YCBag.ColorStone[i][1],}		 
		for _,vep in pairs(YCBag.ColorStone[i][2]) do
			table.insert(mst[i],{szOption=vep[1],rgb={0,255,255},fnAction=function() YCBag.ColorStoneClass(vep) end})  
		end	
	end
	local mColorStone={szOption="���ʯ",rgb={0,255,255},}	 
	table.insert(mColorStone,{szOption="-=����=-",bDisable=true})
	table.insert(mColorStone,{szOption="PVE",bCheck=true,bChecked = YCBag.CSpveF,bMCheck=false,fnAction=function(UserData,bCheck) YCBag.CSpveF=bCheck end})
	table.insert(mColorStone,{szOption="PVP",bCheck=true,bChecked = YCBag.CSpvpF,bMCheck=false,fnAction=function(UserData,bCheck) YCBag.CSpvpF=bCheck end})
	table.insert(mColorStone,{bDevide=true})
	table.insert(mColorStone,	mst[1])
	table.insert(mColorStone,	mst[2])
	table.insert(mColorStone, mst[3])

--[=[������Χ/����]=]	
	local mSearchField = {szOption='������Χ/����/��λ',rgb={0,255,0}} 
	for i=1,#YCBag.SFType do
		v=YCBag.SFType[i][2]
		table.insert(mSearchField,{szOption=v,rgb={255,255,0},bCheck=true,bChecked=YCBag.SFType[i][1],bMCheck=false,
			fnAction=function(UserData,bCheck) YCBag.SFType[i][1]=bCheck end})
	end

--[=[ƫ������]=]	
	local mHistoryList={}
	for i=1,#YCBag.HistoryList do
		v=YCBag.HistoryList[i]
		mHistoryList[i]={szOption=v,rgb={255,255,150},fnAction=function() func(f,v,false) end}		  		
		table.insert(mHistoryList[i],{szOption="����һ��",rgb={0,255,255},fnAction=function() func(f,YCBag.HistoryList[i],false)  end})  			
		table.insert(mHistoryList[i],{szOption="�Ƴ�����",rgb={255,180,0},fnAction=function() table.remove(YCBag.HistoryList,i) end})  
	end	
	
--[=[������ʷ]=]	

	local mHistory={}
	for i=1,#YCBag.History do
	v=YCBag.History[i]
	mHistory[i]={szOption=YCBag.History[i],fnAction=function() func(f,v,false) end}		  
	table.insert(mHistory[i],{szOption="����һ��",rgb={0,255,255},fnAction=function() func(f,YCBag.History[i],false) end})  
	table.insert(mHistory[i],{szOption="��Ϊƫ������",rgb={255,255,0},fnAction=function() 
			flag=0
			for j=1,#YCBag.HistoryList do
				if YCBag.History[i]==YCBag.HistoryList[j] then 
					flag=1
					break 
				end				
			end
			if flag==0 then
				table.insert(YCBag.HistoryList,YCBag.History[i]) 
			else OutputMessage("MSG_SYS","���иü�¼\n") 
			end
			table.remove(YCBag.History,i)	
		end})  
	table.insert(mHistory[i],{szOption="�Ƴ�����",rgb={255,180,0},fnAction=function() table.remove(YCBag.History,i) end})  
	end	
	
--[=[menu��ʼ]=]		
	local m={}
	for k,v in pairs(YCBag.HideBtn or {}) do
		table.insert(m,{szOption="���� "..v,fnMouseEnter = function(hItem) YCBag.ShowBagItems(k) end})
	end
	table.insert(m,{bDevide=true})
	--------------------------------------------
	table.insert(m,mSearchField)	--������Χ/����
	table.insert(m,{bDevide=true})
	--------------------------------------------
	table.insert(m,{szOption='-=Ԥ������=-',bDisable=true})
	table.insert(m,mXYMS)			--Сҩĥʯ
	table.insert(m,mColorStone)	--���ʯ
	table.insert(m,{szOption='��װ��ħ'})
	table.insert(m,{bDevide=true})
	--------------------------------------------
	table.insert(m,{szOption='-=ƫ������=-',bDisable=true}) 
	for i=1,#YCBag.HistoryList do	
		table.insert(m,mHistoryList[i]) 
	end
	table.insert(m,{bDevide=true})
	--------------------------------------------
	table.insert(m,{szOption='-=������ʷ=-',bDisable=true}) 
	for i=1,#YCBag.History do		
		table.insert(m,mHistory[i]) 
	end
	table.insert(m,{szOption='�����ʷ��¼',rgb={255,255,0},fnAction=function() YCBag.History={} end })
	table.insert(m,{bDevide=true})
	--------------------------------------------	
	table.insert(m,{szOption='ȡ����������ԭ����',fnAction=function()  YCBag.BagEditBtn_OnRBDown( Station.Lookup("Normal/BigBagPanel") ) 
							YCBag.BagEditBtn_OnRBDown( Station.Lookup("Normal/BigBankPanel") ) end })
 
	PopupMenu(m)
end

function YCBag.BagEditBtn_OnRBDown(f)--�һ���ť ���������
	if f then
		local	cbb=f:Lookup("cbbSearcher")
		if cbb then
			local edt=cbb:Lookup("Text_Default")
			if edt then 
				edt:SetText("") 
				YCBag.OnEditChange(f,"xx",true)
				YCBag.OnBankEditChange(f,"xx",true)
			end
		end
	end
end
 
function YCBag.AddComboBox(frame,func_EdtChange,func_BtnLbDown,func_BtnRbDown,x,y,w,h,szTitle,isbag) --����������,isbag��ʱû�á�
	local	cbb=frame:Lookup("cbbSearcher")	
	if not cbb then		 
		local f=Wnd.OpenWindow('interface/TF/BBSeek/cbb.ini','asTempCbbWnd')
		if f then
			local r=f:Lookup("WndComboBox")
			if r then
				r:ChangeRelation(frame,true,true)
				r:SetName('cbbSearcher')
				local nw,ny=frame:GetSize()
				r:SetRelPos(nw-x,y)  
		 
				r:SetSize(w,h)
				r:Lookup('',"Image_ComboBoxBg"):SetSize(w,h)
				r:Lookup('',"Edit_Image"):SetSize(w,h)
				local edt=r:Lookup("Text_Default")	 
				if edt then
					edt:SetSize(w-5,h-5)
					if szTitle then
						edt:SetText(szTitle)
					end
					edt.szText=""
					frame.ChangeFunc=func_EdtChange
					--������Ҫ���ܡ����������İ����� 
				end
				local btn=r:Lookup('Btn_ComboBox')
				if btn then
					--btn.OnMouseEnter=function()   end			 
					btn.OnMouseLeave=function() HideTip() end
					btn.OnMouseEnter=function() YCBag.BtnMouseMove(GetFormatText("���������ѡ���ʷ��¼\n�Ҽ���ȡ����������ԭ����", 101) ) end--����ƶ�
					btn.OnLButtonClick=function() func_BtnLbDown(frame,func_EdtChange) end
					btn.OnRButtonClick=function() func_BtnRbDown(frame) end
					btn:SetRelPos(w-24,3)
				end
			end
			Wnd.CloseWindow(f)
		end
	else
 

		local edt=cbb:Lookup("Text_Default")
		if YCBag.BagIsHide then 
			YCBag.BagIsHide=false
			edt:SetText("")
		end
		local str=edt:GetText()
		if str then
			str=    (string.gsub(str, "^%s*(.-)%s*$", "%1")) 
			str=    (string.gsub(str, "^%[*(.-)%]*$", "%1")) 
			if str and  edt.szText~=str  then
				edt:SetText(str)
				edt.szText=str
				if str=="" then
					YCBag.m('��ԭ����.')
					YCBag.OnEditChange(frame,'xx',true)
				else
					YCBag.OnEditChange(frame,str,false)
				end
			end
		end
	end
end

function YCBag.ChangeBagMode(frame)
	if not frame then return end
	local chk=frame:Lookup("CheckBox_Compact")
	if chk then
		chk:Check(true)
	end
end

function YCBag.CreateButton(szName,x,y,tip ) --���� btn
	local f = Station.Lookup("Normal/BigBagPanel")
	if f and f:IsVisible() then
		local btn=f:Lookup("Btn_OpenYCBank")
		if not btn then --ľ�С����
			local szFile="Interface\\TF\\BBSeek\\btn.ini"
			local fx=Wnd.OpenWindow(szFile,"YCBag_BankTemp")
			if fx then
				fx:Show()
				fx:BringToTop()		 
				local itm=fx:Lookup("WndButton")
				if itm then
					itm:ChangeRelation(f,true,true)  
					itm:SetName("Btn_OpenYCBank")
					x=100		 
					itm:SetRelPos(x,y)					 
					itm.nX=x
					itm.nY=y
					itm.OnMouseLeave=function() HideTip() end
					itm.OnMouseEnter=function() YCBag.BtnMouseMove(tip) end 
					itm.OnLButtonClick=function()  YCBag.BtnClick(szName) end
					itm.OnRButtonClick=function()  YCBag.BtnClick2(szName) end
				end
			end
			Wnd.CloseWindow(fx)
			YCBag.ChangeBagMode(f)
		else --����
		 
		end
	end
end

function YCBag.CheckBankEdit()
	local frame = Station.Lookup("Normal/BigBankPanel")
	if frame then
		local	cbb=frame:Lookup("cbbSearcher")
		if not cbb then return end
		local nw,ny=frame:GetSize()
		 
		local edt=cbb:Lookup("Text_Default")
		local str=edt:GetText()
		if str then
			str=    (string.gsub(str, "^%s*(.-)%s*$", "%1")) 
			str=    (string.gsub(str, "^%[*(.-)%]*$", "%1")) 
			if str and  edt.szText~=str  then
				edt:SetText(str)
				edt.szText=str
				if str=="" then
					YCBag.OnBankEditChange(frame,'xx',true)
				else
					YCBag.OnBankEditChange(frame,str,false)
				end
			end
		end
	else
		YCBag.bNeedCheckBankEdt=false
	end
end

function YCBag.AddBankButton()  
	local f = Station.Lookup("Normal/BigBagPanel")
	if f and f:IsVisible() then
		if YCBag.bSaveLastChange then  
			YCBag.bLastCloseBag=0
			YCBag.UpdateChangeItems(f)
		end
		YCBag.CreateButton("Btn_OpenYCBank",10,-4,  GetFormatText("Զ�ֿ̲�/���߱���\n", 101) .. GetFormatText("�����鿴Զ�ֿ̲⣡\n�Ҽ��л����߱���", 106)  )
		YCBag.AddComboBox(f,YCBag.OnEditChange, YCBag.BagEditBtn_OnLBDown,YCBag.BagEditBtn_OnRBDown,160,17,95,20,nil,true) 
		 

	else
		if YCBag.bSaveLastChange then
			if YCBag.bLastCloseBag==0 then
				YCBag.bLastCloseBag=GetTime()
			end
			if GetTime() -YCBag.bLastCloseBag > 5000 then  
				YCBag.ChangeList={}
			end
		end
		
		YCBag.BagIsHide=true  
	end
	if YCBag.bNeedCheckBankEdt then
		YCBag.CheckBankEdit()
	end
end

function YCBag.Hide()
	local f=Station.Lookup("Normal/BigBagPanel")
	if f and f:IsVisible() then
		local r=f:Lookup("cbbSearcher")
		if r then r:Hide() end
	end
end

function YCBag.OnFrameBreathe()
	if GetLogicFrameCount() % 4 == 0 then
		if YCBag.IsOn then 	   
			YCBag.AddBankButton() 
			local f=Station.Lookup("Normal/BigBagPanel")
			if f and f:IsVisible() then
				local r=f:Lookup("cbbSearcher")
				r:Show()
			end
		else 
			YCBag.Hide() 
		end		
	end
end

function YCBag.tip(itm,str)
	local frame = Station.Lookup("Normal/BigBagPanel")
	if not itm then itm=this end
	local x, y = itm:GetAbsPos()
	local w, h = itm:GetSize()
	local szTip= "<text>text=" ..EncodeComponentsString(str).." font=101 </text>" 
	OutputTip(szTip, 400, {x, y, w, h})
end

function YCBag.OnEvent(event)
	if event=="ON_SET_BAG_COMPACT_MODE" then 
	elseif event=="BAG_ITEM_UPDATE" then
		YCBag.bNeedReSet=true
		if YCBag.bSaveLastChange then
 			YCBag.AddChangeList(arg0,arg1,arg2)
 		end
	--	YCBag.ReSetCache(1)
	elseif event=="SYNC_ROLE_DATA_END" then
		YCBag.ReSetCache(3)
	elseif  event =="HELP_EVENT" then
	--Output(arg0,arg1,arg2)
		if arg0=="OnOpenpanel" then			 
			if arg1=="BANK" then  			 
				local frame = Station.Lookup("Normal/BigBankPanel")
				YCBag.bNeedCheckBankEdt=true
				 
				YCBag.AddComboBox(frame,YCBag.OnBankEditChange, YCBag.BagEditBtn_OnLBDown,YCBag.BagEditBtn_OnRBDown,150,10,100,20,nil,false)

			end
		end
	end
end

local f=Station.Lookup("Normal/YCBag")
if not f then
	Wnd.OpenWindow("Interface\\TF\\BBSeek\\YCBag.ini", "YCBag")
	f=Station.Lookup("Normal/YCBag")
	f:Show()
end

function  YCBag.RegAddonModInfo()
	local tDataBBSeek={
		szName = "BBSeek",										 
		szTitle = "��������",									 
		dwIcon = 3556,												 
		szClass = "UI",	
		tWidget={
			{	tag = "BBSeek_IsOn", type = "WndCheckBox", 					 
				w = 100, h = 25, text = "������������",					 
				anchor = "TOPLEFT", x = 0, y = 0,					 
				default = function()							 
					return YCBag.IsOn
				end,
				callback = function(enabled)						 
					YCBag.IsOn = enabled
				end
			},
			{	tag = "BBSeek_ShuoMing", type = "WndTextBox", 					 
				w = 480, h = 28, text = "������˵���������������쿪����Ʒ���и�ְҵԤ��ѡ�",					 
				anchor = "TOPLEFT", x = 0, y = 30,					 
			},{	tag = "BBSeek_zhuyi", type = "WndTextBox", 					 
				w = 480, h = 28, text = "��ʹ��ע�⡿�������ڱ������Ͻǣ�ƫ����������ʷ������",					 
				anchor = "TOPLEFT", x = 0, y = 60,					 
			},
			{	tag = "BBSeek_Author", type = "WndTextBox", 					 
				w = 160, h = 28, text = "By ΢��ƾ��", fontcolor={0,255,255},					 
				anchor = "TOPLEFT", x = 300, y = 330, 					 
			},
		},
	}

	CUIRegAddonModInfo(tDataBBSeek)	
end

RegisterEvent("CUSTOM_DATA_LOADED", function()						 
	if arg0 == "Role" then
		YCBag.RegAddonModInfo()
	end
end)