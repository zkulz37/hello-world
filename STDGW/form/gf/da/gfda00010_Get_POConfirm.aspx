<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>    
</head>
<%ESysLib.SetUser("acnt")%>

<script>
var g_vendor_pk = "<%=Request.querystring("vendor_pk")%>";	
var g_vendor_id = "<%=Request.querystring("vendor_id") %>";	
//--------------------------------------------              
function BodyInit()
{
    System.Translate(document);
	BindingDataList();
}
//--------------------------------------------
function BindingDataList()
{
	var l_dtfr = dtTIDatefr.value ;
	dtTIDatefr.value = l_dtfr.substring(0, 6) + "01" ;
	var ls_data         = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
	lstCompany.SetDataText(ls_data);	
	txtPartnerPK.text = g_vendor_pk ;
	txtVendorID.text = g_vendor_id ;	
}

//--------------------------------------------
function OnSearch()
{
	dso_get_po_confirm.Call("SELECT");	
}
//--------------------------------------------
function OnDataReceive(iObj)
{
	switch(iObj.id)	
	{
		case 'dso_get_po_confirm':
		break ;
	}
}
//--------------------------------------------
function OnSelect()
{
	var code_data = new Array()      
	  	
	var ctrl = grdDtl.GetGridControl();
    var i , j, index = 0;
	if( ctrl.rows == 1 )
	{
		return ;
	}
	else
	{
		for( i = 1 ; i < grdDtl.rows ; i++ )
		{
		    if(grdDtl.GetGridData(i, 1)=='-1')
		    {
			    var arr_data = new Array();			
			    for( j = 0 ; j < grdDtl.cols - 1 ; j++ )
			    {
				    arr_data[arr_data.length] = grdDtl.GetGridData(i , j );				
			    } 
			    code_data[code_data.length] = arr_data ;				
			}    			    
		}
	}
	window.returnValue = code_data; 
	this.close(); 		
}
//--------------------------------------------
function OnClose()
{
    this.close();
}
//--------------------------------------------
function OnPopUp(iCase)
{
	switch(iCase)
	{
		case 'Partner':
			var fpath   = System.RootURL + "/form/fm/gf/PopUpGetPartner.aspx";
			var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
			if ( object != null )  
			{
				if (object[0] != "")
				{
					txtPartnerPK.text = object[0];
					txtVendorID.text = object[1];
					txtVendorNM.text = object[2];
				}
			}	
		break ;
		case 'Item':
			var fpath   = System.RootURL + "/form/fm/gf/PopUpGetOneItem.aspx";
			var object  = System.OpenModal(fpath , 900 , 500 , 'resizable:yes;status:yes'); 
			if ( object != null )  
			{
				if (object[0] != "")
				{
					txtItemPK.text = object[0];
					txtItemCD.text = object[1];
					txtItemNM.text = object[2];
				}
			}			
		break ;
	}
}

function OnReset(iCase)
{
	if(iCase == '1')
	{
		txtVendorID.text = '';
		txtVendorNM.text = '';
		txtPartnerPK.text = "";		
	}
	else if(iCase == "2")
	{
		txtItemCD.text = '';
		txtItemNM.text = '';
		txtItemPK.text = '';
	}
}
</script>
<body style="margin:0; padding:0;">
<!------------------------------------------------------------------------------------------------>
<gw:data id="dso_get_po_confirm" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="acnt.sp_sel_tac_crdad_poconfirm" >
                <input bind="grdDtl">
                    <input bind="lstCompany" />
                    <input bind="txtVoucherNo" />
					<input bind="dtTIDatefr"/>
					<input bind="dtTIDateto"/>
					<input bind="txtPartnerPK"/>
					<input bind="txtItemPK"/>
                </input>
                <output bind="grdDtl"/>
            </dso>
        </xml>
    </gw:data>
	
<!------------------------------------------------------------------------------------------------>
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%">
<tr style="height:0%" >    
    <td width="10%"></td>
    <td width="10%"></td>
    <td width="1%"></td>
	<td width="10%"></td>
	<td width="10%"></td>
    <td width="10%"></td>
    <td width="20%"></td>
    <td width="3%"></td>
    <td width="10%"></td>
    <td width="10%"></td>    
    <td width="6%"></td>	
</tr>
<tr style="height:4%">
	<td align="right" >Company&nbsp;</td>
	<td align="left" colspan="3"><gw:list id="lstCompany" styles="width:100%" /></td>
	<td align="right"><a title="Click here to show Vendor" onclick="OnPopUp('Partner')" href="#tips" ><b>Vendor&nbsp;</b></a></td>
	<td align="left"><gw:textbox id="txtVendorID" text="" styles="width:100%" /></td>
	<td align="left"><gw:textbox id="txtVendorNM" text="" styles="width:100%" /></td>
	<td align="left"><gw:imgBtn id="idBtnReset" img="reset" alt="Reset" onclick="OnReset('1')" /></td>
	<td align="right">VoucherNo&nbsp;</td>
	<td align="left"><gw:textbox id="txtVoucherNo" styles="width:100%;" /></td>	
	<td align="left"><gw:imgBtn id="idBtnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
</tr>
<tr style="height:4%">
	<td align="right" >Trans Date&nbsp;</td>
	<td align="left" colspan="1"><gw:datebox id="dtTIDatefr" lang="1" styles="width:100%" /></td>	
	<td align="right">~</td>
	<td align="left" colspan="1"><gw:datebox id="dtTIDateto" lang="1" styles="width:100%" /></td>
	<td align="right"><a title="Click here to show Item" onclick="OnPopUp('Item')" href="#tips" ><b>Item&nbsp;</b></a></td>
	<td align="left"><gw:textbox id="txtItemCD" text="" styles="width:100%" /></td>
	<td align="left"><gw:textbox id="txtItemNM" text="" styles="width:100%" /></td>
	<td align="left"><gw:imgBtn id="idBtnReset2" img="reset" alt="Reset" onclick="OnReset('2')" /></td>	
	<td align="right"><gw:imgBtn id="idbtnSelect" img="select" alt="Select Item" onclick="OnSelect()" /></td>
</tr>
<tr style="height:4%">
</tr>
<tr style="height:88%">
	<td colspan="12">
		<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%">
			<tr>
				<td>
					<gw:grid
					id="grdDtl"
					header  ="No||_tac_crdad_pk|Voucher No|Trans Date|_Item_PK|Item Code|Item Name|U/Price|Q'ty|Trans Amount|Book Amount|_AccPK|Acc. Code|Acc. Name|Description|Local Description|_WHPK|WH|UOM"
					format  ="0|3|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					aligns  ="1|1|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					defaults="|||||||||||||||||||"
					editcol ="0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					widths  ="0|500|0|1500|1200|0|1400|2500|1000|1000|1200|1200|0|1400|2000|2000|2000|0|1400|700"
					styles  ="width:100%; height:100%"                                                     
					acceptNullDate="T"							
					sorting ="T"					
					 />				
				</td>
			</tr>
		</table>
	</td>
</tr>

</table>
<gw:textbox id="txtcompk"           style="display:none" />
<gw:textbox id="txtPartnerPK"           style="display:none" />
<gw:textbox id="txtItemPK"           style="display:none" />
<!---------------------------------------------------------------------------------------------------->
</body>
</html>