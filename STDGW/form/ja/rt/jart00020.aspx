<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Restauran Sales by Item</title>
</head>

<script>
var COL_1_PK			= 0,
	COL_1_INVOICE_ID	= 0,
	COL_1_INVOICE_DATE	= 0,
	COL_1_PAY_VN		= 0;

function BodyInit()
{
    var data="";
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='POINT'") %>|ALL|Select All";	
	lstLocation.SetDataText(data);
	lstLocation.value = "ALL";
}

function OnSearch()
{
    dsojart00020.Call('SELECT');
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dsojart00020_1':			
			dsojart00020_2.Call('SELECT');
		break;
	}
}

function OnPrint()
{

}

function OnClick()
{
	if (grdMST.rows > 1)
	{
		TCM_INVOICE_PK.text = grdMST.GetGridData(grdMST.row, COL_1_PK);
		dsojart00020_1.Call('SELECT');
	}
}
</script>

<body bgcolor='#F5F8FF'>
	<gw:data id="dsojart00020" onreceive="OnDataReceive(this)" >
        <xml> 
            <dso type="grid" function="CRM.SP_SEL_JART00020">  
                <input bind="grdMST"   >  
                    <input bind="dtFrom" />
					<input bind="dtTo" />
					<input bind="txtInvoiceID_1" />
					<input bind="lstLocation" />
                </input> 
                <output bind="grdMST" /> 
            </dso> 
        </xml> 
    </gw:data>

	<gw:data id="dsojart00020_1" onreceive="OnDataReceive(this)" > 
		<xml> 
			<dso type="control" function="CRM.SP_SEL_JART00020_1" > 
				<inout>
					<inout bind="TCM_INVOICE_PK" />
					<inout bind="txtInvoiceID_2" />
					<inout bind="txtCashier_2" />
					<inout bind="txtLocker" />
					<inout bind="txtRate" />
					<inout bind="txtAMTVAT" />
					<inout bind="txtIN" />
					<inout bind="txtRaiseAMT" />
					<inout bind="txReason" />
					<inout bind="txtOUT" />
					<inout bind="txtCusName" />
					<inout bind="txtCCY" />
				</inout>
			</dso> 
		</xml> 
	</gw:data>

    <gw:data id="dsojart00020_2" onreceive="OnDataReceive(this)" >
        <xml> 
            <dso type="grid" function="CRM.SP_SEL_JART00020_2">  
                <input bind="grdDTL"   >  
                    <input bind="TCM_INVOICE_PK" />
                </input> 
                <output bind="grdDTL" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%; background: #BDE9FF">
        <tr>
            <td valign="top" style="width: 32%; height: 100%; background: white">
				<table valign="top" style="width: 100%; height: 100%">
					<tr style="width: 100%; height: 5%">
						<td width="15%">
							Date 
						</td>
						<td width="10%">
							<gw:datebox id="dtFrom"  styles="width:100%"  lang="<%=Session("Lang")%>" onchange="OnSearch()" />
						</td>
						<td width="10%">
							<gw:datebox id="dtTo"  styles="width:100%"  lang="<%=Session("Lang")%>" onchange="OnSearch()" />
						</td>				
						<td width="3%">
							<gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch()" />
						</td>
                    </tr>
					<tr style="width: 100%; height: 5%">
						<td width="15%">
							Invoice#
						</td>
						<td colspan="3" width="100%">
							<gw:textbox id="txtInvoiceID_1"  styles="width:100%" onenterkey='OnSearch()' />
						</td>
					</tr>
					<tr style="width: 100%; height: 5%">
						<td width="15%">
							Location
						</td>
						<td colspan="3" width="100%">
						    <gw:list id="lstLocation" styles="width:100%" onchange="OnSearch()" />
							<gw:textbox id="txtCashier_1"  styles="width:100%;display:none"  lang="<%=Session("Lang")%>" onenterkey='OnSearch()' />
						</td>
					</tr>
					<tr style="width: 100%; height: 85%">
						<td colspan="4" width="100%; height:100%">
							<gw:grid id='grdMST' 
							header='_PK|Locker#|Invoice#|Invoice Date|_Location|Cash|Close'
							format='0|0|0|4|0|3|3' 
							aligns='0|0|0|0|0|1|1' 
							defaults='||||||' 
							editcol='0|0|0|0|0|0|0'
							widths='0|1500|1500|2000|1000|100|100' 
							sorting='T' 
							autosize="T" 
							styles='width:100%; height:100%'
							oncellclick="OnClick()"/>
						</td>
					</tr>
				</table>	
			</td>
			<td valign="top"  style="width: 68%; height: 100%; background: white">
				<table style="width: 100%; height: 100%" border="0">
					<tr style=" height: 5%">
						<td style="width: 12%; text-align=right">Invoice#</td>
						<td style="width: 19%"><gw:textbox id="txtInvoiceID_2"  styles="width:100%" /></td>
						<td style="width: 14%; text-align=right">Cashier</td>
						<td style="width: 22%" ><gw:textbox id="txtCashier_2"  styles="width:100%" /></td>
						<td style="width: 9%; text-align=right">CCY</td>
						<td style="width: 15%" ><gw:textbox id="txtCCY"  styles="width:100%" /></td>
						<td style="width: auto" colspan="2" align="right">
							<gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint()" />
						</td>
					</tr>
					<tr style=" height: 5%">
						<td style="text-align=right">Locker#</td>
						<td ><gw:textbox id="txtLocker" /></td>
						<td style="text-align=right">Customer</td>
						<td><gw:textbox id="txtCusName"  styles="width:100%" /></td>
						<td style="text-align=right">VAT</td>
						<td ><gw:textbox id="txtRate" type="number" format="###,###.##"  styles="width:100%; text-align:right" /></td>
						<td style="text-align=center;width:3%">IN</td>
						<td style="width:auto;"><gw:textbox id="txtIN"  styles="width:100%; text-align:center" /></td>
					</tr>
					<tr style=" height: 5%">
						<td style="text-align=right">Raise AMT</td>
						<td><gw:textbox id="txtRaiseAMT"  styles="width:100%; text-align:right" /></td>
						<td style="text-align=right">Raise Reason</td>
						<td><gw:textbox id="txReason"  styles="width:100%" /></td>	
						<td style="text-align=right">Total AMT</td>
						<td><gw:textbox id="txtAMTVAT" type="number" format="###,###.##"  styles="width:100%; text-align:right" /></td>
						<td style="text-align=center">OUT</td>
						<td><gw:textbox id="txtOUT"  styles="width:100%; text-align:center" /></td>
					</tr>
					<tr style=" height: 85%">
						<td colspan="8"  style="width: 100%">
							<gw:grid id='grdDTL' header='_PK|Item Code|Item Name|Quantity|Unit|Price|Amount'
							format='0|0|0|1|0|1|1' aligns='0|0|0|3|0|3|3' 
							sorting='T' autosize="true" styles='width:100%; height:100%' />
						</td>
					</tr>
				</table>
			</td>
        </tr>
    </table>
</body>

<gw:textbox id="TCM_INVOICE_PK" style="display:none"/>
