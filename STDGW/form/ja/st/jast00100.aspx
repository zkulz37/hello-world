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
    dso_grdMarshallDepart.Call("SELECT");
}
function MergeRowGrid()
{
     var fg=grdMarshallDepart.GetGridControl();
		grdMarshallDepart.MergeByCol(0);
}
function OnDataReceive(obj)
{
    MergeRowGrid();
}
function OnReport()
{
//    var url = '/reports/ja/st/jast00060.aspx?p_dtfrom='+ dtfr.GetData();
//     System.OpenTargetPage( System.RootURL+url , "newform" );   
    url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/st/jast00100.rpt&procedure=CRM.sp_sel_jast00100&parameter="+dtfr.GetData();   
         	System.OpenTargetPage(url); 
}
</script>

</head>
<body>
 <gw:data id="dso_grdMarshallDepart" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" function="CRM.sp_sel_jast00100_form" >  
                <input bind="grdMarshallDepart" >  
                    <input bind="dtfr" /> 
                </input> 
                <output bind="grdMarshallDepart" /> 
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
                    id="grdMarshallDepart"
                    header="Time|Item|Time|9 Hole|18 Hole|27 Hole|36 Hole|Others|Total" 
                    format="0|0|0|0|0|0|0|0|0"
                    aligns="0|0|0|0|0|0|0|0|0" 
                    editcol="0|0|0|0|0|0|0|0|0" 
                    sorting='T' autosize='T'
	                styles="width:100%; height:100%"
                    />
            </td>
        </tr>
    </table>
</body>
</html>
