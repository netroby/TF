SellDrug={
	nZphld=1,--��Ʒ���絤
	nZpzxd=1,--��ƷֹѪ��
	nTzdt=0,--����ǿ�����Ͱٻ����ң����ʵ��壩
	nGgdt=0,--�������������������ң����ǵ��壩
	nYqdt=0,--��ң��ԭ�����Ϻ����ң�Ԫ�����壩
	nSfdt=0,--����֪�����͹�֦���ң������壩
	nLddt=0,--�����������Ͱع����ң��������壩
	nNggj=0,--�������o����Ʒչ�ﵤ���ڹ��������壩
	nWggj=0,--������Ǵ����Ʒ���������⹦�������壩
	nFjch=0,--��ǲ����Ʒ�ƻ൤�����ӳ�޵��壩
	nCZZ=0,--����������Ʒ��־��(����ֵ)
	nNGHX=0,--��Ƥ��צ�ͣ��ڹ��Ʒ���
	nWGHX=0,--��˿����⣨�⹦�Ʒ���
	nQXSX=0,--��Ʒ����������Ѫ���ޣ�
	nNLSX=0,--��Ʒ���񵤣��������ޣ�
	nCBRD=0,--�б��ⶡ(��)
	nTCMR=0,--�������(��)
	nQXYX=0,--ܽ�س�ˮ��
	nXYS=1,--��ңɢ
	nFYW=1,--������
	nDSFM=0,--������ħ
	nYJFM=0,--������ħ
	nHJFM=0,--������ħ
	nZLFM=0,--���Ƹ�ħ
	nWGFM=0,--�⹦��ħ
	nNGFM=0,--�ڹ���ħ
	nQXFM=0,--��Ѫ��ħ
	nCHFM=0,--��޲��и�ħ
	nWGMZFM=0,--�⹦���и�ħ
	nNGMZFM=0,--�ڹ����и�ħ
	nWXSJ=0,--����ʯ����
	nWXSM=0,--����ʯ��ľ
	nWXSS=0,--����ʯ��ˮ
	nWXSH=0,--����ʯ����
	nWXST=0,--����ʯ����
	nJLHF=0,--�����ָ�
	nTLHF=0,--�����ָ�
	nHXXG=0,--����Ч��
	nOpen=0
}
RegisterCustomData("SellDrug.nZphld")
RegisterCustomData("SellDrug.nZpzxd")
RegisterCustomData("SellDrug.nTzdt")
RegisterCustomData("SellDrug.nGgdt")
RegisterCustomData("SellDrug.nYqdt")
RegisterCustomData("SellDrug.nSfdt")
RegisterCustomData("SellDrug.nLddt")
RegisterCustomData("SellDrug.nNggj")
RegisterCustomData("SellDrug.nWggj")
RegisterCustomData("SellDrug.nFjch")
RegisterCustomData("SellDrug.nCZZ")
RegisterCustomData("SellDrug.nNGHX")
RegisterCustomData("SellDrug.nWGHX")
RegisterCustomData("SellDrug.nQXSX")
RegisterCustomData("SellDrug.nNLSX")
RegisterCustomData("SellDrug.nCBRD")
RegisterCustomData("SellDrug.nTCMR")
RegisterCustomData("SellDrug.nQXYX")
RegisterCustomData("SellDrug.nXYS")
RegisterCustomData("SellDrug.nFYW")
RegisterCustomData("SellDrug.nDSFM")
RegisterCustomData("SellDrug.nYJFM")
RegisterCustomData("SellDrug.nHJFM")
RegisterCustomData("SellDrug.nZLFM")
RegisterCustomData("SellDrug.nWGFM")
RegisterCustomData("SellDrug.nNGFM")
RegisterCustomData("SellDrug.nQXFM")
RegisterCustomData("SellDrug.nCHFM")
RegisterCustomData("SellDrug.nWGMZFM")
RegisterCustomData("SellDrug.nNGMZFM")
RegisterCustomData("SellDrug.nWXSJ")
RegisterCustomData("SellDrug.nWXSM")
RegisterCustomData("SellDrug.nWXSS")
RegisterCustomData("SellDrug.nWXSH")
RegisterCustomData("SellDrug.nWXST")
RegisterCustomData("SellDrug.nJLHF")
RegisterCustomData("SellDrug.nTLHF")
RegisterCustomData("SellDrug.nHXXG")

