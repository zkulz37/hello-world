<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

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
   iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
	
    if (v_language!="ENG")
        System.Translate(document);
 
	OnSearch();
   
	
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
              	x.rows[i].cells[j].innerHTML = "<font color=#ff00cc><b>" + iDay + "</b></font>";
			
             }
             else if (j==5)  // ngay thu 7
             {
				
					x.rows[i].cells[j].innerHTML = "<font color=blue><b>" + iDay + "</b></font>";
				
             }              
             else    // ngay binh thuong
             {
				
					x.rows[i].cells[j].innerHTML = "<font color=black><b>" + iDay + "</b></font>" ;
					
             }
             iDay++;
          }
          else if((iDay <= maxDay)&&(i>1))  // cac dong con lai
          {
             if(j==6)   // ngay chu nhat
             {
				
				
					x.rows[i].cells[j].innerHTML = "<font color=#ff00cc><b>" + iDay + "</b></font>";
					
             }
             else if (j==5)  // ngay thu 7
             {
				
				
					x.rows[i].cells[j].innerHTML = "<font color=blue><b>" + iDay + "</b></font>";
					
             }   
             else   // ngay binh thuong
             {
				
					x.rows[i].cells[j].innerHTML = "<font color=black><b>" + iDay + "</b></font>" ;
					
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
          x.rows[1].cells[j].innerHTML = "<font color=#ff00cc><b>" + iDay +"</b></font>";
       }
       else if (j==5)  // ngay thu 7
       {
		  x.rows[i].cells[j].innerHTML = "<font color=blue><b>" + iDay +"</b></font>";
       }   
       else    // ngay binh thuong
       {
          x.rows[1].cells[j].innerHTML = "<font color=black><b>" + iDay +"</b></font>";
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
	dsohr_chhs00020_s_01.Call("SELECT");
	
}
//---------------------------------------------------------
function OnDataReceive(obj)
{
    if (obj.id=="dsohr_chhs00020_s_01")
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
									x.rows[i].cells[j].innerHTML = "<font color=blue><b>" + v_day + "<BR><BR>(" + p_comment + " ...)" + "</b></font>";	     
								}	
						}
				}  
		}		
}
//--------------------------------------------------------------
function OnClickEntry()
{	 
	var p_month=dtMonth.value;
	 var p_location = lstLocation.value;
	//alert(v_month + "  " + v_year);
	var url = "/form/ch/hs/chhs00021.aspx?p_month=" + p_month  +"&p_location="+p_location;
	var obj;
	obj = System.OpenModal(System.RootURL + url,1000,600,"resizable:yes;status:yes"); 
	
}
function OnClickEntry2()
{	 
	var p_month=dtMonth.value;
	 var p_location = lstLocation.value;
	//alert(v_month + "  " + v_year);
	var url = "/form/ch/hs/chhs00022.aspx?p_month=" + p_month  +"&p_location="+p_location;
	var obj;
	obj = System.OpenModal(System.RootURL + url,1000,600,"resizable:yes;status:yes"); 
	
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
 

<gw:data id="dsohr_chhs00020_s_01" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="hr_chhs00020_s_01" > 
                <input bind="grdCalendar">
                    <input bind="dtMonth" /> 
					<input bind="lstLocation" />
                </input> 
                <output bind="grdCalendar"/>
            </dso> 
        </xml> 
</gw:data>
 
 

<!--------------------main table--------------------------------->
<table width="100%" border=0>
	<tr>
		<td width=7% align=right>Địa điểm</td>
		<td class="topright" width="15%">
                    <gw:list  id="lstLocation"  styles='width:100%' onchange="OnSearch()" >
                        <data>
                            <%= ESysLib.SetListDataSQL("select a.location_id,a.location_name from thr_hs_location a  where a.del_if = 0  order by 2 ")%>
                        </data>
                    </gw:list>
                </td>
		<td width=10% align=right> </td>
		<td width=10% align=right> </td>
		<td width="15%" align=right> </td>
		<td width="10%" align=left> 			
		</td>
		<td width="3%"> </td>
		<td width=10% align=right><font color=black>Month</font></td>
		<td width=10%><gw:datebox id="dtMonth" type="month" lang="<%=session("lang")%>" onchange="OnSearch()"/></td>
		
		<td width="2%">
			<gw:imgBtn id="idBtnEntry" img="Popup" alt="Entry(PopUp)" onclick="OnClickEntry()" />
		</td>
		<td width="2%">
			<gw:imgBtn id="idBtnEntry" img="Popup" alt="Entry(PopUp)" onclick="OnClickEntry2()" />
		</td>
		<td width="2%" align=right>							
			<gw:imgBtn id="idBtnSelect" img="Search" alt="Search" onclick="OnSearch()" />
		</td>
		
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
	styles="width:100%; height:400;display:none "   
	sorting="F"   
	param="0,1,2,3,4,5,6,7,8,9,10"  /> 

<gw:textbox id="iduser_pk" styles="display:none"/>
	<gw:textbox id="txtHr_level" styles="display:none"/>
</body>
</html>

