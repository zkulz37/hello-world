<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Document</title>
</head>
<%  ESysLib.SetUser("crm")%>
<script>
function BodyInit()
{
    var data = "<%=ESysLib.SetListDataSQL("SELECT A.PK, A.COURSE_ID ||' - '|| A.COURSE_NAME FROM CRM.TGM_GOLF_COURSE A WHERE A.DEL_IF =0 " ) %>";	
	lstMemberType.SetDataText(data);
	//lstMemberType.value="ALL";
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.PK, A.COURSE_ID ||' - '|| A.COURSE_NAME FROM CRM.TGM_GOLF_COURSE A WHERE A.DEL_IF =0 " )%>"; 
	grdTeeTimeSheet.SetComboFormat(2,data);
//	 var ctrl = grdTeeTimeSheet.GetGridControl();
//   ctrl.ColEditMask(2) = "##:##";  
    dat_TeeTimeSheet.Call("SELECT");
}
function OnAddnew()
{
   
    if(txtBeginTime.text.length != 5) {
		alert("Please input begin time with format(hh:mi).");
		txtBeginTime.GetControl().focus();
		return;
	}
	if(txtTotalGroup.text == "") {
		alert("Please input total group.");
		txtTotalGroup.GetControl().focus();
		return;
	}
    if(txtInterval.text == "") {
		alert("Please input interval.");
		txtInterval.GetControl().focus();
		return;
	}
    var ArrBeginTime = txtBeginTime.text.split(":"); 
    var hh_mm;  
    var hh,mi; 	
	var t_hh,t_mi,t_hhmi;
	
	hh=Number(ArrBeginTime[0]);
    mi=Number(ArrBeginTime[1]);
    
	for (var i = 1; i <= Number(txtTotalGroup.text) ; i ++ )
	{
		if(i > 1){
				mi += Number(txtInterval.GetData());
	    }
		
		if(mi >= 60)
		{
			mi -= 60;
			hh += 1;
		}
		
		if(mi < 10){
		   t_mi = "0" + mi;
		}
		else{
			t_mi = mi;
		}
		
		if(hh < 10){
		   t_hh = "0" + hh;
		}
		else{
			t_hh = hh;
		}
		t_hhmi = t_hh + ":" + t_mi;
		grdTeeTimeSheet.AddRow();
		grdTeeTimeSheet.SetGridText(grdTeeTimeSheet.rows-1,3,t_hhmi);
		grdTeeTimeSheet.SetGridText(grdTeeTimeSheet.rows-1,1,dtMonth.GetData());
		grdTeeTimeSheet.SetGridText(grdTeeTimeSheet.rows-1,2,lstMemberType.value);
		grdTeeTimeSheet.SetGridText(grdTeeTimeSheet.rows-1,5,-1);
	}    
}
function OnSearch()
{
    dat_TeeTimeSheet.Call("SELECT");
}
function OnDelete()
{
    if(confirm('Are you sure you want to delete ?'))
	{
        grdTeeTimeSheet.DeleteRow();
        dat_TeeTimeSheet.Call();
    }
}
function OnSave()
{
    if(CheckData())
    {
        dat_TeeTimeSheet.Call();
     }
}
function CheckData()
{
    for(var i=1;i<grdTeeTimeSheet.rows;i++)
          {
            if(grdTeeTimeSheet.GetGridData(i,2) == "")
             {
                alert("Please input tee time at row   "+ i);
                
                return false;
             }
                         
          }
          return true;
}
function CheckTimeBegin()
{
    //var pattern = /^\d{1,2}:\d{2}$/;	
	 var matchArray = txtBeginTime.text.split(":"); 
	 var hh_mm = matchArray[0]+":"+matchArray[1];
	
	 if (txtBeginTime.text != hh_mm) 
	 { 
	 	alert("Please enter valid format(HH:MM).");
		txtBeginTime.text = "";
	 	return false;  
	 }   
	 hour = matchArray[0]; 
	 minute = matchArray[1];
	  if (hour < 0  || hour > 23) 
	 { 
	 	alert("Please enter hour between 1 and 23.");
	 	txtBeginTime.text = "";
	 	return false;
	 }
	 if (minute<0 || minute > 59) 
	 {  
	 	alert ("Please enter minute between 0 and 59.");  
		txtBeginTime.text = "";
		return false; 
	 } 
         
	 return true; 
}
function CheckTimeEnd()
{
    var pattern = /^\d{1,2}:\d{2}$/;	
	 var matchArray = txtTimeEnd.text.split(":"); 
	 var hh_mm = matchArray[0]+":"+matchArray[1];
	
	 if (txtTimeEnd.text != hh_mm) 
	 { 
	 	alert("Please enter valid format(HH:MM).");
		txtTimeEnd.text = "";
	 	return false;  
	 }   
	 hour = matchArray[0]; 
	 minute = matchArray[1];
	 if (hour < 0  || hour > 23) 
	 { 
	 	alert("Please enter hour between 1 and 23.");
	 	txtTimeEnd.text = "";
	 	return false;
	 }
	 if (minute<0 || minute > 59) 
	 {  
	 	alert ("Please enter minute between 0 and 59.");  
		txtTimeEnd.text = "";
		return false; 
	 } 
         
	 return true; 
}
</script>
<body>
<!----------------------------------------------------------------------------------------------->
<gw:data id="dat_TeeTimeSheet"  onreceive="" > 
    <xml> 
        <dso  type="grid"   parameter="0,1,2,3,4,5,6" function="CRM.sp_sel_jabs00070" procedure="CRM.sp_upd_jabs00070"> 
            <input bind="grdTeeTimeSheet">                    
                <input bind="lstMemberType" /> 
				<input bind="dtMonth" /> 
            </input> 
            <output bind="grdTeeTimeSheet" />
        </dso> 
    </xml> 
