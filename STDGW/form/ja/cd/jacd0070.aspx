<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Golf Cart Monthly Report</title>
     <%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
    OnSearch();
    //Binding();
}
function Binding()
{
}
function OnSearch(){
    dso_CaddyReport.Call("SELECT");
}
function OnReport()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/cd/jacd0070.rpt&procedure=CRM.sp_sel_jacd0070&parameter="+idMonth.GetData();
    System.OpenTargetPage(url);
}
function OnDataReceive(po_oData)
 {
     switch(po_oData.id)
     {
        case "dso_CaddyReport":
            txtCount.text=grdCaddyReport.rows-1 + " item(s).";
        break;
     }
}
</script>

</head>
<body>
 <gw:data id="dso_CaddyReport" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" function="crm.sp_sel_jacd0070_form" >  
                <input bind="grdCaddyReport" >  
                    <input bind="idMonth" /> 
                </input> 
                <output bind="grdCaddyReport" /> 
            </dso> 
        </xml> 
    </gw:data> 	
    <table width="100%" style="height:100%">
         <tr style="height: 2%">
            <td style="width: 5%">
                <b>Date</b></td>
            <td style="width: 10%">
                <gw:datebox id="idMonth" maxlen="10" text="" styles='width:50%' lang="<%=Session("Lang")%>"
                    type="month" onchange="OnSearch()" />
            </td>
            <td align="right" style="width: 10%">
                <b>Total Record</b></td>
            <td style="width: 10%" align="center">
                <gw:label id="txtCount" />
            </td>
            <td style="width: 7%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 3%">
                <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
            </td>
            <td style="width: 45%" align="right">
            </td>
        </tr>
        <tr style="height: 98%">
            <td colspan="7">
                 <gw:grid 
                    id="grdCaddyReport"
                    header="_No|Cart No|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|Total" 
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    defaults="|||||||||||||||||||||||||||||||||" 
                    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    sorting='T'
                    autosize='T'
	                styles="width:100%; height:100%"
                    />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" style="display: none" />
</body>
</html>
