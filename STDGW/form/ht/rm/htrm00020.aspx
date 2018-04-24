<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Room Status Daily Report</title>
</head>
<%  ESysLib.SetUser("CRM")%>

<script>
 
    var  user_pk    = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name  = "<%=Session("USER_NAME")%>" ;
 function OnSearch()
 {
    data_htrm00020.Call("SELECT");
 }
 function BodyInit()
 {
	var data = '';
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='RTYPE'")%>";
	grdStatusDailyReport.SetComboFormat(0, data);//room type
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='RSTA'")%>";
	grdStatusDailyReport.SetComboFormat(2, data);//room type
 }
//=========================================================================
 
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htrm00020" onreceive=""> 
        <xml>
           <dso  type="grid"  function="crm.sp_sel_htrm00020" >
                <input  bind="grdStatusDailyReport">
                    <input bind="dtFrom" />
                </input> 
                <output bind="grdStatusDailyReport" /> 
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
                            <!--~<gw:datebox id="dtTo" lang="1" onchange="OnSearch()" /-->
                        </td>
                        <td style="width: 5%" align="right">
                        </td>
                        <td style="width: 5%" align="right">
                        </td>
                        <td style="width: 13%" align="right">
                        </td>
                        <td style="width: 10%;">
                            </td>
                        <td style="width: 10%;">
                        </td>
                        <td style="width: 3%; white-space: nowrap" align="center">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td width="3%" align="right">
                            <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
                        </td>
                        <td style="width: 29%" align="right">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
            <td>
                <gw:grid id='grdStatusDailyReport' header='Room Type|Total|Using|Amount'
                    format='0|0|0|-0' aligns='0|0|0|3' defaults='|||' editcol='0|0|0|0'
                    widths='1000|1000|1000|1000' sorting='T' styles='width:100%; height:100%'
                    autosize="T" acceptnulldate="T" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
