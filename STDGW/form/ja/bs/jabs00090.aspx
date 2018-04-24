<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("crm")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var lang="<%=Session("Lang")%>";
var arrHolidayDate    = new Array();
var arrHolidayMonth   = new Array();
var arrHolidayYear    = new Array();
var arrHolidayType    = new Array();
var arrHolidayComment = new Array();
var cGrid;
var v_month;
var v_year;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{   
   
    if (v_language!="ENG")
        System.Translate(document);
   dtDate.SetEnable(false);     
	OnSearch();
	//Dsql_Holiday_Plan_Receive();
}
//-----------------------------------------------------
function DrawingCalendar()
{   
    ClearDay();
    var iDay = 1;
    var maxDay = GetMaxDayOfMonth(dtMonth.GetData());
    var m = dtMonth.GetData();
    var tmp = m.substr(0,4)+"/"+m.substr(4,2)+"/01";
    var d = new Date(tmp);
    var dayOfWeek = d.getDay();
    var x = document.getElementById("tblCalendar");    
    dayOfWeek = dayOfWeek -1;
    for(var i=1;i<=5;i++)
    {
       for(var j=0;j<=6;j++)
       {
          if((j >= dayOfWeek)&&(i == 1))  // dong dau tien
          {
             if((j==6)||(dayOfWeek == -1))  // ngay Sunday
             {
                j=6;
              	x.rows[i].cells[j].innerHTML = "<font color=#ff00cc><b>&nbsp;" + iDay + "</b></font>";
			
             }
             else if (j==5)  // ngay thu 7
             {
				
					x.rows[i].cells[j].innerHTML = "<font color=blue><b>&nbsp;" + iDay + "</b></font>";
				
             }              
             else    // ngay binh thuong
             {
				
					x.rows[i].cells[j].innerHTML = "<font color=black><b>&nbsp;" + iDay + "</b></font>" ;
					
             }
             iDay++;
          }
          else if((iDay <= maxDay)&&(i>1))  // cac dong con lai
          {
             if(j==6)   // ngay chu nhat
             {
				
				
					x.rows[i].cells[j].innerHTML = "<font color=#ff00cc><b>&nbsp;" + iDay + "</b></font>";
					
             }
             else if (j==5)  // ngay thu 7
             {
				
				
					x.rows[i].cells[j].innerHTML = "<font color=blue><b>&nbsp;" + iDay + "</b></font>";
					
             }   
             else   // ngay binh thuong
             {
				
					x.rows[i].cells[j].innerHTML = "<font color=black><b>&nbsp;" + iDay + "</b></font>" ;
					
             }
             iDay++;
          }
                   
          
       }
    }
    j=0;
    while(iDay <= maxDay) 
    {
       
       if(j==6)  // ngay chu nhat
       {
          x.rows[1].cells[j].innerHTML = "<font color=#ff00cc><b>&nbsp;" + iDay +"</b></font>";
       }
       else if (j==5)  // ngay thu 7
       {
		  x.rows[i].cells[j].innerHTML = "<font color=blue><b>&nbsp;" + iDay +"</b></font>";
       }   
       else    // ngay binh thuong
       {
          x.rows[1].cells[j].innerHTML = "<font color=black><b>&nbsp;" + iDay +"</b></font>";
       }
       iDay++;
       j++;
    }
    
}
//------------------------------------------------------
function GetMaxDayOfMonth(vMonth)
{
   var iMonth = Number(vMonth.substr(4,2));
   var iYear = Number(vMonth.substr(0,4));
   if((iMonth == 4)||(iMonth == 6)||(iMonth == 9)||(iMonth == 11))
   {
     return 30;
   }
   else if(iMonth == 2)
   {
      if(IsLeapYear(iYear))
      {
        return 29;
      }
      else
      {
        return 28;
      }
   }
   else
   {
     return 31;
   }

}
//------------------------------------------------------------
function IsLeapYear(vYear)
{
       
   iYear  = Number(vYear);
   if((iYear%4==0)&&(iYear%100!=0)||(iYear%100==0))
   {
     return true;
   }
   else
   {
    return false;
   }
}

//-----------------------------------------------------------------
function ClearDay()
{
    var x = document.getElementById("tblCalendar");
    for(var i=1;i<=5;i++)
    {
        for(var j=0;j<=6;j++)
        {
           //x.rows[i].cells[j].innerHTML = "";
           x.rows[i].cells[j].innerText = "";
        }
    }
}

//------------------------------------------------------
function OnSearch()
{	
	DrawingCalendar();
	datCanlendar.Call("SELECT");
	
}
//---------------------------------------------------------
function OnDataReceive(obj)
{
    if (obj.id=="datCanlendar")
    {
        for(cGrid=1;cGrid<grdCalendar.rows;cGrid++)
        {
           arrHolidayDate[cGrid]  = Number((grdCalendar.GetGridData(cGrid,1)).substr(6,2));
           arrHolidayMonth[cGrid] = Number((grdCalendar.GetGridData(cGrid,1)).substr(4,2));
           arrHolidayYear[cGrid]  = Number((grdCalendar.GetGridData(cGrid,1)).substr(0,4));
           arrHolidayType[cGrid]    = grdCalendar.GetGridData(cGrid,3);
           arrHolidayComment[cGrid] = grdCalendar.GetGridData(cGrid,4);
        }   
       
       for (var i=1;i<cGrid;i++)
       {	
	        SearchDraw(arrHolidayDate[i],arrHolidayMonth[i],arrHolidayYear[i],arrHolidayType[i],arrHolidayComment[i]);
       }   
    datMaxDate.Call();
    
    }
        
}
//------------------------------------------------------

