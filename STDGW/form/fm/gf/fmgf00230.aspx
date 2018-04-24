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
	var g_Size			= 0,
		g_Prod_qty		= 1,
		g_standard_wt	= 2,
		g_Yield			= 3,
		g_CalcAmount	= 4,
		g_allocate_cost	= 5,
		g_Unit1_Materials 	= 6,
		g_QuantityHR		= 7,
		g_Oper_time 		= 8,
		g_allocate_cost2	= 9,
		g_Unit2				= 10,
		g_UnitPrice			= 11;
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
//    idGrid.GetGridControl().FrozenCols = 2 ;
    OnMergeHeader();
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data) ;
	txtMat_Grp.text = '621';
	txtMat_Grp_2.text = "621";	
	txtLabour_Grp.text = "622";
	txtConversion_Grp.text = "627";
	btnMakeSlip.SetEnable(false);
}
//------------------------------------------------------------------------
function OnDataReceive(obj)
{
	var l_sum_prod_qty = 0, l_sum_calc_cost = 0, l_sum_allo_mat = 0;
	var l_unit1 = 0, l_oper_time = 0, l_allo_conver = 0, l_unit2 = 0;
	var i, l_uprice = 0;
	if(obj.id == "dso_process_cost")
	{
		alert(txtReturn.text);
		fmgf00230.Call('SELECT');
	}
	else if(obj.id == "fmgf00230")
	{
		OnMergeHeader();
		if(idGrid.rows > 2)
		{
			btnMakeSlip.SetEnable(true);
		}
		else
		{
			btnMakeSlip.SetEnable(false);
		}		
		for(i = 2; i < idGrid.rows; i++)
		{
			l_sum_prod_qty += Number(idGrid.GetGridData(i, g_Prod_qty));
			l_sum_calc_cost += Number(idGrid.GetGridData(i, g_CalcAmount));	
			l_sum_allo_mat += Number(idGrid.GetGridData(i, g_allocate_cost));	
			l_oper_time += Number(idGrid.GetGridData(i, g_Oper_time));
			l_allo_conver += Number(idGrid.GetGridData(i, g_allocate_cost2));			
        }		
		l_unit1 = Number(l_sum_allo_mat / l_sum_prod_qty) ;
		l_unit2 = Number(l_allo_conver / l_sum_prod_qty) ;
		l_uprice = Number(l_unit1 + l_unit2);
		idGrid.AddRow();
		idGrid.SetGridText(idGrid.rows - 1, g_Prod_qty, l_sum_prod_qty);
		idGrid.SetGridText(idGrid.rows - 1, g_CalcAmount, l_sum_calc_cost);
		idGrid.SetGridText(idGrid.rows - 1, g_allocate_cost, l_sum_allo_mat);
		idGrid.SetGridText(idGrid.rows - 1, g_Oper_time, l_oper_time);
		idGrid.SetGridText(idGrid.rows - 1, g_allocate_cost2, l_allo_conver);
		idGrid.SetGridText(idGrid.rows - 1, g_Unit1_Materials, l_unit1);
		idGrid.SetGridText(idGrid.rows - 1, g_Unit2, l_unit2);
		idGrid.SetGridText(idGrid.rows - 1, g_UnitPrice, l_uprice);
	}
	else if(obj.id == "dso_make_slip")
	{
		alert(txtReturn.text);
	}
	else if(obj.id == "dso_cancel_slip")
	{
		alert(txtReturn.text);
	}
}
//------------------------------------------------------------------------
function OnFormatGrid(iCase)
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
function OnSearch()
{
	fmgf00230.Call('SELECT');
}
//-----------------------------------------------------
function OnExcel()
{
	 var url =System.RootURL + '/reports/fm/gf/fmgf00230.aspx?p_std_ym=' + dtMonth.value + '&p_tco_company_pk=' + lstCompany.value + '&p_mat_grp=' + txtMat_Grp_2.text ;
      System.OpenTargetPage(url); 
}
//-----------------------------------------------------
function OnProcess()
{
	dso_process_cost.Call();	
}		
//-----------------------------------------------------
function OnMergeHeader()
{
	if(idGrid.rows == 1)
		idGrid.AddRow();
	var fg = idGrid.GetGridControl();
	fg.FixedRows = 2; 
	fg.Cell(13, 1, 0, 1, fg.Cols - 1) = true ;    
	fg.MergeCells = 5;
	fg.MergeRow(0) = true;   
	fg.MergeCol(g_Size) = true ;
	fg.Cell(0, 0, g_Size, 1, g_Size) = 'Size';   
	fg.MergeCol(g_Prod_qty) = true ;
	fg.Cell(0, 0, g_Prod_qty, 1, g_Prod_qty) = '(1)PRODUCT' + '\n' + 'QUANTITY';   
	fg.MergeCol(g_standard_wt) = true ;
	fg.Cell(0, 0, g_standard_wt, 1, g_standard_wt) = '(2)STANDARD' + '\n' + 'WEIGHT';				
	fg.MergeCol(g_Yield) = true ;		
	fg.Cell(0, 0, g_Yield, 1, g_Yield) = '(3)YIELD' ;
	fg.MergeCol(g_CalcAmount) = true ;		
	fg.Cell(0, 0, g_CalcAmount, 1, g_CalcAmount) = '(4)=(1)*(2)/(3)';
	fg.MergeCol(g_allocate_cost) = true ;		
	fg.Cell(0, 0, g_allocate_cost, 1, g_allocate_cost) = '(5)Allocation' + '\n' + 'material Cost';
	fg.MergeCol(g_Unit1_Materials) = true ;		
	fg.Cell(0, 0, g_Unit1_Materials, 1, g_Unit1_Materials) = '(6)Unit1' + '\n' + '(Materials)' ;
	fg.MergeCol(g_QuantityHR) = true ;		
	fg.Cell(0, 0, g_QuantityHR, 1, g_QuantityHR) = '(7)Quantity/' + '\n' + 'HR' ;
	fg.MergeCol(g_Oper_time) = true ;		
	fg.Cell(0, 0, g_Oper_time, 1, g_Oper_time) = '(8)Operating' + '\n' + 'time' ;
	fg.MergeCol(g_allocate_cost2) = true ;		
	fg.Cell(0, 0, g_allocate_cost2, 1, g_allocate_cost2) = '(9)Allocation' + '\n' + 'Conversion Cost' ;	
	fg.MergeCol(g_Unit2) = true ;		
	fg.Cell(0, 0, g_Unit2, 1, g_Unit2) = 'Unit2(OVER' + '\n' + 'HEAD COST)' ;
	fg.MergeCol(g_UnitPrice) = true ;		
	fg.Cell(0, 0, g_UnitPrice, 1, g_UnitPrice) = 'UNIT-PRICE' + '\n' + '(unit1+unit2)' ;	
	fg.ColFormat(g_Prod_qty) = "#,###,###,###R";
	fg.ColFormat(g_standard_wt) = "#,###,###,###R";
	fg.ColFormat(g_CalcAmount) = "#,###,###,###R";
	fg.ColFormat(g_allocate_cost) = "#,###,###,###R";
	fg.ColFormat(g_Unit1_Materials) = "#,###,###,###.###R";
	fg.ColFormat(g_QuantityHR) = "#,###,###,###R";
	fg.ColFormat(g_Oper_time) = "#,###,###,###R";
	fg.ColFormat(g_allocate_cost2) = "#,###,###,###R";
	fg.ColFormat(g_Unit2) = "#,###,###,###.###R";
	fg.ColFormat(g_UnitPrice) = "#,###,###,###.###R";
}
//-----------------------------------------------------
function OnMakeSlip()
{
	dso_make_slip.Call();
}
//-----------------------------------------------------
function OnCancelSlip()
{
	dso_cancel_slip.Call();
}
//-----------------------------------------------------
</script>