</gw:data>
<!----------------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 5%">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table border="0" width="100%" id="table1">
                                <tr>
                                    <td>
                                        <fieldset style="padding: 2; width: 100%; height: 100%">
                                            <table border="0" width="100%" id="table2">
                                                <tr>
                                                    <td width="10%">
                                                        Golf Type</td>
                                                    <td width="15%">
                                                        <gw:list id="lstMemberType" styles="background-color:#fffaaf" onchange="OnSearch()" />
                                                    </td>
													<td width="8%">
                                                        Month</td>
                                                    <td width="8%">
														<gw:datebox id="dtMonth" type="month" onchange='OnSearch()'/>
                                                    </td>
                                                    <td width="10%">
                                                        Begin Time</td>
                                                    <td width="8%">
                                                        <gw:textbox id="txtBeginTime" styles='width:100%;; text-align: center' text="06:00" onchange='CheckTimeBegin()' />
                                                    </td>
                                                    <td width="10%">
                                                        Total Group</td>
                                                    <td width="8%">
                                                        <gw:textbox id="txtTotalGroup" styles='width:100%;; text-align: center' text="18" onchange='' />
                                                    </td>
                                                    <td width="8%">
                                                        Interval</td>
                                                    <td width="8%">
                                                        <gw:textbox id="txtInterval" styles='width:100%;text-align: right' text="8"  />
                                                    </td>
                                                    <td width="1%"></td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Process" onclick="OnSearch()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch2" img="new" width="100%" img="in" text="Process" onclick="OnAddnew()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch4" img="delete" width="100%" img="in" text="Process" onclick="OnDelete()" />
                                                    </td>
                                                    <td width="3%">
                                                        <gw:imgbtn id="btnSearch3" img="save" width="100%" img="in" text="Process" onclick="OnSave()" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="width: 100%; height: 95%">
            <td width="100%">
                <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
                    <tr valign="top">
                        <td width="100%">
                            
                            <gw:grid id="grdTeeTimeSheet" header="_PK|Month|Golf Type|Tee Time|Slot|Use YN|_Description"
                                format="0|0|0|0|0|3|0" aligns="0|0|0|1|3|0|0" defaults="||||4||" editcol="1|1|1|1|1|1|1"
                                widths="1000|1000|1000|1000|1000|1000|1000" styles="width:100%; height:100%"
                                sorting="T"  autosize="T" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk" style="display:none"/>
	<gw:textbox id="txtTimeEnd"  style="display:none" onchange='CheckTimeEnd()' />
</body>
</html>
