<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Daily Revenue Report</title>
    <%  ESysLib.SetUser("crm")%>
</head>

<script>
function BodyInit()
{
  SetGridHeader();
}
function SetGridHeader()
{
    var fg=grdData.GetGridControl(); 
    fg.FrozenCols = 3;
    if(grdData.rows == 1)
        grdData.AddRow();
    grdData.SetCellBold(0,1,1,18,true);
    fg.FixedRows = 2;
    fg.FixCols=1;
    fg.MergeCells = 5;
    
    fg.MergeCol(0) = true;
    fg.Cell(0, 0, 0, 1, 0) = "No";
    
    fg.MergeCol(1) = true;
    fg.Cell(0, 0, 1, 1, 1) = "Item";
    
    fg.MergeCol(2) = true;
    fg.Cell(0, 0, 2, 1, 2) = "Unit";
    
    fg.MergeRow(0) = true;
    fg.Cell(0, 0, 3, 0, 9) = "Quantity"
    
    fg.Cell(0, 1, 3, 1, 3) = "Open";
	fg.Cell(0, 1, 4, 1, 4) = "In";
	fg.Cell(0, 1, 5, 1, 5) = "Bar";
	fg.Cell(0, 1, 6, 1, 6) = "T.6";
	fg.Cell(0, 1, 7, 1, 7) = "T.14";
    fg.Cell(0, 1, 8, 1, 8) = "Club";
	fg.Cell(0, 1, 9, 1, 9) = "Hotel";
	
    fg.Cell(0, 0, 10, 0, 11) = "Sold Revenue";
    
    fg.Cell(0, 1, 10, 1, 10) = "Q.ty";
	fg.Cell(0, 1, 11, 1, 11) = "Amount";
	
	fg.Cell(0, 0, 12, 0, 13) = "Internal";
	
	fg.Cell(0, 1, 12, 1, 12) = "Q.ty";
	fg.Cell(0, 1, 13, 1, 13) = "Amount";
	
	fg.Cell(0, 0, 14, 0, 15) = "Internal Free";
	
	fg.Cell(0, 1, 14, 1, 14) = "Q.ty";
	fg.Cell(0, 1, 15, 1, 15) = "Amount";
	
	fg.Cell(0, 0, 16, 0, 17) = "Send Bill";
	
	fg.Cell(0, 1, 16, 1, 16) = "Q.ty";
	fg.Cell(0, 1, 17, 1, 17) = "Amount";
	
	fg.MergeCol(18) = true;
    fg.Cell(0, 0, 18, 1, 18) = "Closes";
	
    //size of Inquiry grid
    fg.ColWidth(0)=500;
    fg.ColWidth(1)=3550; 
    fg.ColWidth(2)=700;  
    fg.ColWidth(3)=700; 
    fg.ColWidth(4)=700; 
    fg.ColWidth(5)=700;  
    fg.ColWidth(6)=700; 
    fg.ColWidth(7)=700; 
    fg.ColWidth(8)=700; 
    fg.ColWidth(9)=700; 
    fg.ColWidth(10)=700; 
    fg.ColWidth(11)=1270; 
    fg.ColWidth(12)=700; 
    fg.ColWidth(13)=1270;  
    fg.ColWidth(14)=700; 
    fg.ColWidth(15)=1270;
    fg.ColWidth(16)=700; 
    fg.ColWidth(17)=1270;
    fg.ColWidth(18)=700; 
}
function OnSearch()
{
	dso_jart00150.Call("SELECT");
}
function OnReport(){
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/rt/jart00150.rpt&procedure=CRM.sp_sel_jart00150_rpt&parameter=" + dtbFrom.GetData();
    System.OpenTargetPage(url); 
}
function OnDataReceive(obj)
{
	if(obj.id=='dso_jart00150')
	{
		SetGridHeader();
		if (grdData.rows > 2)
			{
				//txtCount.text = grdData.rows - 1 + " record(s)";
				grdData.Subtotal( 1, 2, -1, '11!13!15!17');
			}
	}
}
</script>  
<body>
	<gw:data id="dso_jart00150" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_jart00150"> 
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
						<td style="width: 5%;" align="center">Date</td>
						<td width="7%" align="left"><gw:datebox id="dtbFrom" lang="<%=Application("Lang")%>" mode="01" onchange="OnSearch()" /></td>
						<td style="width: 3%;"><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"    onclick="OnSearch()" /></td>
						<td style="width: 15%;"></td>
						<td style="width: 10%" align="center">
							
						 </td>
						 <td style="width: 10%" align="center">
							<gw:label id="txtCount" />
						 </td>
						<td style="width: 48%;"></td>
						<td style="width: 2%;">
						    <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
						</td>
					</tr>
                    <tr style="height: 98%">
                        <td colspan="8">
                            <gw:grid id="grdData" 
                                header  ="0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18" 
                                format  ="0|0|0|0|0|0|0|0|0|0|0|-0|0|-0|0|-0|0|-0|0"
                                aligns  ="1|0|0|1|1|1|1|1|1|1|1|0|1|0|1|0|1|0|1" 
                                defaults="||||||||||||||||||" 
                                editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                                widths  ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                                sorting ='T'
                                styles  ="width:100%; height:100%" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

</body>
</html>
