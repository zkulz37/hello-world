<!-- #include file="../../../system/lib/form.inc" -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>    
</head>
<%ESysLib.SetUser("acnt")%>

<script>
var g_Chk			= 0,
	g_tco_item_pk	= 1,
	g_ItemCode		= 2,
	g_ItemName		= 3,
	g_Unit			= 4,
	g_Beginning_Qty	= 5,
	g_ReceiptQty	= 6,
	g_IssueQty		= 7,
	g_EndingQty		= 8,
	g_tac_abacctcode_pk	= 9,
	g_AccCode		= 10,
	g_AccName		= 11,
	g_tac_abplcenter_pk	= 12,
	g_PLCode			= 13,
	g_PLName			= 14;

//--------------------------------------------              
function BodyInit()
{
    System.Translate(document);
	BindingDataList();
}
//--------------------------------------------
function BindingDataList()
{
	var ls_data         = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
	lstCompany.SetDataText(ls_data);	
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
		for( i = 1 ; i < ctrl.rows ; i++ )
		{
			if(grdDtl.GetGridData(i, g_Chk)=="-1")
			{
				var arr_data = new Array();
				{
					for( j = 0 ; j < grdDtl.cols - 1 ; j++ )
					{
						arr_data[arr_data.length] = grdDtl.GetGridData(i , j );				
					} 
					code_data[code_data.length] = arr_data ;
				}	
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
function OnSearch()
{
	dso_getdata_SH.Call("SELECT");
}
//--------------------------------------------
function OnCheckAll()
{
	var i;
	if(ckSelect.value == "T")
	{
		for(i = 1 ; i < grdDtl.rows; i++)
		{
			grdDtl.SetGridText(i, g_Chk, '-1');
		}
	}
	else if(ckSelect.value == "F")
	{
		for(i = 1 ; i < grdDtl.rows; i++)
		{
			grdDtl.SetGridText(i, g_Chk, '0');
		}	
	}
}
//--------------------------------------------
function OnDataReceive(iObj)
{
	switch(iObj.id)
	{
		case 'dso_getdata_SH':
			
		break ;
	}
}
</script>
<body style="margin:0; padding:0;">
<!-------------------------------------------------------------------------------------------->
    <gw:data id="dso_getdata_SH" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" function="acnt.sp_sel_fmgf00120_1" >
                <input bind="grdDtl">
					<input bind="lstCompany"/>
                    <input bind="dbMonth"/>					
                </input>
                <output bind="grdDtl"/>
            </dso>
        </xml>
    </gw:data>
<!-------------------------------------------------------------------------------------------->
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%">
<tr style="height:0%" >    
    <td width="15%"></td>
	<td width="10%"></td>
	<td width="20%"></td>
	<td width="18%"></td>
	<td width="10%"></td>
	<td width="2%"></td>
	<td width="10%"></td>
	<td width="15%"></td>
</tr>
<tr style="height:4%">
	<td></td>
	<td align="right" >Company&nbsp;</td>
	<td align="right" colspan="1" ><gw:list id="lstCompany" styles="width:100%" /></td>
	<td align="right" >Period&nbsp;</td>
	<td><gw:datebox id="dbMonth" lang="1" type="month"  /></td>	
</tr>
<tr style="height:4%">
	<td colspan="8" >
		<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%">
			<tr>
				<td width="75%" align="right"></td>
				<td width="5%" align="right" ><gw:imgBtn id="btnSelect" img="select" alt="Select" onclick="OnSelect()" /></td>
				<td width="10%" align="right">Check All&nbsp;</td>				
				<td width="5%" align="right" ><gw:checkbox id="ckSelect" onchange="OnCheckAll()" /></td>
				<td width="5%" align="right"><gw:imgBtn id="idBtnSearch" img="search" alt="Search" styles="width:100%" onclick="OnSearch()" /></td>				
			</tr>
		</table>
	</td>			
</tr>
<tr style="height:92%">
	<td colspan="10">
		<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%">
			<tr>
				<td>
					<gw:grid
					id="grdDtl"
					header  ="|_tco_item_pk|Item Code|Item Name|Unit|Beginning Q'ty|Receipt Q'ty|Issue Q'ty|Ending Q'ty|_tac_abacctcode_pk|Acc. Code|Acc. Name|_tac_abplcenter_pk|PL. Code|PL. Name"
					format  ="3|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					aligns  ="1|0|1|0|1|3|3|3|3|0|0|0|0|0|0"
					defaults="||||||||||||||"
					editcol ="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					widths  ="600|0|1500|2500|800|1800|1800|1800|1800|0|1500|2500|0|1500|2500"
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