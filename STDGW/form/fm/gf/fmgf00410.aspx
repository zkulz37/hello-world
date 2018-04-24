<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Consumption Evaluation</title>
</head>

<script>

    var  user_pk = "<%=Session("USER_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;
    // Grid columns
    var iWH = 0,
    iProduct = 1,
    iSemi_Prod = 2,
    iQtySemi_Prod = 3,
    iSTCode = 4,
    iSTName = 5,
    iSTCodeQty = 6,
    iSTCodeAmt = 7,
    iPrice = 8;
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
    //OnFormatGrid();
	//OnFormatHeader();
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
    var data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_name FROM inv.tin_warehouse  WHERE del_if = 0 and wh_type in ('20', '04') ORDER BY wh_name  ASC" )%>|ALL|ALL";    
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
            var path = System.RootURL + "/form/fm/gf/PopUpGetOneItem.aspx?purchase_yn=&item_code=" + txtItemCode.text + "&item_name=" + txtItemName.text ;
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
function OnSearch()
{
     data_fmgf00410.Call("SELECT")            
}
//------------------------------------------------------------------------
function OnDataReceive(obj)
{
    if(obj.id == "pro_fmgf00410")
    {
        //alert(txtReturn.GetData());
        data_fmgf00410.Call('SELECT');
    }
    if(obj.id == "pro_fmgf00410_1")
    {
        //alert(txtReturn.GetData());
        data_fmgf00410.Call('SELECT');
    }
    else if(obj.id == "data_fmgf00410")
    {
        var v_qtystcode = 0, v_amtstcode = 0;
        var i;
        idGrid.GetGridControl().MergeCells  = 2 ;	
        idGrid.GetGridControl().MergeCol(0) = true ;	
        idGrid.GetGridControl().MergeCol(1) = true ;   	
        idGrid.Subtotal( 0, 2, 1, '6!7');
        
        OnFormatGrid();
    }
}
//------------------------------------------------------------------------
function OnExcel()
{
    //var url = System.RootURL + "/reports/fm/gf/fmgf00400.aspx?comp_pk=" + lstCompany.value + "&std_ym=" + dbMonthly.value + "&warehouse_pk=" + lstWH.value + "&acpk=" + txtTAC_ABACCTCODE_PK.GetData() + "&item_pk=" + txtTCO_ITEM_PK.GetData() + "&abplcenter_pk=" + txttac_abplcenter_pk.GetData();
    //System.OpenTargetPage(url);                
    alert('Not Yet, Waiting for design...');
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
//-----------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//-----------------------------------------------------
//-----------------------------------------------------
function OnUpdate()
{
	if(confirm("Are you sure you want to process data?"))
	{
		pro_fmgf00410.Call();
	}
}
//-----------------------------------------------------
function OnFormatGrid()
{
    var fg = idGrid.GetGridControl();
    fg.ColFormat(iQtySemi_Prod) = "###,###,###,###R";
    fg.ColFormat(iSTCodeQty) = "###,###,###,###.###R";
    fg.ColFormat(iSTCodeAmt) = "###,###,###,###,###,###R";    
}
//-----------------------------------------------------

function OnCancel()
{
    if(confirm('Are you sure you want to cancel data already processed?'))
    {
        pro_fmgf00410_1.Call();
    }
}
</script>

<body>
    <!-------------------------------------------------------------------->
	    <gw:data id="pro_fmgf00410" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="acnt.sp_pro_fmgf00410">
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
	    <gw:data id="pro_fmgf00410_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="acnt.sp_pro_fmgf00410_1">
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
  <gw:data id="data_fmgf00410" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="ACNT.sp_sel_fmgf00410" > 
                <input bind="idGrid" >                 
                    <input bind="lstCompany"/>
                    <input bind="dbMonthly"/>					
                    <input bind="lstWH"/> 
                    <input bind="txtTAC_ABACCTCODE_PK"/>
                    <input bind="txtTCO_ITEM_PK"/>                    
                    <input bind="txttac_abplcenter_pk"/>                                                           
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
				<tr>
                    <td align="right">Company</td>
                    <td align="left"><gw:list id="lstCompany" styles="width:100%" /></td>				
					<td align="right">Month</td>
					<td align="left" ><gw:datebox id="dbMonthly" type="month" lang="1" /></td>
					<td align="right" colspan="2" ></td>
                    <td align="right" ><a title="Click here to select Product Item" onclick="OnPopUp('Item')" href="#tips">Item</a></td>
                    <td align="left" ><gw:textbox id="txtItemCode" text="" styles="width:100%; " /></td>
                    <td align="left" ><gw:textbox id="txtItemName" text="" styles="width:100%; " /></td>
                    <td align="right">
						<gw:imgbtn img="reset" alt="Reset" id="btnReset3" onclick="OnReset('Item')" />
                    </td>                                                            					
                    <td align="right"><gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" /></td>
                    <td align="right"><gw:imgbtn img="printer" alt="Report by STItem" id="btnExcel" onclick="OnExcel()" /></td>
                    <td align="right"></td>					
				</tr>
				<tr>
                    <td align="right" >WH</td>
                    <td colspan="1" align="left" ><gw:list id="lstWH" styles="width:100%; " onchange="OnSearch()" /></td>				
                    <td align="right" ><a title="Click here to select account" onclick="OnPopUp('Account')" href="#tips">Account</a></td>
                    <td align="left"><gw:textbox id="txtAccountCode" text="" styles="width:100%; " /></td>
                    <td align="left"><gw:textbox id="txtAccountName" text="" styles="width:100%; " /></td>
                    <td align="right">
                        <gw:imgbtn img="reset" alt="Reset" id="btnReset" onclick="OnReset('Account')" />
					</td>
                    <td align="right" ><a title="Click here to select PL" onclick="OnPopUp('PL')" href="#tips">PL</a></td>
                    <td align="left"><gw:textbox id="txtPLCode" text="" styles="width:100%; " /></td>
                    <td align="left" ><gw:textbox id="txtPLName" text="" styles="width:100%; " /></td>                    
                    <td align="right"><gw:imgbtn img="reset" alt="Reset" id="btnReset2" onclick="OnReset('PL')" /></td>                    					
					<td colspan="3" align="right" ><gw:list id="lstRptExcel" style="display:none; " >
						<data>DATA|0|Report by Item|1|Report by Group</data>
						</gw:list>
					</td>
				</tr>
					<td colspan="10" align="right"><gw:icon id="btnCancel" text="Cancel" img="in" onclick="OnCancel()" /></td>
					<td colspan="3" align="right"><gw:icon id="btnUpdate" text="Process" img="in" onclick="OnUpdate()" /></td>
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
                            header="W/H|Product|Semi-Prod|Q'ty(Semi-Prod)|STItem Code|STItem Name|Q'ty|Amount|Price"
                            format="0|0|0|0|0|0|0|0|0" 
                            aligns="1|1|1|3|1|2|3|3|3"
                            defaults="||||||||" 
                            editcol="0|0|0|0|0|0|0|0|0" 
                            widths="2400|1200|1800|1500|1500|2000|1600|1900|1000"
                            styles="width:100%; height:100% " 
                            acceptNullDate="T" 
                            sorting="F" 
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