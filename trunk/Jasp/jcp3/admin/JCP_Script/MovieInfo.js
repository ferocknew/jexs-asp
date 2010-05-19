var ItemList = new Array;
var MovieItemCount = 0;

function MovieItem(MediaId,Title,MediaType,Actors,Directors,DescURL,Post1URL,Post2URL,Company,RemarkId,TypeCaption,HometownCaption,MediaCost,MediaVisitors,Summary,IcpID,ChannelID) //constructor 
{ 
  //constant data 
  this.MediaId=MediaId;
  this.Actors = Actors;
  this.MediaType = MediaType;
  this.Directors = Directors;
  this.DescURL = DescURL;
  this.Post1URL = Post1URL;
  this.Post2URL = Post2URL;
  this.Title = Title;
  this.Company = Company;
  this.RemarkId = RemarkId;
  this.TypeCaption = TypeCaption;
  this.HometownCaption = HometownCaption;
  this.MediaCost = MediaCost;
  this.MediaVisitors = MediaVisitors;
  this.Summary=Summary;
  this.IcpID=IcpID;
  this.ChannelID=ChannelID;
} 
function addMovie(node)
{
  	ItemList[MovieItemCount] = node;
  	MovieItemCount++; 
}
function addItem(MovieTitle,MovieURL,Post2URL,SummaryCont,tempIcpID,tempChannelID){
	addMovie(new MovieItem("0",MovieTitle,"N/A","N/A","N/A",MovieURL,"N/A",Post2URL,"N/A","N/A","N/A","N/A","N/A","N/A",SummaryCont,tempIcpID,tempChannelID));
}
function GetItemCount()
{
	return MovieItemCount;
}
function GetItem(ItemId)
{
	if(ItemId >=0 &&ItemId < MovieItemCount)
	{
		return ItemList[ItemId];
	}
	else
	{
		return null;
	}
}
function OpenNewWindow(newURL)
{
	var winDesc = window.open("DescWindow.htm","surveywin","width=400,height=300,fullscreen=1,toolbar=0,location=0,directories=0,status=0,menubar=0,resizable=0");	
	winDesc.resizeTo(400, 300);
	winDesc.moveTo((window.screen.width-400)/2 ,(window.screen.height-300)/2);	
	winDesc.nowDesc = newURL;
}

