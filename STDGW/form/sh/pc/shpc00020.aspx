<!-- #include file="../../../system/lib/form.inc"  -->
<html>
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("prod")%>
<script>
function BodyInit()
{
    var data="";
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);
        DtFrom.value	= "<%=Request.querystring("p_date_from")%>";
        DtTo.value	= "<%=Request.querystring("p_date_to")%>";
}
function OnPrint()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=sh/pc/shpc00020.rpt&procedure=PROD.sp_sel_shpc00010_rpt&parameter="+lstCompany.value+','+ DtFrom.value +',' + DtTo.value;              
	System.OpenTargetPage(url);
	window.close(); 
}
</script>
<body>
        <fieldset> 
        <table style="background: #BDE9FF;height: 100%; width: 100%">
        <tr>
            <td style="width: 20%">
            </td>
            <td style="width: 60%">
            <table style="height: 100%; width: 100%">
             <!--<tr style="height: 1%;" valign="top">
                <td style="width: 20%"></td>
                <td style="width: 80%" align="right"><gw:imgbtn id="ibtnReport" img="printer" alt="Print Acct" onclick="OnReportAcct()" styles='width:100%'/></td>
            </tr>-->
            <tr valign="top" style="height: 1%;">
                <td style="width: 35%" align="right">Pant</td>
                <td style="width: 65%"><gw:list id="lstCompany" styles='width:100%' /></td>
            </tr>
            <tr valign="top" style="height: 1%;">
                <td style="width: 35%" align="right">Instructed Date</td>
                <td style="width: 65%">
                    <table>
                        <tr>
                            <td>
                            <gw:datebox id="DtFrom" maxlen="10"   styles='width:100%' lang="<%=Session("Lang")%>"/></td>
                            <td>
                            ~
                            </td>
                            <td>
                            <gw:datebox id="DtTo" maxlen="10"   styles='width:100%' lang="<%=Session("Lang")%>"/></td>
                        </tr>
                    </table>
                </td>
            </tr>
            </table>
            </td>
            <td style="width: 20%">
            <table style="background: #BDE9FF;height: 100%; width: 100%">
               <tr style="height: 100%;" valign="top">
                <td style="width: 35%"></td>
                <td style="width:65%" align="right"><gw:imgbtn id="ibtnReport" img="printer" alt="Print Acct" onclick="OnPrint()" styles='width:100%'/></td>
            </tr>
            </table>
            </td>
        </tr>
            <tr valign="top" style="height: 97%;"></tr>
        </table>
        </fieldset>
</body>
</html>
