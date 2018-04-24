<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Student</title>
     <%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
    OnSearch();
}
function OnSearch(){
    dso_grdGolfer.Call("SELECT");
}

function OnReport()
{
//    var url = '/reports/ja/st/jast00060.aspx?p_dtfrom='+ dtfr.GetData();
//     System.OpenTargetPage( System.RootURL+url , "newform" );   
    url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/st/jast00080.rpt&procedure=CRM.sp_sel_jast00060_1&parameter="+dtfr.GetData();   
         	System.OpenTargetPage(url); 
}
</script>

</head>
<body>
 <gw:data id="dso_grdGolfer" onreceive=""> 
        <xml> 
            <dso  type="grid" function="crm.sp_sel_jast00060_1" >  
                <input bind="grdGolfer" >  
                    <input bind="dtfr" /> 
                </input> 
                <output bind="grdGolfer" /> 
            </dso> 
        </xml> 
    </gw:data> 
    	
    <table width="100%" style="height:100%">
        <tr style="height: 2%">
            <td width="5%" >
                Date</td>
            <td width="8%" >
                <gw:datebox id="dtfr"  lang="1" onchange="OnSearch()" />
            </td>
             <td width="3%"></td>
            <td with="3%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td width="3%">
                <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
            </td>
            <td width="78%"></td>
        </tr>
        <tr style="height: 48%">
            <td colspan="6">
                <gw:grid 
                    id="grdGolfer"
                    header="_PK|Group#|_tgm_visitorfee|Player Name|Locker#|Bagtag#|Caddy#|Start Time|Total Time|Cross 1st|Cross 2nd|Cross 3rd
                    |Finish Time|Play Holes|Cart Holes|Printed Invoice|Print Time|Remark" 
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3|0|0"
                    aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|3|3|0|0|0" 
                    editcol="0|0|0|0|0|0|0|1|0|1|1|1|1|1|1|0|0|1" 
                    sorting='T' autosize='T'
	                styles="width:100%; height:100%"
                    />
            </td>
        </tr>
    </table>
</body>
</html>
