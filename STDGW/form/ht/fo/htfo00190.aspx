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
    data_htfo00190.Call("SELECT");
 }
 function BodyInit()
 {
//    var data;
//    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM COMM.TCO_COMMCODE WHERE DEL_IF = 0 AND PARENT_CODE = 'RTYPE'")%>";
//	grdArriving.SetComboFormat(7, data);
//	
//	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='CTYPE'" )%>"; 
//    grdArriving.SetComboFormat(1, data);
//	
//    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'")%>";
//	grdArriving.SetComboFormat(3, data);

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT num1, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='VAT'")%>";
	grdBills_List.SetComboFormat(5, data);
	//dtTo.SetDataText(System.AddDate(dtFrom.GetData(),15));
	OnSearch();
 }
 function OnClickGrid()
 {
    if(grdBills_List.rows-1 >0)
    {
        grdBills_List.row=-1;
    }
 }
//=========================================================================
 
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htfo00190" onreceive=""> 
        <xml>
           <dso  type="grid"  function="crm.sp_sel_htfo00190" >
                <input  bind="grdBills_List">
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtSlipNo" />
                </input> 
                <output bind="grdBills_List" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 5%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td align="right" style="width: 10%; white-space: nowrap">
                             Date
                        </td>
                        <td style="width: 15%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                            ~<gw:datebox id="dtTo" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                        </td>
                        <td style="width: 10%" align="right">
                            Slip No
                        </td>
                        <td width="26%">
                            <gw:textbox id="txtSlipNo" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 3%; white-space: nowrap" align="center">
                            <gw:imgbtn id="ibtnSearch1" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 40%" align="right">
                        </td>
                        <td style="width: 3%" align="right">
                        </td>
                        <td style="width: 3%" align="right">
                        </td>
                        <td width="3%" align="right"></td>
                        <td style="width: 3%" align="right">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
            <td>
                <gw:grid id='grdBills_List' header='No|Slip No|Trans Date|Room No|Total Amt|Vat Rate|Vat Amt|Total Amt|Description'
                    format='0|0|4|0|-0|0|-0|-0|0' aligns='0|0|0|0|3|1|3|3|0'
                    defaults='||||||||' editcol='0|0|0|0|0|0|0|0|0'
                    widths='1000|1000|1000|1000|1000|1000|1000|1000|1000'
                    sorting='T' styles='width:100%; height:100%' autosize="T"
                    acceptnulldate="T" oncellclick="OnClickGrid()" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
