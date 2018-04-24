<!-- #include file="../../../system/lib/form.inc"  -->
<html >
<head>
    <title>Golf Cart Monthly Report</title>
     <%  ESysLib.SetUser("crm")%>

<script>
var arrTest = new Array();
function BodyInit()
{
    Binding();
    OnSearch();
}
function Binding()
{
   grdCaddyReport.SetColComboData(0, "#001;CONFIRM|#002;WAITING|#30;CANCEL|#038;TENTATIVE|#;");
   grdCaddyReport.SetColComboData(6, "#10;CONFIRM|#20;WAITING|#30;CANCEL|#40;TENTATIVE|#;");
   dtfr.SetDataText(System.AddDate(dtfr.GetData(),-30));
}
function OnSearch(){
    dso_CaddyReport.Call("SELECT");
}
function OnReport()
{
    /*var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/cd/jacd0070.rpt&procedure=CRM.sp_sel_jacd0070&parameter="+idMonth.GetData();
    System.OpenTargetPage(url);*/
}
function OnDataReceive(po_oData)
 {   
     arrTest = event.array;
     //alert(po_oData)
     switch(po_oData.id)
     {
        case "dso_CaddyReport":
            txtCount.text=grdCaddyReport.rows-1 + " Row(s).";
           grdCaddyReport.MergeByCol(2);
           //grdCaddyReport.MergeByCol(4);
           grdCaddyReport.MergeByCol(5);
           //grdCaddyReport.MergeByColFree(5);
        break;
     }
}
function OnAddRow(){
    grdCaddyReport.AddRow();
}
function OnRemoveRow(){
    //grdCaddyReport.RemoveRow();
    grdCaddyReport.ClearData();
    //grdCaddyReport.DeleteRow();
}
function OnGridCellEnter(obj){
    //alert(obj.GetGridData(event.row, event.col))
}
function OnGridCellDblClick(obj){
  //alert(obj.GetGridData(event.row, event.col))
}
function OnCellAfterEdit(obj){
    //alert(obj.GetGridData(event.row, event.col))
}

</script>

</head>
<body>

 <gw:data id="dso_CaddyReport" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" function="crm.sp_sel_jacd0080" >  
                <input bind="grdCaddyReport" >  
                    <input bind="dtfr" />
					<input bind="dtto" />	
					<input bind="txtID_Name" />		
                </input> 
                <output bind="grdCaddyReport" /> 
            </dso> 
        </xml> 
    </gw:data> 	
    <table width="100%" style="height:100%; font-weight:">
         <tr style="height: 2%">
            <td style="width: 5%">
                <b>Date</b></td>
            <td style="width: 26%">
                <gw:datebox id="dtfr"  lang="1" onchange="OnSearch()" />
				~ <gw:datebox id="dtto"  lang="1" onchange="OnSearch()" />
				
            </td>
			<td width="10%">
                Caddy#/Name</td>
            <td width="18%" >
                <gw:textbox id="txtID_Name" onenterkey="OnSearch()" />
            </td>
            <td align="right" style="width: 12%">
                <b>Total Record</b></td>
            <td style="width: 13%" align="center">
                <gw:label id="txtCount" />
            </td>
            <td style="width: 3%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 3%">
                <gw:imgbtn id="ibtnReport" style="display: none" img="printer" alt="Print" onclick="OnReport()"  />
            </td>
            <td style="width: 3%">
                <gw:imgbtn id="ibtnAdd" img="new" alt="Print" onclick="OnAddRow()"  />
            </td>
            <td style="width: 3%">
                <gw:imgbtn id="ibtnRemove" img="delete" alt="Print" onclick="OnRemoveRow()"  />
            </td>
        </tr>
        <tr style="height: 98%;">
            <td colspan="10" valign="top" >
                <div style="width:100%; height:500; overflow:auto">
                <gw:datagrid 
                    id="grdCaddyReport"
                    header="Caddy#|Full Name|Book Date|Book Time|Golfer Name|Holes|Status|Book Cart YN|Book Bag YN|Book Shoes YN" 
                    format="2|0|4|-4|0|0|2|3|3|3"
                    aligns="0|0|0|0|0|1|1|1|1|1" 
                    defaults="|||||||||" 
                    editcol="1|0|1|1|1|1|1|1|1|1" 
                    sorting='T' autosize='T' summary="true"
                    widths="100|200|200|100|100|100|100|100|100|100" 
	                style="width:100%;"
	                rowheight="17" paging="true" pageview="15"
	                onentercell="OnGridCellEnter(this)"
	                oncelldblclick="OnGridCellDblClick(this)"
	                onafteredit="OnCellAfterEdit(this)"
                    />
                </div>
                 
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" style="display: none" />
</body>
</html>
