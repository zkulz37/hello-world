<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Golf Club Daily Revenue Report</title>
    <%  ESysLib.SetUser("crm")%>
</head>

<script>
function BodyInit()
{
// dtTo.SetDataText(System.AddDate(dtFrom.GetData(),15));
  SetGridHeader();
  OnSearch();
}
function SetGridHeader()
{
  if(grdInquiry.rows == 1)
	{
		grdInquiry.AddRow();
	}
  var fg=grdInquiry.GetGridControl();
		fg.FixedRows  = 2
		fg.MergeCells = 5
		fg.MergeRow(0) = true
		fg.Cell(0, 0, 2, 0, 8) = "Team"  
		fg.Cell(0, 1, 2, 1) 	= "Morning"
		fg.Cell(0, 1, 3, 1 ) 	= "%"
		fg.Cell(0, 1, 4, 1) 	= "Afternoon"
		fg.Cell(0, 1, 5, 1 ) 	= "%"
		fg.Cell(0, 1, 6, 1 ) 	= "Total"
		fg.Cell(0, 1, 7, 1) 	= "Occ %"
			
		fg.MergeCol(0) = true
		fg.Cell(0, 0, 0, 1, 0) = "Date"

		fg.MergeCol(1) = true
		fg.Cell(0, 0, 1, 1, 1) = "Day"

		fg.MergeCol(8) = true
		fg.Cell(0, 0, 8, 1, 8) = "Players"

		fg.MergeCol(9) = true
		fg.Cell(0, 0, 9, 1, 9) = "Green Fee"

		fg.MergeCol(10) = true
		fg.Cell(0, 0, 10, 1, 10) = "Cadies Fee"

		fg.MergeCol(11) = true
		fg.Cell(0, 0, 11, 1, 11) = "Cart Fee"

		fg.MergeCol(12) = true
		fg.Cell(0, 0, 12, 1, 12) = "Total"
    //size of Inquiry grid
    fg.ColWidth(0)=1100;
    fg.ColWidth(1)=1300; 
    fg.ColWidth(2)=950;  
    fg.ColWidth(3)=950; 
    fg.ColWidth(4)=950; 
    fg.ColWidth(5)=950;  
    fg.ColWidth(6)=950; 
    fg.ColWidth(7)=950; 
    fg.ColWidth(8)=950; 
    fg.ColWidth(9)=1400; 
    fg.ColWidth(10)=1400; 
    fg.ColWidth(11)=1400; 
    fg.ColWidth(12)=1400; 
}
function OnSearch()
{
	dso_jabk0070.Call("SELECT");
}
function OnDataReceive(obj)
{
	if(obj.id=='dso_jabk0070')
	{
		SetGridHeader();
		txtCount.text = grdInquiry.rows - 1 + " record(s)";
	}
}
function OnPrint()
{
	 var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/bk/jabk0070.rpt&procedure=CRM.sp_sel_jabk0070_rpt&parameter=" + dtMonth.GetData();
            System.OpenTargetPage(url); 
}
</script>  
<body>
	<gw:data id="dso_jabk0070" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="CRM.sp_sel_jabk0070"> 
                <input bind="grdInquiry" > 
                     <input bind="dtMonth" /> 
                </input> 
                <output bind="grdInquiry" />  
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">  
					<tr style="height: 100%" valign="top">
                        <td>
                            <table style="width: 100%; height: 100%" border="0">
								<tr style=" height: 2%">
									<td style="width: 5%;" align="center">Date</td>
									<td width="7%" align="left"><gw:datebox id="dtMonth" type="month" lang="1" onchange="OnSearch()" /></td>
									<td style="width: 7%;" align="center">Total : </td>
									<td style="width: 13%;" align="center"><gw:label id="txtCount" /></td>
									<td style="width: 3%;"><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"    onclick="OnSearch()" /></td>
									<td style="width:3%">
								            <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnPrint()" styles='width:100%'/>
								    </td>
								<td style="width: 57%;"></td>
								</tr>
                                <tr style="height: 98%">
                                    <td colspan="7">
                                        <gw:grid id="grdInquiry" header="0|1|2|3|4|5|6|7|8|9|10|11|12" format="4|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0"
                                            aligns="0|0|3|3|3|3|3|3|3|3|3|3|0" defaults="||||||||||||" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            widths="0|0|0|0|0|0|0|0|0|0|0|0|0" sorting='T'
                                            styles="width:100%; height:100%" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
