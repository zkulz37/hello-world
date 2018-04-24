<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>    
</head>
<%ESysLib.SetUser("acnt")%>

<script>
var g_No 				= 0,
	g_OrderNo			= 1,
	g_DeliveryDate		= 2,
	g_OrderDate			= 3,
	g_Size				= 4,
	g_CapColor			= 5,
	g_BodyColor			= 6,
	g_DeliveryQty		= 7,
	g_OutQty			= 8,
	g_ProductCode		= 9,
	g_ProductName		= 10,
	g_PartnerCode		= 11,
	g_PartnerName		= 12,
	g_tco_item_pk		= 13,
	g_vendor_pk			= 14,
	g_tac_abacctcode_pk	= 15,
	g_Unit				= 16,
	g_Price				= 17,
	g_Amount			= 18,
	g_AccCD				= 19,
	g_AccNM				= 20,
	g_ItemDesc			= 21,
	g_Get_YN			= 22;
	var g_sourcetp = "<%=Request.querystring("sourcetp")%>"
	var g_partner_pk = "<%=Request.querystring("tco_partner_pk")%>"
	var g_partner_cd = "<%=Request.querystring("partner_cd")%>"	
//--------------------------------------------              
function BodyInit()
{
    System.Translate(document);
	BindingDataList();
}
//--------------------------------------------
function BindingDataList()
{
	var l_dtfr = dtSaleDTfr.value ;
	dtSaleDTfr.value = l_dtfr.substring(0, 6) + "01" ;
	var ls_data         = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
	lstCompany.SetDataText(ls_data);
	
	
	txtDOOS_Source.text = lstDOME_YN.value ;
	txtPartnerID.text = g_partner_cd ;	
	txtPartnerPK.text = g_partner_pk ;
	if(g_partner_pk != "")
	{
		dso_get_partnerNM.Call();	
	}
}
//--------------------------------------------
function OnPopUp(iCase)
{
	switch(iCase)
	{
		case 'Partner':
			var fpath   = System.RootURL + "/form/fp/ab/PopUpGetPartner.aspx";
			var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
			if ( object != null )  
			{
				if (object[0] != "")
				{
					txtPartnerPK.text = object[0];
					txtPartnerID.text = object[1];
					txtPartnerNM.text = object[2];
				}
			}	
		break ;
		case 'Product':
			var fpath   = System.RootURL + "/form/fp/ab/PopUpGetOneItem.aspx";
			var object  = System.OpenModal(fpath , 900 , 500 , 'resizable:yes;status:yes'); 
			if ( object != null )  
			{
				if (object[0] != "")
				{
					txtProductPK.text = object[0];
					txtProductID.text = object[1];
					txtProductNM.text = object[2];
				}
			}			
		break ;
	}
}
//--------------------------------------------
function OnSearch()
{
	txtDOOS_Source.text = lstDOME_YN.value ;
	dso_getdata_SH.Call("SELECT");
}
//--------------------------------------------
function OnDataReceive(iObj)
{
	switch(iObj.id)	
	{
		case 'dso_getdata_SH':
			var i, l_deli_tot_qty = 0, l_out_tot_qty = 0 ;
			OnFormatGrid();
			for(i = 1; i < grdDtl.rows; i++)
			{
				if(grdDtl.GetGridData(i, g_Get_YN)=="Y")
				{
					grdDtl.SetCellBgColor(i, 0, i , grdDtl.cols-1, Number("0xA9EBD7"));
				}
			}
			for(i = 1; i < grdDtl.rows; i++)
			{
				if(grdDtl.GetGridData(i, g_DeliveryQty)!="")
				{
					l_deli_tot_qty += Number(grdDtl.GetGridData(i, g_DeliveryQty));					
				}
				if(grdDtl.GetGridData(i, g_OutQty)!="")
				{
					l_out_tot_qty += Number(grdDtl.GetGridData(i, g_OutQty));					
				}
			}
			grdDtl.AddRow();
			grdDtl.SetGridText(grdDtl.rows - 1, g_OrderNo, "TOTAL");
			grdDtl.SetGridText(grdDtl.rows - 1, g_DeliveryQty, l_deli_tot_qty);
			grdDtl.SetGridText(grdDtl.rows - 1, g_OutQty, l_out_tot_qty);
			var fg = grdDtl.GetGridControl();
			fg.Cell(13, grdDtl.rows - 1, 0, grdDtl.rows - 1, grdDtl.cols - 1) = true;
		break ;
		case 'dso_get_partnerNM':
			//txtPartnerNM.text = 
		break ;
	}
}
//--------------------------------------------
/*function OnAddNew()
{
	var i;
	grdDtl2.AddRow();
	for(i = 0; i < grdDtl.cols ; i++)
	{
		grdDtl2.SetGridText(grdDtl2.rows - 1, i, grdDtl.GetGridData(event.row, i));
	}
	grdDtl.RemoveRowAt(event.row);
}*/
//--------------------------------------------
/*function OnSelect()
{
	var code_data = new Array()      	  	
	var ctrl = grdDtl2.GetGridControl();
    var i , j, index = 0;
	if( ctrl.rows == 1 )
	{
		return ;
	}
	else
	{
		for( i = 1 ; i < ctrl.rows ; i++ )
		{
			var arr_data = new Array();
			{
				for( j = 0 ; j < grdDtl2.cols - 1 ; j++ )
				{
					arr_data[arr_data.length] = grdDtl2.GetGridData(i , j );				
				} 
				code_data[code_data.length] = arr_data ;
			}	
		}
	}
	window.returnValue = code_data; 
	this.close(); 		
}*/
//--------------------------------------------
function OnClose()
{
    this.close();
}
//--------------------------------------------
function OnReset(iCase)
{
    if(iCase == '1')
    {
        txtPartnerID.text = '';
        txtPartnerNM.text = '';
        txtPartnerPK.text = '';
    }
    else if(iCase == '2')
    {
        txtProductID.text = '';
        txtProductNM.text = '';
        txtProductPK.text = '';
    }
}
function OnFormatGrid()
{
	var  fg = grdDtl.GetGridControl();
	fg.ColFormat(g_OutQty) = "###,###,###,###,###.#####R";
	fg.ColFormat(g_DeliveryQty) = "###,###,###,###,###.#####R";
}
</script>
<body style="margin:0; padding:0;">
<!------------------------------------------------------------------------------------------------>
    <gw:data id="dso_getdata_SH" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="acnt.sp_sel_getdata_SH" >
                <input bind="grdDtl">
                    <input bind="dtSaleDTfr"/>
					<input bind="dtSaleDTto"/>
					<input bind="lstSize"/>
					<input bind="txtPartnerID"/>
					<input bind="txtProductPK"/>
					<input bind="txtDOOS_Source"/>
                </input>
                <output bind="grdDtl"/>
            </dso>
        </xml>
    </gw:data>
    <gw:data id="dso_get_partnerNM" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="acnt.sp_pro_get_partner_nm" > 
                <input> 
                     <input bind="txtPartnerPK"/>
                </input>
                <output>
                     <output bind="txtPartnerNM"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
	
