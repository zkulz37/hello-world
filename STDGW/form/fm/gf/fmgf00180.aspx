<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Inventory Inquiry</title>
</head>

<script>

    var  user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;
	var  i_language = "<%=Session("SESSION_LANG")%>"  ;
    var 
		i_mat_pk			= 0,
		i_Item_code        	= 1,
		i_Item_name			= 2,
		i_Acc_code			= 3,
		i_norm_qty			= 4,
		i_norm_amt   		= 5,
		i_to_mat_qty		= 6,
		i_to_mat_amt		= 7,
		i_Diff_Qty			= 8,
		i_Diff_Amt			= 9,
		i_WH_Name			= 10;
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
    txtAccountCode.SetEnable(false);
    txtAccountName.SetEnable(false);
    txtItemCode.SetEnable(false);
    txtItemName.SetEnable(false);
//    txtPLCode.SetEnable(false);
//    txtPLName.SetEnable(false);
//    idGrid.GetGridControl().FrozenCols = 2 ;
    OnFormatGrid();
	FormatHeader();
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
            //txttac_abplcenter_pk.text = object[2];
            //txtPLCode.text = object[0];
            //txtPLName.text = object[1];
        }
        break;
    }
}
//------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'dso_consp_inq' :        
            dso_consp_inq.Call("SELECT")            
        break;
    }
}
//------------------------------------------------------------------------
function OnDataReceive(obj)
{	
    var i ;
	var l_tot_norm_qty = 0, l_tot_norm_amt = 0, l_to_mat_qty = 0, l_to_mat_amt = 0, l_tot_diff_qty = 0, l_tot_diff_amt = 0;
    switch (obj.id)
    {
        case "dso_consp_inq" :  
			FormatHeader();          
            //CalcuSubTotal();       
          var ctr = idGrid.GetGridControl()
          
           if(ctr.rows > 1)
           {
                for( i = 2; i< ctr.rows; i++)
               	{
					l_tot_norm_qty += Number(idGrid.GetGridData(i, i_norm_qty));
					l_tot_norm_amt += Number(idGrid.GetGridData(i, i_norm_amt));
					l_to_mat_qty += Number(idGrid.GetGridData(i, i_to_mat_qty));
					l_to_mat_amt += Number(idGrid.GetGridData(i, i_to_mat_amt));
					l_tot_diff_qty += Number(idGrid.GetGridData(i, i_Diff_Qty));
					l_tot_diff_amt += Number(idGrid.GetGridData(i, i_Diff_Amt));
                }
              idGrid.AddRow();
              idGrid.SetGridText(idGrid.rows-1, i_Item_code, "TOTAL");
              idGrid.SetCellBgColor(idGrid.rows-1, 0, idGrid.rows-1, idGrid.cols-1, 0xA9EBD7);
              idGrid.SetGridText(idGrid.rows-1, i_norm_qty, l_tot_norm_qty) ;
              idGrid.SetGridText(idGrid.rows-1, i_norm_amt, l_tot_norm_amt) ;
              idGrid.SetGridText(idGrid.rows-1, i_to_mat_qty, l_to_mat_qty) ;
              idGrid.SetGridText(idGrid.rows-1, i_to_mat_amt, l_to_mat_amt) ;
              idGrid.SetGridText(idGrid.rows-1, i_Diff_Qty, l_tot_diff_qty) ;
              idGrid.SetGridText(idGrid.rows-1, i_Diff_Amt, l_tot_diff_amt) ;    
              //ctr.TopRow = idGrid.rows-1;                    
          }         
        break;
    }   
}
//------------------------------------------------------------------------
function OnExcel()
{
   	var url = System.RootURL + "/reports/fm/gf/fmgf00180.aspx?std_ym=" + dbMonthly.value + "&tco_company_pk=" + lstCompany.value + "&tin_warehouse_pk=" + lstWH.value + "&tac_abacctcode_pk=" + txtTAC_ABACCTCODE_PK.text + "&tco_item_pk=" + txtTCO_ITEM_PK.text ;
   	System.OpenTargetPage(url);        
}
//-----------------------------------------------------
function OnFormatGrid()
{
    var trl ;
    trl = idGrid.GetGridControl();	
    trl.ColFormat(i_norm_qty)                 = "###,###,###,###,###.##";
    trl.ColFormat(i_norm_amt)                 = "###,###,###,###,###";
    trl.ColFormat(i_to_mat_qty)                   = "###,###,###,###,###.##R";
    trl.ColFormat(i_to_mat_amt)                   = "###,###,###,###,###";
    trl.ColFormat(i_Diff_Qty)                  = "###,###,###,###,###.##R";
    trl.ColFormat(i_Diff_Amt)                  = "###,###,###,###,###";
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
            //txtPLCode.text = '';
            //txtPLName.text = '';
            //txttac_abplcenter_pk.text = '' ;
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
/*        
		var ctr=idGrid.GetGridControl(); 
        ctr.OutlineBar =2 ;
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
*/	
}
//-----------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//-----------------------------------------------------
function FormatHeader()
{
    var fg  = idGrid.GetGridControl(); 
	if(idGrid.rows == 1)
		idGrid.AddRow();
    fg.FixedRows = 2; 
    fg.Cell(13, 1, 0, 1, fg.Cols - 1) = true ;    
    fg.MergeCells = 5;
    fg.MergeRow(0) = true ;

      if(i_language == "ENG")
      {
		// item code
          fg.MergeCol(i_Item_code) = true ;            
          fg.Cell(0, 0, i_Item_code, 1, i_Item_code) = 'Item code';   
		// item name 
          fg.MergeCol(i_Item_name) = true ;            
          fg.Cell(0, 0, i_Item_name, 1, i_Item_name) = 'Item Name';   
		  // account code
          fg.MergeCol(i_Acc_code) = true ;            
          fg.Cell(0, 0, i_Acc_code, 1, i_Acc_code) = 'Acc. code';   
		  // Prod Norm		          
          fg.Cell(0, 0, i_norm_qty, 0, i_norm_amt) = 'Prod Norm(a)';   		  
          fg.Cell(0, 1, i_norm_qty, 1, i_norm_qty) = 'Qty';
          fg.Cell(0, 1, i_norm_amt, 1, i_norm_amt) = 'Amount';
          // T/O MAT
          fg.Cell(0, 0, i_to_mat_qty, 0, i_to_mat_amt) = 'T/O MAT(b)';   		  
          fg.Cell(0, 1, i_to_mat_qty, 1, i_to_mat_qty) = 'Qty';
          fg.Cell(0, 1, i_to_mat_amt, 1, i_to_mat_amt) = 'Amount';
          // Diff (a)-(b)
          fg.Cell(0, 0, i_Diff_Qty, 0, i_Diff_Amt) = 'Diff(a) - (b)';   		  
          fg.Cell(0, 1, i_Diff_Qty, 1, i_Diff_Qty) = 'Qty';
          fg.Cell(0, 1, i_Diff_Amt, 1, i_Diff_Amt) = 'Amount';
          //warehouse name
          fg.MergeCol(i_WH_Name) = true ;            
          fg.Cell(0, 0, i_WH_Name, 1, i_WH_Name) = 'WH Name';   
      } 
      else if( i_language == "VIE")          
      {
          fg.MergeCol(i_Item_code) = true ;            
          fg.Cell(0, 0, i_Item_code, 1, i_Item_code) = 'Mã NVL';   
		// item name 
          fg.MergeCol(i_Item_name) = true ;            
          fg.Cell(0, 0, i_Item_name, 1, i_Item_name) = 'Tên NVL';   
		  // account code
          fg.MergeCol(i_Acc_code) = true ;            
          fg.Cell(0, 0, i_Acc_code, 1, i_Acc_code) = 'Mã TK';   
		  // Prod Norm		          
          fg.Cell(0, 0, i_norm_qty, 0, i_norm_amt) = 'Định mức(a)';   		  
          fg.Cell(0, 1, i_norm_qty, 1, i_norm_qty) = 'Số lượng';
          fg.Cell(0, 1, i_norm_amt, 1, i_norm_amt) = 'Thành tiền';
          // T/O MAT
          fg.Cell(0, 0, i_to_mat_qty, 0, i_to_mat_amt) = 'Xuất chỉ định(b)';   		  
          fg.Cell(0, 1, i_to_mat_qty, 1, i_to_mat_qty) = 'Số lượng';
          fg.Cell(0, 1, i_to_mat_amt, 1, i_to_mat_amt) = 'Thành tiền';
          // Diff (a)-(b)
          fg.Cell(0, 0, i_Diff_Qty, 0, i_Diff_Amt) = 'Trừ(a) - (b)';   		  
          fg.Cell(0, 1, i_Diff_Qty, 1, i_Diff_Qty) = 'Số lượng';
          fg.Cell(0, 1, i_Diff_Amt, 1, i_Diff_Amt) = 'Thành tiền';
          //warehouse name
          fg.MergeCol(i_WH_Name) = true ;            
          fg.Cell(0, 0, i_WH_Name, 1, i_WH_Name) = 'Tên kho';   	  
      }
}
//-----------------------------------------------------
</script>

