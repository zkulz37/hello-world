<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>S/L for Inventory</title>
</head>

<script>

    var  user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;
    var g_company_pk = "<%=Session("COMPANY_PK")%>"  ;
        
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
    txtAccountCode.SetEnable(false);
    txtAccountName.SetEnable(false);
    txtItemCode.SetEnable(false);
    txtItemName.SetEnable(false);	
// from day to day
var l_from = dtFrom.value;
dtFrom.value = l_from.substr(0, 6) + '01';

//    idGrid.GetGridControl().FrozenCols = 2 ;
    OnFormatGrid();
    OnMergeHeader();
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
    lstCompany.value = g_company_pk ;
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

	fmgf00390.Call("SELECT");
}
//------------------------------------------------------------------------
function OnFormatGrid()
{
    var trl ;
    trl = idGrid.GetGridControl();	
    trl.ColFormat(6) = "###,###,###,###R";
    trl.ColFormat(5) = "###,###,###,###.#####R";
    trl.ColFormat(7) = "###,###,###,###.#####R";
    trl.ColFormat(8) = "###,###,###,###R";
    trl.ColFormat(9) = "###,###,###,###.#####R";
    trl.ColFormat(10) = "###,###,###,###R";
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
function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}
//-----------------------------------------------------
function CalcuSubTotal()
{                
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
}
//-----------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//-----------------------------------------------------
function OnGetData()
{
		fmgf00110.Call("SELECT");
}
//-----------------------------------------------------
function OnReset(iCase)
{
    if(iCase == '1')
    {
        txtAccountCode.text = '';
        txtAccountName.text = '';
        txtTAC_ABACCTCODE_PK.text = '';
    }
    else if(iCase == '2')
    {
        txtItemCode.text = '';
        txtItemName.text = '';
        txtTCO_ITEM_PK.text = '';    
    }
}
//-------------------------------------------------
function OnMergeHeader()
{
    var fg = idGrid.GetGridControl();
    if(idGrid.rows == 1)
    {
        idGrid.AddRow();
    }
    fg.Cell(13, 1, 1, 1,fg.Cols - 1) = true; //Format all col merge : Fone = Bold		
    fg.FixedRows = 2;
    fg.MergeCells =5;
    // merger header
    fg.MergeRow(0) = true;
        
    fg.Cell(0,0,0,0,1)  = "Voucher";
    fg.Cell(0,1,0,1,0)  = "No";
    fg.Cell(0,1,1,1,1)  = "Date";
    fg.MergeCol(2) = true;
    fg.Cell(0,0,2,1,2)  = "Remark";
    fg.MergeCol(3) = true;
    fg.Cell(0,0,3,1,3)  = "Account code";
    
    fg.MergeCol(4) = true;
    fg.Cell(0,0,4,1,4)  = "Unit Price";
    
    fg.Cell(0,0,5,0,6)  = "Input";
    fg.Cell(0,1,5,1,5)  = "Q'ty";
    fg.Cell(0,1,6,1,6)  = "Amount";
    
    fg.Cell(0,0,7,0,8)  = "Output";
    fg.Cell(0,1,7,1,7)  = "Q'ty";
    fg.Cell(0,1,8,1,8)  = "Amount";
    
    fg.Cell(0,0,9,0,10)  = "Ending";
    fg.Cell(0,1,9,1,9)  = "Q'ty";
    fg.Cell(0,1,10,1,10)  = "Amount";
    fg.Cell(0,0,11,0,11)  = "Notes";
    fg.Cell(0,1,11,1,11)  = "Seq";
    fg.MergeCol(12) = true;    
    fg.Cell(0,0,12,1,12)  = "Diễn giải";
}