function SearchDraw(p_date,p_month,p_year,p_holtype,p_comment)
{   	
	var v_day;
	var x = document.getElementById("tblCalendar"); 
	v_month = Number((dtMonth.value).substr(4,2));
	v_year = Number((dtMonth.value).substr(0,4));

	if ((v_month == p_month) && (v_year == p_year))
		{	
			for(var i=1;i<=5;i++)
				{   
					for(var j=0;j<=6;j++)
						{	
							var s = (x.rows[i].cells[j].innerText).substr(0,5);
							s = Number(s);
							v_day = s;	
							if (v_day == p_date)	
								{
									x.rows[i].cells[j].innerHTML = "<font color=red><b>&nbsp;" + v_day + "<BR><BR>&nbsp;&nbsp;(" + p_comment + " ...)" + "</b></font>";	     
								}	
						}
				}  
		}		
}
//--------------------------------------------------------------
function OnClickEntry()
{	 
	var month=dtMonth.value;
	v_month = Number((dtMonth.value).substr(4,2));
	v_year = Number((dtMonth.value).substr(0,4));
	//alert(v_month + "  " + v_year);
	var url = "/form/ja/bs/jabs00090_popup.aspx?MONTH=" + v_month + "&YEAR=" + v_year;
	var obj;
	obj = System.OpenModal(System.RootURL + url,800,500,"resizable:yes;status:yes"); 
	if (obj != 0)
	  { 	 
		 OnSearch();
	  }
	
}
function OnCreate()
{datCreateDate.Call();
}
function OnChangeDate()
{if(  Number(dtUntilDate.value) <=Number(dtDate.value))
    {ibtnProcess.SetEnable(false);
    }
   else
    ibtnProcess.SetEnable(true);
}
</script>
<body>
<!------------main control---------------------->

<gw:data id="datCanlendar" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="crm.sp_sel_calendar" > 
                <input bind="grdCalendar">
                    <input bind="dtMonth" /> 
                </input> 
                <output bind="grdCalendar"/>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datMaxDate" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="crm.sp_sel_max_date" > 
                <input>
                    <input bind="dtDate" /> 
                </input> 
                <output>
                    <output bind="dtDate" />
                     <input bind="dtUntilDate" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datCreateDate" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="crm.sp_pro_create_date" > 
                <input>
                    <input bind="dtDate" />
                    <input bind="dtUntilDate" /> 
                </input> 
                <output>
                    <output bind="dtDate" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!--------------------main table--------------------------------->
<table width="100%" border=0>
	<tr>
		<td width=10% align=right>Max date</td>
		<td width=10% align=right><gw:datebox id="dtDate" type="date" lang="<%=session("lang")%>" onchange=""/></td>
		<td width="20%" align=right>Create Date Until </td>
		<td width="10%" align=left><gw:datebox id="dtUntilDate" type="date" lang="<%=session("lang")%>" onchange="OnChangeDate()"/>				
		</td>
		<td width="10%"><gw:imgBtn img="process" id="ibtnProcess"   alt="Create Date"  onclick="OnCreate()"/></td>
		<td width=10% align=right><font color=black>Month</font></td>
		<td width=10%><gw:datebox id="dtMonth" type="month" lang="<%=session("lang")%>" onchange="OnSearch()"/></td>
		
		<td width="2%">
			<gw:imgBtn id="idBtnEntry" img="Popup" alt="Entry(PopUp)" onclick="OnClickEntry()" />
		</td>
		<td width="2%" align=right>							
			<gw:imgBtn id="idBtnSelect" img="Search" alt="Search" onclick="OnSearch()" />
		</td>
		<td width="10%"></td>
	</tr>		
</table>
		
<table width=100% id="tblCalendar" cellpadding=0 cellspacing=0 border=1 bordercolor=gray bgcolor="#f5f8f9" style="border-collapse: collapse">
	<tr bgcolor="#93cefc">
		<th height=30px width=14%><basefont size=4>MON</th>
		<th height=30px width=14%><basefont size=4>TUE</th>
		<th height=30px width=14%><basefont size=4>WED</th>
		<th height=30px width=14%><basefont size=4>THU</th>
		<th height=30px width=14%><basefont size=4>FRI</th>
		<th height=30px width=14% bgcolor=#99ffff><basefont size=4>SAT</th>
		<th bgcolor=#ffc448 height=30px width=14%><basefont size=4>SUN</th>
	</tr>
	<tr valign=top>
        <td height=80px></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr valign=top>
        <td height=80px></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr valign=top>
        <td height=80px></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr valign=top>
        <td height=80px></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
     <tr valign=top>
        <td height=80px></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
     </tr>
</table>

		
<gw:grid   
	id="grdCalendar"  
	header="_PK|Date|Day Type|Holiday Type|Comment|Remark|_DEL_IF|_CRT_BY|_CRT_DT|_MOD_BY|_MOD_DT"   
	format="0|0|0|0|0|0|0|0|0|0|0"  
	aligns="0|0|0|0|0|0|0|0|0|0|0"  
	defaults="||||||||||"  
	editcol="1|1|1|1|1|1|1|1|1|1|1"  
	widths="0|0|0|0|0|0|0|0|0|0|0"  
	styles="width:100%; height:400; display:none"   
	sorting="F"   
	param="0,1,2,3,4,5,6,7,8,9,10"  /> 


</body>
</html>

