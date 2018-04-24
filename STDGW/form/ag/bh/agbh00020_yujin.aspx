<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var tmp;
function BodyInit()
{   
   System.Translate(document); 
    if (v_language!="ENG")
        System.Translate(document);	
         iduser_pk.text = "<%=session("USER_PK")%>";
   txtUser_PK.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>";

    tmp="#N;Day Shift|#D;Night Shift";
    grdWorkShift.SetComboFormat(25,tmp);

   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
     datUser_info.Call(); 
    else
    ChangeLocation();
}
function OnDataReceive(obj)
{
    if(obj.id=="datUser_info")
        datListWorkShift.Call("SELECT"); 
    else if(obj.id=="datListWorkShift") 
        auto_resize_column(grdWorkShift,0,grdWorkShift.cols-1,0);
          
  
  }
function ChangeLocation()
{datListWorkShift.Call("SELECT");    
}  
function checkData()
{
	var control = grdWorkShift.GetGridControl();
	var rows = control.Rows;
	var cols = control.Cols;
	var row = control.Row;
	var col = control.Col;
	
	for (j=1; j< rows; j++)	
	{
		var inTIME
		var outTIME
		inTIME	= grdWorkShift.GetGridData(row, col);		
		
		var inH1, inH2, inHH
		var inMM, inM1, inM2
		var inHHMM
		var dau
		
		if((col == 1) || (col== 2)|| (col== 7)|| (col== 8)|| (col== 10)|| (col== 11))
		{	
			if (inTIME.length == 5) 
			{
				
				inHH		= inTIME.substr(0,2);
				inH1		= inTIME.substr(0,1);
				inH2		= inTIME.substr(1,1);
				dau			= inTIME.substr(2,1);
				inMM		= inTIME.substr(3,2);
				inM1		= inTIME.substr(3,1);
				inM2		= inTIME.substr(4,1);
								
				if (dau == ":")
				{
					//if (((parseInt(inH1)) && (parseInt(inH1))) && ((parseInt(inM2)) && (parseInt(inM1))))
					if (((inH1 >= 0 )&& (inH2 >= 0)) && ((inM2 >= 0) && (inM1 >= 0)))
					{
						if((inHH >= 24) || (inMM >= 60))
						{
							alert("IN and OUT format HH:MM with HH < 24 and MM <60");
							grdWorkShift.SetGridText(row, col, txtidSaveData.text);
							return;
						}
					}
					else
					{
						alert("IN and OUT format HH:MM and IN and OUT must number with HH < 24 and MM <60");
						grdWorkShift.SetGridText(row, col, txtidSaveData.text);
						return;
					}
				}
				else
				{
					alert("IN and OUT format HH:MM and IN and OUT must number with HH < 24 and MM <60");
					grdWorkShift.SetGridText(row, col, txtidSaveData.text);
					return;
				}
			}
			else
			{
				alert("IN and OUT format HH:MM with HH < 24 and MM <60");
				grdWorkShift.SetGridText(row, col, txtidSaveData.text);
				return;
			}
		}
		
		if((col == 3) || (col == 4) || (col == 5) || (col == 6))
		{
			data	= grdWorkShift.GetGridData(j, col);
			
			if (parseInt(data) )
			{
				if (data.length >  4)
				{
					alert('Len of sting can not more than 2 character...');
					grdWorkShift.SetGridText(j, col, txtidSaveData.text);
					return ;
				}
				
				else
				{
					if (data.length < 1)
					{
						alert('Len of sting can not more than 1 character...');
						grdWorkShift.SetGridText(j, col, txtidSaveData.text);
						return ;			
					}
					
				}
			}
			if(isNaN(data))
			{
				alert('Can not empty string...');
				grdWorkShift.SetGridText(j, col, txtidSaveData.text);
				return ;
			}
		}

	}
	
	if(col == 2)	
	{
		var outH1, outH2, outHH
		var outM1, outM2, outMM
		var outHHMM
		inTIME	= grdWorkShift.GetGridData(row, 1);
		outTIME	= grdWorkShift.GetGridData(row, 2);
		
		inHH		= inTIME.substr(0,2);
		inH1		= inTIME.substr(0,1);
		inH2		= inTIME.substr(1,2);
		
		inMM		= inTIME.substr(3,5);
		inM1		= inTIME.substr(3,4);
		inM2		= inTIME.substr(4,5);
		
		inHHMM		= inHH + inMM
		
		outHH		= outTIME.substr(0,2);
		outH1		= outTIME.substr(0,1);
		outH2		= outTIME.substr(1,2);
		
		outMM		= outTIME.substr(3,5);
		outM1		= outTIME.substr(3,4);
		outM2		= outTIME.substr(4,5);
		
		outHHMM		= outHH + outMM					
		
	}
	
	
	
	//Dim s_hour, s_min, e_hour, e_min, wt, ot, nt, shift, result, tmp
	var s_hour 	= new String;
	var e_hour 	= new String;
	
	var wt	 	= new String;
	var ot	 	= new String;
	var nt	 	= new String;
	var shift	= new String;
    var m_ot,c_ot;
	
	
	var tmp_result 	= new String;
	txtidPK.text	= grdWorkShift.GetGridData(row, 0);
	s_hour		= grdWorkShift.GetGridData(row, 1);
	e_hour		= grdWorkShift.GetGridData(row, 2);
	wt			= grdWorkShift.GetGridData(row, 3);
	ot			= grdWorkShift.GetGridData(row, 4);
	nt			= grdWorkShift.GetGridData(row, 5);
	shift		= grdWorkShift.GetGridData(row, 6);
	start_lunch = grdWorkShift.GetGridData(row,7);
	end_lunch   = grdWorkShift.GetGridData(row,8);
	start_dinner= grdWorkShift.GetGridData(row,10);
	end_dinner  = grdWorkShift.GetGridData(row,11);
	start_ot    = grdWorkShift.GetGridData(row,13);
    m_ot    = grdWorkShift.GetGridData(row,23);
    c_ot    = grdWorkShift.GetGridData(row,24);
	
	if (s_hour < 10)
	{
		s_hour = "0" + s_hour
	}
	
	if (e_hour < 10)
	{
		e_hour = "0" + e_hour
	}
	
		
	tmp_result = s_hour + "-" + e_hour + "W" + wt + "O" + ot + "N" + nt + "S" + shift + "L" + start_lunch + "-" + end_lunch + "D" + start_dinner + "-" + end_dinner + "SOT" + start_ot+ "M" + m_ot+ "C" + c_ot;
	
	grdWorkShift.SetGridText(row, 26, tmp_result);
	                    
	//Set this action to "edit" so that when a user click Update, it's only update the edited field.       
}
function AddOnClick()
{
    grdWorkShift.AddRow();
    grdWorkShift.SetGridText(grdWorkShift.rows-1,21,lstCompany.value);
}


