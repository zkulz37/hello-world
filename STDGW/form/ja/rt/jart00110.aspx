<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Golf F&B Report</title>
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
		grdInquiry.AddRow();
	}
    grdInquiry.SetCellBold(0,1,1,28,true);
    fg.FixedRows = 3;
    fg.FixCols=1;
    fg.MergeCells = 5;
    
    fg.MergeCol(0) = true
    fg.Cell(0, 0, 0, 2, 0) = "Invoice#";
    
    fg.MergeCol(1) = true
    fg.Cell(0, 0, 1, 2, 1) = "Tee - Off Time";
    
    fg.MergeCol(2) = true
    fg.Cell(0, 0, 2, 2, 2) = "Name(Family,Given)";
    
    fg.MergeCol(3) = true
    fg.Cell(0, 0, 3, 2, 3) = "Player Type"
    
    fg.MergeCol(4) = true
    fg.Cell(0, 0, 4, 2, 4) = "Locker#";
    
    fg.MergeCol(5) = true
    fg.Cell(0, 0, 5, 2, 5) = "No Of Holes Played";

	fg.MergeCol(26) = true
    fg.Cell(0, 0, 26, 2, 26) = "Special Consumption Tax";

	fg.MergeCol(27) = true
    fg.Cell(0, 0, 27, 2, 27) = "VAT";

	fg.MergeCol(28) = true
    fg.Cell(0, 0, 28, 2, 28) = "Total Revenue & Tax";

    fg.MergeRow(0) = true
    fg.Cell(0, 0, 6, 0, 25) = "Food & Beverage Revenue(VND)";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 6, 1, 9) = "Club - Hse";
    fg.Cell(0, 2, 6, 2)    = "Cover";
    fg.Cell(0, 2, 7, 2 )   = "Food";
    fg.Cell(0, 2, 8, 2)    = "Bev";
    fg.Cell(0, 2, 9, 2)    = "Total";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 10, 1, 13) = "Academy";
    fg.Cell(0, 2, 10, 2)    = "Cover";
    fg.Cell(0, 2, 11, 2 )   = "Food";
    fg.Cell(0, 2, 12, 2)    = "Bev";
	fg.Cell(0, 2, 13, 2)    = "Total";
    
    fg.MergeRow(1) = true
    fg.Cell(0, 1, 14, 1, 17) = "T - Hse 6";
    fg.Cell(0, 2, 14, 2)    = "Cover";
    fg.Cell(0, 2, 15, 2 )   = "Food";
    fg.Cell(0, 2, 16, 2)    = "Bev";
    fg.Cell(0, 2, 17, 2)    = "Total";

	fg.MergeRow(1) = true
    fg.Cell(0, 1, 18, 1, 21) = "T - Hse 14";
    fg.Cell(0, 2, 18, 2)    = "Cover";
    fg.Cell(0, 2, 19, 2 )   = "Food";
    fg.Cell(0, 2, 20, 2)    = "Bev";
	fg.Cell(0, 2, 21, 2)    = "Total";

	fg.MergeRow(1) = true
    fg.Cell(0, 1, 22, 1, 25) = "Total";
    fg.Cell(0, 2, 22, 2)    = "Cover";
    fg.Cell(0, 2, 23, 2 )   = "Food";
    fg.Cell(0, 2, 24, 2)    = "Bev";
	fg.Cell(0, 2, 25, 2)    = "Total";

	
    //size of Inquiry grid
    fg.ColWidth(0)=1400;
    fg.ColWidth(1)=1280; 
    fg.ColWidth(2)=3500;  
    fg.ColWidth(3)=1450; 
    fg.ColWidth(4)=900; 
    fg.ColWidth(5)=1650;  
    fg.ColWidth(6)=1000; 
    fg.ColWidth(7)=1000; 
    fg.ColWidth(8)=1000; 
    fg.ColWidth(9)=1000; 
    fg.ColWidth(10)=1000; 
    fg.ColWidth(11)=1000; 
    fg.ColWidth(12)=1000; 
    fg.ColWidth(13)=1000; 
    fg.ColWidth(14)=1000;  
    fg.ColWidth(15)=1000;    
    fg.ColWidth(16)=1000; 
    fg.ColWidth(17)=1000; 
    fg.ColWidth(18)=1000;  
    fg.ColWidth(19)=1000;   

	fg.ColWidth(20)=1000; 
    fg.ColWidth(21)=1000; 
    fg.ColWidth(22)=1000; 
    fg.ColWidth(23)=1000; 
    fg.ColWidth(24)=1000;  
    fg.ColWidth(25)=1000;    
    fg.ColWidth(26)=2400; 
    fg.ColWidth(27)=1600; 
    fg.ColWidth(28)=1500;  
   
}
function OnSearch()
{
	dso_jart00110.Call("SELECT");
}
function OnDataReceive(obj)
{
	if(obj.id=='dso_jart00110')
	{
		SetGridHeader();
		if (grdInquiry.rows > 2)
			{
				txtCount.text = grdInquiry.rows - 1 + " record(s)";
				grdInquiry.Subtotal( 1, 2, -1, '7!8!9');
			}
	}
}
function OnPrint()
{
	 var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/jart00110.rpt&procedure=CRM.sp_sel_jart00110_rpt&parameter=" + dtbFrom.GetData();
            System.OpenTargetPage(url); 
}
</script>  
<body>
	<gw:data id="dso_jart00110" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_jart00110"> 
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
									<td style="width: 10%;" align="center">Date</td>
									<td width="7%" align="left"><gw:datebox id="dtbFrom" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch()" /></td>
									
									<td style="width: 7%;" align="center">Total : </td>
									<td style="width: 13%;" align="center"><gw:label id="txtCount" /></td>
									<td style="width: 3%;"><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"    onclick="OnSearch()" /></td>
									<td style="width:3%">
								            <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnPrint()" styles='width:100%'/>
								    </td>
									<td style="width: 57%;"></td>
								</tr>
                                <tr style="height: 98%">
                                    <td colspan="9">
                                        <gw:grid id="grdInquiry" header="0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28" format="0|0|0|0|0|0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0|-0"
                                            aligns="0|0|0|0|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3" defaults="|||||||||||||||||||||||||||" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            widths="1500|1500|2000|2000|2000|1000|1000|1000|1000|2000|2000|500|500|500|500|500|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000" sorting='T'
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
