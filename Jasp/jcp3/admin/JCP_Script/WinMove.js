// JavaScript Document
<!--

		var moveable = false;
		function startgrap(obj)
        {                        
            if(event.button==1)
            {
            obj.setCapture();
                       x0 = event.clientX;
                       y0 = event.clientY;
                       x1 = parseInt(obj.style.left);
                       y1 = parseInt(obj.style.top);
                       moveable = true;
            }
         }
        function stopgrap(obj)
        {
            if(moveable)
            {
                obj.releaseCapture();
                moveable = false;
            }
        }
        function grap(obj)
        {
             if(moveable)
                  {
				  		if(event.clientX>4&&event.clientX<doc.body.clientWidth-4&&event.clientY>4&&event.clientY<doc.body.clientHeight){               
                           obj.style.left = x1 + event.clientX - x0;
                           obj.style.top  = y1 + event.clientY - y0;
						}
            }
        }

//-->