//Ms Van modify 

function CheckUpdate()
{
    var rowvalue;
    for (var i=1;i<grdWorkShift.rows;i++)
    {
        rowvalue=grdWorkShift.GetGridData(i,3);
        if (isNaN(rowvalue)) //telephone
        {
            alert("Please input number in row " + i + " and column 3");
            return false;
        }
        rowvalue=grdWorkShift.GetGridData(i,4); //person id
        
        if (isNaN(rowvalue))
        {
            alert("Please input number in row " + i + " and column 4");
            return false;
        }
		rowvalue=grdWorkShift.GetGridData(i,5); //person id
        
        if (isNaN(rowvalue))
        {
            alert("Please input number in row " + i + " and column 5");
            return false;
        }
		rowvalue=grdWorkShift.GetGridData(i,6); //person id
        
        if (isNaN(rowvalue))
        {
            alert("Please input number in row " + i + " and column 6");
            return false;
        }
		
		rowvalue=grdWorkShift.GetGridData(i,9); //person id
        
        if (isNaN(rowvalue))
        {
            alert("Please input number in row " + i + " and column 9");
            return false;
        }
		
		rowvalue=grdWorkShift.GetGridData(i,12); //person id
        
        if (isNaN(rowvalue))
        {
            alert("Please input number in row " + i + " and column 12");
            return false;
        }        
    }
    return true;
}
function UpdateOnClick()
{
    if (CheckUpdate())
        if (confirm("do you want to save?"))
            datListWorkShift.Call();         
}
function DeleteOnClick()
{
    if (confirm("do you want to delte?"))
        grdWorkShift.DeleteRow();
}
function UnDeleteOnClick()
{
    grdWorkShift.UnDeleteRow();
}
///////////////////////