function PrintDesc(ItemId)
{
	var Result="";
	if(ItemId <0 || ItemId >= MovieItemCount)
	{
		return Result;
	}
	Result = "<br><br><table  align=center cellspacing=0 cellpadding=0 width=155 border=\"1\" bordercolorlight=\"#000080\" bordercolordark=\"#FFFFFF\"><tr><td><table align=center cellspacing=0 cellpadding=0 width=155>";
	Result = Result + "<tr><td height=35 width=40 bgcolor=#01CFFF>片名：</td><td height=35 width=80 bgcolor=#01CFFF><font class=myfont2>"+ItemList[ItemId].Title+"</td></tr>";
	Result = Result + "<tr><td height=35 width=40 bgcolor=#01CFFF>主演：</td><td height=35 width=80 bgcolor=#01CFFF><font class=myfont2>"+ItemList[ItemId].Actors+"</td></tr>";
	Result = Result + "<tr><td height=35 width=40 bgcolor=#01CFFF>导演：</td><td height=35 width=80 bgcolor=#01CFFF><font class=myfont2>"+ItemList[ItemId].Directors+"</td></tr>";
	Result = Result + "<tr><td height=35 width=40 bgcolor=#01CFFF>类型：</td><td height=35 width=80 bgcolor=#01CFFF><font class=myfont2>"+ItemList[ItemId].TypeCaption+"</td></tr>";
	Result = Result + "<tr><td height=35 width=40 bgcolor=#01CFFF>产地：</td><td height=35 width=80 bgcolor=#01CFFF><font class=myfont2>"+ItemList[ItemId].HometownCaption+"</td></tr>";
	Result = Result + "<tr><td height=35 width=40 bgcolor=#01CFFF>公司：</td><td height=35 width=80 bgcolor=#01CFFF><font class=myfont2>"+ItemList[ItemId].Company+"</td></tr>";
	if(ItemList[ItemId].DescURL != null)
	{
		if(ItemList[ItemId].DescURL != ""||ItemList[ItemId].length>0)
		{
/*
			Result = Result +"<tr><td colspan=2 width=100%><table bgcolor=#01CFFF width=100%>"+
			         "<tr><td width=50%><a href='#' onClick='fnLinkBBS()' ><font color=blue>&gt;&gt;影片评论</font>"+
			         "</a></td><td width=50% align=right><a href='#' onclick='window.open(\""+
			         ItemList[ItemId].DescURL+
			         "\",\"NewWIndow\",\"toolbar=false,width=780,height=590,top=10,left=10\")'"+
			         "><font color=blue>&gt;&gt;影片简介</font></a></td></tr></table></tr>";
*/			         
			Result = Result +"<tr><td colspan=2 width=100%><table bgcolor=#01CFFF width=100%>"+
			         "<tr><td width=50%><a href='#' onClick='fnLinkBBS()' ><font color=blue>【影片评论】</font>"+
			         "</a></td><td width=50% align=right><a href='#' onclick='OpenNewWindow(\""+
			         ItemList[ItemId].DescURL+
			         "\")'"+
			         "><font color=blue>【影片简介】</font></a></td></tr></table></tr>";
		}
		else
		{
			Result = Result + "<tr><td colspan=2 width=100% bgcolor=#01CFFF><a href='#' onClick='fnLinkBBS()' ><font color=blue>【影片评论】</td></tr>";
		}
	}
	Result = Result + "</table></td></tr></table>";
	return Result;
}
function SetParentSelectedMovieId(MovieId)
{
	if(parent!=null)
	{
				parent.SelectedMovieId = MovieId;
	}
}

function OutList()
{
    var i;
    var TempHTML="<table align='center' width='100%' style='border-collapse: collapse' cellspacing='0' cellpadding='0' border='0'>";
    for(i=1;i<=MovieItemCount;i++)
    {
         if(i%2==0)
         {
            TempHTML = TempHTML + '<tr class="td_a">';
			 TempHTML = TempHTML +
					'<td><CENTER>' +
					'<img src="images/t' + i + '.gif" width="17" height="15"></CENTER>'+
					'</TD><TD><h1><a href="../' +  ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL+'">'+
					ItemList[i-1].Title + '('+ItemList[i-1].MediaVisitors+')</a></h1></td>';
            TempHTML = TempHTML + '</tr>';
         }
         if(i%2==1)
         {
		 	if(i==1){
				TempHTML = TempHTML + '<tr>' +
					'<TD width=22><CENTER><img src="images/t' + i + '.gif" width="17" height="15"></CENTER></TD>' +
					'<TD width=162><TABLE cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR>' +
                    '<TD vAlign=top width="42%"><A href="../' +  ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL+ '">' +
					'<IMG height=81 src="'+ItemList[i-1].Post2URL + '" width=58 border=0></A></TD>' +
                    '<TD class=td2 vAlign=top width="58%">' +
					'<A class=h1 href="../' +  ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL+ '">' + ItemList[i-1].Title + '</A><br>' + ItemList[i-1].Summary +
					'</TD></TR></TBODY></TABLE></TD></TR>';
			}else{
				TempHTML = TempHTML + '<tr>';
				 TempHTML = TempHTML +
						'<td><CENTER>' +
						'<img src="images/t' + i + '.gif" width="17" height="15"></CENTER>'+
						'</TD><TD><h1><a href="../' +  ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL+'">'+
						ItemList[i-1].Title + '('+ItemList[i-1].MediaVisitors+')</a></h1></td>';
				TempHTML = TempHTML + '</tr>';
			}
         }

    }
    TempHTML=TempHTML+"</table>";
    window.top10Div.innerHTML = TempHTML;
}

