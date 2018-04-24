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

//==============================================================
function OnPrint()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?file=sh/pp/rpt_shpp00200.rpt&export_pdf=Y&procedure=prod.sp_rpt_shpp00200&parameter=" + dtDateFrom.value + "," + dtDateTo.value;
	System.OpenTargetPage(url);
}
 //==============================================================
 function OnPopUp(obj)
{
}
//===============================================================
function OnDataReceive(obj)
{

}
//===============================================================
function OnClosing()
{

}
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%; background-color: #B4CFEC" border="1">
        <tr>
            <td style="width: 100%">
                <table style="height: 100%; width: 100%" border="0">
                    <tr style="height: 100%">
                        <td style="width: 100%" valign="middle" align="center">
                            <fieldset style="padding: 2; width: 50%">
                                <legend><font color="blue" size="4"><b><i>Optional</i></b></font></legend>
                                <table style="width: 100%" cellpadding="1" cellspacing="2" border="0">
                                    <tr>
                                        <td colspan="3" align="right">
                                            <gw:imgbtn img="printer" alt="Print" id="btnPrint" onclick="OnPrint()" />
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%" align="right">
                                            Plant
                                        </td>
                                        <td style="width: 75%; white-space: nowrap" align="left" colspan="2">
                                            <gw:list id="lstCompany" styles='width:100%' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 25%; white-space: nowrap" align="right">
                                            Period
                                        </td>
                                        <td style="width: 5%; white-space: nowrap" align="left">
                                            <gw:datebox id="dtDateFrom" lang="1" />
                                            ~
                                            <gw:datebox id="dtDateTo" lang="1" />
                                        </td>
                                        <td style="width: 70%; white-space: nowrap" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%" align="right">
                                        </td>
                                        <td style="width: 35%; white-space: nowrap">
                                            <gw:checkbox id="chkProType" styles='width:10%' />
                                            Gelatin Cap.
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