<body>
    <!-------------------------------------------------------------------->
  <gw:data id="dso_consp_inq" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="ACNT.sp_sel_consp_inquiry" > 
                <input bind="idGrid" >                 
                    <input bind="lstCompany"/>
                    <input bind="dbMonthly"/>
                    <input bind="lstWH"/>
					<input bind="txtTAC_ABACCTCODE_PK"/>
                    <input bind="txtTCO_ITEM_PK"/>                                       
                </input>
                <output  bind="idGrid" />
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
                <tr >
                    <td align="right">Company</td>
                    <td align="left"><gw:list id="lstCompany" styles="width:100%" /></td>
                    <td align="right" ><a title="Click here to select account" onclick="OnPopUp('Account')" href="#tips">Account</a></td>
                    <td align="left"><gw:textbox id="txtAccountCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left"><gw:textbox id="txtAccountName" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="right">
                        <gw:imgbtn img="reset" alt="Reset" id="btnReset" onclick="OnReset('Account')" /></td>                                        
                    <td align="right" >WH</td>
					<td colspan="3" align="left" ><gw:list id="lstWH" styles="width:100%; " onchange="OnSearch('fmgf00110')" /></td>					
                    <td align="right"><gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('dso_consp_inq')" /></td>
                    <td align="right"><gw:imgbtn img="excel" alt="Export Consumption" id="btnExcel" onclick="OnExcel()" /></td>					
                    <td align="right"></td> <!-- <gw:imgbtn img="excel" alt="Report by Item" id="btnExcel2" onclick="OnExcel('item')" /> -->
                </tr>
                <tr>
                    <td align="right" >Month</td>
                    <td align="left" ><gw:datebox id="dbMonthly" type="month" lang="1"  /></td>
                    <td align="right" ><a title="Click here to select Product Item" onclick="OnPopUp('Item')" href="#tips">Item</a></td>
                    <td align="left" ><gw:textbox id="txtItemCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left" ><gw:textbox id="txtItemName" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="right">
                        <gw:imgbtn img="reset" alt="Reset" id="btnReset3" onclick="OnReset('Item')" />
                    </td>                                                            
                    <td align="right" ></td>
                    <td colspan="3" ></td>
                    <td colspan="3" align="right" ></td>
					<!-- <gw:icon id="btnExcel3" text="Details Inventory" onclick="OnExcel('details')" /> -->
                </tr> 
            </table>            
        </td>                     
    </tr>        
    <tr style="height:90%" >
        <td >
            <table width="100%;" border="0" cellpadding="0" cellspacing="0" style="height:100%"  >
                <tr>
                    <td>
                        <gw:grid id="idGrid" 
                            header="_mat_pk|Item code|Item name|Acc. code|norm qty|norm amt|t/o mat qty|t/o mat amt|Diff Qty|Diff Amt|WH Name"
                            format="0|0|0|0|0|0|0|0|0|0|0" 
                            aligns="0|1|0|1|3|3|3|3|3|3|0"
                            defaults="||||||||||"
                            editcol="0|0|0|0|0|0|0|0|0|0|0" 
                            widths="0|1200|2500|1200|1500|1500|1500|1500|1500|1500|1500"
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
</body>
</html>