/*动漫频道首页下载排行榜*/
function OutList_index()
{
    var i;
    var TempHTML = "<table width='185' border='0' cellspacing='0' cellpadding='0'><tr><td height='2' colspan='2'></td></tr>";
						
    for(i=1;i<=MovieItemCount;i++)
    {
         if(i%2==0)
         {
         	TempHTML = TempHTML + "<tr class='td_a'>";
			TempHTML = TempHTML + "<td><center><img src='images/icon_" + i + ".gif' width='15' height='15' /></center></td>";
			TempHTML = TempHTML + "<td><h1><a href='../" + ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL + "'>" + ItemList[i-1].Title.substring(0,17) + "(" + ItemList[i-1].MediaVisitors + ")</a></h1></td>";
			TempHTML = TempHTML + "</tr>";
         }
         if(i%2==1)
         {
		 	if(i==1)
			{
				TempHTML = TempHTML + "<tr>";
				TempHTML = TempHTML + "<td width='22' valign='top'><center><img src='images/icon_" + i + ".gif' width='17' height='15'/></center></td>";
				TempHTML = TempHTML + "<td width='162'><table width='100%' border='0' cellspacing='0' cellpadding='0'>";
				TempHTML = TempHTML + "<tr>";
				TempHTML = TempHTML + "<td width='42%' valign='top'><a href='../" + ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL + "'><img src='" + ItemList[i-1].Post2URL + "' width='58' height='81' border='0'/></a></td>";
				TempHTML = TempHTML + "<td width='58%' valign='top'><h1><a href='../" + ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL + "'>" + ItemList[i-1].Title.substring(0,17) + "</a></h1></td>";
				TempHTML = TempHTML + "</tr>";
				TempHTML = TempHTML + "</table>";
				TempHTML = TempHTML + "</td>";
				TempHTML = TempHTML + "</tr>";
				TempHTML = TempHTML + "<tr>";
				TempHTML = TempHTML + "<td height='4' colspan='2'></td>";
				TempHTML = TempHTML + "</tr>";
			}
			else
			{
         		TempHTML = TempHTML + "<tr>";
				TempHTML = TempHTML + "<td><center><img src='images/icon_" + i + ".gif' width='15' height='15' /></center></td>";
				TempHTML = TempHTML + "<td><h1><a href='../" + ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL + "'>" + ItemList[i-1].Title.substring(0,17) + "(" + ItemList[i-1].MediaVisitors + ")</a></h1></td>";
				TempHTML = TempHTML + "</tr>";
			}
         }
    }
	
    TempHTML = TempHTML + "</table>";
	
	//document.getElementById("top10Div_index").innerHTML = TempHTML;
	window.top10Div_index.innerHTML = TempHTML;
}

/*动漫频道列表页下载排行榜*/
function OutList_list()
{
    var i;
    var TempHTML = "<table width='184' border='0' cellspacing='0' cellpadding='0'><tr><td height='2' colspan='2'></td></tr>";
						
    for(i=1;i<=MovieItemCount;i++)
    {
         if(i%2==0)
         {
         	TempHTML = TempHTML + "<tr class='td_a'>";
			TempHTML = TempHTML + "<td><center><img src='../images/icon_" + i + ".gif' width='17' height='15' /></center></td>";
			TempHTML = TempHTML + "<td><h1><a href='../../" + ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL + "'>" + ItemList[i-1].Title.substring(0,17) + "(" + ItemList[i-1].MediaVisitors + ")</a></h1></td>";
			TempHTML = TempHTML + "</tr>";
         }
         if(i%2==1)
         {
		 	if(i==1)
			{
				TempHTML = TempHTML + "<tr>";
				TempHTML = TempHTML + "<td width='22' valign='top'><center><img src='../images/icon_" + i + ".gif' width='15' height='15'/></center></td>";
				TempHTML = TempHTML + "<td width='162'><table width='100%' border='0' cellspacing='0' cellpadding='0'>";
				TempHTML = TempHTML + "<tr>";
				TempHTML = TempHTML + "<td width='42%' valign='top'><a href='../../" + ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL + "'><img src='" + ItemList[i-1].Post2URL + "' width='58' height='81' border='0'/></a></td>";
				TempHTML = TempHTML + "<td width='58%' valign='top'><h1><a href='../../" + ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL + "'>" + ItemList[i-1].Title.substring(0,17) + "</a></h1></td>";
				TempHTML = TempHTML + "</tr>";
				TempHTML = TempHTML + "</table>";
				TempHTML = TempHTML + "</td>";
				TempHTML = TempHTML + "</tr>";
				TempHTML = TempHTML + "<tr>";
				TempHTML = TempHTML + "<td height='4' colspan='2'></td>";
				TempHTML = TempHTML + "</tr>";
			}
			else
			{
         		TempHTML = TempHTML + "<tr>";
				TempHTML = TempHTML + "<td><center><img src='../images/icon_" + i + ".gif' width='17' height='15' /></center></td>";
				TempHTML = TempHTML + "<td><h1><a href='../../" + ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL + "'>" + ItemList[i-1].Title.substring(0,17) + "(" + ItemList[i-1].MediaVisitors + ")</a></h1></td>";
				TempHTML = TempHTML + "</tr>";
			}
         }
    }
	
    TempHTML = TempHTML + "</table>";
	
	//document.getElementById("top10Div_list").innerHTML = TempHTML;
	window.top10Div_list.innerHTML = TempHTML;
}

