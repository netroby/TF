JLTL={
JL_On=false,
TL_On=false,
JLCount=0,		
TLCount=0,		
JLIdx=19458,
TLIdx=19459,
JLTitle="[�Զ��Ծ���]-",
TLTitle="[�Զ�������]-",
MsgHorseFlag=0,
MoveFlag=0,
fTimeStamp=0,
}

function JLTL.JLSwitch()
local p=GetClientPlayer()
	JLTL.JL_On= not JLTL.JL_On
	if JLTL.JL_On then
		JLTL.MsgHorseFlag=0	JLTL.MoveFlag=0	 
		JLTL.JLCount=(p.nMaxStamina-p.nCurrentStamina)/51
		JLTL.JLCount=math.ceil(JLTL.JLCount)    
		JLTime=JLTL.JLCount*15
		if JLTime>0 then JLTime=JLTime-10 end	
		JLMin=math.floor(JLTime/60)
		JLSec=JLTime%60
		OutputMessage("MSG_SYS",JLTL.JLTitle.."����\n")
		OutputMessage("MSG_SYS",JLTL.JLTitle.."��������"..JLTL.JLCount.."�š��ѡ���Ԫ�͡�,Ԥ����ʱ"..JLMin.."��"..JLSec.."�루��ʱ�������\n")
		OutputMessage("MSG_SYS",JLTL.JLTitle.."��ȷ�ϲ������״̬��ս��״̬\n")
	else
		OutputMessage("MSG_SYS",JLTL.JLTitle.."�ر�\n")
		p.StopCurrentAction()		
	end
end

function JLTL.TLSwitch()
local p=GetClientPlayer()
	JLTL.TL_On= not JLTL.TL_On
	if JLTL.TL_On then
		JLTL.MsgHorseFlag=0	JLTL.MoveFlag=0	 
		JLTL.TLCount=math.ceil((p.nMaxThew-p.nCurrentThew)/51)			
		TLTime=JLTL.TLCount*15
		if TLTime>0 then TLTime=TLTime-10 end	
		TLMin=math.floor(TLTime/60)
		TLSec=TLTime%60
		OutputMessage("MSG_SYS",JLTL.TLTitle.."����\n")
		OutputMessage("MSG_SYS",JLTL.TLTitle.."��������"..JLTL.TLCount.."�š��ѡ�ת��͡�,Ԥ����ʱ"..TLMin.."��"..TLSec.."�루��ʱ�������\n")
		OutputMessage("MSG_SYS",JLTL.TLTitle.."��ȷ�ϲ������״̬��ս��״̬\n")
	else
		OutputMessage("MSG_SYS",JLTL.TLTitle.."�ر�\n")
		p.StopCurrentAction()		
	end
end


function JLTL.OnFrameBreathe()
if GetLogicFrameCount() < JLTL.fTimeStamp then return end
	if GetLogicFrameCount()%8==0 then
		local player = GetClientPlayer()		
		if JLTL.JL_On then 
			dwIndex=JLTL.JLIdx 
			if player.nMaxStamina == player.nCurrentStamina then  _JT.Alert("�������� �Զ���ҩ�ر�", function() end, "Yes")  
			JLTL.JL_On=false return end
		elseif  JLTL.TL_On then 
			dwIndex=JLTL.TLIdx
			if  player.nMaxThew == player.nCurrentThew then  _JT.Alert("�������� �Զ���ҩ�ر�", function() end, "Yes")    
			JLTL.TL_On=false return end			
		else return end	
		if player.bOnHorse then			
			if JLTL.MsgHorseFlag==0 then _JT.Alert("���������״̬��ҩ��������Զ�����", function() end, "Yes") JLTL.MsgHorseFlag=1 end 
			return	
		else JLTL.MsgHorseFlag=0	 
		end
		if player.bFightState then end	 
		if player.nMoveState~=MOVE_STATE.ON_STAND and player.nMoveState~=MOVE_STATE.ON_SIT then   
			if JLTL.MoveFlag==0 then _JT.Alert("���Զ�������������վ�û����£����Զ�����", function() end, "Yes") JLTL.MoveFlag=1 end 
			return	
		else JLTL.MoveFlag=0	 
		end		
		if player.GetOTActionState()~=0 then   return end		
		JLTL.Eat(dwIndex)
	end
