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
}
function SetGridHeader()
{
   var fg=grdInquiry.GetGridControl(); 
    fg.FrozenCols = 3;
    if(grdInquiry.rows == 1)
	{
		grdInquiry.AddRow();
	}
    grdInquiry.SetCellBold(0,1,1,24,true);
    fg.FixedRows = 2;
    fg.FixCols=1;
    fg.MergeCells = 5;
    
    fg.MergeCol(0) = true
    fg.Cell(0, 0, 0, 1, 0) = "Invoice#";
    
    fg.MergeCol(1) = true
    fg.Cell(0, 0, 1, 1, 1) = "Tee - Off Time";
    
    fg.MergeCol(2) = true
    fg.Cell(0, 0, 2, 1, 2) = "Name(Family,Given)";
    
    fg.MergeCol(3) = true
    fg.Cell(0, 0, 3, 1, 3) = "Player Type"
    
    fg.MergeCol(4) = true
    fg.Cell(0, 0, 4, 1, 4) = "Locker#";
    
    fg.MergeCol(5) = true
    fg.Cell(0, 0, 5, 1, 5) = "No Of Holes Played";
	
	fg.MergeCol(6) = true
    fg.Cell(0, 0, 6, 1, 6) = "Finish Time";
	
    fg.MergeRow(0) = true
    fg.Cell(0, 0, 7, 0, 17) = "Revenue(VND)";
    
    fg.MergeRow(0) = true
    fg.Cell(0, 1, 7, 1, 7) = "Green Fee";
	fg.Cell(0, 1, 8, 1, 8) = "Cadies Fee";
	fg.Cell(0, 1, 9, 1, 9) = "Cart Fee";
	fg.Cell(0, 1, 10, 1, 10) = "Driving Range";
	fg.Cell(0, 1, 11, 1, 11) = "Teaching Pro";
    fg.Cell(0, 1, 12, 1, 12) = "Rental";
	fg.Cell(0, 1, 13, 1, 13) = "Pro-shop";
	fg.Cell(0, 1, 14, 1, 14) = "Tee House";
	fg.Cell(0, 1, 15, 1, 15) = "F&B";
	fg.Cell(0, 1, 16, 1, 16) = "Orthers";
	fg.Cell(0, 1, 17, 1, 17) = "Total";
    
	fg.MergeCol(18) = true
    fg.Cell(0, 0, 18, 1, 18) = "Specical Consumption Tax";
	fg.MergeCol(19) = true
    fg.Cell(0, 0, 19, 1, 19) = "VAT";
	fg.MergeCol(20) = true
    fg.Cell(0, 0, 20, 1, 20) = "Total Rev&Taxes";


	fg.MergeRow(0) = true
    fg.Cell(0, 0, 21, 0, 22) = "Cash";
    
    fg.MergeRow(0) = true
    fg.Cell(0, 1, 21, 1, 21) = "VND";
	fg.Cell(0, 1, 22, 1, 22) = "USD";

	fg.MergeRow(0) = true
    fg.Cell(0, 0, 23, 0, 24) = "Credit Card";
    
    fg.MergeRow(0) = true
    fg.Cell(0, 1, 23, 1, 23) = "VND";
	fg.Cell(0, 1, 24, 1, 24) = "USD";

	fg.MergeCol(25) = true
    fg.Cell(0, 0, 25, 1, 25) = "Acc R;able";
    //size of Inquiry grid
    fg.ColWidth(0)=1400;
    fg.ColWidth(1)=1280; 
    fg.ColWidth(2)=3500;  
    fg.ColWidth(3)=1450; 
    fg.ColWidth(4)=900; 
    fg.ColWidth(5)=1650;  
    fg.ColWidth(6)=1150; 
    fg.ColWidth(7)=1500; 
    fg.ColWidth(8)=1500; 
    fg.ColWidth(9)=1500; 
    fg.ColWidth(10)=1500; 
    fg.ColWidth(11)=1500; 
    fg.ColWidth(12)=1500; 
    fg.ColWidth(13)=1500; 
    fg.ColWidth(14)=1500;  
    fg.ColWidth(15)=1500;    
    fg.ColWidth(16)=1500; 
    fg.ColWidth(17)=1500; 
    fg.ColWidth(18)=1500;  
    fg.ColWidth(19)=1500;   
	fg.ColWidth(20)=1500; 
    fg.ColWidth(21)=1500; 
    fg.ColWidth(22)=1500; 
    fg.ColWidth(23)=1500; 
    fg.ColWidth(24)=1500;
	fg.ColWidth(25)=1500;   	
}
function OnSearch()
{
	dso_jart00120.Call("SELECT");
}
function OnReport(){
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/jart00120.rpt&procedure=CRM.sp_sel_jart00120_rpt&parameter=" + dtbFrom.GetData();
    System.OpenTargetPage(url); 
}
function OnDataReceive(obj)
{
	if(obj.id=='dso_jart00120')
	{
		SetGridHeader();
		if (grdInquiry.rows > 2)
			{
				txtCount.text = grdInquiry.rows - 1 + " record(s)";
				//grdInquiry.Subtotal( 1, 2, -1, '7!8!9');
			}
	}
}
</script>  
<body>
	<gw:data id="dso_jart00120" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="CRM.sp_sel_jart00120"> 
                <input bind="grdInquiry" > 
                     <input bind="dtbFrom" /> 
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
						<td width="7%" align="left"><gw:datebox id="dtbFrom" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch()" /></td>
						<td style="width: 3%;"><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"    onclick="OnSearch()" /></td>
						<td style="width: 15%;"></td>
						<td style="width: 10%" align="center">
							Total :
						 </td>
						 <td style="width: 18%" align="center">
							<gw:label id="txtCount" />
						 </td>
						<td style="width: 40%;"></td>
						<td style="width: 2%;">
						    <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
						</td>
					</tr>
                    <tr style="height: 98%">
                        <td colspan="8">
                            <gw:grid id="grdInquiry" header="0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25" 
							format="0|0|0|0|0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0"
                                aligns="0|0|0|0|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3" 
								defaults="||||||||||||||||||||||||" 
								editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                widths="1500|1500|2000|2000|2000|1000|1000|1000|1000|2000|2000|2000|500|500|500|500|500|1000|1000|1000|1000|1000|1000|1000|1000|1000" sorting='T'
                                styles="width:100%; height:100%" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

</body>
</html>