/*动漫频道详细页下载排行榜*/
function OutList_media()
{
    var i;
    var TempHTML = "<table width='184' border='0' cellspacing='0' cellpadding='0'><tr><td height='2' colspan='2'></td></tr>";
						
    for(i=1;i<=MovieItemCount;i++)
    {
         if(i%2==0)
         {
         	TempHTML = TempHTML + "<tr class='td_a'>";
			TempHTML = TempHTML + "<td><center><img src='../images/icon_" + i + ".gif' width='17' height='15' /></center></td>";
			TempHTML = TempHTML + "<td><h1><a href='../../" + ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL + "'>" + ItemList[i-1].Title.substring(0,17) + "(" + ItemList[i-1].MediaVisitors + ")</a></h1></td>";
			TempHTML = TempHTML + "</tr>";
         }
         if(i%2==1)
         {
		 	if(i==1)
			{
				TempHTML = TempHTML + "<tr>";
				TempHTML = TempHTML + "<td width='22' valign='top'><center><img src='../images/icon_" + i + ".gif' width='15' height='15'/></center></td>";
				TempHTML = TempHTML + "<td width='162'><table width='100%' border='0' cellspacing='0' cellpadding='0'>";
				TempHTML = TempHTML + "<tr>";
				TempHTML = TempHTML + "<td width='42%' valign='top'><a href='../../" + ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL + "'><img src='" + ItemList[i-1].Post2URL + "' width='58' height='81' border='0'/></a></td>";
				TempHTML = TempHTML + "<td width='58%' valign='top'><h1><a href='../../" + ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL + "'>" + ItemList[i-1].Title.substring(0,17) + "</a></h1></td>";
				TempHTML = TempHTML + "</tr>";
				TempHTML = TempHTML + "</table>";
				TempHTML = TempHTML + "</td>";
				TempHTML = TempHTML + "</tr>";
				TempHTML = TempHTML + "<tr>";
				TempHTML = TempHTML + "<td height='4' colspan='2'></td>";
				TempHTML = TempHTML + "</tr>";
			}
			else
			{
         		TempHTML = TempHTML + "<tr>";
				TempHTML = TempHTML + "<td><center><img src='../images/icon_" + i + ".gif' width='17' height='15' /></center></td>";
				TempHTML = TempHTML + "<td><h1><a href='../../" + ItemList[i-1].ChannelID + "/" + ItemList[i-1].DescURL + "'>" + ItemList[i-1].Title.substring(0,17)+ "(" + ItemList[i-1].MediaVisitors + ")</a></h1></td>";
				TempHTML = TempHTML + "</tr>";
			}
         }
    }
	
    TempHTML = TempHTML + "</table>";
	
	//document.getElementById("top10Div_media").innerHTML = TempHTML;
	window.top10Div_media.innerHTML = TempHTML;
}