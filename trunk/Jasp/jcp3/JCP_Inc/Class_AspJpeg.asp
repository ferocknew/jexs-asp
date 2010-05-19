<% 
''''''''''''''''''''''''''''''''''
'Used for AspJpeg v1.5.0.0
''''''''''''''''''''''''''''''''''

Class AspJpeg
	dim Jpeg,L
	public YN	'true/false 图片尺寸小于目标值时，是否扩大，扩大后可能有失真
	
	'构造函数，在使用 set new 创建对象时，自动执行
	private sub class_initialize()
		on error resume next
		err.clear
		Set Jpeg = Server.CreateObject("Persits.Jpeg")
		if err.number>0 then
			response.write "<script>alert(""系统不支持AspJpeg v1.5.0.0，程序终止！"");</script>"
			response.end
		end if
		YN=false
	end sub
	
	'判断是否需要对图片执行缩放
	private function ResizeYN(width,nwidth,height,nheight)
		if nwidth=0 then	'尺寸以高为基础
			if height<nheight then
				ResizeYN=YN
			else
				ResizeYN=true
			end if
		elseif nheight=0 then	'尺寸以宽为基础
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

	'改变图片尺寸，以宽为基础，保持图片原比例
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

	'改变图片尺寸，以高为基础，保持图片原比例
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

	'改变图片尺寸，放弃原图片比例
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

	'改变图片尺寸，保持图片原比例
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