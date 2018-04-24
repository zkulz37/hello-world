<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Ending Wip & Goods Weight</title>
</head>

<script>
    var  user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;      
var  	g_size				= 0,
		g_1STANDARD			= 1,
		g_2WIPQTY			= 2,
		g_WIPWeight			= 3,
		g_PRODUCTQUANTITY	= 4,
		g_GOODSWT			= 5,
		g_TOTALWEIGHT		= 6;
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
//    idGrid.GetGridControl().FrozenCols = 2 ;
    OnFormatGrid('idGrid');	
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
function OnDataReceive(obj)
{
	if(obj.id == "fmgf00280_1")
	{	
		OnFormatGrid('idGrid');		
		var i, l_std_wt = 0, l_wip_qty = 0, l_wip_wt = 0;
		var l_prod_qty = 0, l_goods_wt = 0, l_total_wt = 0;
		for( i = 2; i < idGrid.rows; i++)
		{
			l_std_wt += Number(idGrid.GetGridData(i, g_1STANDARD ));
			l_wip_qty += Number(idGrid.GetGridData(i, g_2WIPQTY ));
			l_wip_wt += Number(idGrid.GetGridData(i, g_WIPWeight ));
			l_prod_qty += Number(idGrid.GetGridData(i, g_PRODUCTQUANTITY ));
			l_goods_wt += Number(idGrid.GetGridData(i, g_GOODSWT ));
			l_total_wt += Number(idGrid.GetGridData(i, g_TOTALWEIGHT ));
		}
		idGrid.AddRow();
		idGrid.SetGridText(idGrid.rows - 1, g_1STANDARD, l_std_wt);
		idGrid.SetGridText(idGrid.rows - 1, g_2WIPQTY, l_wip_qty);
		idGrid.SetGridText(idGrid.rows - 1, g_WIPWeight, l_wip_wt);
		idGrid.SetGridText(idGrid.rows - 1, g_PRODUCTQUANTITY, l_prod_qty);
		idGrid.SetGridText(idGrid.rows - 1, g_GOODSWT, l_goods_wt);
		idGrid.SetGridText(idGrid.rows - 1, g_TOTALWEIGHT, l_total_wt);
		idGrid.SetCellBgColor(idGrid.rows - 1, 0, idGrid.rows - 1, idGrid.cols - 1, Number('0X8B8B00'));
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
		fg.MergeCol(g_1STANDARD) = true ;
		fg.Cell(0, 0, g_1STANDARD, 1, g_1STANDARD) = '(1)STANDARD' + '\n' + 'WEIGHT';   
		fg.MergeCol(g_2WIPQTY) = true ;
		fg.Cell(0, 0, g_2WIPQTY, 1, g_2WIPQTY) = '(2)WIP' + '\n' + 'QUANTITY';				
		fg.MergeCol(g_WIPWeight) = true ;		
		fg.Cell(0, 0, g_WIPWeight, 1, g_WIPWeight) = 'WIP WEIGHT' + '\n' + '(1)*(2)';
		fg.MergeCol(g_PRODUCTQUANTITY) = true ;		
		fg.Cell(0, 0, g_PRODUCTQUANTITY, 1, g_PRODUCTQUANTITY) = '(3)PRODUCT' + '\n' + 'QUANTITY';
		fg.MergeCol(g_GOODSWT) = true ;		
		fg.Cell(0, 0, g_GOODSWT, 1, g_GOODSWT) = 'GOODS WEIGHT' + '\n' + '(1)*(3)';
		fg.MergeCol(g_TOTALWEIGHT) = true ;		
		fg.Cell(0, 0, g_TOTALWEIGHT, 1, g_TOTALWEIGHT) = 'TOTAL WEIGHT' ;
		fg.ColFormat(g_2WIPQTY) = "#,###,###,###R";
		fg.ColFormat(g_WIPWeight) = "#,###,###,###R";
		fg.ColFormat(g_PRODUCTQUANTITY) = "#,###,###,###R";
		fg.ColFormat(g_GOODSWT) = "#,###,###,###R";
		fg.ColFormat(g_TOTALWEIGHT) = "#,###,###,###R";
	}
}
//-----------------------------------------------------
//function Upcase()
//{
//    var c = String.fromCharCode (event.keyCode);
//	var x = c.toUpperCase().charCodeAt(0);
//	event.keyCode = x;
//}	
//-----------------------------------------------------
function OnSearch()
{
	fmgf00280_1.Call('SELECT');
}
//-----------------------------------------------------
function OnExcel()
{
	//var url = System.RootURL + "/reports/fm/gf/fmgf00270.aspx?dt_from=" + dtFrom.value + "&dt_to=" + dtTo.value ;
	//System.OpenTargetPage(url);        
	alert('Waiting for report...');
}
</script>

<body>
    <!-------------------------------------------------------------------->
  <gw:data id="fmgf00280_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_fmgf00280_1" > 
                <input bind="idGrid" >                 
                    <input bind="dtFrom"/>
					<input bind="dtTo"/>
                </input>
                <output  bind="idGrid" />
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
    <tr style="height:95%" >
        <td >
            <table width="100%;" border="0" cellpadding="0" cellspacing="0" style="height:100%"  >
                <tr>
                    <td>
                        <gw:grid id="idGrid" 
                            header="SIZE|(1)STANDARD|(2)WIP QTY|WIP WT(1)*(2)|(3)PRODUCT QUANTITY|GOODS WT|TOTAL WEIGHT"
                            format="0|0|0|0|0|0|0" 
                            aligns="1|3|3|3|3|3|3"
                            defaults="||||||" 
                            editcol="0|0|0|0|0|0|0" 
                            widths="800|1600|1600|1600|1600|1600|1600"
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