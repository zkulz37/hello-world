<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Inventory Evaluation Goods</title>
</head>

<script>

    var  user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;
    var 
        iG0_No          = 0,
        iG0_B_qty      	= 1,
        iG0_B_unit      = 2,
        iG0_B_amount   	= 3,
		iG0_I_Qty		= 4,
		iG0_I_Unit		= 5,
		iG0_I_amount	= 6,
		iG0_O_qty		= 7,
		iG0_O_Sam_Qty	= 8,
		iG0_Output_Qty	= 9,
		iG0_O_Unit		= 10,
		iG0_O_amount	= 11,
		iG0_O_Sam_amount	= 12,
		iG0_Output_amt	= 13,
		iG0_E_qty		= 14,
		iG0_E_unit		= 15,
		iG0_E_amount	= 16;
        
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
    txtAccountCode.SetEnable(false);
    txtAccountName.SetEnable(false);
    txtItemCode.SetEnable(false);
    txtItemName.SetEnable(false);
    txtPLCode.SetEnable(false);
    txtPLName.SetEnable(false);
//    idGrid.GetGridControl().FrozenCols = 2 ;
    OnFormatGrid();
	OnFormatHeader();
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
    var data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_name  FROM inv.tin_warehouse  WHERE del_if = 0 ORDER BY wh_name  ASC" )%>|ALL|ALL";    
    lstWH.SetDataText(data); 
    lstWH.value = 'ALL';       
}
//------------------------------------------------------------------------
function OnPopUp(iObj)
{
    switch(iObj)
    {
    case 'Account':
            if(Trim(lstCompany.value)=='')
            {
                alert('Must select Company!!!');
                return ;
            }            
            var path = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_code=&comm_nm=&dsqlid=ACNT.SP_SEL_fmgf00050_3&val1=" + lstCompany.value + "&val2=" + lstWH.value + "&val3=" ;

            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            if(object!=null)
            {
                txtAccountCode.text = object[0];
                txtAccountName.text = object[1];
                txtTAC_ABACCTCODE_PK.text = object[3];
            }    
        break ;
    case 'Item':        
            var path = System.RootURL + "/form/fp/ab/PopUpGetOneItem.aspx?purchase_yn=&item_code=" + txtItemCode.text + "&item_name=" + txtItemName.text ;
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
            if(object != null)
            {
                txtTCO_ITEM_PK.text = object[0] ;
                txtItemCode.text = object[1];
                txtItemName.text = object[2];
            }                        
        break;
    case 'PL':
        if(Trim(lstCompany.value)=='')
        {
            alert('Must select Company!!!');
            return ;
        }              
        var path = System.RootURL + "/form/gf/co/gfco002005.aspx?dsqlid=ACNT.SP_SEL_fmgf00050_2&company=" + lstCompany.value + "&col_code=PL Code&col_nm=PL Name&comm_nm=" +  + "&val1=" + lstWH.value ;
        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
        if(object != null)
        {
            txttac_abplcenter_pk.text = object[2];
            txtPLCode.text = object[0];
            txtPLName.text = object[1];
        }
        break;
    }
}
//------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'fmgf00280' :        
            fmgf00280.Call("SELECT")            
        break;
    }
}
//------------------------------------------------------------------------
function OnDataReceive(obj)
{
    var i ;
	var l_tot_B_qty = 0, l_tot_B_amount = 0, l_tot_I_qty = 0, l_tot_I_amount = 0;
    var l_tot_O_qty = 0, l_tot_O_amount = 0, l_tot_E_qty = 0, l_tot_E_amount = 0;	
	var l_tot_sam_qty = 0, l_tot_sam_amt = 0;
	var l_sum_o_qty = 0, l_sum_o_amt = 0 ; 
    switch (obj.id)
    {
        case "fmgf00280": 
			OnFormatHeader();			
            //CalcuSubTotal();       
          var ctr = idGrid.GetGridControl();          
           if(ctr.rows > 1)
           {
                for( i =2 ; i< ctr.rows; i++)
               {
					l_tot_B_qty += Number(idGrid.GetGridData(i, iG0_B_qty));
					l_tot_B_amount += Number(idGrid.GetGridData(i, iG0_B_amount));
					l_tot_I_qty += Number(idGrid.GetGridData(i, iG0_I_Qty));
					l_tot_I_amount += Number(idGrid.GetGridData(i, iG0_I_amount));
					l_tot_O_qty += Number(idGrid.GetGridData(i, iG0_O_qty));
					l_tot_O_amount += Number(idGrid.GetGridData(i, iG0_O_amount));
					l_tot_E_qty += Number(idGrid.GetGridData(i, iG0_E_qty));
					l_tot_E_amount += Number(idGrid.GetGridData(i, iG0_E_amount));
					l_tot_sam_qty += Number(idGrid.GetGridData(i, iG0_O_Sam_Qty));
					l_tot_sam_amt += Number(idGrid.GetGridData(i, iG0_O_Sam_amount));					
					l_sum_o_qty += Number(idGrid.GetGridData(i, iG0_Output_Qty));
					l_sum_o_amt += Number(idGrid.GetGridData(i, iG0_Output_amt));										
               }
              idGrid.AddRow();
              idGrid.SetGridText(idGrid.rows-1, 0, "TOTAL");
              idGrid.SetCellBgColor(idGrid.rows-1, 0,idGrid.rows-1,idGrid.cols-1,0xA9EBD7);
              idGrid.SetGridText(idGrid.rows-1, iG0_B_qty, l_tot_B_qty) ;
              idGrid.SetGridText(idGrid.rows-1, iG0_B_amount, l_tot_B_amount) ;
              idGrid.SetGridText(idGrid.rows-1, iG0_I_Qty, l_tot_I_qty) ;
              idGrid.SetGridText(idGrid.rows-1, iG0_I_amount, l_tot_I_amount) ;
              idGrid.SetGridText(idGrid.rows-1, iG0_O_qty, l_tot_O_qty) ;
              idGrid.SetGridText(idGrid.rows-1, iG0_O_amount, l_tot_O_amount) ;                  
              idGrid.SetGridText(idGrid.rows-1, iG0_E_qty, l_tot_E_qty) ;
              idGrid.SetGridText(idGrid.rows-1, iG0_E_amount, l_tot_E_amount) ;                            
              idGrid.SetGridText(idGrid.rows-1, iG0_O_Sam_Qty, l_tot_sam_qty) ;
              idGrid.SetGridText(idGrid.rows-1, iG0_O_Sam_amount, l_tot_sam_amt) ;                            
              idGrid.SetGridText(idGrid.rows-1, iG0_Output_Qty, l_sum_o_qty) ;
              idGrid.SetGridText(idGrid.rows-1, iG0_Output_amt, l_sum_o_amt) ;                            
			  
              ctr.TopRow = idGrid.rows-1;                    
          }
        break;
		case "dso_save_inv_goods":
			alert(txtReturn.text);
		break ;
    }   	
}
//------------------------------------------------------------------------
function OnExcel()
{
	var l_case = lstRptExcel.value ;
    switch(l_case)
    {
        case '1':
            var url = System.RootURL + "/reports/fm/gf/fmgf00280_2.aspx?std_ym=" + dbMonthly.value + "&ac_cd=" + txtAccountCode.text + "&tin_warehouse_pk=" + lstWH.value + "&tco_company_pk=" + lstCompany.value + "&item_code=" + txtItemCode.text ;
            System.OpenTargetPage(url);        
        break ;
        case '0':
            var url = System.RootURL + "/reports/fm/gf/fmgf00280_3.aspx?std_ym=" + dbMonthly.value + "&ac_cd=" + txtAccountCode.text + "&tin_warehouse_pk=" + lstWH.value + "&tco_company_pk=" + lstCompany.value + "&tco_item_pk=" + txtTCO_ITEM_PK.text + "&pl_cd=" + txtPLCode.text ;
            System.OpenTargetPage(url);        
        break ;
    }
}
//-----------------------------------------------------
function OnFormatGrid()
{
    var trl ;
    trl = idGrid.GetGridControl();	
    trl.ColFormat(iG0_B_qty)                = "###,###,###,###,###,###,###";
    trl.ColFormat(iG0_B_unit)               = "###,###,###,###,###.###";
    trl.ColFormat(iG0_B_amount)             = "###,###,###,###,###,###,###";
    trl.ColFormat(iG0_I_Qty)                = "###,###,###,###,###,###,###";
    trl.ColFormat(iG0_I_Unit)               = "###,###,###,###,###.###";
    trl.ColFormat(iG0_I_amount)             = "###,###,###,###,###,###,###,###";
    trl.ColFormat(iG0_O_qty)                = "###,###,###,###,###,###,###";
    trl.ColFormat(iG0_O_Unit)              	= "###,###,###,###,###.###";
	trl.ColFormat(iG0_O_amount)             = "###,###,###,###,###,###,###,###";
    trl.ColFormat(iG0_E_qty)                = "###,###,###,###,###,###,###";
    trl.ColFormat(iG0_E_unit)              	= "###,###,###,###,###.###";
	trl.ColFormat(iG0_E_amount)             = "###,###,###,###,###,###,###,###";	
    trl.ColFormat(iG0_O_Sam_amount)         = "###,###,###,###,###";
	trl.ColFormat(iG0_O_Sam_Qty)            = "###,###,###,###,###,###,###.###";	
    trl.ColFormat(iG0_Output_Qty)         = "###,###,###,###,###.###";
	trl.ColFormat(iG0_Output_amt)            = "###,###,###,###,###,###,###";	
	
}
//-----------------------------------------------------
function OnReset(iObj)
{
    switch(iObj)
    {
        case 'Account':
            txtAccountCode.text = "" ;
            txtAccountName.text = "" ;
            txtTAC_ABACCTCODE_PK.text = "" ;
        break;
        case 'Item':
            txtItemCode.text = '' ;
            txtItemName.text = '' ;                    
            txtTCO_ITEM_PK.text = '' ;
        break ;   
        case 'PL':         
            txtPLCode.text = '';
            txtPLName.text = '';
            txttac_abplcenter_pk.text = '' ;
        break ;            
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
function CalcuSubTotal()
{                
        var ctr=idGrid.GetGridControl();         ctr.OutlineBar =2 ;
        //ctr.SubtotalPosition=0;
        var color;
        var caption;
        var operator;        
        for (var igroup=0;igroup<=1;igroup++)
        {
            switch (igroup)
            {
                case 0:
                {
                    color=0xCCFFFF ;
                    caption='Grand Total';
                    break;
                }
                case iG0_Acc_Cd:
                {
                    color = 0xCCFFFF ;
                    caption='%s';
                    break;
                }                
            }
            for(var itotal = iG0_Open_Qty; itotal <= iG0_End_Amt; itotal++)
            {                
                ctr.SubTotal(2, igroup, itotal, '', color, 0x000000, '1', caption, '', true);
            }
        auto_resize_column(idGrid, 0, idGrid.cols-1, 10); 
    }            
}
//-----------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//-----------------------------------------------------
function OnFormatHeader()
{
	var fg = idGrid.GetGridControl();
	if(fg.rows < 2)
		idGrid.AddRow();
	fg.FixedRows = 2; 
	fg.Cell(13, 1, 0, 1, fg.Cols - 1) = true ;    
	fg.MergeCells = 5;
	fg.MergeRow(0) = true;   
	fg.MergeCol(iG0_No) = true ;
	fg.Cell(0, 0, iG0_No, 1, iG0_No) = ' ';   
	fg.Cell(0, 0, iG0_B_qty, 0, iG0_B_amount) 		= 'Beginning inventory';   
	fg.Cell(0, 1, iG0_B_qty, 1, iG0_B_qty) 			= 'Quantity';
	fg.Cell(0, 1, iG0_B_unit, 1, iG0_B_unit) 		= 'unit';
	fg.Cell(0, 1, iG0_B_amount, 1, iG0_B_amount) 	= 'amount';
	fg.Cell(0, 0, iG0_I_Qty, 0, iG0_I_amount) 		= 'This term products';   
	fg.Cell(0, 1, iG0_I_Qty, 1, iG0_I_Qty) 			= 'Quantity';
	fg.Cell(0, 1, iG0_I_Unit, 1, iG0_I_Unit) 		= 'unit';
	fg.Cell(0, 1, iG0_I_amount, 1, iG0_I_amount) 	= 'amount';
	fg.Cell(0, 0, iG0_O_qty, 0, iG0_Output_amt) 		= 'Issues';   
	fg.Cell(0, 1, iG0_O_qty, 1, iG0_O_qty) 			= 'Order Qty';
	fg.Cell(0, 1, iG0_O_Sam_Qty, 1, iG0_O_Sam_Qty) 			= 'Sample';
	fg.Cell(0, 1, iG0_Output_Qty, 1, iG0_Output_Qty) 		= 'Output Qty';
	fg.Cell(0, 1, iG0_O_Unit, 1, iG0_O_Unit) 		= 'unit';
	fg.Cell(0, 1, iG0_O_amount, 1, iG0_O_amount) 	= 'Order Amount';
	fg.Cell(0, 1, iG0_O_Sam_amount, 1, iG0_O_Sam_amount) 	= 'Sample';
	fg.Cell(0, 1, iG0_Output_amt, 1, iG0_Output_amt) 	= 'Output amount';		
	fg.Cell(0, 0, iG0_E_qty, 0, iG0_E_amount) 		= 'Ending inventory';   
	fg.Cell(0, 1, iG0_E_qty, 1, iG0_E_qty) 			= 'Quantity';
	fg.Cell(0, 1, iG0_E_unit, 1, iG0_E_unit) 		= 'unit';
	fg.Cell(0, 1, iG0_E_amount, 1, iG0_E_amount) 	= 'amount';			
}
//-----------------------------------------------------
function OnUpdate()
{
	if(confirm("Are you sure you want to update data?"))
	{
		dso_save_inv_goods.Call();
	}
}
//-----------------------------------------------------
</script>

<body>
    <!-------------------------------------------------------------------->
  <gw:data id="fmgf00280" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="ACNT.sp_sel_fmgf00280" > 
                <input bind="idGrid" >                 
                    <input bind="lstCompany"/>
                    <input bind="dbMonthly"/>					
                    <input bind="txtAccountCode"/>
                    <input bind="txtAccountName"/>
                    <input bind="txtTCO_ITEM_PK"/>                    
                    <input bind="txtPLCode"/>
                    <input bind="txtPLName"/>
                    <input bind="lstWH"/>                    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>       
    <!-------------------------------------------------------------------->
	    <gw:data id="dso_save_inv_goods" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="acnt.sp_pro_fmgf00280">
                <input> 
                     <input bind="lstCompany"/>
					 <input bind="dbMonthly"/>                     
                </input>  
                <output>  
                     <output bind="txtReturn"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>	
<!-------------------------------------------------------------------->
<table style="width:100%; height:100% " border="1" cellpadding="0" cellspacing="0"  >
    <tr style="height:10%" >
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                <tr>
                    <td style="width: 8%"></td>
                    <td style="width: 14%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 16%"></td>
                    <td style="width: 2%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 16%"></td>
                    <td style="width: 2%"></td>
                    <td style="width: 4%"></td>
                    <td style="width: 3%"></td>
                    <td style="width: 3%"></td>
                </tr>
				<tr>
                    <td align="right">Company&nbsp;</td>
                    <td align="left"><gw:list id="lstCompany" styles="width:100%" /></td>				
					<td align="right">Period&nbsp;</td>
					<td align="left" ><gw:datebox id="dbMonthly" type="month" lang="1" /></td>
					<td align="right" colspan="2" ></td>
                    <td align="right" ><a title="Click here to select Product Item" onclick="OnPopUp('Item')" href="#tips">Item&nbsp;</a></td>
                    <td align="left" ><gw:textbox id="txtItemCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left" ><gw:textbox id="txtItemName" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="right">
						<gw:imgbtn img="reset" alt="Reset" id="btnReset3" onclick="OnReset('Item')" />
                    </td>                                                            					
                    <td align="right"><gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('fmgf00280')" /></td>
                    <td align="right"><gw:imgbtn img="excel" alt="Report by Item Group" id="btnExcel" onclick="OnExcel()" /></td>
                    <td align="right"></td>					
				</tr>
				<tr>
                    <td align="right" >WH&nbsp;</td>
                    <td colspan="1" align="left" ><gw:list id="lstWH" styles="width:100%; " onchange="OnSearch('fmgf00110')" /></td>				
                    <td align="right" ><a title="Click here to select account" onclick="OnPopUp('Account')" href="#tips">Account&nbsp;</a></td>
                    <td align="left"><gw:textbox id="txtAccountCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left"><gw:textbox id="txtAccountName" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="right">
                        <gw:imgbtn img="reset" alt="Reset" id="btnReset" onclick="OnReset('Account')" />
					</td>
                    <td align="right" ><a title="Click here to select PL" onclick="OnPopUp('PL')" href="#tips">PL&nbsp;</a></td>
                    <td align="left"><gw:textbox id="txtPLCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left" ><gw:textbox id="txtPLName" text="" styles="width:100%; " csstype="mandatory" /></td>                    
                    <td align="right"><gw:imgbtn img="reset" alt="Reset" id="btnReset2" onclick="OnReset('PL')" /></td>                    					
					<td colspan="3" align="right" ><gw:list id="lstRptExcel" >
						<data>DATA|0|Report by Item|1|Report by Group</data>
						</gw:list>
					</td>
				</tr>
					<td colspan="10"></td>
					<td colspan="3" align="right"><gw:icon id="btnUpdate" text="Update Date" img="in" onclick="OnUpdate()" /></td>
				<tr>
				</tr>
            </table>            
        </td>                     
    </tr>        
    <tr style="height:86%" >
        <td >
            <table width="100%;" border="0" cellpadding="0" cellspacing="0" style="height:100%"  >
                <tr>
                    <td>
                        <gw:grid id="idGrid" 
                            header="|B Qty|B Unit|B amount|I Qty|I Unit|I amount|Order Qty|O Sample Qty|O Qty|O Unit|Order amount|Sample amount|O Amount|E Qty|E Unit|E amount"
                            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                            aligns="2|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3"
                            defaults="||||||||||||||||" 
                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                            widths="0|1500|1400|1500|1400|1500|1500|1400|1500|1500|1500|1500|1500|1500|1500|1500|1500"
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
<gw:textbox id="txtTAC_ABACCTCODE_PK" styles="display:none; " />
<gw:textbox id="txtTCO_ITEM_PK" styles="display:none; " />
<gw:textbox id="txttac_abplcenter_pk" styles="display:none; " />
<gw:textbox id="txtReturn" styles="display:none; " />
</body>
</html>