end

function JLTL.Eat(dwIndex)
 	
	local dwBox, dwX=GetItemPosByItemTypeIndex(5,dwIndex)		
	if not dwBox then 	
		if dwIndex==JLTL.JLIdx then OutputMessage("MSG_ANNOUNCE_RED","û�о���ҩ�ˣ���ȷ�ϱ������С��ѡ���Ԫ�͡�")
		_JT.Alert("�Զ���ҩ�ѹر�\nû�о���ҩ�ˣ���ȷ�ϱ������С��ѡ���Ԫ�͡�", function() end, "Yes")
		JLTL.JL_On=false
		else OutputMessage("MSG_ANNOUNCE_RED","û������ҩ�ˣ���ȷ�ϱ������С��ѡ�ת��͡�") 			
		_JT.Alert("�Զ���ҩ�ѹر�\nû������ҩ�ˣ���ȷ�ϱ������С��ѡ�ת��͡�", function() end, "Yes")
		JLTL.TL_On=false
		end
	else
		player=GetClientPlayer()
		item = player.GetItem(dwBox, dwX)
		local _,NeedCD,_,_=player.GetItemCDProgress(item.dwID)
		if NeedCD==0 then		
			OnUseItem(dwBox,dwX)					
		elseif  NeedCD>90 then     
			JLTL.fTimeStamp=GetLogicFrameCount()+NeedCD
		end
	end
end

 
Wnd.OpenWindow("Interface\\TF\\EatJLTL\\JLTL.ini","JLTL")

function  JLTL.RegAddonModInfo()
	local tDataJLTL={
		szName = "EatJLTL",									
		szTitle = "��������",									
		dwIcon = 3721,										
		szClass = "AUTO",	
		tWidget={
			{	tag = "JL_On", type = "WndCheckBox", 				 
				w = 100, h = 25, text = "�Զ��Ծ�������",				 
				anchor = "TOPLEFT", x = 0, y = 0,					 
				default = function()								 
					return JLTL.JL_On
				end,
				callback = function(enabled)						
					JLTL.JL_On = enabled
				end
			},
				{	tag = "TL_On", type = "WndCheckBox", 				 
				w = 100, h = 25, text = "�Զ�����������",				 
				anchor = "TOPLEFT", x = 150, y = 0,					 
				default = function()								 
					return JLTL.TL_On
				end,
				callback = function(enabled)					 
					JLTL.TL_On = enabled
				end
			},
			{	tag = "JLTL_ShuoMing", type = "WndTextBox", 				 
				w = 480, h = 28, text = "������˵�����Զ��Ծ�������ҩ��",				 
				anchor = "TOPLEFT", x = 0, y = 30,					 
			},{	tag = "JLTL_zhuyi", type = "WndTextBox", 				 
				w = 480, h = 28, text = "��ʹ��ע�⡿��Ҫ�����״̬������ˢ��ҩ�һ���",				 
				anchor = "TOPLEFT", x = 0, y = 60,					 
			},
			{	tag = "JLTL_Author", type = "WndTextBox", 				 
				w = 160, h = 28, text = "By ΢��ƾ��", fontcolor={0,255,255},				 
				anchor = "TOPLEFT", x = 300, y = 330, 					 
			},
		},
	}

	CUIRegAddonModInfo(tDataJLTL)	
end

RegisterEvent("CUSTOM_DATA_LOADED", function()					 
	if arg0 == "Role" then
		JLTL.RegAddonModInfo()
	end
end)