function SellDrug.OnFrameCreate()
	this:Lookup("CheckBox_Zphld"):Check(SellDrug.nZphld)
	this:Lookup("CheckBox_Zpzxd"):Check(SellDrug.nZpzxd)
	this:Lookup("CheckBox_Tzdt"):Check(SellDrug.nTzdt)
	this:Lookup("CheckBox_Ggdt"):Check(SellDrug.nGgdt)
	this:Lookup("CheckBox_Yqdt"):Check(SellDrug.nYqdt)
	this:Lookup("CheckBox_Sfdt"):Check(SellDrug.nSfdt)
	this:Lookup("CheckBox_Lddt"):Check(SellDrug.nLddt)
	this:Lookup("CheckBox_Nggj"):Check(SellDrug.nNggj)
	this:Lookup("CheckBox_Wggj"):Check(SellDrug.nWggj)
	this:Lookup("CheckBox_Fjch"):Check(SellDrug.nFjch)
	this:Lookup("CheckBox_Zldt"):Check(SellDrug.nCZZ)
	this:Lookup("CheckBox_NGHX"):Check(SellDrug.nNGHX)
	this:Lookup("CheckBox_WGHX"):Check(SellDrug.nWGHX)
	this:Lookup("CheckBox_WGYX"):Check(SellDrug.nQXSX)
	this:Lookup("CheckBox_NGYX"):Check(SellDrug.nNLSX)
	this:Lookup("CheckBox_LSYX"):Check(SellDrug.nCBRD)
	this:Lookup("CheckBox_CHYX"):Check(SellDrug.nTCMR)
	this:Lookup("CheckBox_QXYX"):Check(SellDrug.nQXYX)
	this:Lookup("CheckBox_XYS"):Check(SellDrug.nXYS)
	this:Lookup("CheckBox_FYW"):Check(SellDrug.nFYW)
	this:Lookup("CheckBox_BLD"):Check(SellDrug.nDSFM)
	this:Lookup("CheckBox_YJFM"):Check(SellDrug.nYJFM)
	this:Lookup("CheckBox_HJFM"):Check(SellDrug.nHJFM)
	this:Lookup("CheckBox_ZLFM"):Check(SellDrug.nZLFM)
	this:Lookup("CheckBox_WGFM"):Check(SellDrug.nWGFM)
	this:Lookup("CheckBox_NGFM"):Check(SellDrug.nNGFM)
	this:Lookup("CheckBox_QXFM"):Check(SellDrug.nQXFM)
	this:Lookup("CheckBox_CHFM"):Check(SellDrug.nCHFM)
	this:Lookup("CheckBox_WGMZFM"):Check(SellDrug.nWGMZFM)
	this:Lookup("CheckBox_NGMZFM"):Check(SellDrug.nNGMZFM)
	this:Lookup("CheckBox_WXSJ"):Check(SellDrug.nWXSJ)
	this:Lookup("CheckBox_WXSM"):Check(SellDrug.nWXSM)
	this:Lookup("CheckBox_WXSS"):Check(SellDrug.nWXSS)
	this:Lookup("CheckBox_WXSH"):Check(SellDrug.nWXSH)
	this:Lookup("CheckBox_WXST"):Check(SellDrug.nWXST)
	this:Lookup("CheckBox_XPWLD"):Check(SellDrug.nJLHF)
	this:Lookup("CheckBox_ZPNSD"):Check(SellDrug.nTLHF)
	this:Lookup("CheckBox_ZPCSD"):Check(SellDrug.nHXXG)