//-----------------------------------------
function OnDataReceive(iObj)
{
    if(iObj.id == 'fmgf00390')
    {
        OnMergeHeader();
        if(idGrid.rows >= 3)
        {
            idGrid.SetCellBgColor(2, 0,2,idGrid.cols-1,0xA9EBD7);            
        }
        
    }
}
//-----------------------------------------
function OnPrint()
{
    var url = System.RootURL + "/reports/fm/gf/fmgf00390_soCTVLDC_sanphamHH_S10-DN.aspx?company_pk=" + lstCompany.value + "&item_pk=" + txtTCO_ITEM_PK.text + "&acc_pk=" + txtTAC_ABACCTCODE_PK.text + "&wh_pk=" + lstWH.value + "&from_date=" + dtFrom.value + "&to_date=" + dtTo.value ;
    System.OpenTargetPage(url);            
}

</script>

<body>    
  <gw:data id="fmgf00390" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="ACNT.sp_sel_fmgf00390" > 
                <input bind="idGrid" >                 
                    <input bind="lstCompany" />
                    <input bind="txtTCO_ITEM_PK" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtTAC_ABACCTCODE_PK" />                    
                    <input bind="lstWH" />
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
                    <td style="width: 17%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 3%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 15%"></td>
                    <td style="width: 15%"></td>
                    <td style="width: 15%"></td>
                    <td style="width: 9%"></td>
                    <td style="width: 3%"></td>
                    <td style="width: 3%"></td>
                </tr>
				<tr>
                    <td align="right">Company&nbsp;</td>
                    <td align="left" colspan="3"><gw:list id="lstCompany" styles="width:100%" /></td>				
					<td align="right" ><a title="Click here to select account code" onclick="OnPopUp('Account')" href="#tips">Account code&nbsp;</a></td>
                    <td align="left"><gw:textbox id="txtAccountCode" text="" styles="width:100%; " /></td>
                    <td align="left" colspan="3"><gw:textbox id="txtAccountName" text="" styles="width:100%; " /></td>										
                    <td><gw:imgBtn id="btnReset" img="reset" alt="Reset" onclick="OnReset('1')" /></td>                  
				</tr>
				<tr>
				    <td align="right">Period&nbsp;</td>
				    <td align="left"><gw:datebox id="dtFrom" lang="1" /></td>
				    <td>~&nbsp;</td>
				    <td align="left"><gw:datebox id="dtTo" lang="1" /></td>
				    <td align="right"><a title="Click here to select item code" onclick="OnPopUp('Item')" href="#tips">Item code&nbsp;</a></td>
				    <td align="left"><gw:textbox id="txtItemCode" styles="width:100%;" /></td>
				    <td align="left" colspan="3"><gw:textbox id="txtItemName" styles="width:100%;" /></td>
				    <td><gw:imgBtn id="btnReset_1" img="reset" alt="Reset" onclick="OnReset('2')" /></td>
				</tr>
				<tr>
				    <td align="right">Warehouse&nbsp;</td>
				    <td align="left" colspan="3"><gw:list id="lstWH" styles="width:100%;" /></td>
				    <td align="right">Voucher No&nbsp;</td>
				    <td align="left"><gw:textbox id="txtVoucherNo" styles="width:100%;" onkeypress="Upcase()" /></td>
				    <td align="right">Seq&nbsp;</td>
				    <td align="left" colspan="1"><gw:textbox id="txtSeq" styles="width:100%;" /></td>
				    <td><gw:imgBtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
				    <td><gw:imgBtn id="btnPrint" img="printer" alt="Print" onclick="OnPrint()" /></td>				    
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
                            header="VoucherNo|Date|Remark|acc code|Unit Price|Q'ty|Amount|Q'ty|Amt|Q'ty|Amt|seq|remark2"
                            format="0|4|0|0|0|0|0|0|0|0|0|0|0" 
                            aligns="2|1|2|1|3|3|3|3|3|3|3|3|0"
                            defaults="||||||||||||" 
                            editcol="0|1|0|0|0|0|0|0|0|0|0|0|0" 
                            widths="1500|1200|2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"
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
</body>
</html>