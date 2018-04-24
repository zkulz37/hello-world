<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>In-process Products Inventory Values</title>
</head>

<script>

    var  user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;      
	var g_size			= 0,
		g_begin_qty		= 1,
		g_Receipts		= 2,
		g_packing		= 3,
		g_repacking		= 4,
		g_reprinting	= 5,
		g_subtotal		= 6,
		g_loss			= 7,
		g_IssueTotal	= 8,
		g_EndingInv		= 9;
	var g2_Size			= 0,
		g2_Gelatin		= 1,
		g2_Trimming		= 2,		
		g2_SubRawMat	= 3,
		g2_TotRawMat	= 4,
		g2_DipWT		= 5,
		g2_SolLeft		= 6,
		g2_Scrap		= 7,
		g2_RawMatUsed	= 8;
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
//    idGrid.GetGridControl().FrozenCols = 2 ;
    OnFormatGrid('idGrid');
	OnFormatGrid('idGrid2');
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
	var l_today = dtTo.value ;
	dtFrom.value = l_today.substring(0, 6) + "01";
	
}
//------------------------------------------------------------------------

//------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'fmgf00110' :        
            fmgf00110.Call("SELECT")            
        break;
    }
}
//------------------------------------------------------------------------
function OnDataReceive(obj)
{
	if(obj.id == 'fmgf00270_1')
	{
		var i, l_begin_qty = 0, l_rcpt_qty = 0, l_packing_qty = 0, l_repack_qty = 0 ;
		var l_reprint_qty = 0, l_sub_total = 0, l_loss = 0, l_issue_qty = 0, l_end_qty = 0;
		OnFormatGrid('idGrid');
		for( i = 2; i < idGrid.rows; i++)
		{
			l_begin_qty += Number(idGrid.GetGridData(i, g_begin_qty));
			l_rcpt_qty += Number(idGrid.GetGridData(i, g_Receipts));
			l_packing_qty += Number(idGrid.GetGridData(i, g_packing));
			l_repack_qty += Number(idGrid.GetGridData(i, g_repacking));
			l_reprint_qty += Number(idGrid.GetGridData(i, g_reprinting));
			l_sub_total += Number(idGrid.GetGridData(i, g_subtotal));
			l_loss += Number(idGrid.GetGridData(i, g_loss));
			l_issue_qty += Number(idGrid.GetGridData(i, g_IssueTotal));
			l_end_qty += Number(idGrid.GetGridData(i, g_EndingInv));			
		}
		idGrid.AddRow();
		idGrid.SetGridText(idGrid.rows - 1, g_begin_qty, l_begin_qty);
		idGrid.SetGridText(idGrid.rows - 1, g_Receipts, l_rcpt_qty);
		idGrid.SetGridText(idGrid.rows - 1, g_packing, l_packing_qty);
		idGrid.SetGridText(idGrid.rows - 1, g_repacking, l_repack_qty);
		idGrid.SetGridText(idGrid.rows - 1, g_reprinting, l_reprint_qty);
		idGrid.SetGridText(idGrid.rows - 1, g_subtotal, l_sub_total);
		idGrid.SetGridText(idGrid.rows - 1, g_loss, l_loss);
		idGrid.SetGridText(idGrid.rows - 1, g_IssueTotal, l_issue_qty);
		idGrid.SetGridText(idGrid.rows - 1, g_EndingInv, l_end_qty);
		idGrid.SetCellBgColor(idGrid.rows - 1, 0, idGrid.rows - 1, idGrid.cols - 1, Number('0X8B8B00'));
		fmgf00270_2.Call('SELECT');
	}
	else if(obj.id == 'fmgf00270_2')	
	{	
		var i, l_gelatin_qty = 0, l_trimming_qty = 0, l_subsidiary_qty = 0, l_totraw_weight = 0 ;
		var l_dip_weight = 0, l_sol_left = 0, l_scrap = 0, l_raw_mat_used = 0;
		OnFormatGrid('idGrid2');
		for( i = 1; i < idGrid2.rows; i++)
		{
			l_gelatin_qty += Number(idGrid2.GetGridData(i, g2_Gelatin));
			l_trimming_qty += Number(idGrid2.GetGridData(i, g2_Trimming));
			l_subsidiary_qty += Number(idGrid2.GetGridData(i, g2_SubRawMat));
			l_totraw_weight += Number(idGrid2.GetGridData(i, g2_TotRawMat));
			l_dip_weight += Number(idGrid2.GetGridData(i, g2_DipWT));
			l_sol_left += Number(idGrid2.GetGridData(i, g2_SolLeft));
			l_scrap += Number(idGrid2.GetGridData(i, g2_Scrap));
			l_raw_mat_used += Number(idGrid2.GetGridData(i, g2_RawMatUsed));
			
		}
		idGrid2.AddRow();
		idGrid2.SetGridText(idGrid2.rows - 1, g2_Gelatin, l_gelatin_qty);
		idGrid2.SetGridText(idGrid2.rows - 1, g2_Trimming, l_trimming_qty);
		idGrid2.SetGridText(idGrid2.rows - 1, g2_SubRawMat, l_subsidiary_qty);
		idGrid2.SetGridText(idGrid2.rows - 1, g2_TotRawMat, l_totraw_weight);
		idGrid2.SetGridText(idGrid2.rows - 1, g2_DipWT, l_dip_weight);
		idGrid2.SetGridText(idGrid2.rows - 1, g2_SolLeft, l_sol_left);
		idGrid2.SetGridText(idGrid2.rows - 1, g2_Scrap, l_scrap);
		idGrid2.SetGridText(idGrid2.rows - 1, g2_RawMatUsed, l_raw_mat_used);
		idGrid2.SetCellBgColor(idGrid2.rows - 1, 0, idGrid2.rows - 1, idGrid2.cols - 1, Number('0X8B8B00'));
	}
	
}
//------------------------------------------------------------------------
function OnExcel(iObj)
{
}
//-----------------------------------------------------
function OnFormatGrid(iCase)
{
    if(iCase == 'idGrid')
	{
		if(idGrid.rows < 2)
			idGrid.AddRow();
		var fg = idGrid.GetGridControl();
		fg.FixedRows = 2; 
		fg.Cell(13, 1, 0, 1, fg.Cols - 1) = true ;    
		fg.MergeCells = 5;
		fg.MergeRow(0) = true;   
		fg.MergeCol(g_size) = true ;
		fg.Cell(0, 0, g_size, 1, g_size) = 'Size';   
		fg.MergeCol(g_begin_qty) = true ;
		fg.Cell(0, 0, g_begin_qty, 1, g_begin_qty) = 'Beginning' + '\n' + 'Inventory';   
		fg.MergeCol(g_Receipts) = true ;
		fg.Cell(0, 0, g_Receipts, 1, g_Receipts) = 'Receipts';		
		fg.Cell(0, 0, g_packing, 0, g_loss) = 'Issues';
		fg.Cell(0, 1, g_packing, 1, g_packing) = 'Packing';
		fg.Cell(0, 1, g_repacking, 1, g_repacking) = 'Repacking';
		fg.Cell(0, 1, g_reprinting, 1, g_reprinting) = 'Reprinting';
		fg.Cell(0, 1, g_subtotal, 1, g_loss) = 'Sub Total';
		fg.Cell(0, 1, g_loss, 1, g_loss) = 'Loss';
		fg.MergeCol(g_IssueTotal) = true ;
		fg.Cell(0, 0, g_IssueTotal, 1, g_IssueTotal) = 'Issue Total';   
		fg.MergeCol(g_EndingInv) = true ;
		fg.Cell(0, 0, g_EndingInv, 1, g_EndingInv) = 'Ending' + '\n' + 'Inventory';   
		fg.ColFormat(g_begin_qty) = '#,###,###,###R';
		fg.ColFormat(g_Receipts) = '#,###,###,###R';
		fg.ColFormat(g_packing) = '#,###,###,###R';
		fg.ColFormat(g_repacking) = '#,###,###,###R';
		fg.ColFormat(g_reprinting) = '#,###,###,###R';
		fg.ColFormat(g_subtotal) = '#,###,###,###R';
		fg.ColFormat(g_loss) = '#,###,###,###R';
		fg.ColFormat(g_IssueTotal) = '#,###,###,###R';
		fg.ColFormat(g_EndingInv) = '#,###,###,###R';
	}
	else if(iCase == 'idGrid2')
	{
		var fg = idGrid2.GetGridControl();
		/*if(idGrid2.rows < 2)
			idGrid2.AddRow();	
		
		fg.FixedRows = 2; 
		fg.Cell(13, 1, 0, 1, fg.Cols - 1) = true ;    
		fg.MergeCells = 5;
		fg.MergeRow(0) = true;   
		fg.MergeCol(g2_Size) = true ;*/
		fg.Cell(0, 0, g2_Size, 0, g2_Size) = 'Size';
		//fg.MergeCol(g2_Gelatin) = true ;
		fg.Cell(0, 0, g2_Gelatin, 0, g2_Gelatin) = 'Gelatin';
		//fg.MergeCol(g2_Trimming) = true ;
		fg.Cell(0, 0, g2_Trimming, 0, g2_Trimming) = 'Trimming';
		//fg.MergeCol(g2_SubRawMat) = true ;
		fg.Cell(0, 0, g2_SubRawMat, 0, g2_SubRawMat) = 'Subsidiary Raw' + '\n' + 'Material';
		//fg.MergeCol(g2_TotRawMat) = true ;
		fg.Cell(0, 0, g2_TotRawMat, 0, g2_TotRawMat) = 'Total Raw Material' + '\n' + 'Weight';
		//fg.MergeCol(g2_DipWT) = true ;
		fg.Cell(0, 0, g2_DipWT, 0, g2_DipWT) = 'Dip Weight';
		//fg.MergeCol(g2_SolLeft) = true ;
		fg.Cell(0, 0, g2_SolLeft, 0, g2_SolLeft) = 'Sol. Left';
		//fg.MergeCol(g2_Scrap) = true ;
		fg.Cell(0, 0, g2_Scrap, 0, g2_Scrap) = 'Scrap';
		//fg.MergeCol(g2_RawMatUsed) = true ;
		fg.Cell(0, 0, g2_RawMatUsed, 0, g2_RawMatUsed) = 'Raw Material Used';			
		fg.ColFormat(g2_Gelatin) = '#,###,###.###R';
		fg.ColFormat(g2_Trimming) = '#,###,###.###R';
		fg.ColFormat(g2_SubRawMat) = '#,###,###.######R';
		fg.ColFormat(g2_TotRawMat) = '#,###,###.######R';
		fg.ColFormat(g2_DipWT) = '#,###,###.######R';
		fg.ColFormat(g2_SolLeft) = '#,###,###.###R';
		fg.ColFormat(g2_Scrap) = '#,###,###.######R';
		fg.ColFormat(g2_RawMatUsed) = '#,###,###.######R';
	}
}
//-----------------------------------------------------
function OnReset(iObj)
{
}
//-----------------------------------------------------
//function Upcase()
//{
//    var c = String.fromCharCode (event.keyCode);
//	var x = c.toUpperCase().charCodeAt(0);
//	event.keyCode = x;
//}
//-----------------------------------------------------
	