end

function SellDrug.OnLButtonClick()
	local szName = this:GetName()
	local frame = Station.Lookup("Normal/SellDrug")
	if szName == "Button_Close" then
		if not frame then
			return
		end
		frame:Hide()
	end
	if szName == "Button_All" then
		frame:Lookup("CheckBox_Zphld"):Check(true)
		frame:Lookup("CheckBox_Zpzxd"):Check(true)
		frame:Lookup("CheckBox_Tzdt"):Check(true)
		frame:Lookup("CheckBox_Ggdt"):Check(true)
		frame:Lookup("CheckBox_Yqdt"):Check(true)
		frame:Lookup("CheckBox_Sfdt"):Check(true)
		frame:Lookup("CheckBox_Lddt"):Check(true)
		frame:Lookup("CheckBox_Nggj"):Check(true)
		frame:Lookup("CheckBox_Wggj"):Check(true)
		frame:Lookup("CheckBox_Fjch"):Check(true)
		frame:Lookup("CheckBox_Zldt"):Check(true)
		frame:Lookup("CheckBox_NGHX"):Check(true)
		frame:Lookup("CheckBox_WGHX"):Check(true)
		frame:Lookup("CheckBox_WGYX"):Check(true)
		frame:Lookup("CheckBox_NGYX"):Check(true)
		frame:Lookup("CheckBox_LSYX"):Check(true)
		frame:Lookup("CheckBox_CHYX"):Check(true)
		frame:Lookup("CheckBox_QXYX"):Check(true)
		frame:Lookup("CheckBox_XYS"):Check(true)
		frame:Lookup("CheckBox_FYW"):Check(true)
		frame:Lookup("CheckBox_BLD"):Check(true)
		frame:Lookup("CheckBox_YJFM"):Check(true)
		frame:Lookup("CheckBox_HJFM"):Check(true)
		frame:Lookup("CheckBox_ZLFM"):Check(true)
		frame:Lookup("CheckBox_WGFM"):Check(true)
		frame:Lookup("CheckBox_NGFM"):Check(true)
		frame:Lookup("CheckBox_QXFM"):Check(true)
		frame:Lookup("CheckBox_CHFM"):Check(true)
		frame:Lookup("CheckBox_WGMZFM"):Check(true)
		frame:Lookup("CheckBox_NGMZFM"):Check(true)
		frame:Lookup("CheckBox_WXSJ"):Check(true)
		frame:Lookup("CheckBox_WXSM"):Check(true)
		frame:Lookup("CheckBox_WXSS"):Check(true)
		frame:Lookup("CheckBox_WXSH"):Check(true)
		frame:Lookup("CheckBox_WXST"):Check(true)
		frame:Lookup("CheckBox_XPWLD"):Check(true)
		frame:Lookup("CheckBox_ZPNSD"):Check(true)
		frame:Lookup("CheckBox_ZPCSD"):Check(true)
	end
	if szName == "Button_UnAll" then
		frame:Lookup("CheckBox_Zphld"):Check(false)
		frame:Lookup("CheckBox_Zpzxd"):Check(false)
		frame:Lookup("CheckBox_Tzdt"):Check(false)
		frame:Lookup("CheckBox_Ggdt"):Check(false)
		frame:Lookup("CheckBox_Yqdt"):Check(false)
		frame:Lookup("CheckBox_Sfdt"):Check(false)
		frame:Lookup("CheckBox_Lddt"):Check(false)
		frame:Lookup("CheckBox_Nggj"):Check(false)
		frame:Lookup("CheckBox_Wggj"):Check(false)
		frame:Lookup("CheckBox_Fjch"):Check(false)
		frame:Lookup("CheckBox_Zldt"):Check(false)
		frame:Lookup("CheckBox_NGHX"):Check(false)
		frame:Lookup("CheckBox_WGHX"):Check(false)
		frame:Lookup("CheckBox_WGYX"):Check(false)
		frame:Lookup("CheckBox_NGYX"):Check(false)
		frame:Lookup("CheckBox_LSYX"):Check(false)
		frame:Lookup("CheckBox_CHYX"):Check(false)
		frame:Lookup("CheckBox_QXYX"):Check(false)
		frame:Lookup("CheckBox_XYS"):Check(false)
		frame:Lookup("CheckBox_FYW"):Check(false)
		frame:Lookup("CheckBox_BLD"):Check(false)
		frame:Lookup("CheckBox_YJFM"):Check(false)
		frame:Lookup("CheckBox_HJFM"):Check(false)
		frame:Lookup("CheckBox_ZLFM"):Check(false)
		frame:Lookup("CheckBox_WGFM"):Check(false)
		frame:Lookup("CheckBox_NGFM"):Check(false)
		frame:Lookup("CheckBox_QXFM"):Check(false)
		frame:Lookup("CheckBox_CHFM"):Check(false)
		frame:Lookup("CheckBox_WGMZFM"):Check(false)
		frame:Lookup("CheckBox_NGMZFM"):Check(false)
		frame:Lookup("CheckBox_WXSJ"):Check(false)
		frame:Lookup("CheckBox_WXSM"):Check(false)
		frame:Lookup("CheckBox_WXSS"):Check(false)
		frame:Lookup("CheckBox_WXSH"):Check(false)
		frame:Lookup("CheckBox_WXST"):Check(false)
		frame:Lookup("CheckBox_XPWLD"):Check(false)
		frame:Lookup("CheckBox_ZPNSD"):Check(false)
		frame:Lookup("CheckBox_ZPCSD"):Check(false)
	end
