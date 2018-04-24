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
var G_PK  			= 0,
G_item_code			= 1,
G_item_name			= 2,
G_uom				= 3,
G_wh_name			= 4,
G_ac_cd				= 5,
G_ac_nm				= 6,
G_input_qty			= 7,
G_tco_item_pk		= 8,
G_tac_abacctcode_pk	= 9,
G_tin_warehouse_pk	= 10,
G_tac_abplcenter_pk	= 11,
G_pl_cd				= 12,
G_pl_nm				= 13,
G_std_ym 			= 14,
G_tr_status 		= 15,
G_tco_company_pk	= 16;

//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
	BindingDataList();
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), partner_name FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
    var data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_name from inv.tin_warehouse  WHERE del_if = 0 ORDER BY wh_name  ASC" )%>|ALL|ALL";    
    lstWH.SetDataText(data); 
    lstWH.value = 'ALL';       
	<%=ESysLib.SetGridColumnComboFormat("idGrid", 3,"SELECT A.CODE, A.CODE_NM FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0 AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'COCI0030' ORDER BY A.CODE asc")%>;	
}
//------------------------------------------------------------------------
function OnPopUp(iObj)
{
	var tmp = new Array();
	var i;
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
	case 'Add Item':
            var path = System.RootURL + "/form/fp/ab/PopUpGetItem.aspx?purchase_yn=N&item_code=" + txtItemCode.text + "&item_name=" + txtItemName.text ;
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
            if(object != null)
            {
				for(i = 0; i < object.length; i++)
				{
					tmp = object[i];
					idGrid.AddRow();					
					idGrid.SetGridText(idGrid.rows - 1, G_item_code, tmp[1]) ;
					idGrid.SetGridText(idGrid.rows - 1, G_item_name, tmp[2]) ;
					idGrid.SetGridText(idGrid.rows - 1, G_tco_item_pk, tmp[0]) ;
					idGrid.SetGridText(idGrid.rows - 1, G_uom, tmp[5]) ;
					idGrid.SetGridText(idGrid.rows - 1, G_tac_abacctcode_pk, tmp[19]) ;		
					idGrid.SetGridText(idGrid.rows - 1, G_ac_cd, tmp[20]) ;					
					idGrid.SetGridText(idGrid.rows - 1, G_ac_nm, tmp[21]) ;					
					idGrid.SetGridText(idGrid.rows - 1, G_std_ym, dbMonthly.value ) ;
					if(lstWH.value != "ALL")
					{
						idGrid.SetGridText(idGrid.rows - 1, G_tin_warehouse_pk, lstWH.GetData() ) ;
						idGrid.SetGridText(idGrid.rows - 1, G_wh_name, lstWH.GetText() ) ;
					}		
					idGrid.SetGridText(idGrid.rows - 1, G_tco_company_pk, lstCompany.value ) ;				
				}                
            }                        
		break ;		
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
	case 'Item DblClick':
		var l_row = idGrid.row;		
		if(event.col == G_item_code)
		{
            var path = System.RootURL + "/form/fp/ab/PopUpGetOneItem.aspx?purchase_yn=&item_code=" + txtItemCode.text + "&item_name=" + txtItemName.text ;
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
            if(object != null)
            {
				idGrid.SetGridText(l_row, G_item_code, object[1]) ;
				idGrid.SetGridText(l_row, G_item_name, object[2]) ;
				idGrid.SetGridText(l_row, G_tco_item_pk, object[0]) ;
				idGrid.SetGridText(l_row, G_uom, object[5]) ;
				idGrid.SetGridText(l_row, G_tac_abacctcode_pk, object[19]) ;		
				idGrid.SetGridText(l_row, G_ac_cd, object[20]) ;					
				idGrid.SetGridText(l_row, G_ac_nm, object[21]) ;									
            }                        
		}
		else if(event.col == G_pl_cd)
		{
	        var path = System.RootURL + "/form/gf/co/gfco002005.aspx?dsqlid=ACNT.SP_SEL_fmgf00050_2&company=" + lstCompany.value + "&col_code=PL Code&col_nm=PL Name&comm_nm=" +  + "&val1=" + lstWH.value ;
	        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
	        if(object != null)
	        {
	            idGrid.SetGridText(l_row, G_tac_abplcenter_pk, object[2] );
				idGrid.SetGridText(l_row, G_pl_cd, object[0] );
				idGrid.SetGridText(l_row, G_pl_nm, object[1] );
	        }		
		}
		else if(event.col == G_wh_name)
		{
            var path = System.RootURL + "/form/fp/ab/PopUpGetWareHouse.aspx";
            var object = System.OpenModal( path ,500 , 350 ,  'resizable:yes;status:yes');        
            if(object != null)
            {
				idGrid.SetGridText(l_row, G_tin_warehouse_pk, object[0] );
				idGrid.SetGridText(l_row, G_wh_name, object[2] );
			}			
		}
		else if(event.col == G_ac_cd)
		{
            var path = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_code=&comm_nm=&dsqlid=ACNT.SP_SEL_fmgf00050_3&val1=" + lstCompany.value + "&val2=" + lstWH.value + "&val3=" ;

            var object = System.OpenModal( path ,700 , 400 ,  'resizable:yes;status:yes');
            if(object!=null)
            {
				idGrid.SetGridText(l_row, G_ac_cd, object[0]);
				idGrid.SetGridText(l_row, G_ac_nm, object[1]);
				idGrid.SetGridText(l_row, G_tac_abacctcode_pk, object[3]);
            }    			
		}
		break ;		
    }
}
//------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'datfmgf00200' :        
            datfmgf00200.Call("SELECT");         
        break;
    }	
}
//------------------------------------------------------------------------
function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'datfmgf00200':
			if(idGrid.rows > 1)
			{
				btnDel.SetEnable(true);
			}
			else
			{
				btnDel.SetEnable(false);
			}
			OnFormatGrid();
		break ;
		case 'pro_fmgf000200':
			alert(txtReturnValue.text);
		break ;
	}
}
//------------------------------------------------------------------------
function OnExcel(iObj)
{
}
//-----------------------------------------------------
function OnFormatGrid()
{
    var trl ;
    trl = idGrid.GetGridControl();	
    trl.ColFormat(G_input_qty) = "###,###,###,###,###.##";
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
function auto_resize_column(obj,col1,col2,font_size)
{
/*
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
  */
}
//--------------------------------------------------
function OnAddNew()
{
	OnPopUp('Add Item');
}
//--------------------------------------------------
function OnSave()
{
	datfmgf00200.Call();
}
//--------------------------------------------------
function OnDelete()
{
	var i, l_cnt = 0;
	var ctr = idGrid.GetGridControl() ;
	for(i = 1; i < idGrid.rows; i++)
	{
		if(ctr.SelectedRow(i))
		{
			if(idGrid.GetGridData(i, G_tr_status) == '1')
			{
				idGrid.DeleteRow(i);
				l_cnt += 1;	
			}				
			else
				alert('Cannot delete row ' + i);				
		}
	}
	if(l_cnt > 0)
	{
		OnSave();
	}
}
//-----------------------------------------------------
function OnConfirm()
{
	pro_fmgf000200.Call();
}
//-----------------------------------------------------
</script>

<body>
    <!-------------------------------------------------------------------->
  <gw:data id="datfmgf00200" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,3,7,8,9,10,11,14,16" function="acnt.sp_sel_wip_incoming" procedure="acnt.sp_upd_wip_incoming" > 
                <input bind="idGrid" >                 
                    <input bind="lstCompany"/>
                    <input bind="dbMonthly"/>
                    <input bind="txtTAC_ABACCTCODE_PK"/>
                    <input bind="txtTCO_ITEM_PK"/>                    
                    <input bind="txttac_abplcenter_pk"/>
                    <input bind="lstWH"/>                    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>       
    <!-------------------------------------------------------------------->
  <gw:data id="pro_fmgf000200" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="acnt.sp_pro_wip_material" > 
                <input>
					<input bind="dbMonthly" />                 
                    <input bind="lstCompany" />
                </input>
	            <output>
                	<output  bind="txtReturnValue" />
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
                    <td style="width: 2%"></td>
                    <td style="width: 2%"></td>
					<td style="width: 2%"></td>
                </tr>
                <tr >
                    <td align="right">Company&nbsp;</td>
                    <td align="left"><gw:list id="lstCompany" styles="width:100%" /></td>
                    <td align="right" ><a title="Click here to select account" onclick="OnPopUp('Account')" href="#tips">Account&nbsp;</a></td>
                    <td align="left"><gw:textbox id="txtAccountCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left"><gw:textbox id="txtAccountName" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="right">
                        <gw:imgbtn img="reset" alt="Reset" id="btnReset" onclick="OnReset('Account')" /></td>                                        
                    <td align="right" ><a title="Click here to select PL" onclick="OnPopUp('PL')" href="#tips">PL&nbsp;</a></td>
                    <td align="left"><gw:textbox id="txtPLCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left" ><gw:textbox id="txtPLName" text="" styles="width:100%; " csstype="mandatory" /></td>                    
                    <td align="right"><gw:imgbtn img="reset" alt="Reset" id="btnReset2" onclick="OnReset('PL')" /></td>                    
                    <td align="right"><gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('datfmgf00200')" /></td>
                    <td align="right"><gw:imgbtn img="new" alt="New" id="btnNew" onclick="OnAddNew()" /></td>
                    <td align="right"><gw:imgbtn img="delete" alt="Delete" id="btnDel" onclick="OnDelete()" /></td>
					<td align="right"><gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" /></td>
                </tr>
                <tr>
                    <td align="right" >Month&nbsp;</td>
                    <td align="left" ><gw:datebox id="dbMonthly" type="month" lang="1"  /></td>
                    <td align="right" ><a title="Click here to select Product Item" onclick="OnPopUp('Item')" href="#tips">WIP&nbsp;</a></td>
                    <td align="left" ><gw:textbox id="txtItemCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left" ><gw:textbox id="txtItemName" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="right">
                        <gw:imgbtn img="reset" alt="Reset" id="btnReset3" onclick="OnReset('Item')" />
                    </td>                                                            
                    <td align="right" >Warehouse&nbsp;</td>
                    <td colspan="3" align="left" ><gw:list id="lstWH" styles="width:100%; " onchange="OnSearch('fmgf00110')" /></td>
                    <td colspan="4" align="right" ><gw:icon id="idBtnConfirm" text="Confirm" img="in" onclick="OnConfirm()" /></td>
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
                            header="_tac_stocktr_pk|Item code|Item Name|UOM|Warehouse|Acc. code|Acc. Name|Input Qty|_tco_item_pk|_tac_abacctcode_pk|_tin_warehouse_pk|_tac_abplcenter_pk|PL Code|PL Name|_std_ym|_tr_status|_tco_company_pk"
                            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                            aligns="0|1|0|1|0|1|0|3|0|0|0|0|0|0|0|0|0"
                            defaults="||||||||||||||||" 
                            editcol="0|1|1|1|1|1|1|1|0|0|0|0|1|1|0|0|0" 
                            widths="0|2000|3000|1500|2000|2500|3000|2500|0|0|0|0|1200|1500|0|0|0"
                            styles="width:100%; height:100% " 
                            acceptNullDate="T" 
                            sorting="T"
                            param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16"
							oncelldblclick="OnPopUp('Item DblClick')" />                    
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>            
<gw:textbox id="txtTAC_ABACCTCODE_PK" styles="display:none; " />
<gw:textbox id="txtTCO_ITEM_PK" styles="display:none; " />
<gw:textbox id="txttac_abplcenter_pk" styles="display:none; " />
<gw:textbox id="txtReturnValue" styles="display:none; " />
</body>
</html>