<!------------------------------------------------------------------------------------------------>
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%">
<tr style="height:0%" >    
    <td width="20%"></td>
    <td width="10%"></td>
    <td width="1%"></td>
	<td width="10%"></td>
	<td width="20%"></td>
    <td width="10%"></td>
    <td width="20%"></td>
    <td width="3%"></td>
    <td width="3%"></td>
	<td width="3%"></td>
</tr>
<tr style="height:4%">
	<td align="right" >Company&nbsp;</td>
	<td align="right" colspan="3" ><gw:list id="lstCompany" styles="width:100%" /></td>
	<td align="right" ><b>Size&nbsp;</b></td>	
	<td align="left" colspan="2" ><gw:list id="lstSize" styles="width:100%" >
		<data>DATA|#4|#4|#3|#3|#2|#2|#1|#1|#0E|#0E|#00|#00|#0|#0|ALL|ALL</data>
		</gw:list>
	</td>
	<td align="left" ><gw:imgBtn id="idBtnReset" alt="Reset" img="reset" /></td>
	<td align="left" ><gw:imgBtn id="idBtnSearch" alt="Search" img="search" onclick="OnSearch()" /></td>
	<td align="left" ></td>
	
</tr>
<tr style="height:4%">
	<td align="right" >Sale Date&nbsp;</td>
	<td align="right" colspan="1" ><gw:datebox id="dtSaleDTfr" lang="1" /></td>
	<td align="right" >~</td>
	<td align="left"><gw:datebox id="dtSaleDTto" lang="1" /></td>
	<td align="right"><a title="Click here to show Partner" onclick="OnPopUp('Partner')" href="#tips" ><b>Partner&nbsp;</b></a></td>
	<td align="left" ><gw:textbox id="txtPartnerID" styles="width:100%" /></td>
	<td align="left" ><gw:textbox id="txtPartnerNM" styles="width:100%" /></td>
	<td align="left" ><gw:imgBtn id="idBtnReset2" alt="Reset" img="reset" onclick="OnReset('1')" /></td>
	<td align="left" ><gw:icon id="idBtnClose" img="in" text="Close" alt="Close" onclick="OnClose()" /></td>
</tr>
<tr style="height:4%">
	<td align="right">Domestic&nbsp;</td>
	<td align="left"><gw:list id="lstDOME_YN" onchange="OnSearch()" >
		<data>DATA|Y|Yes|N|No</data>
		</gw:list>
	</td>
	<td colspan="2"></td>
	<td align="right" ><a title="Click here to show Product" onclick="OnPopUp('Product')" href="#tips" ><b>Product&nbsp;</b></a></td>
	<td align="left" ><gw:textbox id="txtProductID" styles="width:100%" /></td>
	<td align="left" ><gw:textbox id="txtProductNM" styles="width:100%" /></td>
	<td align="left" ><gw:imgBtn id="idBtnReset3" alt="Reset" img="reset" onclick="OnReset('2')" /></td>	
</tr>
<tr style="height:88%">
	<td colspan="10">
		<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%">
			<tr>
				<td>
					<gw:grid
					id="grdDtl"
					header  ="No|Order No|Delivery Date|Order Date|Size|Cap Color|Body Color|Delivery Qty|Out Qty|Product Code|Product Name|Partner Code|Partner Name|_tco_item_pk|_vendor_pk|_tac_abacctcode_pk|Unit|Price|Amount|Acc. Code|Acc. Name|_Item_Desc|GET_YN"
					format  ="0|0|4|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					aligns  ="1|0|1|1|0|0|0|3|3|0|0|0|0|0|0|0|0|3|3|0|0|0|1"
					defaults="||||||||||||||||||||||"
					editcol ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					widths  ="500|1400|1500|1400|800|1200|1400|1500|1500|1400|2500|1400|2500|0|0|0|800|1200|1400|1400|2500|0|0"
					styles  ="width:100%; height:100%"                                                     
					acceptNullDate="T"
					oncelldblclick="OnAddNew()"
					sorting ="F" />				
				</td>
			</tr>
		</table>
	</td>
</tr>
</table>
<gw:textbox id="txtcompk"           style="display:none" />
<gw:textbox id="txtPartnerPK"  style="display:none"          />
<gw:textbox id="txtProductPK"           style="display:none" />
<gw:textbox id="txtDOOS_Source"      style="display:none" />
<!---------------------------------------------------------------------------------------------------->
</body>
</html>