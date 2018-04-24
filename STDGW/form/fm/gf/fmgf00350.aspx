<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1"  runat="server">
    <title>Transfer Material</title>
</head>
<script>
    var  user_pk = "<%=Session("USER_PK")%>" ;
    var  user_name = "<%=Session("USER_NAME")%>" ;
    var  user_id = "<%=Session("USER_ID")%>" ;
	var org_pk = "<%=Session("TCO_ORG_PK")%>" ;
	var g_item_code 	= 0,
		g_item_name		= 1,
		g_warehouse		= 2,
		g_qty			= 3,
		g_trans_amt		= 4,
		g_book_amt		= 5,
		g_req_no		= 6,
		g_stock_date	= 7,
		g_pl_code		= 8,
		g_pl_name		= 9,
		g_remark		= 10,
		g_seq			= 11,
		g_voucher_no	= 12;	
//-----------------------------------------------------
function BodyInit()
{
	System.Translate(document);
	BindingDataList();
	btnMkSlip.SetEnable(false);
	btnCancel.SetEnable(false);	
} 
//-----------------------------------------------------
 function BindingDataList()
 {
     var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
	ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), wh_name FROM inv.tin_warehouse WHERE DEL_IF=0")%>||Select All";
	lstWHOut.SetDataText(ls_data);
	lstWHOut.value = '';	
	lstWHIn.SetDataText(ls_data);
	lstWHIn.value = '';
	grdDtl.GetGridControl().FrozenCols = 3;
	var l_fr_date = "";
	l_fr_date = dtStockDT_To.value ;
	dtStockDT.SetDataText(l_fr_date.substring(0, 6) + "01");
	
 }  
 //----------------------------------------------------- 
function OnDataReceive(iObj)
{
	switch(iObj.id)
	{
		case "dso_transfer_mat_lst":
			var fg = grdDtl.GetGridControl();
			fg.ColFormat(g_book_amt) = "###,###,##.##";
			fg.ColFormat(g_trans_amt) = "###,###,##.##";
			fg.ColFormat(g_qty) = "###,###,##.##";


			txtSeq.text = "";
			txtVoucherNo.text = "";
			if(grdDtl.rows > 1)
			{
				txtVoucherNo.text = grdDtl.GetGridData(grdDtl.rows - 1, g_voucher_no);
				txtSeq.text = grdDtl.GetGridData(grdDtl.rows - 1, g_seq);
			}
			if(	txtSeq.text == "" && grdDtl.rows > 1 )
			{
				btnMkSlip.SetEnable(true);
				btnCancel.SetEnable(false);
			}
			if(	txtSeq.text != "" && grdDtl.rows > 1 )
			{
				btnMkSlip.SetEnable(false);
				btnCancel.SetEnable(true);
			}
		break ;
		case "dso_pro_transfer":
			dso_transfer_mat_lst.Call("SELECT");
		break;
		case "dso_pro_make_slip":
			dso_transfer_mat_lst.Call("SELECT");
		break ;
		case "dso_pro_cancel_slip":
			dso_transfer_mat_lst.Call("SELECT");
		break ;		
	}
}
//---------------------------------------------------
function OnSearch()
{
	dso_transfer_mat_lst.Call("SELECT");
}
//------------------------------------------------------------
function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}
//------------------------------------------------------------
function OnProcess()
{
	if(confirm("Are you sure you want to process transferred material?"))
	{
		dso_pro_transfer.Call();
	}	
}
//------------------------------------------------------------
function OnMakeSlip()
{
	if(confirm("Are you sure you want to make slip for transferred material on " + dtStockDT.text + " ?"))
	{
		dso_pro_make_slip.Call();
	}
}
//------------------------------------------------------------
function OnCancelSlip()
{
	if(confirm("Are you sure you want to cancel slip for transferred material on " + dtStockDT.text + " ?"))
	{
		if(Trim(txtSeq.text) != "")
			dso_pro_cancel_slip.Call();		
	}
}
//------------------------------------------------------------
</script>
<body>
<!------------------------------------------------------------------------>
<gw:data id="dso_transfer_mat_lst" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="grid" function="acnt.sp_sel_fmgf00350" > 
            <input bind="grdDtl" > 
                 <input bind="lstCompany" />
                 <input bind="dtStockDT" />
                 <input bind="txtReqNo" />
                 <input bind="lstWHOut" />
                 <input bind="lstWHIn" />                 
				 <input bind="txtItem" />
             </input> 
            <output bind="grdDtl" /> 
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------>
   <gw:data id="dso_pro_transfer" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_FMGF00350"> 
                <input>                      
                     <input bind="lstCompany" />
                     <input bind="dtStockDT" />
                     <input bind="dtStockDT_To" />
                </input>
                <output>
                     <output bind="txtReturn" />                     
               </output> 
            </dso> 
        </xml> 
    </gw:data>
	
   <gw:data id="dso_pro_make_slip" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_FMGF00350_1"> 
                <input> 
                     <input bind="lstCompany" />
                     <input bind="dtStockDT" />
                     <input bind="dtStockDT_To" />
                </input>
                <output>
                     <output bind="txtReturn" />                     
               </output> 
            </dso> 
        </xml> 
    </gw:data>

   <gw:data id="dso_pro_cancel_slip" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_FMGF00350_2"> 
                <input> 
					 <input bind="txtSeq"/>		                     
                </input>
                <output>
                     <output bind="txtReturn" />                     
               </output> 
            </dso> 
        </xml> 
    </gw:data>
	
 <!------------------------------------------------------------------------>
