<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Proshop Cash Report</title>
    <%  ESysLib.SetUser("crm")%>
<script>
function BodyInit()
{
    var data;
	data = "<%=ESysLib.SetListDataSQL("SELECT A.* FROM (SELECT CODE, NAME FROM comm.tco_commcode WHERE PARENT_CODE = 'POINT' and code in ('POINT-02','POINT-07') UNION SELECT '','ALL' FROM DUAL) A ORDER BY A.NAME")%>";
	lstLocation.SetDataText(data);
    OnSearch();
    
}
function Binding()
{
    var grid =grdData.GetGridControl();
	if(grid.Rows < 2)
		   grdData.AddRow();
    grid.FixedRows  = 2;
    //grid.FrozenCols = 6;
    grid.MergeCells = 5;
    
    var col = 0;
    for (col = 1; col < 10; col++){
        grid.MergeCol(col) = true;
        grid.Cell(0, 0, col, 1, col) = grdData.GetGridData(0,col);
    }
    grid.MergeRow(0) = true;
    grid.Cell(0, 0, col, 0, col+1) = grdData.GetGridData(0,col);
    grid.Cell(0, 0, col+2, 0, col+3) = grdData.GetGridData(0,col+2);
    
    grid.Cell(0, 1, col, 1, col) = "VND";
    grid.Cell(0, 1, col+2, 1, col+2) = "VND";
    
    grid.Cell(0, 1, col+1, 1, col+1) = "USD";
    grid.Cell(0, 1, col+3, 1, col+3) = "USD";
        grdData.SetCellBold( 1, col, 1, col+3, true);
    
    col = col + 4;
    grid.MergeCol(col) = true;
    grid.Cell(0, 0, col, 1, col) = grdData.GetGridData(0,col);
    
    grid.ColWidth(0) =0;
    grid.ColWidth(1) =1400;
    grid.ColWidth(2) =1200;
    grid.ColWidth(3) =2000;
    grid.ColWidth(4) =1600;
    grid.ColWidth(5) =700;
    grid.ColWidth(6) =1600;
    grid.ColWidth(7) =650;
    grid.ColWidth(8) =650;
    grid.ColWidth(9) =700;
    grid.ColWidth(10) =1200;
    grid.ColWidth(11) =1200;
    grid.ColWidth(12) =1200;
    grid.ColWidth(13) =1200;
}
function OnSearch(){
    dso_japs00030.Call("SELECT");
}
function OnReport()
{
    var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/ps/japs00030.rpt&procedure=crm.sp_sel_japs00030_rpt&parameter="+dtDate.GetData()+","+lstLocation.GetData();   
     System.OpenTargetPage(url); 
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_japs00030':			
			if (grdData.rows > 1)
			{
				lblRecord.text = grdData.rows - 2 + " record(s)";
				grdData.Subtotal( 0, 2, -1, '10!11!12!13');
			}
			Binding();
		break;
	}
}
</script>

</head>
<body>
 <gw:data id="dso_japs00030" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" parameter="" function="crm.sp_sel_japs00030" procedure="" >  
                <input bind="grdData" >  
                    <input bind="dtDate" />
                    <input bind="lstLocation" /> 
                </input> 
                <output bind="grdData" /> 
            </dso> 
        </xml> 
    </gw:data> 	
    <table width="100%" style="height:100%">
        <tr style="height: 5%">
            <td colspan="2">
                 <fieldset>
			        <table style="width: 100%; height: 100%">
				        <tr>
				            <td style="width:25%"></td>
					        <td width="5%" align="center">
						        Date
					        </td>
					        <td width="10%">
						        <gw:datebox id="dtDate" lang="1" onchange="OnSearch()" />
					        </td>
					        <td width="5%" align="center">
						        Location
					        </td>
					        <td width="20%">
						        <gw:list id="lstLocation" onchange="OnSearch()" />
					        </td>
					        <td width="1%"></td>
					        <td width="3%">
						        <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
					        </td>
					        <td style="width:3%">
					            <gw:imgbtn id="ibtnReport" img="printer" alt="ProShop Cash Daily Report" onclick="OnReport();" styles='width:100%'/>
					        </td>
					        <td style="width:22%" align="left">
					            <gw:label id="lblRecord" styles="color: blue; width: 100%"></gw:label>
					        </td>
				        </tr>
			        </table>
                </fieldset>
            </td>
        </tr>
        <tr style="height: 95%">
            <td colspan="11">
                 <gw:grid 
                    id="grdData"
                    header="_PK|Invoice ID|Invoice Date|Location|Staff|Locker|Golfer|In|Out|Rate|Send Bill||Collectors||Payment Method" 
                    format  ="0|0|0|0|0|0|0|0|0|-0|-0|-2|-0|-2|0"
                    aligns  ="0|1|1|0|0|1|0|1|1|3|0|0|0|0|0" 
                    defaults="||||||||||||||" 
                    editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    sorting='T'
                    autosize='F'
	                styles="width:100%; height:100%"
                    />
            </td>
        </tr>
    </table>
</body>
</html>