end


function SellDrug.OnCheckBoxCheck()
	local szName = this:GetName()
	if szName == "CheckBox_Zphld"  then
		SellDrug.nZphld = 1
	end
	if szName == "CheckBox_Zpzxd"  then
		SellDrug.nZpzxd = 1
	end
	if szName == "CheckBox_Tzdt"  then
		SellDrug.nTzdt = 1
	end
	if szName == "CheckBox_Ggdt"  then
		SellDrug.nGgdt = 1
	end
	if szName == "CheckBox_Yqdt"  then
		SellDrug.nYqdt = 1
	end
	if szName == "CheckBox_Sfdt"  then
		SellDrug.nSfdt = 1
	end
	if szName == "CheckBox_Lddt"  then
		SellDrug.nLddt = 1
	end
	if szName == "CheckBox_Nggj"  then
		SellDrug.nNggj = 1
	end
	if szName == "CheckBox_Wggj"  then
		SellDrug.nWggj = 1
	end
	if szName == "CheckBox_Fjch"  then
		SellDrug.nFjch = 1
	end
	if szName == "CheckBox_Zldt"  then
		SellDrug.nCZZ = 1
	end
	if szName == "CheckBox_NGHX"  then
		SellDrug.nNGHX = 1
	end
	if szName == "CheckBox_WGHX"  then
		SellDrug.nWGHX = 1
	end
	if szName == "CheckBox_WGYX"  then
		SellDrug.nQXSX = 1
	end
	if szName == "CheckBox_NGYX"  then
		SellDrug.nNLSX = 1
	end
	if szName == "CheckBox_LSYX"  then
		SellDrug.nCBRD = 1
	end
	if szName == "CheckBox_CHYX"  then
		SellDrug.nTCMR = 1
	end
	if szName == "CheckBox_QXYX"  then
		SellDrug.nQXYX = 1
	end
	if szName == "CheckBox_XYS"  then
		SellDrug.nXYS = 1
	end
	if szName == "CheckBox_FYW"  then
		SellDrug.nFYW = 1
	end
	if szName == "CheckBox_BLD"  then
		SellDrug.nDSFM = 1
	end
	if szName == "CheckBox_YJFM"  then
		SellDrug.nYJFM = 1
	end
	if szName == "CheckBox_HJFM"  then
		SellDrug.nHJFM = 1
	end
	if szName == "CheckBox_ZLFM"  then
		SellDrug.nZLFM = 1
	end
	if szName == "CheckBox_WGFM"  then
		SellDrug.nWGFM = 1
	end
	if szName == "CheckBox_NGFM"  then
		SellDrug.nNGFM = 1
	end
	if szName == "CheckBox_QXFM"  then
		SellDrug.nQXFM = 1
	end
	if szName == "CheckBox_CHFM"  then
		SellDrug.nCHFM = 1
	end
	if szName == "CheckBox_WGMZFM"  then
		SellDrug.nWGMZFM = 1
	end
	if szName == "CheckBox_NGMZFM"  then
		SellDrug.nNGMZFM = 1
	end
	if szName == "CheckBox_WXSJ"  then
		SellDrug.nWXSJ = 1
	end
	if szName == "CheckBox_WXSM"  then
		SellDrug.nWXSM = 1
	end
	if szName == "CheckBox_WXSS"  then
		SellDrug.nWXSS = 1
	end
	if szName == "CheckBox_WXSH"  then
		SellDrug.nWXSH= 1
	end
	if szName == "CheckBox_WXST"  then
		SellDrug.nWXST = 1
	end
	if szName == "CheckBox_XPWLD"  then
		SellDrug.nJLHF = 1
	end
	if szName == "CheckBox_ZPNSD"  then
		SellDrug.nTLHF = 1
	end
	if szName == "CheckBox_ZPCSD"  then
		SellDrug.nHXXG = 1
	end
	if szName == "CheckBox_Open"  then
		SellDrug.nOpen = 1
	end
