<% 
''''''''''''''''''''''''''''''''''
'Used for AspJpeg v1.5.0.0
''''''''''''''''''''''''''''''''''

Class AspJpeg
	dim Jpeg,L
	public YN	'true/false ͼƬ�ߴ�С��Ŀ��ֵʱ���Ƿ���������������ʧ��
	
	'���캯������ʹ�� set new ��������ʱ���Զ�ִ��
	private sub class_initialize()
		on error resume next
		err.clear
		Set Jpeg = Server.CreateObject("Persits.Jpeg")
		if err.number>0 then
			response.write "<script>alert(""ϵͳ��֧��AspJpeg v1.5.0.0��������ֹ��"");</script>"
			response.end
		end if
		YN=false
	end sub
	
	'�ж��Ƿ���Ҫ��ͼƬִ������
	private function ResizeYN(width,nwidth,height,nheight)
		if nwidth=0 then	'�ߴ��Ը�Ϊ����
			if height<nheight then
				ResizeYN=YN
			else
				ResizeYN=true
			end if
		elseif nheight=0 then	'�ߴ��Կ�Ϊ����
			if width<nwidth then
				ResizeYN=YN
			else
				ResizeYN=true
			end if
		else
			if width<nwidth and height<nheight then
				ResizeYN=YN
			else
				ResizeYN=true
			end if
		end if
	end function

	'�ı�ͼƬ�ߴ磬�Կ�Ϊ����������ͼƬԭ����
	public function ResizeW(width,oldpath,newpath)
		Jpeg.Open oldpath
		if ResizeYN(Jpeg.Width,width,Jpeg.Height,0) then
			L=width
			Jpeg.Width = L
			Jpeg.Height = Jpeg.OriginalHeight * L / Jpeg.OriginalWidth
			Jpeg.Save newpath
		else
			if oldpath<>newpath then Jpeg.Save newpath
		end if
	end function

	'�ı�ͼƬ�ߴ磬�Ը�Ϊ����������ͼƬԭ����
	public function ResizeH(height,oldpath,newpath)
		Jpeg.Open oldpath
		if ResizeYN(Jpeg.Width,0,Jpeg.Height,height) then
			L=height
			Jpeg.Height = L
			Jpeg.Width = Jpeg.OriginalWidth * L / Jpeg.OriginalHeight
			Jpeg.Save newpath
		else
			if oldpath<>newpath then Jpeg.Save newpath
		end if
	end function

	'�ı�ͼƬ�ߴ磬����ԭͼƬ����
	public function ResizeWH(width,height,oldpath,newpath)
		Jpeg.Open oldpath
		if ResizeYN(Jpeg.Width,width,Jpeg.Height,height) then
			Jpeg.Height = height
			Jpeg.Width = width
			Jpeg.Save newpath
		else
			if oldpath<>newpath then Jpeg.Save newpath
		end if
	end function

	'�ı�ͼƬ�ߴ磬����ͼƬԭ����
	public function Resize(num,oldpath,newpath)
		Jpeg.Open oldpath
		if ResizeYN(Jpeg.Width,num,Jpeg.Height,num) then
			L=num
			If jpeg.OriginalWidth > jpeg.OriginalHeight Then
			   jpeg.Width = L
			   jpeg.Height = jpeg.OriginalHeight * L / jpeg.OriginalWidth
			Else
			   jpeg.Height = L
			   jpeg.Width = jpeg.OriginalWidth * L / jpeg.OriginalHeight
			End If
			Jpeg.Save newpath
		else
			if oldpath<>newpath then Jpeg.Save newpath
		end if
	end function

end class

dim AJ
set AJ=new AspJpeg

%>