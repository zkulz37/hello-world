<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Golf Operation Data</title>
    <%  ESysLib.SetUser("crm")%>
</head>

<script>
function BodyInit(){
  SetGridHeader();
  OnSearch();
}
function SetGridHeader()
{
    var fg = grdData.GetGridControl(); 
    fg.FrozenCols = 7;
    if(grdData.rows == 1)
	  grdData.AddRow();

    grdData.SetCellBold(0,1,1,21,true);
    fg.FixedRows = 2;
    fg.FixCols=1;
    fg.MergeCells = 5;
    
	fg.MergeCol(0) = true;
    fg.Cell(0, 0, 0, 1, 0) = "Player Type";
	
    fg.MergeCol(1) = true;
    fg.Cell(0, 0, 1, 1, 1) = "Invoice No.";
    
    fg.MergeCol(4) = true;
    fg.Cell(0, 0, 4, 1, 4) = "Check in time";
    
    fg.MergeCol(7) = true;
    fg.Cell(0, 0, 7, 1, 7) = "Name (Family, Given)";
    
    fg.MergeCol(8) = true;
    fg.Cell(0, 0, 8, 1, 8) = "Locker No.";
    
    fg.MergeCol(11) = true;
    fg.Cell(0, 0,11, 1,11) = "Caddie No.";
    
    fg.MergeCol(16) = true;
    fg.Cell(0, 0,16, 1,16) = "Finish Time";
    
    fg.MergeCol(17) = true;
    fg.Cell(0, 0,17, 1,17) = "Check out time";
    
    fg.MergeRow(0) = true;
    fg.Cell(0, 0, 2, 0, 3) = "Team";
    fg.Cell(0, 0, 5, 0, 6) = "Tee-Off";
	
    fg.Cell(0, 0, 9, 0,10) = "Course Played";
    fg.Cell(0, 0,12, 0,13) = "Cart used";
    fg.Cell(0, 0,14, 0,15) = "Cross Over Time";
    fg.Cell(0, 0,18, 0,21) = "Time Taken";
    
    fg.MergeRow(1) = true;
    fg.Cell(0, 1, 2, 1, 2) = "Team No.";
    fg.Cell(0, 1, 3, 1, 3) = "No. of Player";
    fg.Cell(0, 1, 5, 1, 5) = "Time";
    fg.Cell(0, 1, 6, 1, 6) = "T-Box";
    fg.Cell(0, 1, 9, 1, 9) = "Course";
    fg.Cell(0, 1,10, 1,10) = "No. of Holes";
    fg.Cell(0, 1,12, 1,12) = "No. of Hole";
    fg.Cell(0, 1,13, 1,13) = "Cart No.";
    fg.Cell(0, 1,14, 1,14) = "1st";
    fg.Cell(0, 1,15, 1,15) = "2nd";
    fg.Cell(0, 1,18, 1,18) = "1st-9";
    fg.Cell(0, 1,19, 1,19) = "2nd-9";
    fg.Cell(0, 1,20, 1,20) = "3rd-9";
    fg.Cell(0, 1,21, 1,21) = "Total";
    
    //size of grid
    fg.ColWidth(0)  =1600;
    fg.ColWidth(1)  =1200; 
    fg.ColWidth(2)  =1300;  
    fg.ColWidth(3)  =1300; 
    fg.ColWidth(4)  =1400; 
    fg.ColWidth(5)  =1000;  
    fg.ColWidth(6)  =1300; 
    fg.ColWidth(7)  =2550; 
    fg.ColWidth(8)  =1000; 
    fg.ColWidth(9)  =1000; 
    fg.ColWidth(10) =1200; 
    fg.ColWidth(11) =1000; 
    fg.ColWidth(12) =1200; 
    fg.ColWidth(13) =900; 
    fg.ColWidth(14) =750;  
    fg.ColWidth(15) =750;    
    fg.ColWidth(16) =1100; 
    fg.ColWidth(17) =1400; 
    fg.ColWidth(18) =700;  
    fg.ColWidth(19) =700;   
	fg.ColWidth(20) =700; 
    fg.ColWidth(21) =700; 
}
function OnSearch()
{
	dso_jart00130.Call("SELECT");
}
function OnDataReceive(obj)
{
	if(obj.id=='dso_jart00130')
	{
		SetGridHeader();
		var count=0;
		var set_color="";
		if (grdData.rows > 2)
			{
				for(var i=2;i<grdData.rows;i++)
				{
					if(grdData.GetGridData(i,7) != "")//guest name
					{
						count=count+1;
					}
					if(grdData.GetGridData(i,7) == ""&& grdData.GetGridData(i,3) != ""&&grdData.GetGridData(i,0) != "")
					{
						set_color =0XEE82EE;
						grdData.SetGridText(i,2,'Sub Total');
						grdData.SetCellBgColor(i, 0, i, 21, set_color);
						grdData.SetCellBold(i,2,i,21,14);

					}
					grdData.SetGridText(grdData.rows-1,2,'Total');
					grdData.SetCellBold(grdData.rows-1,2,grdData.rows-1,21,14);
					grdData.SetCellBgColor(grdData.rows-1, 0, grdData.rows-1, 21,0xB3B3D7);
				}
				txtCount.text = count + " record(s)";
			}
			else
			{
				txtCount.text = "0" + " record(s)";
			}
	}
}
function OnPrint()
{
	 var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/jart00130_new.rpt&procedure=CRM.sp_sel_jart00130_rpt&parameter=" + dtbFrom.GetData();
     System.OpenTargetPage(url); 
}
function OnPrint2()
{
	var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/jart00130_2.rpt&procedure=CRM.sp_rpt_jart00130&parameter=" + dtbFrom.GetData();
     System.OpenTargetPage(url); 
}
</script>  
<body>
	<gw:data id="dso_jart00130" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_jart00130"> 
                <input bind="grdData" > 
                     <input bind="dtbFrom" /> 
                </input> 
                <output bind="grdData" />  
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
									<td style="width:3%">
								            <gw:imgbtn id="ibtnReport2" img="printer" alt="Print2" onclick="OnPrint2()" styles='width:100%'/>
								    </td>
									<td style="width: 54%;"></td>
								</tr>
                                <tr style="height: 98%">
                                    <td colspan="10">
                                        <gw:grid id="grdData" 
                                            header  = "0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21" 
                                            format  = "0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            aligns  = "1|3|3|1|1|3|0|3|3|3|3|3|3|3|1|1|1|1|3|3|3|3" 
                                            defaults= "|||||||||||||||||||||" 
                                            editcol = "0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                            widths  = "0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                            sorting ='T'
                                            styles  = "width:100%; height:100%" />
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