end

function SellDrug.OnCheckBoxUncheck()
	local szName = this:GetName()
	if szName == "CheckBox_Zphld" then
		SellDrug.nZphld = 0
	end
	if szName == "CheckBox_Zpzxd" then
		SellDrug.nZpzxd = 0
	end
	if szName == "CheckBox_Tzdt"  then
		SellDrug.nTzdt = 0
	end
	if szName == "CheckBox_Ggdt"  then
		SellDrug.nGgdt = 0
	end
	if szName == "CheckBox_Yqdt"  then
		SellDrug.nYqdt = 0
	end
	if szName == "CheckBox_Sfdt"  then
		SellDrug.nSfdt = 0
	end
	if szName == "CheckBox_Lddt"  then
		SellDrug.nLddt = 0
	end
	if szName == "CheckBox_Nggj"  then
		SellDrug.nNggj = 0
	end
	if szName == "CheckBox_Wggj"  then
		SellDrug.nWggj = 0
	end
	if szName == "CheckBox_Fjch"  then
		SellDrug.nFjch = 0
	end
	if szName == "CheckBox_Zldt"  then
		SellDrug.nCZZ = 0
	end
	if szName == "CheckBox_NGHX"  then
		SellDrug.nNGHX = 0
	end
	if szName == "CheckBox_WGHX"  then
		SellDrug.nWGHX = 0
	end
	if szName == "CheckBox_WGYX"  then
		SellDrug.nQXSX = 0
	end
	if szName == "CheckBox_NGYX"  then
		SellDrug.nNLSX = 0
	end
	if szName == "CheckBox_LSYX"  then
		SellDrug.nCBRD = 0
	end
	if szName == "CheckBox_CHYX"  then
		SellDrug.nTCMR = 0
	end
	if szName == "CheckBox_QXYX"  then
		SellDrug.nQXYX = 0
	end
	if szName == "CheckBox_XYS"  then
		SellDrug.nXYS = 0
	end
	if szName == "CheckBox_FYW"  then
		SellDrug.nFYW = 0
	end
	if szName == "CheckBox_BLD"  then
		SellDrug.nDSFM = 0
	end
	if szName == "CheckBox_YJFM"  then
		SellDrug.nYJFM = 0
	end
	if szName == "CheckBox_HJFM"  then
		SellDrug.nHJFM = 0
	end
	if szName == "CheckBox_ZLFM"  then
		SellDrug.nZLFM = 0
	end
	if szName == "CheckBox_WGFM"  then
		SellDrug.nWGFM = 0
	end
	if szName == "CheckBox_NGFM"  then
		SellDrug.nNGFM = 0
	end
	if szName == "CheckBox_QXFM"  then
		SellDrug.nQXFM = 0
	end
	if szName == "CheckBox_CHFM"  then
		SellDrug.nCHFM = 0
	end
	if szName == "CheckBox_WGMZFM"  then
		SellDrug.nWGMZFM = 0
	end
	if szName == "CheckBox_NGMZFM"  then
		SellDrug.nNGMZFM = 0
	end
	if szName == "CheckBox_WXSJ"  then
		SellDrug.nWXSJ = 0
	end
	if szName == "CheckBox_WXSM"  then
		SellDrug.nWXSM = 0
	end
	if szName == "CheckBox_WXSS"  then
		SellDrug.nWXSS =0
	end
	if szName == "CheckBox_WXSH"  then
		SellDrug.nWXSH= 0
	end
	if szName == "CheckBox_WXST"  then
		SellDrug.nWXST = 0
	end
	if szName == "CheckBox_XPWLD"  then
		SellDrug.nJLHF = 0
	end
	if szName == "CheckBox_ZPNSD"  then
		SellDrug.nTLHF = 0
	end
	if szName == "CheckBox_ZPCSD"  then
		SellDrug.nHXXG = 0
	end
	if szName == "CheckBox_Open"  then
		SellDrug.nOpen = 0
	end

