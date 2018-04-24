<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>M/R CHECKING</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
 
    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
 function OnSearch()
 {
    data_htbk00020.Call("SELECT");
 }
 function BodyInit()
 {
	var data = '';
    data = "<%=ESysLib.SetListDataSQL("SELECT 'ALL', 'ALL' FROM DUAL UNION ALL SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'") %>";
	//lstNationality.SetDataText(data);
 }
 
 function OnNoShow()
 {
		var url = '/reports/ht/bk/rpt_htbk00020.aspx?from_dt='+ dtFrom.value +'&to_dt=' + dtTo.value ;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
 
 }
 
  function OnCancel()
 {
		var url = '/reports/ht/bk/rpt_htbk00021.aspx?from_dt='+ dtFrom.value +'&to_dt=' + dtTo.value ;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
 
 }
 function OnPopUp()
 {
	var path = System.RootURL + "/form/ht/bk/htbk00010_bus.aspx?";
			var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
			if ( object != null )
			{
				txtCustomerName.text			= object[4];
			}

 }
 function OnReport()
 {
	if(grdReservationHistory.rows > 1)
	{
		var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/bk/htbk00020.rpt&procedure=CRM.sp_rpt_htbk00020_inquiry&parameter="+dtFrom.value+","+dtTo.value+","+txtGuestName.text+","+txtCustomerName.text;   
         System.OpenTargetPage(url); 
	}
 }
//=========================================================================
 
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htbk00020" onreceive=""> 
        <xml>
           <dso  type="grid"  function="crm.sp_sel_htbk00020" >
                <input  bind="grdReservationHistory">
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtGuestName" />
                    <input bind="txtCustomerName" />
                </input> 
                <output bind="grdReservationHistory" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 5%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 5%; white-space: nowrap">
                             Date
                        </td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                            ~<gw:datebox id="dtTo" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                        </td>
                        <td style="width: 19%" align="right">Last Name/First Name
                        </td>
                        <td style="width: 13%" align="right">
                            <gw:textbox id="txtGuestName" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 10%" align="right"><b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp()">Customer</b>

                        </td>
                        <td style="width: 23%" align="right">
                            <gw:textbox id="txtCustomerName" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 3%; white-space: nowrap" align="center">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td width="3%" align="right"><gw:imgBtn id="ibtnReport" img="printer"   alt="Print"  onclick="OnReport()"/></td>
                        <td  style="width: 1%" align="right"></td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="idBtnCancel" img="2" text="Cancel" styles='width:100%' onclick="OnCancel()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="idBtnNoShow" img="2" text="No Show" styles='width:100%' onclick="OnNoShow()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
            <td>
                <gw:grid id='grdReservationHistory' 
					header	='Room|Last Name|First Name|Register By|Register Date|Arrival|Departure|Company Name|Request|Contact Name|Contact Phone'
                    format	='0|0|0|0|4|4|4|0|0|0|0'
					aligns	='1|0|0|0|1|1|1|0|0|0|0'
                    defaults='||||||||||' 
					editcol	='0|0|0|0|0|0|0|0|0|0|0'
                    widths	='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting	='T' 
					styles	='width:100%; height:100%' 
					autosize="T"
                    acceptnulldate="T" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
