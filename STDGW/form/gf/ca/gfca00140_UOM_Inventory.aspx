<!-- #include file="../../../system/lib/form.inc" -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Adjust Takeout FG</title>
    
</head>
<%ESysLib.SetUser("acnt")%>

<script type="text/javascript" language="javascript">
var lang = "<%=Session("SESSION_LANG")%>";
var g_company_pk = "<%=Session("COMPANY_PK")%>";
var g_tco_dept_pk = "<%=Session("DEPT_PK")%>";
//------------Grid
var i_Seq       = 0,
    i_VCNo      = 1,
    i_TransDt   = 2,
    i_Item_Pk   = 3,
    i_Item_code = 4,
    i_Item_name = 5,
    i_UOM       = 6,
    i_Qty       = 7,
    i_InvoiceNo = 8,
    i_InvoiceDT = 9,
    i_SerialNo  = 10,
    i_PK        = 11;
function BodyInit()
{
    System.Translate(document);    
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM COMM.TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);   
    <%=ESysLib.SetGridColumnComboFormat("idGrid", 6, "SELECT M.UOM_CODE, M.UOM_NM FROM COMM.TCO_UOM M WHERE M.DEL_IF = 0")%>;  
}
//-------------------------------------------------------------------------------
function OnSearch()
{
    dso_upd_uom.Call("SELECT");
}
//-------------------------------------------------------------------------------
function OnDataReceive(iObj)
{
    if(iObj.id == "dso_get_log")
    {
    }
}
//--------------------------------------------------------------------------------
function OnSave()
{
    dso_upd_uom.Call();
}
//--------------------------------------------------------------------------------
</script>
<!------------------------------------------------>
<body style="margin:0; padding:0;">
    <gw:data id="dso_upd_uom" onreceive="OnDataReceive(this)">
        <xml>
            <dso type="grid" parameter="6,7,11" function="acnt.sp_sel_gfca00140" procedure="acnt.sp_upd_gfca00140">
                <input bind="idGrid">
                    <input bind="lstCompany"/>
                    <input bind="txtPartner_PK"/>
                    <input bind="dtTransFr"/>
                    <input bind="dtTransTo"/>
                    <input bind="lstStatus"/>
                    <input bind="txtInvNo"/>
                    <input bind="txtSeq"/>
                </input>
                <output bind="idGrid"/>
            </dso>
        </xml>
    </gw:data>

<!-------------------------------------->
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%" >
	<tr>
		<td width="10%"></td>
        <td width="15%"></td>
        <td width="10%"></td>
        <td width="7%"></td>
        <td width="16%"></td>
		<td width="2%"></td>
        <td width="10%"></td>
        <td width="10%"></td>
        <td width="2%"></td>
        <td width="10%"></td>
        <td width="5%"></td>
        <td width="3%"></td>
	</tr>
	<tr style="height:5%">
		<td align="right">Company&nbsp;</td>
		<td align="right"><gw:list id="lstCompany" styles="width:100%" /></td>
		<td align="right"><a title="Click here to show Customer" onclick="GetCustomer()" href="#tips" ><b>Customer&nbsp;</b></a></td>
        <td ><gw:textbox id="txtPartnerCD" styles='width:100%' text='' /></td>
		<td ><gw:textbox id="txtPartnerNM" styles='width:100%' text='' /></td>
		<td ><gw:imgBtn id="ibtnReset" img="reset"  alt="Reset"  onclick="OnReset()" /></td>
		<td align="right">Trans date&nbsp;</td>
		<td align="left"><gw:datebox id="dtTransFr" lang="1" /></td>
		<td>~</td>
		<td align="left"><gw:datebox id="dtTransTo" lang="1" /></td>		
        <td align="right"><gw:imgBtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()"/></td>
        <td align="left"><gw:imgBtn id="ibtnSave" img="save"  alt="Save" onclick="OnSave()" /></td>
	</tr>
	<tr style="height:5%">
		<td align="right">Status&nbsp;</td>
		<td align="left"><gw:list id="lstStatus" styles="width:100%" onchange="OnSearch()" >
		<data>DATA|2|Confirmed|0|Approved|4|NApp|ALL|Select All</data>
		</gw:list>
		</td>
		<td align="right">Seq/Vou. No&nbsp;</td>
		<td align="left"><gw:textbox id="txtSeq" text="" styles="width:100%" onenterkey="OnSearch()" /></td>
		<td align="left" colspan="2"><gw:textbox id="txtVoucherNo" text="" styles="width:100%" onenterkey="OnSearch()" /></td>
		<td align="right">Invoice No&nbsp;</td>
		<td align="left"><gw:textbox id="txtInvNo" styles="width:100%" onenterkey="OnSearch()" /></td>
		<td align="right" colspan="2">Origin Source&nbsp;</td>
		<td align="left" colspan="2"><gw:list id="lstTrType" styles="width:100%" onchange="OnSearch()" >
		<data>DATA|DO|Domestic|OS|Foreign|ALL|Select all</data>
		</gw:list>
		</td>	
	</tr>
	<tr style="height:90%">
		<td colspan="12">
			<gw:grid
				id="idGrid"
				header  ="Seq|Voucher No|Trans date|_Item_PK|Item code|Item Name|UOM|Q'ty|InvoiceNo|InvoiceDate|SerialNo|_PK"
				format  ="0|0|4|0|0|0|0|0|0|0|0|0"
				aligns  ="0|0|0|0|0|0|1|3|0|4|0|0"
				defaults="|||||||||||"
				editcol ="0|0|0|0|0|0|1|1|0|0|0|0"
				widths  ="1000|1400|1200|0|1500|2000|1000|1400|1500|1500|1500|0"
				styles  ="width:100%; height:100%"							
				sorting ="F" />        
		</td>
	</tr>
</table>	
<gw:textbox id="txtPartner_PK" styles="display:none; " />
</body>
</html>