end
RegisterEvent("SYS_MSG", function()
	if arg0 == "UI_OME_DEATH_NOTIFY" then
		SellDrug.OnUserKilled(arg1, arg3)
	end
end)
function SellDrug.OnUserKilled(dwID, szKiller)
	local killer=GetPlayer(dwID) or GetNpc(dwID)
        OutputMessage("MSG_SYS","["..szKiller.."]��ɱ["..killer.szName.."]\n")		--ս����¼���ǡ�A''������"B"
end
function SellDrug.OnOpenShop()
	local nNpcID, nShopID = arg4, arg0
	SellDrug.SellItemBy(nNpcID, nShopID)
end
SellsGood="55797,55798,55799,55800,55801,55802,73209,73210,72772,72824,73118,73276,73638,72918,72919,72920,72944,72945,72949,72946,72950,72951,73090,73100,73109,72925,72923,72934,72941,73091,73092,73093,73095,72757,72756,72761,72762,72924,73099,73101,3752,4595,4596,5095,73831,73817,73811"
function SellDrug.SellItemBy(nNpcID, nShopID)
	local player = GetClientPlayer()
	if SellDrug.nOpen==0 then
		return
	end

	for i = 1, 5 do	 				--1,4�ɱ������һ������
		local dwBox = INVENTORY_INDEX.PACKAGE + i - 1
		local dwSize = player.GetBoxSize(dwBox) - 1	 	--    "-3"�ɱ���ÿ�������������
		for dwX = 0, dwSize, 1 do
		     local item = GetPlayerItem(player, dwBox, dwX)
		     local nCount = 1
		     if item.nGenre == ITEM_GENRE.EQUIPMENT and item.nSub == EQUIPMENT_SUB.ARROW then --Զ������
		         nCount = item.nCurrentDurability
		      elseif item.bCanStack then
		         nCount = item.nStackNum
		     end
            local uiid=item.nUiId --�����Ʒ��UIID
            if SellDrug.nZphld == 0 then
		if uiid==72836 then --��Ʒ���絤
			SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
		end
	    end
            if SellDrug.nZpzxd == 0 then
		if uiid==72835 then --��ƷֹѪ��
			SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
		end
            end
            if SellDrug.nTzdt == 0 then
		if uiid==72751 or uiid==72825 then --���ʵ���-����ǿ�����Ͱٻ�����
			SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
		end
            end
            if SellDrug.nGgdt == 0 then
		if uiid==72752 or uiid==72826 then --���ǵ���
			SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
		end
            end
	    if SellDrug.nLddt == 0 then
				if uiid==72753 or uiid==72827  then --��������
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nYqdt == 0 then
				if uiid==72754 or uiid==72828 then --Ԫ������
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nSfdt == 0 then
				if uiid==72755 or uiid==72829 then --������
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nNggj == 0 then
				if uiid==72759 or uiid==72833 or uiid==73115 then --�ڹ���������-�������o����Ʒչ�ﵤ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nWggj == 0 then
				if uiid==72758 or uiid==72832 or uiid==73117 then --�⹦��������-������Ǵ����Ʒ������
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nFjch == 0 then
				if uiid==72768 or uiid==72840 then --���ӳ�޵���-��ǲ����Ʒ�ƻ൤
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nCZZ == 0 then
				if uiid==72763 or uiid==72837 then --����������Ʒ��־��(����ֵ)
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nNGHX == 0 then
				if uiid==72765 or uiid==72766 or uiid==72838 then --��Ƥ��צ���ڹ��Ʒ���
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nWGHX == 0 then
				if uiid==72764 or uiid==72767 or uiid==72839 then --��˿����⣨�⹦�Ʒ���
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
             if SellDrug.nQXSX == 0 then
				if uiid==72830 then --��Ʒ����������Ѫ���ޣ�
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nNLSX == 0 then
				if uiid==72831 then --��Ʒ���񵤣��������ޣ�
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nCBRD == 0 then
				if uiid==72760 or uiid==72834 then --������ϯ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nTCMR == 0 then
				if uiid==4542 then --�����ϯ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nQXYX == 0 then
				if uiid==72771 then --��ˮܽ����
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nXYS == 0 then
				if uiid==673 then --��ңɢ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nFYW == 0 then
				if uiid==622 then --������
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nDSFM == 0 then
				if uiid==72922 or uiid==72948 then --������ħ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nYJFM == 0 then
				if uiid==72926 or uiid==72952  then --������ħ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nHJFM== 0 then
				if uiid==72927 or uiid==72953  then --������ħ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nZLFM == 0 then
				if uiid==72932 or uiid==72939 or uiid==73112 or uiid==73116  then --���Ƹ�ħ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nWGFM == 0 then
		if uiid==72928 or uiid==72930 or uiid==72935 or uiid==72937 or uiid==73110 or uiid==73113 or uiid==73114 or uiid==73105 or uiid==73102 then --�⹦��ħ
			SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
		end
            end
            if SellDrug.nNGFM == 0 then
		if uiid==72931 or uiid==72933 or uiid==72936 or uiid==72938 or uiid==72940 or uiid==73106 or uiid==73096 or uiid==72929 or uiid==73103 or uiid==73111 then 