function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

</script>
<body>
    <gw:data id="datListWorkShift"   onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37" function="HR_SEL_80020020_WS_YUJIN" procedure="HR_UPD_80020020_WS_YUJIN"> 
                <input bind="grdWorkShift"  > 
                   <input bind="lstCompany" />                 
                </input>
                <output bind="grdWorkShift" > 
                </output>
            </dso> 
            
        </xml> 
    </gw:data> 
    <!------------------------------------------>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_get_company_user"  > 
                <input>
                    <input bind="txtUser_PK" />
                </input> 
                <output>
                    <output bind="lstCompany" />
                </output>
            </dso> 
        </xml> 
</gw:data>
    <table border=1 cellpadding=0 cellspacing=0 style="width:100%;height:100%">
        <tr style="height:5%">
        <td align=center style="width:100%">
            <table border=0 style="width:100%" cellpadding =0 cellspacing=0>
                <td style="color:Red;font-size:larger"align=right>Company</td>
                <td style="color:Red;font-size:larger; width:70%"><gw:list  id="lstCompany"  maxlen = "100" styles='width:70%'onchange="ChangeLocation()" >
                            <data>
                                <%= ESysLib.SetListDataSQL("SELECT a.pk,A.PARTNER_NAME FROM tco_company a where a.del_if=0 and nvl(a.active_yn,'N')='Y' order by A.PARTNER_ID")%>
                            </data>
                        </gw:list></td>
                <td width="4%" align=right><gw:imgBtn img="new"     alt="new"      id="ibtnAdd" 	onclick="AddOnClick()" /></td>					
			    <td width="4%" align=right><gw:imgBtn img="delete"  alt="delete"   id="ibtnDelete" 	onclick="DeleteOnClick()" /></td>  
			    <td width="4%" align=right><gw:imgBtn img="udelete" alt="undelete" id="ibtnDelete1" onclick="UnDeleteOnClick()" /></td> 
			    <td width="4%" align=right><gw:imgBtn img="save"    alt="save"     id="ibtnUpdate"  onclick="UpdateOnClick()"/></td>
			</table>
		</td>
        </tr>
        <tr style="height:95%">
            <td style="width:100%">
                <gw:grid   
					id="grdWorkShift"  
					header="_PK|Begin|End|WT|OT|NT|Shift|Start (1)|End (1)|Hour (1)|Start (2)|End (2)|Hour (2)|Start OT|Start NT|Use|Description|Days|WT Plus|Max OT|_WT Plus Rate|_company_pk|_Reverse OT|M OT|C OT|Type|Description 2|A_WT|A_TimeOut_F|A_TimeOut_T|A_OT_F|A_OT_T|A_OT_PLUS_1|A_OT_PLUS_2|A_OT_PLUS_3|A_KIND|A_KIND2|A_NOTE"   
					format="0|0|0|0|0|0|2|0|0|0|0|0|0|0|0|3|0|0|0|0|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
					aligns="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|1|0|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0"  
					defaults="|||||||||||||||-1||||||||||||||||||||"  
					editcol="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|1|1|1|1|1|1|1|1|1|1"  
					widths="0|800|800|500|500|500|500|1000|1000|800|1000|1000|800|1200|1200|600|6000|500|1000|1000|1000|0|1000|1000|1000|1000|1000|1200|1200|1200|1200|1200|1200|1200|1200|1200|1200"  
					styles="width:100%; height:100%;border:1"   
					sorting="T"   
					oncelldblclick="checkData()" onafteredit="checkData()" />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtidPK"  		text=""  style="display:none"/>  
    <gw:textbox id="txtidSaveData" 	text=""  style="display:none"/> 
    <gw:textbox id="txtAction" 	    text=""  style="display:none"/> 
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtUser_PK" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
</body>
</html>
