<% 
class JCP_Template
	private Blocks
	private ClassID,TemplateGuideOrder,TemplateTableID
	private TemplateType,TemplateID
	private ArticleID
	private ListBlockID,ListPage,ListOver
	public TemplateResult,TemplateRecordBlocksYN,PushPath,PushList
	
	
	public sub Open()
		ClassID=""
		TemplateGuideOrder=1
		TemplateType=-1
		TemplateID=0
		ArticleID=0
		ListBlockID=0
		ListPage=0
		ListOver=true
		TemplateResult=""
		TemplateRecordBlocksYN=true
		PushPath=""
		PushList=""
		if TemplateRecordBlocksYN then set Blocks=server.CreateObject("Scripting.Dictionary")
	end sub
	
	public sub Close()
		if TemplateRecordBlocksYN then
			Blocks.RemoveAll
			set Blocks=nothing
		end if
	end sub
	
	public function BlockAdd(tblockid,tblockcontent)
		Blocks(tblockid)=tblockcontent
	end function
	
	public function BlockDelete(tblockid)
		if BlockExists(tblockid) then Blocks(tblockid)=""
	end function
	
	public function BlockCount()
		BlockCount=Blocks.count
	end function
		
	public function BlockExists(tblockid)
		if TemplateRecordBlocksYN then 
			if isempty(Blocks(tblockid)) or Blocks(tBlockid)="" then
				BlockExists=false
			elseif Blocks(tblockid)<>"" then
				BlockExists=true
			else
				BlockExists=false
			end if
		else
			BlockExists=false
		end if
	end function
	
	public function BlockComplete(tblockid,curJCP)
		if BlockExists(tblockid) then
			BlockComplete=Blocks(tblockid)
		else
			dim blockrs
			set blockrs=curJCP.Data.Exe("select * from JCP_BlockList where id="&tblockid)
			if blockrs.eof then
				BlockComplete=false
				TemplateResult="��������ģ�鲻���ڣ�"
			else
				on error resume next
				err.clear
				'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				dim BlockAttribute,BlockHTML      '�̶����ݲ����������޸�
				'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
				BlockAttribute=blockrs("BlockAttribute")
				'ģ�鴦�����
				dim blockmanage
				if blockrs("blocktype")<3 then
					blockmanage=blockrs("blockmanage")
					execute replace(replace(blockmanage,"<"&"%",""),"%"&">","")
				elseif blockrs("blocktype")=3 then
					blockmanage=blockrs("blockmanage")
					execute replace(replace(blockmanage,"<"&"%",""),"%"&">","")
					curJCP.fso.FolderN curJCP.SiteRoot & curJCP.ScriptPath
					curJCP.fso.FileN curJCP.SiteRoot & curJCP.ScriptPath & "\" & blockrs("id") & ".js",BlockHTML
					PushList=PushList & "|" & curJCP.SiteUrlRoot & curJCP.ScriptPath & "/" & blockrs("id") & ".js"
					BlockHTML="<script language=""javascript"" src=""../../" & curJCP.ScriptPath & "/" & blockrs("id") & ".js""></script>"
				elseif blockrs("blocktype")=4 then
					BlockHTML=blockrs("BlockAttribute")
				elseif blockrs("blocktype")=5 then
					BlockHTML="<script language=""javascript"" src=""../../" & curJCP.ScriptPath & "/" & blockrs("id") & ".js""></script>"
				elseif blockrs("blocktype")=6 then
					BlockHTML="<script language=""javascript"" src=""../../" & curJCP.ScriptPath & "/" & blockrs("id") & ".vb""></script>"
				end if
				'��ȡ���
				if err>0 then
					TemplateResult="ģ���"&blockrs("blockname")&"�� ִ��ʱ�����ˣ�<br>ԭ��"&err.description
					BlockComplete=TemplateResult
					err.clear
				else
					if TemplateRecordBlocksYN then 'ĳЩģ�鴦��������Ա������ڴ��У��Թ������ģ��ʹ�ã���������������ٶ�
						if blockrs("blocktype")=3 or blockrs("blocktype")=4 or blockrs("blocktype")=5 or blockrs("blocktype")=6 then Blocks(tblockid)=BlockHTML
					end if
					BlockComplete=BlockHTML
				end if
				blockrs.close
			end if
		end if
	end function
	
	private function GetClass(classinfos)          '��ģ�����Ŀ�������л�ȡ��Ŀ���
		dim paramclasses,paramclassid(),classi,app,classinfo
		paramclasses=split(classinfos,",|")
		redim paramclassid(ubound(paramclasses))
		for classi=0 to ubound(paramclasses)
			execute "paramclassid(classi)=array(" & right(paramclasses(classi),len(paramclasses(classi))-1) & ")"
		next
		for classi=0 to ubound(paramclasses)
			app=app & string(classi,"	") & "for JCP_class"&classi&"=0 to ubound(paramclassid("&classi&"))" & vbcrlf
		next
		for classi=0 to ubound(paramclasses)
			if classi=0 then
				app=app & string(ubound(paramclasses)+1,"	") & "classinfo=classinfo & paramclassid("&classi&")(JCP_class"&classi&")" & vbcrlf
			else
				app=app & string(ubound(paramclasses)+1,"	") & "classinfo=classinfo & ""&"" & paramclassid("&classi&")(JCP_class"&classi&")" & vbcrlf
			end if
			if classi=ubound(paramclasses) then app=app & string(ubound(paramclasses)+1,"	") & "classinfo=classinfo & ""|""" & vbcrlf
		next
		for classi=0 to ubound(paramclasses)
			app=app & string(ubound(paramclasses)-classi,"	") & "next" & vbcrlf
		next
		execute app
		GetClass=classinfo
	end function
	
	private function GetTemplateClassSQL(classinfo)      '��Ŀ��Ϣת��Ϊ��Ӧ ģ�� ���ݱ��SQL�﷨
		GetTemplateClassSQL=""
		dim infos,paraminfo,infoi
		infos=split(classinfo,"&")
		for infoi=0 to ubound(infos)
			if instr(infos(infoi),"=")>0 then
				paraminfo=split(infos(infoi),"=")
				if GetTemplateClassSQL="" then GetTemplateClassSQL="%,"&paraminfo(1)&",%" else GetTemplateClassSQL=GetTemplateClassSQL & "|%,"&paraminfo(1)&",%"
			else
				if GetTemplateClassSQL="" then GetTemplateClassSQL="%,"&infos(infoi)&",%" else GetTemplateClassSQL=GetTemplateClassSQL & "|%,"&infos(infoi)&",%"
			end if
		next
		if GetTemplateClassSQL<>"" then GetTemplateClassSQL="and TemplateClassIDs & ',' like '" & GetTemplateClassSQL & "'"
	end function
	
	private function GetArticleClassSQL(classinfo,tableid,curJCP)      '��Ŀ��Ϣת��Ϊ��Ӧ ���� ���ݱ��SQL�﷨
		GetArticleClassSQL=""
		dim artrs,arti,infos
		infos=split(classinfo,"&")
		artrs=curJCP.Data.GetRows("select item_id from JCP_ArtSys where item_type='class' and sys_id="&tableid&" order by item_order")
		if not isempty(artrs) then
			for arti=0 to ubound(artrs,2)
				if GetArticleClassSQL="" then
					GetArticleClassSQL= " where " & artrs(0,arti) & "_class=" & infos(arti)
				else
					GetArticleClassSQL=GetArticleClassSQL & " and " & artrs(0,arti) & "_class=" & infos(arti)
				end if
			next
		end if
	end function
	
	public function PushIndex(arguments)
		dim trs,ti
		if ubound(arguments)=0 and typename(arguments(0))="JCP" then          'arguments����Ϊ1��curJCP
			trs=arguments(0).Data.GetRows("select id from JCP_Template where TemplateType=4")
			if not isempty(trs) then
				for ti=0 to ubound(trs,2)
					PushIndex=PushIndex(array(trs(0,ti),arguments(0)))                   '���������templateid,curJCP
				next
			else
				PushIndex=false
				TemplateResult="��������վ��ҳģ�壡"
			end if
		elseif ubound(arguments)=1 and typename(arguments(1))="JCP" then        'arguments����Ϊ2��templateid,curJCP
			PushIndex=PushByIndex(arguments(0),arguments(1))
		else
			PushIndex=false
			TemplateResult="������վ��ҳʱ�����δ���"
		end if
	end function
	
	public function PushSole(arguments)
		dim trs,ti
		if ubound(arguments)=0 and typename(arguments(ubound(arguments)))="JCP" then          'arguments����Ϊ1��curJCP
			trs=arguments(0).Data.GetRows("select id from JCP_Template where TemplateType=3")
			if not isempty(trs) then
				for ti=0 to ubound(trs,2)
					PushSole=PushSole(array(trs(0,ti),arguments(0)))                   '���������templateid,curJCP
				next
			else
				PushSole=false
				TemplateResult="�����ڶ���ģ�壡"
			end if
		elseif ubound(arguments)=1 and typename(arguments(ubound(arguments)))="JCP" then        'arguments����Ϊ2��templateid,curJCP
			PushSole=PushBySole(arguments(0),arguments(1))
		else
			PushSole=false
			TemplateResult="���Ͷ���ģ��ʱ�����δ���"
		end if
	end function
	
	public function PushClassIndex(arguments)
		dim trs,ti,classinfos,classi
		if ubound(arguments)=0 and typename(arguments(ubound(arguments)))="JCP" then          'arguments����Ϊ1��curJCP
			dim trs0,ti0
			trs0=arguments(0).Data.GetRows("select id from JCP_Template where TemplateType=0")
			if not isempty(trs0) then
				for ti0=0 to ubound(trs0,2)
					PushClassIndex=PushClassIndex(array(trs0(0,ti0),arguments(0)))                   '���������templateid,curJCP
				next
			else
				PushClassIndex=false
				TemplateResult="δ�ҵ��κ���Ŀ����ҳģ�壡"
			end if
		elseif ubound(arguments)=1 and typename(arguments(ubound(arguments)))="JCP" then          'arguments����Ϊ2��classinfo,curJCP �� templateid,curJCP
			dim trs1,ti1
			if typename(arguments(0))="String" then  'classinfo,curJCP
				trs1=arguments(1).Data.GetRows("select id from JCP_Template where TemplateType=0 "&GetTemplateClassSQL(arguments(0)))
				if not isempty(trs1) then
					for ti1=0 to ubound(trs1,2)
						PushClassIndex=PushClassIndex(array(arguments(0),trs1(0,ti1),arguments(1)))                   '���������classinfo,templateid,curJCP
					next
				else
					PushClassIndex=false
					TemplateResult="�����ڵ�ǰ��Ŀ����ҳģ�壡"
				end if
			elseif typename(arguments(0))="Long" or typename(arguments(0))="Integer" then   'templateid,curJCP
				trs1=arguments(1).Data.GetRows("select TemplateClassIDs from JCP_Template where TemplateType=0 and id="&arguments(0))
				if not isempty(trs1) then
					for ti1=0 to ubound(trs1,2)
						if instr(trs1(0,ti1),",")>0 then
							classinfos=split(GetClass(trs1(0,ti1)),"|")
							for classi=0 to ubound(classinfos)-1
								PushClassIndex=PushClassIndex(array(classinfos(classi),arguments(0),arguments(1)))                   '���������classinfo,templateid,curJCP
							next
						else
							PushClassIndex=false
							TemplateResult="��ǰ��ҳģ��δ�����κ���Ŀ��"
						end if
					next
				else
					PushClassIndex=false
					TemplateResult="��ǰģ�岢����ҳģ�壡"
				end if
			else
				PushClassIndex=false
				TemplateResult="������Ŀ��ҳʱ������δ֪��������"
			end if
		elseif ubound(arguments)=2 and typename(arguments(ubound(arguments)))="JCP" then        'arguments����Ϊ3��classinfo,templateid,curJCP
			PushClassIndex=PushByClassIndex(arguments(0),arguments(1),arguments(2))
		else
			PushClassIndex=false
			TemplateResult="������Ŀ��ҳʱ�����δ���"
		end if
	end function
	
	public function PushClassList(arguments)
		dim trs,ti,classinfos,classi
		if ubound(arguments)=0 and typename(arguments(ubound(arguments)))="JCP" then          'arguments����Ϊ1��curJCP
			dim trs0,ti0
			trs0=arguments(0).Data.GetRows("select id from JCP_Template where TemplateType=1")
			if not isempty(trs0) then
				for ti0=0 to ubound(trs0,2)
					PushClassList=PushClassList(array(trs0(0,ti0),arguments(0)))                   '���������templateid,curJCP
				next
			else
				PushClassList=false
				TemplateResult="δ�ҵ��κ���Ŀ���б�ģ�壡"
			end if
		elseif ubound(arguments)=1 and typename(arguments(ubound(arguments)))="JCP" then          'arguments����Ϊ2��classinfo,curJCP �� templateid,curJCP
			dim trs1,ti1
			if typename(arguments(0))="String" then  'classinfo,curJCP
				trs1=arguments(1).Data.GetRows("select id from JCP_Template where TemplateType=1 "&GetTemplateClassSQL(arguments(0)))
				if not isempty(trs1) then
					for ti1=0 to ubound(trs1,2)
						PushClassList=PushClassList(array(arguments(0),trs1(0,ti1),arguments(1)))                   '���������classinfo,templateid,curJCP
					next
				else
					PushClassList=false
					TemplateResult="�����ڵ�ǰ��Ŀ����ҳģ�壡"
				end if
			elseif typename(arguments(0))="Long" or typename(arguments(0))="Integer" then   'templateid,curJCP
				trs1=arguments(1).Data.GetRows("select TemplateClassIDs from JCP_Template where TemplateType=1 and id="&arguments(0))
				if not isempty(trs1) then
					for ti1=0 to ubound(trs1,2)
						if instr(trs1(0,ti1),",")>0 then
							classinfos=split(GetClass(trs1(0,ti1)),"|")
							for classi=0 to ubound(classinfos)-1
								PushClassList=PushClassList(array(classinfos(classi),arguments(0),arguments(1)))                   '���������classinfo,templateid,curJCP
							next
						else
							PushClassList=false
							TemplateResult="��ǰ�б�ģ��δ�����κ���Ŀ��"
						end if
					next
				else
					PushClassList=false
					TemplateResult="��ǰģ�岢���б�ģ�壡"
				end if
			else
				PushClassList=false
				TemplateResult="������Ŀ�б�ʱ������δ֪��������"
			end if
		elseif ubound(arguments)=2 and typename(arguments(ubound(arguments)))="JCP" then        'arguments����Ϊ3��classinfo,templateid,curJCP
			PushClassList=PushByClassList(arguments(0),arguments(1),arguments(2))
		else
			PushClassList=false
			TemplateResult="������Ŀ�б�ʱ�����δ���"
		end if
	end function
	
	public function PushClassContent(arguments)
		dim trs,ti,classinfos,classi
		if ubound(arguments)=0 and typename(arguments(ubound(arguments)))="JCP" then          'arguments����Ϊ1��curJCP
			dim trs0,ti0
			trs0=arguments(0).Data.GetRows("select id from JCP_Template where TemplateType=2")
			if not isempty(trs0) then
				for ti0=0 to ubound(trs0,2)
					PushClassContent=PushClassContent(array(trs0(0,ti0),arguments(0)))                   '���������templateid,curJCP
				next
			else
				PushClassContent=false
				TemplateResult="δ�ҵ��κ���Ŀ������ģ�壡"
			end if
		elseif ubound(arguments)=1 and typename(arguments(ubound(arguments)))="JCP" then          'arguments����Ϊ2��classinfo,curJCP �� templateid,curJCP
			dim trs1,ti1
			if typename(arguments(0))="String" then  'classinfo,curJCP
				trs1=arguments(1).Data.GetRows("select id from JCP_Template where TemplateType=2 "&GetTemplateClassSQL(arguments(0)))
				if not isempty(trs1) then
					for ti1=0 to ubound(trs1,2)
						PushClassContent=PushClassContent(array(arguments(0),trs1(0,ti1),arguments(1)))                   '���������classinfo,templateid,curJCP
					next
				else
					PushClassContent=false
					TemplateResult="�����ڵ�ǰ��Ŀ������ģ�壡"
				end if
			elseif typename(arguments(0))="Long" or typename(arguments(0))="Integer" then   'templateid,curJCP
				trs1=arguments(1).Data.GetRows("select TemplateClassIDs from JCP_Template where TemplateType=2 and id="&arguments(0))
				if not isempty(trs1) then
					for ti1=0 to ubound(trs1,2)
						if instr(trs1(0,ti1),",")>0 then
							classinfos=split(GetClass(trs1(0,ti1)),"|")
							for classi=0 to ubound(classinfos)-1
								PushClassContent=PushClassContent(array(classinfos(classi),arguments(0),arguments(1)))                   '���������classinfo,templateid,curJCP
							next
						else
							PushClassContent=false
							TemplateResult="��ǰ����ģ��δ�����κ���Ŀ��"
						end if
					next
				else
					PushClassContent=false
					TemplateResult="��ǰģ�岢������ģ�壡"
				end if
			else
				PushClassContent=false
				TemplateResult="������Ŀ����ʱ������δ֪��������"
			end if
		elseif ubound(arguments)=2 and typename(arguments(ubound(arguments)))="JCP" then          'arguments����Ϊ3��classinfo,templateid,curJCP �� classinfo,articleid,curJCP
			dim trs2,ti2,tableid
			if typename(arguments(0))="String" and (typename(arguments(1))="Long" or typename(arguments(1))="Integer") then  'classinfo,templateid,curJCP
				tableid=arguments(2).Data.GetRows("select TemplateTableID from JCP_Template where TemplateType=2 and id="&arguments(1))
				if not isempty(tableid) then
					trs2=arguments(2).Data.GetRows("select id from Article_"&tableid(0,0)&GetArticleClassSQL(arguments(0),tableid(0,0),arguments(2))&" order by id")
					if not isempty(trs2) then
						for ti2=0 to ubound(trs2,2)
							PushClassContent=PushClassContent(array(arguments(0),trs2(0,ti2),arguments(1),arguments(2)))                   '���������classinfo,articleid,templateid,curJCP
						next
					else
						PushClassContent=false
						TemplateResult="��ǰ��Ŀ�������ݼ�¼��"
					end if
				else
					PushClassContent=false
					TemplateResult="��ǰģ�岢������ģ�壡"
				end if
			elseif typename(arguments(0))="String" and typename(arguments(1))="String" then   'classinfo,articleid,curJCP
				trs2=arguments(2).Data.GetRows("select id from JCP_Template where TemplateType=2 "&GetTemplateClassSQL(arguments(0)))
				if not isempty(trs2) then
					for ti2=0 to ubound(trs2,2)
						PushClassContent=PushClassContent(array(arguments(0),arguments(1),trs2(0,ti2),arguments(2)))                   '���������classinfo,articleid,templateid,curJCP
					next
				else
					PushClassContent=false
					TemplateResult="�����ڵ�ǰ��Ŀ������ģ�壡"
				end if
			else
				PushClassContent=false
				TemplateResult="������Ŀ����ʱ������δ֪��������"
			end if
		elseif ubound(arguments)=3 and typename(arguments(ubound(arguments)))="JCP" then        'arguments����Ϊ4��classinfo,articleid,templateid,curJCP
			PushClassContent=PushByClassContent(arguments(0),arguments(1),arguments(2),arguments(3))
		else
			PushClassContent=false
			TemplateResult="������Ŀ����ʱ�����δ���"
		end if
	end function
	
	public function PushByIndex(t_templateid,curJCP)
		TemplateID=t_templateid
		TemplateType=4
		dim trs,tcode,tblockids,blockcontent,pushi
		trs=curJCP.Data.GetRows("select * from JCP_Template where TemplateType=4 and id="&t_templateid)
		if not isempty(trs) then
			dim re:set re=new RegExp
			re.IgnoreCase=True:re.Global=true
			tcode=trs(4,0)
			TemplateType=trs(3,0)
			TemplateGuideOrder=trs(7,0)
			TemplateTableID=trs(5,0)
			if trs(10,0)&""<>"" then
				tblockids=split(trs(10,0),",")
				for pushi=0 to ubound(tblockids)
					blockcontent=BlockComplete(tblockids(pushi),curJCP)
					re.pattern="<\s*block(?:(\s+blockid=""?"&tblockids(pushi)&"""?)+(\s+blockname=""?[^<>]+""?)?|(\s+blockname=""?[^<>]+""?)?(\s+blockid=""?"&tblockids(pushi)&"""?)+)+\s*>"
					tcode=re.replace(tcode,blockcontent)
				next
			end if
			tcode=replace(tcode,"../../","")
			if trs(8,0) then
				PushPath=curJCP.SiteUrlRoot & trs(9,0)
				curJCP.fso.FileN curJCP.SiteRoot & trs(9,0),tcode
			else
				PushPath=curJCP.SiteUrlRoot & curJCP.IndexName & "." & curJCP.FileExt
				curJCP.fso.FileN curJCP.SiteRoot & curJCP.IndexName & "." & curJCP.FileExt,tcode
			end if
			PushByIndex=PushPath
			PushList=PushList & "|" & PushPath
		else
			PushByIndex=false
			TemplateResult="�����ڵ�ǰ��վ��ҳģ�壡"
		end if	
	end function
	
	public function PushBySole(t_templateid,curJCP)
		TemplateID=t_templateid
		TemplateType=3
		dim trs,tcode,tblockids,blockcontent,pushi
		trs=curJCP.Data.GetRows("select * from JCP_Template where TemplateType=3 and id="&t_templateid)
		if not isempty(trs) then
			dim re:set re=new RegExp
			re.IgnoreCase=True:re.Global=true
			tcode=trs(4,0)
			TemplateType=trs(3,0)
			TemplateGuideOrder=trs(7,0)
			TemplateTableID=trs(5,0)
			if trs(10,0)&""<>"" then
				tblockids=split(trs(10,0),",")
				for pushi=0 to ubound(tblockids)
					blockcontent=BlockComplete(tblockids(pushi),curJCP)
					re.pattern="<\s*block(?:(\s+blockid=""?"&tblockids(pushi)&"""?)+(\s+blockname=""?[^<>]+""?)?|(\s+blockname=""?[^<>]+""?)?(\s+blockid=""?"&tblockids(pushi)&"""?)+)+\s*>"
					tcode=re.replace(tcode,blockcontent)
				next
			end if
			curJCP.fso.FolderN curJCP.SiteRoot & curJCP.WebPath
			curJCP.fso.FolderN curJCP.SiteRoot & curJCP.WebPath & "\SOLE\"
			if trs(8,0) then
				curJCP.fso.FileD curJCP.SiteRoot & curJCP.WebPath & "\SOLE\" & trs(9,0)
			else
				curJCP.fso.FileD curJCP.SiteRoot & curJCP.WebPath & "\SOLE\" & t_templateid & "." & curJCP.FileExt
			end if
			if trs(8,0) then
				PushPath=curJCP.SiteUrlRoot & curJCP.WebPath & "/SOLE/" & trs(9,0)
				curJCP.fso.FileN curJCP.SiteRoot & curJCP.WebPath & "\SOLE\" & trs(9,0),tcode
			else
				PushPath=curJCP.SiteUrlRoot & curJCP.WebPath & "/SOLE/" & t_templateid & "." & curJCP.FileExt
				curJCP.fso.FileN curJCP.SiteRoot & curJCP.WebPath & "\SOLE\" & t_templateid & "." & curJCP.FileExt,tcode
			end if
			PushBySole=PushPath
			PushList=PushList & "|" & PushPath
		else
			PushBySole=false
			TemplateResult="�����ڵ�ǰ����ģ�壡"
		end if	
	end function
	
	public function PushByClassIndex(classinfo,t_templateid,curJCP)
		ClassID=classinfo
		TemplateID=t_templateid
		TemplateType=0
		dim trs,tcode,tblockids,blockcontent,pushi,pushfolder
		trs=curJCP.Data.GetRows("select * from JCP_Template where TemplateType=0 and id="&t_templateid)
		if not isempty(trs) then
			dim re:set re=new RegExp
			re.IgnoreCase=True:re.Global=true
			tcode=trs(4,0)
			ClassID=classinfo
			TemplateType=trs(3,0)
			TemplateGuideOrder=trs(7,0)
			TemplateTableID=trs(5,0)
			if trs(10,0)&""<>"" then
				tblockids=split(trs(10,0),",")
				for pushi=0 to ubound(tblockids)
					blockcontent=BlockComplete(tblockids(pushi),curJCP)
					re.pattern="<\s*block(?:(\s+blockid=""?"&tblockids(pushi)&"""?)+(\s+blockname=""?[^<>]+""?)?|(\s+blockname=""?[^<>]+""?)?(\s+blockid=""?"&tblockids(pushi)&"""?)+)+\s*>"
					tcode=re.replace(tcode,blockcontent)
				next
			end if
			pushfolder=replace(classinfo,"&",",")
			if trs(8,0) then
				curJCP.fso.FolderN curJCP.SiteRoot & trs(9,0)
				curJCP.fso.FolderN curJCP.SiteRoot & trs(9,0) & "\" & pushfolder
				curJCP.fso.FileD curJCP.SiteRoot & trs(9,0) & "\" & pushfolder & "\" & curJCP.IndexName & "." & curJCP.FileExt
			else
				curJCP.fso.FolderN curJCP.SiteRoot & curJCP.WebPath
				curJCP.fso.FolderN curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder
				curJCP.fso.FileD curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder & "\" & curJCP.IndexName & "." & curJCP.FileExt
			end if
			if trs(8,0) then
				PushPath=curJCP.SiteUrlRoot & trs(9,0) & "/" & pushfolder & "/" & curJCP.IndexName & "." & curJCP.FileExt
				curJCP.fso.FileN curJCP.SiteRoot & trs(9,0) & "\" & pushfolder & "\" & curJCP.IndexName & "." & curJCP.FileExt,tcode
			else
				PushPath=curJCP.SiteUrlRoot & curJCP.WebPath & "/" & pushfolder & "/" & curJCP.IndexName & "." & curJCP.FileExt
				curJCP.fso.FileN curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder & "\" & curJCP.IndexName & "." & curJCP.FileExt,tcode
			end if
			PushByClassIndex=PushPath
			PushList=PushList & "|" & PushPath
		else
			PushByClassIndex=false
			TemplateResult="�����ڵ�ǰ��Ŀ��ҳģ�壡"
		end if	
	end function
	
	public function PushByClassList(classinfo,t_templateid,curJCP)
		'on error resume next
		ClassID=classinfo
		TemplateID=t_templateid
		TemplateType=1
		dim trs,brs,tcode,tblockids,blockcontent,pushi,pushfolder
		ListOver=false:ListPage=1:ListBlockID=0
		trs=curJCP.Data.GetRows("select * from JCP_Template where TemplateType=1 and id="&t_templateid)
		if not isempty(trs) then
			dim re:set re=new RegExp
			re.IgnoreCase=True:re.Global=true
			tcode=trs(4,0)
			ClassID=classinfo
			TemplateType=trs(3,0)
			TemplateGuideOrder=trs(7,0)
			TemplateTableID=trs(5,0)
			if trs(10,0)&""<>"" then
				'��ȡģ���е��б��ҳģ��
				set brs=curJCP.Data.Exe("select id from JCP_BlockList where id in ("&trs(10,0)&") and blocktype=1")
				if not brs.eof then
					ListBlockID=brs(0)
				end if
				set brs=nothing
				'�ȴ�����б��ҳģ���������ģ��
				tblockids=split(trs(10,0),",")
				for pushi=0 to ubound(tblockids)
					if tblockids(pushi)<>Cstr(ListBlockID) then
						blockcontent=BlockComplete(tblockids(pushi),curJCP)
						re.pattern="<\s*block(?:(\s+blockid=""?"&tblockids(pushi)&"""?)+(\s+blockname=""?[^<>]+""?)?|(\s+blockname=""?[^<>]+""?)?(\s+blockid=""?"&tblockids(pushi)&"""?)+)+\s*>"
						tcode=re.replace(tcode,blockcontent)
					end if
				next
			end if
			pushfolder=trs(5,0) & "," & replace(classinfo,"&",",") & "," & trs(7,0)
			if trs(8,0) then
				curJCP.fso.FolderN curJCP.SiteRoot & trs(9,0)
				curJCP.fso.FolderN curJCP.SiteRoot & trs(9,0) & "\" & pushfolder
				curJCP.fso.FileD curJCP.SiteRoot & trs(9,0) & "\" & pushfolder & "\" & curJCP.IndexName & ".asp"
			else
				curJCP.fso.FolderN curJCP.SiteRoot & curJCP.WebPath
				curJCP.fso.FolderN curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder
				curJCP.fso.FileD curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder & "\" & curJCP.IndexName & ".asp"
			end if
			if ListBlockID=0 then
				if trs(8,0) then
					curJCP.fso.FileN curJCP.SiteRoot & trs(9,0) & "\" & pushfolder & "\" & curJCP.IndexName & ".asp",tcode
				else
					curJCP.fso.FileN curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder & "\" & curJCP.IndexName & ".asp",tcode
				end if
			else
				'���������б��ҳģ��
				dim tlistcode
				blockcontent=replace(replace(BlockComplete(ListBlockID,curJCP),"[%","<" & "%"),"%]","%" & ">")
				re.pattern="<\s*block(?:(\s+blockid=""?"&ListBlockID&"""?)+(\s+blockname=""?[^<>]+""?)?|(\s+blockname=""?[^<>]+""?)?(\s+blockid=""?"&ListBlockID&"""?)+)+\s*>"
				tlistcode=re.replace(tcode,blockcontent)
				if trs(8,0) then
					curJCP.fso.FileN curJCP.SiteRoot & trs(9,0) & "\" & pushfolder & "\" & curJCP.IndexName & ".asp",tlistcode
				else
					curJCP.fso.FileN curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder & "\" & curJCP.IndexName & ".asp",tlistcode
				end if
			end if
			if trs(8,0) then
				PushPath=curJCP.SiteUrlRoot & trs(9,0) & "/" & pushfolder & "/" 
			else
				PushPath=curJCP.SiteUrlRoot & curJCP.WebPath & "/" & pushfolder & "/"
			end if
			PushByClassList=PushPath
			PushList=PushList & "|" & PushPath
		else
			PushByClassList=false
			TemplateResult="�����ڵ�ǰ��Ŀ�б�ģ�壡"
		end if	
	end function
	
	public function PushByClassContent(classinfo,t_articleid,t_templateid,curJCP)
		ClassID=classinfo
		ArticleID=t_articleid
		TemplateID=t_templateid
		TemplateType=2
		dim trs,brs,tcode,tblockids,blockcontent,pushi,pushfolder,ContentBlockID
		ContentBlockID=0
		trs=curJCP.Data.GetRows("select * from JCP_Template where TemplateType=2 and id="&t_templateid)
		if not isempty(trs) then
			dim re:set re=new RegExp
			re.IgnoreCase=True:re.Global=true
			tcode=trs(4,0)
			ClassID=classinfo
			TemplateType=trs(3,0)
			TemplateGuideOrder=trs(7,0)
			TemplateTableID=trs(5,0)
			if trs(10,0)&""<>"" then
				'��ȡģ���е�������ʾģ��
				set brs=curJCP.Data.Exe("select id from JCP_BlockList where id in ("&trs(10,0)&") and blocktype=2")
				if not brs.eof then
					ContentBlockID=brs(0)
				end if
				set brs=nothing
				'�ȴ����������ʾģ���������ģ��
				tblockids=split(trs(10,0),",")
				for pushi=0 to ubound(tblockids)
					if tblockids(pushi)<>Cstr(ContentBlockID) then
						blockcontent=BlockComplete(tblockids(pushi),curJCP)
						re.pattern="<\s*block(?:(\s+blockid=""?"&tblockids(pushi)&"""?)+(\s+blockname=""?[^<>]+""?)?|(\s+blockname=""?[^<>]+""?)?(\s+blockid=""?"&tblockids(pushi)&"""?)+)+\s*>"
						tcode=re.replace(tcode,blockcontent)
					end if
				next
			end if
			pushfolder=trs(5,0) & "," & replace(classinfo,"&",",")
			if trs(8,0) then
				curJCP.fso.FolderN curJCP.SiteRoot & trs(9,0)
				curJCP.fso.FolderN curJCP.SiteRoot & trs(9,0) & "\" & pushfolder
				curJCP.fso.FileD curJCP.SiteRoot & trs(9,0) & "\" & pushfolder & "\Content" & t_articleid & "." & curJCP.FileExt
				curJCP.fso.FileD curJCP.SiteRoot & trs(9,0) & "\" & pushfolder & "\Content" & t_articleid & "_*." & curJCP.FileExt
			else
				curJCP.fso.FolderN curJCP.SiteRoot & curJCP.WebPath
				curJCP.fso.FolderN curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder
				curJCP.fso.FileD curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder & "\Content" & t_articleid & "." & curJCP.FileExt
				curJCP.fso.FileD curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder & "\Content" & t_articleid & "_*." & curJCP.FileExt
			end if
			if ContentBlockID=0 then
				if trs(8,0) then
					curJCP.fso.FileN curJCP.SiteRoot & trs(9,0) & "\" & pushfolder & "\Content" & t_articleid & "." & curJCP.FileExt,tcode
				else
					curJCP.fso.FileN curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder & "\Content" & t_articleid & "." & curJCP.FileExt,tcode
				end if
			else
				'��������������ʾģ��
				dim thtmls,tContentcode,codei,contentpageinfo,pagei,tarticlecont
				if BlockComplete(ContentBlockID,curJCP)=false then blockcontent=TemplateResult else blockcontent=BlockComplete(ContentBlockID,curJCP)
				thtmls=split(blockcontent,"[NextPage]")
				for codei=0 to ubound(thtmls)
					re.pattern="<\s*block(?:(\s+blockid=""?"&ContentBlockID&"""?)+(\s+blockname=""?[^<>]+""?)?|(\s+blockname=""?[^<>]+""?)?(\s+blockid=""?"&ContentBlockID&"""?)+)+\s*>"
					tContentcode=re.replace(tcode,thtmls(codei))
					if codei=0 then
						if trs(8,0) then
							curJCP.fso.FileN curJCP.SiteRoot & trs(9,0) & "\" & pushfolder & "\Content" & t_articleid & "." & curJCP.FileExt,tContentcode
						else
							curJCP.fso.FileN curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder & "\Content" & t_articleid & "." & curJCP.FileExt,tContentcode
						end if
					else
						if trs(8,0) then
							curJCP.fso.FileN curJCP.SiteRoot & trs(9,0) & "\" & pushfolder & "\Content" & t_articleid & "_" & (codei+1) & "." & curJCP.FileExt,tContentcode
						else
							curJCP.fso.FileN curJCP.SiteRoot & curJCP.WebPath & "\" & pushfolder & "\Content" & t_articleid & "_" & (codei+1) & "." & curJCP.FileExt,tContentcode
						end if
					end if
				next
			end if
			if trs(8,0) then
				PushPath=curJCP.SiteUrlRoot & trs(9,0) & "/" & pushfolder & "/Content" & t_articleid & "." & curJCP.FileExt
			else
				PushPath=curJCP.SiteUrlRoot & curJCP.WebPath & "/" & pushfolder & "/Content" & t_articleid & "." & curJCP.FileExt
			end if
			PushByClassContent=PushPath
			PushList=PushList & "|" & PushPath
		else
			PushByClassContent=false
			TemplateResult="�����ڵ�ǰ��Ŀ����ģ�壡"
		end if
	end function
	
	public function PushDataJS(arguments)
		dim trs,ti
		if ubound(arguments)=0 and typename(arguments(0))="JCP" then          'arguments����Ϊ1��curJCP
			trs=arguments(0).Data.GetRows("select id from JCP_BlockList where blocktype=3")
			if not isempty(trs) then
				for ti=0 to ubound(trs,2)
					PushDataJS=PushDataJS(array(trs(0,ti),arguments(0)))                   '���������blockid,curJCP
				next
			else
				PushDataJS=false
				TemplateResult="����������JSģ�飡"
			end if
		elseif ubound(arguments)=1 and typename(arguments(1))="JCP" then        'arguments����Ϊ2��blockid,curJCP
			PushDataJS=BlockComplete(arguments(0),arguments(1))
		else
			PushDataJS=false
			TemplateResult="��������JSģ��ʱ�����δ���"
		end if
	end function
	
	public Function PushInfo(push_classinfo,push_templateid,push_articleid,push_type,curJCP)
		dim pushrs
		set pushrs=curJCP.Data.ReRsOpen("select * from JCP_AutoPushInfo where classinfo='"&push_classinfo&"' and templateid="&push_templateid&" and articleid="&push_articleid&" and pushtype="&push_type & " and adminid=" & session("JCP_AdminID"),"pushrs",3)
		if pushrs.eof then
			pushrs.addnew
			pushrs("classinfo")=push_classinfo
			pushrs("templateid")=push_templateid
			pushrs("articleid")=push_articleid
			pushrs("pushtype")=push_type
			pushrs("adminid")=session("JCP_AdminID")
			pushrs.update
		end if
		pushrs.close
	end Function
	
	public Function ModifyByBlock(mod_blockid,mod_blocktype,curJCP)
		if mod_blocktype<5 and mod_blocktype<>3 then
			dim modrs
			set modrs=curJCP.Data.ReRsOpen("select id,TemplateType from JCP_Template where ',' & TemplateBlockIDs & ',' like '%"&mod_blockid&"%' order by id","modrs",1)
			do while not modrs.eof
				PushInfo "",modrs(0),0,modrs(1),curJCP
				modrs.movenext
			loop
			modrs.close
		elseif mod_blocktype=3 then
			PushInfo "",0,0,5,curJCP
		end if 
	end Function
end class
%>