--�ڹ���ħ
			SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
		end
            end
            if SellDrug.nQXFM == 0 then
		if uiid==72916 or uiid==72917 or uiid==72942 or uiid==72945 or uiid==72919 or uiid==72943 then  --��Ѫ��ħ
			SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
		end
            end
            if SellDrug.nCHFM == 0 then
				if uiid==73104 or uiid==73094 or uiid==72947 or uiid==72921 then --��޲��и�ħ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nWGMZFM == 0 then
				if uiid==73097 or uiid==73107  then --�⹦���и�ħ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nNGMZFM == 0 then
				if uiid==73108 or uiid==73098 then --�ڹ����и�ħ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nWXSJ == 0 then
				if uiid==65901 then --����ʯ����
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nWXSM == 0 then
				if uiid==65912 then --����ʯ��ľ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nWXSS == 0 then
				if uiid==65922 then --����ʯ��ˮ
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nWXSH == 0 then
				if uiid==65932 then --����ʯ����
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nWXST == 0 then
				if uiid==65942 then --����ʯ����
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nJLHF == 0 then
				if uiid==72769 then --����
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nTLHF == 0 then
				if uiid==72770 then --����
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
            if SellDrug.nHXXG == 0 then
				if uiid==72534 then --��Ʒ������
					SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
				end
            end
 	    if string.find(SellsGood,uiid) or (uiid>=4100 and uiid<=4200) or (uiid>=4900 and uiid<=5000) or (uiid>=65900 and uiid<=65955) then
	    	SellItem(nNpcID, nShopID, dwBox, dwX, nCount)
	    end
	  end
    end