//-----------------------------------------------------
function OnSearch()
{
	fmgf00270_1.Call('SELECT');
}
//-----------------------------------------------------
function OnExcel()
{
	var url = System.RootURL + "/reports/fm/gf/fmgf00270.aspx?dt_from=" + dtFrom.value + "&dt_to=" + dtTo.value ;
	System.OpenTargetPage(url);        
	
}
</script>

<body>
    <!-------------------------------------------------------------------->
  <gw:data id="fmgf00270_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_fmgf00270_1" > 
                <input bind="idGrid" >                 
                    <input bind="dtFrom"/>
					<input bind="dtTo"/>
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>      

	  <gw:data id="fmgf00270_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_fmgf00270_2" > 
                <input bind="idGrid2" >                 
                    <input bind="dtFrom"/>
					<input bind="dtTo"/>
                </input>
                <output  bind="idGrid2" />
            </dso> 
        </xml> 
    </gw:data>      

    <!-------------------------------------------------------------------->
<table style="width:100%; height:100% " border="1" cellpadding="0" cellspacing="0"  >
    <tr style="height:5%" >
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                <tr>
					<td style="width:20%;"></td>
					<td style="width:20%;"></td>
					<td style="width:10%;"></td>
					<td style="width:2%;"></td>
					<td style="width:10%;"></td>
					<td style="width:30%;"></td>
					<td style="width:8%;"></td>
                </tr>
                <tr >
                    <td align="right">Company&nbsp;</td>
                    <td align="left"><gw:list id="lstCompany" styles="width:100%" /></td>
					<td align="right">Period&nbsp;</td>
					<td align="left"><gw:datebox id="dtFrom" lang="1" styles="width:100%" /></td>
					<td align="center">~</td>
					<td align="left"><gw:datebox id="dtTo" lang="1" styles="width:100%" /></td>
					<td align="right"><gw:imgBtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
					<td align="left"><gw:imgBtn id="btnExcel" img="excel" alt="Excel" onclick="OnExcel()" /></td>
                </tr>
            </table>            
        </td>                     
    </tr>        
    <tr style="height:45%" >
        <td >
            <table width="100%;" border="0" cellpadding="0" cellspacing="0" style="height:100%"  >
                <tr>
                    <td>
                        <gw:grid id="idGrid" 
                            header="size|begin_qty|Receipts|packing|repacking|reprinting|sub total|loss|Issue Total|Ending Inv"
                            format="0|0|0|0|0|0|0|0|0|0" 
                            aligns="0|3|3|3|3|3|3|3|3|3"
                            defaults="|||||||||" 
                            editcol="0|0|0|0|0|0|0|0|0|0" 
                            widths="800|1500|1500|1500|1500|1500|1500|1500|1500|1500"
                            styles="width:100%; height:100% " 
                            acceptNullDate="T" 
                            sorting="T" 
                            />                    
                    </td>
                </tr>
            </table>
        </td>
    </tr>
	<tr style="height:5%" >
	</tr>
	<tr style="height:45%" >
        <td >
            <table width="100%;" border="0" cellpadding="0" cellspacing="0" style="height:100%"  >
                <tr>
                    <td>
                        <gw:grid id="idGrid2" 
                            header="Size|Gelatin|Trimming|SubRawMat|Tot Raw Mat|Dip WT|Sol. Left|Scrap|RawMatUsed"
                            format="0|0|0|0|0|0|0|0|0" 
                            aligns="0|3|3|3|3|3|3|3|3"
                            defaults="||||||||"
                            editcol="0|0|0|0|0|0|0|0|0" 
                            widths="800|1500|1500|1500|1500|1500|1500|1500|1500"
                            styles="width:100%; height:100% " 
                            acceptNullDate="T" 
                            sorting="T" 
                            />                    
                    </td>
                </tr>
            </table>
        </td>	
	</tr>
</table>            
</body>
</html>