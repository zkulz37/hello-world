<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Daily Product Delivery</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>  
//===============================================================
function BodyInit()
{
    var data="";
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);
}
//===============================================================
//function OnDataReceive(obj)
//{
//    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/bo/rpt_shbo00170.rpt&export_pdf=Y&procedure=prod.sp_rpt_shbo00170&parameter=" + txtBatchNo.text + "," + dtIssueDate.value + "," + emp_pk + "," + user_id ;                            
//	System.OpenTargetPage(url); 
//}
//==============================================================
function OnPrint()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pp/rpt_shpp00050.rpt&export_pdf=Y&procedure=PROD.sp_rpt_shpp00050|PROD.sp_rpt_shpp00050_1|PROD.sp_rpt_shpp00050_2&parameter=" + dtReceiptDate.value +"|"+ dtReceiptDate.value + "," + txtWorkday.text + "," + txtActWorkday.text + "|"+ dtReceiptDate.value;                         
	System.OpenTargetPage(url);
}
 //==============================================================
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%; background-color: #B4CFEC" border="1">
        <tr>
            <td>
                <table style="height: 100%; width: 100%">
                    <tr style="height: 100%">
                        <td valign="middle" align="center">
                            <fieldset style="padding: 2; width: 50%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table width="100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td colspan="3" align="right">
                                            <gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnPrint()" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%" align="right">
                                            Plant
                                        </td>
                                        <td style="width: 75%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:list id="lstCompany" styles='width:100%' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%; white-space: nowrap" align="right">
                                            Date of Receipt
                                        </td>
                                        <td style="width: 30%" align="left" style="white-space: nowrap" colspan="2">
                                            <gw:datebox id="dtReceiptDate" lang="1" styles="width:100%" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%" align="right">
                                            <b>Product Type</b>
                                        </td>
                                        <td style="width: 3%" align="left" style="white-space: nowrap">
                                            <gw:checkbox id="chkProType" value='T' styles='width:100%' />
                                        </td>
                                        <td style="width: 35%">
                                            Gelatin Cap.
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="white-space: nowrap" align="center">
                                            <b style="color: Red">Workdays of Month</b>&nbsp;
                                            <gw:textbox id="txtWorkday" styles="width:8%" />&nbsp;
                                            <b style="color: Red">Actual Workdays</b>&nbsp;
                                            <gw:textbox id="txtActWorkday" styles="width:8%" />
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
    <gw:textbox id="txtMasterPK" style="display: none" />
    <gw:textbox id="txtEmpPK" style="display: none" />
    <gw:textbox id="txtReturnValue" style="display: none" />
</body>
<!--------------------------------------------------------------------------------------->
</html>