end
function SellDrug._OpenWindow()
	local frame = Station.Lookup("Normal/SellDrug")
	if frame then
		if frame:IsVisible() then
			frame:Hide()
		else
			frame:Show()
		end
	else
		frame = Wnd.OpenWindow("Interface\\TF\\SellDrug\\SellDrug.ini","SellDrug")
		frame:Show()
	end
end

SellDrug.OpenMenu = function()
local drugmenu =
{
          szOption = "���Է�ˢҩ����",
          {szOption = "���������", bMCheck=false,bCheck=false,fnAction=function()
	     	SellDrug._OpenWindow()
	      end},
          {bDevide = true,},
          {szOption = "By ���Է������", bMCheck=false,bCheck=false}
}
return drugmenu
end


RegisterEvent("SHOP_OPENSHOP", SellDrug.OnOpenShop)
RegisterEvent("LOGIN_GAME", function()
	local tMenu = {
		function()
			return {SellDrug.OpenMenu()}
		end,
	}
	Player_AppendAddonMenu(tMenu)
end)
OutputMessage("MSG_SYS","���Է�ˢҩ����V3.1.0 ���سɹ�\n")

function  SellDrug.RegAddonModInfo()
	local tDataSellDrug={
		szName = "SellDrug",										 
		szTitle = "ˢҩ����",										 
		dwIcon = 4460,												 
		szClass = "TOOL",	
		tWidget={
			{
				tag = "SellDrug_OpenWnd", type = "WndButton",					 
				w = 100, h = 29, text = "���������",					 
				anchor = "TOPLEFT", x = 0, y = 0,					 
				callback = function()								 
					SellDrug._OpenWindow()
				end
			},
			{	tag = "SellDrug_ShuoMing", type = "WndTextBox", 					 
				w = 480, h = 28, text = "������˵����ˢҩ���������Զ�����",					 
				anchor = "TOPLEFT", x = 0, y = 30,					 
			},{	tag = "SellDrug_zhuyi", type = "WndTextBox", 					 
				w = 480, h = 28, text = "��ʹ��ע�⡿��������年ѡҪ��������Ʒ",				 
				anchor = "TOPLEFT", x = 0, y = 60,					 
			},{	tag = "SellDrug_zhuyi2", type = "WndTextBox", 					 
				w = 480, h = 28, text = "ǿ�ҽ���ʹ��֮ǰ����������Ҫ�Ķ�����ֿ⣡",	 fontcolor={255,255,0},				 
				anchor = "TOPLEFT", x = 0, y = 90,					 
			},
			{	tag = "SellDrug_Author", type = "WndTextBox", 					 
				w = 160, h = 28, text = "By ��죬��ͨһ/���� ��� �Ϲٽ���", fontcolor={0,255,255},					 
				anchor = "TOPLEFT", x = 170, y = 330, 					 
			},
		},
	}

	CUIRegAddonModInfo(tDataSellDrug)	
end

RegisterEvent("CUSTOM_DATA_LOADED", function()						 
	if arg0 == "Role" then
		SellDrug.RegAddonModInfo()
	end
end)