<body>
    <!-------------------------------------------------------------------->
  <gw:data id="fmgf00230" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_fmgf00230" > 
                <input bind="idGrid" >                 
                     <input bind="dtMonth"/>
                     <input bind="lstCompany"/>		
					<input bind="txtMat_Grp_2"/>			 
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>      
    <!-------------------------------------------------------------------->
    <gw:data id="dso_process_cost" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="acnt.sp_pro_fmgf00230_1">
                <input> 
                     <input bind="dtMonth" />
                     <input bind="lstCompany" />
					 <input bind="txtMat_Grp" />
					 <input bind="txtConversion_Grp" />
					 <input bind="txtLabour_Grp" />
                </input>  
                <output>  
                     <output bind="txtReturn"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>	
	<!-------------------------------------------------------------------->
    <gw:data id="dso_make_slip" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="acnt.sp_pro_fmgf00230_4">
                <input> 
                     <input bind="lstCompany" />
                     <input bind="dtMonth" />
					 <input bind="txtMat_Grp_2"/>
                </input>  
                <output>  
                     <output bind="txtReturn"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>	
	<!-------------------------------------------------------------------->
    <gw:data id="dso_cancel_slip" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="acnt.sp_pro_fmgf00230_3">
                <input> 
                     <input bind="lstCompany" />
                     <input bind="dtMonth" />					 
                </input>  
                <output>  
                     <output bind="txtReturn"/>
               </output> 
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
					<td style="width:10%;"></td>
					<td style="width:5%;"></td>
					<td style="width:5%;"></td>
					<td style="width:5%;"></td>
					<td style="width:15%;"></td>
					<td style="width:10%;"></td>
                </tr>
                <tr >
                    <td align="right">Company&nbsp;</td>
                    <td align="left"><gw:list id="lstCompany" styles="width:100%" /></td>
					<td align="right">Month&nbsp;</td>
					<td align="left"><gw:datebox id="dtMonth" lang="1" type="month" /></td>					
					<td align="right"><gw:icon id="btnProcess" text="Process" alt="Process Data" onclick="OnProcess()" /></td>
					<td align="right"><gw:icon id="btnMakeSlip" text="Make Slip" alt="Make Slip" onclick="OnMakeSlip()" /></td>
					<td align="right"><gw:icon id="btnCancelSlip" text="Cancel Slip" alt="Cancel Slip" onclick="OnCancelSlip()" /></td>
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
                            header="SIZE|PRO QTY|standard wt|Yield|Calc Amount|allocate cost|Unit1 (Materials)|QuantityHR|Operating time|allo cost|Unit2(Over Head Cost)|Unit Price"
                            format="0|0|0|0|0|0|0|0|0|0|0|0" 
                            aligns="1|3|1|1|3|3|3|3|3|3|3|3"
                            defaults="|||||||||||" 
                            editcol="0|0|0|0|0|0|0|0|0|0|0|0" 
                            widths="700|1500|800|800|1500|1500|1500|1500|1500|2000|2000|2000"
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
<gw:textbox id="txtReturn" styles="display:none; " />
<gw:textbox id="txtMat_Grp" styles="display:none; " />
<gw:textbox id="txtLabour_Grp" styles="display:none; " />
<gw:textbox id="txtConversion_Grp" styles="display:none; " />
<gw:textbox id="txtMat_Grp_2" styles="display:none; " />         
</body>
</html>