<table border="1" style="width:100%" cellpadding="0" cellspacing="0" style="height:100%">
    <tr style="height:100%"> 
        <td id="tRIGHT" style="width: 100%; ">
            <table style="width: 100%; height:100%; " border="0" cellpadding="0" cellspacing="0">
                <tr style="height:5%">
                    <td align="right" width="15%;" >Company</td>
                    <td width="20%;" align="right"><gw:list id="lstCompany" styles="width:100%;" /></td>
                    <td width="15%;" align="right">Stock Date</td>
                    <td width="10%;" align="left"><gw:datebox id="dtStockDT" lang="1" styles="width:100%;" /></td>
                    <td width="10%;" align="left"><gw:datebox id="dtStockDT_To" lang="1" styles="width:100%;" /></td>
                    <td width="15%;" align="right">Req. No</td>
                    <td align="left" width="15%;" ><gw:textbox id="txtReqNo" styles="width:100%;" /></td>
                </tr>
                <tr style="height:5%">
                    <td align="right" width="15%;" >WH Output</td>
                    <td width="20%;" align="right"><gw:list id="lstWHOut" styles="width:100%;" /></td>
                    <td width="15%;" align="right">WH Input</td>
                    <td width="20%;" colspan="2" align="left"><gw:list id="lstWHIn" styles="width:100%;" /></td>
                    <td width="15%;" align="right">Item</td>
                    <td align="left" width="15%;" ><gw:textbox id="txtItem" styles="width:100%;" /></td>				
                </tr>  
				<tr style="height:5%">
					<td align="right">Voucher No</td>
					<td align="left"><gw:textbox id="txtVoucherNo" styles="width:100%;" /></td>
					<td align="right">Seq</td>
					<td align="left" colspan="2"><gw:textbox id="txtSeq" styles="width:100%;" /></td>
					<td colspan="2" >
						<table style="width:100%;height:100%;" border="0" cellpadding="0" cellspacing="0" >
							<tr>
								<td align="right"><gw:imgBtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
								<td align="right"><gw:icon id="btnProcess" img="in" text="Process" alt="Process" onclick="OnProcess()" /></td>
								<td align="right"><gw:icon id="btnMkSlip" img="in" text="Make Slip" alt="Make Slip" onclick="OnMakeSlip()" /></td>
								<td align="right"><gw:icon id="btnCancel" img="in" text="Cancel Slip" alt="Cancel Slip" onclick="OnCancelSlip()" /></td>
							</tr>
						</table>
					</td>
				</tr>	
                <tr style="height:85%;">
                    <td colspan="7">
                        <gw:grid id='grdDtl'
                            header='Item Code|Item Name|Warehouse|Qty|UPrice|Book Amt|Req. No|Stock Date|PL Code|PL Name|Remark|Seq|Voucher No'
                            format='0|0|0|0|0|0|0|4|0|0|0|0|0'
                            aligns='2|2|2|3|3|3|2|1|2|2|0|1|0'
                            defaults='||||||||||||' 
							editcol='0|0|0|0|0|0|0|0|0|0|0|0|0'
                            widths='1400|2000|1500|1400|1500|1500|1500|1300|1200|1500|1500|1400|1500'
                            acceptNullDate='T'
                            sorting='T' 
							styles='width:100%; height:100%' 
                            />                                                                                                                               
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    </table>
<!------------------------------------------------------------------------>
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />      
<!------------------------------------------------------------------------>    
<gw:textbox id="txtItemPK" style="display:none" />
<gw:textbox id="txtReturn" style="display:none" />
</body>
</html>
