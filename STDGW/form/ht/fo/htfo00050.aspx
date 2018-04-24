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
    data_htfo00050.Call("SELECT");
 }
 function BodyInit()
 {
	var data = '';
	OnSearch();
	SetGridHeader();
 }
 function OnReport()
 {
        var url = '/reports/ht/fo/htfo00050.aspx?p_dt_frm='+ dtFrom.value;
	    System.OpenTargetPage( System.RootURL+url , "newform" );
 }
 
 function OnReportFRD()
 {
  	    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ht/fo/rpt_htfo00052.rpt&procedure=CRM.sp_rpt_htfo00052&parameter="+dtFrom.value;   
	    System.OpenTargetPage(url); 
 }
 
function SetGridHeader()
{
  if(grdIncomeDailyReport.rows == 1)
	{
		grdIncomeDailyReport.AddRow();
	}
	 var fg=grdIncomeDailyReport.GetGridControl();
		fg.FixedRows  = 2
		fg.MergeCells = 3
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 1, 0, 1) = ""  
		fg.Cell(0, 0, 2, 0, 3) = "MTD"
		fg.Cell(0, 0,4, 0, 5) = "YTD"  
		
		fg.Cell(0, 1, 1, 1) 	= "Today"
		fg.Cell(0, 1, 2, 1 ) 	= "Actual"
		fg.Cell(0, 1, 3, 1) 	= "Budget"
		fg.Cell(0, 1, 4, 1) 	= "Actual"
		fg.Cell(0, 1, 5, 1 ) 	= "Budget"
		
		 fg.ColWidth(0)=4500;

		fg.ColWidth(1)=1600; 
		fg.ColWidth(2)=2000;  
		fg.ColWidth(3)=2000;
		
		fg.ColWidth(4)=2000; 
		fg.ColWidth(5)=2000;  
		
		fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = ""
	}
function OnDataReceive(obj)
{
	if(obj.id=='data_htfo00050')
	{
		if(grdIncomeDailyReport.rows > 1)
		{
			SetGridHeader();
		}
	}
}
//=========================================================================
 
</script>

<body>
    <!----------------------------------------------------------------------->
    <gw:data id="data_htfo00050" onreceive="OnDataReceive(this)"> 
        <xml>
           <dso  type="grid"  function="crm.sp_sel_room_daily_report" >
                <input  bind="grdIncomeDailyReport">
                    <input bind="dtFrom" />
                </input> 
                <output bind="grdIncomeDailyReport" /> 
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
                        <td style="width: 10%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="<%=Session("Lang")%>" onchange="OnSearch()" />
                        </td>
                        <td style="width: 1%" align="right">
                        </td>
                        <td style="width: 3%" align="right">
                        </td>
                        <td style="width: 3%; white-space: nowrap" align="center">
                            <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td width="3%" align="right">
                            <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
                        </td>
                        
                        <td style="width: 30%" align="right">
                        </td>
                        <td style="width: 8%" align="right">
                            <gw:icon id="idBtnFRDReport" img="2" text="Final Revenue Daily Report" styles='width:100%' onclick="OnReportFRD()" />
                        </td>
                         <td style="width: 40%" align="right">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 95%">
            <td>
                <gw:grid id='grdIncomeDailyReport' header='1|2|3|4|5|6' format='0|-0|-0|-0|-0|-0'
                    aligns='0|3|3|3|3|3' defaults='|||||' editcol='0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000'
                    sorting='T' styles='width:100%; height:100%' autosize="T" acceptnulldate="T" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
</body>
</html>
