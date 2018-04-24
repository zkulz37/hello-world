<!-- #include file="../../../system/lib/form.inc" -->

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>genuwin</title>    
</head>
<%ESysLib.SetUser("acnt")%>

<script>
// 1, 6,10,13,14,20
	
var g_Save = false ;
	
function BodyInit()
{
    System.Translate(document);
	var l_today = dtInvoiceDateto.value ;
	var l_frdate = l_today.substr(0, 6) + '01';
	dtInvoiceDatefr.value = l_frdate;
	g_tco_company_pk = "<%=Request("tco_company_pk") %>"
	txtcompk.text = g_tco_company_pk;
}
//--------------------------------------------
function onSearchVen()
{
    var path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
	var object  = System.OpenModal( path, 800, 550,'resizable:yes;status:yes;toolbar:no;location:no;directories:no;status:no;menubar:no;scrollbars:no;resizable:no;');
	if ( object != null )
	{
	    if (object[0] != 0)
        {
            txtven_cd.text = object[1];
            txtven_nm.text = object[2];
            txtven_pk.text = object[0];
        }
    }
}
//--------------------------------------------
function onResetVen()
{
    txtven_cd.text = '';
    txtven_nm.text = '';
    txtven_pk.text = '';
}
//--------------------------------------------
function onSearch()
{
	dso_grd_takein_ap.Call("SELECT");
}
//--------------------------------------------
function OnDataReceive(iObj)
{
	var i;
	if(iObj.id == "dso_grd_takein_ap")
	{
		for( i = 1; i < grdDtl.rows; i++)
		{
			if(grdDtl.GetGridData(i, 24)=="Y")
			{
				grdDtl.SetCellBgColor(i, 0, i, grdDtl.cols - 1, Number("0x0xA9EBD7"));
			}
		}
	}
}
//--------------------------------------------
</script>
<body style="margin:0; padding:0;">
<!----------------------------------------------------------------------------------------------------------------->
    <gw:data id="dso_grd_takein_ap" onreceive="OnDataReceive(this)" >
        <xml>
            <dso type="grid" function="acnt.sp_sel_vin_stocktrdaily_3" >
                <input bind="grdDtl">
                    <input bind="txtcompk" />                   
                    <input bind="txtDeliveryNo" />
					<input bind="dtInvoiceDatefr" />
                    <input bind="dtInvoiceDateto" />
                    <input bind="txtven_pk" />
                    <input bind="txtpo_no" />                    
					<input bind="lstType" />
					<input bind="txtItemCD" />
                </input>
                <output bind="grdDtl" />
            </dso>
        </xml>
    </gw:data>
<!----------------------------------------------------------------------------------------------------------------->
<table width="100%" cellpadding="0" cellspacing="0" border="0" style="height:100%">
<tr style="height:0%" >    
    <td width="8%"></td>
    <td width="12%"></td>
    <td width="8%"></td>
    <td width="10%"></td>
    <td width="3%"></td>
    <td width="10%"></td>
    <td width="5%"></td>
    <td width="27%"></td>
    <td width="12%"></td>
    <td width="3%"></td>
</tr>
    <tr style="height:5%; " >
        <td align="right">Slip No&nbsp</td>
        <td ><gw:textbox id="txtDeliveryNo" styles="width:100%" onenterkey="onSearch()"/></td>
        <td align="right">Stock Date&nbsp</td>
        <td><gw:datebox id="dtInvoiceDatefr" lang="1" /></td>
        <td align="center">~</td>
        <td><gw:datebox id="dtInvoiceDateto" styles="width:100%" lang="1" /></td>
        <td align="right">Vendor&nbsp</td>
        <td>
            <table width="100%"  border="0" cellspacing="0" cellpadding="0" style="height:100%">
            <tr>
                <td width="30%"><gw:textbox id="txtven_cd" styles='width:100%' /></td>
                <td width="60%"><gw:textbox id="txtven_nm" styles='width:100%'/></td>
                <td width="0%"><gw:textbox  id="txtven_pk" styles='display:none'/></td>
                <td width="5%"><gw:imgBtn   img="popup"	id="idSearchVen" alt="Popup" onclick="onSearchVen()"/></td> 
                <td width="5%"><gw:imgBtn   img="reset"	id="idResetVen"  alt="Reset" onclick="onResetVen()"/></td>
            </tr>
            </table>
        </td>
        <td>
            <table width="100%"  border="0" cellspacing="0" cellpadding="0" style="height:100%">
				<tr>
					<td align="center" width="40%"><gw:label id="lblsum" text="0" styles="color:red;width:90%;font-weight: bold;font-size:12"/></td>
					<td align="right" width="60%"><gw:label id="lblLabel" text="record(s)" styles="color:red;width:90%;font-weight: bold;font-size:12"/>&nbsp;</td>
				</tr>
            </table>
        </td>
        <td><gw:imgBtn id="ibtnSearch" img="search"    alt="Search"        onclick="onSearch()"/></td>
    </tr>
    <tr style="height:5%">
        <td align="right" style="width:10%" >PO No&nbsp</td>
        <td align="left" style="width:15%" ><gw:textbox id="txtpo_no" styles="width:100%" onenterkey="onSearch()" /></td>
        <td align="right">Domestic/Oversea&nbsp;</td>
        <td colspan="1"><gw:list id="lstType" onchange="onSearch()" >
	<data>DATA|0|Domestic|1|Oversea</data>
	</gw:list>	
	</td>                    
	<td colspan="2" align="right">Item&nbsp;</td>
        <td align="left" colspan="2"><gw:textbox id="txtItemCD" text="" styles="width:100%;" onenterkey="onSearch()" /></td>      
        <td colspan="2" align="left" ></td>
    </tr>    
    <tr style="height40%;">
        <td colspan="10" >
            <gw:grid
                id      ="grdDtl"  
                header  ="|_tin_stocktr_PK|Slip No|Date|Item Code|Item Name|Vendor|UOM|Unit Price|Takein Q'ty|Loaded Qty|Balance|Invoice Q'ty|PO No|_ItemPK|Ccy|Trans Amount|_tac_abacctcode_pk|Acc Code|Acc Name|_tin_wh_pk|WH|_tac_abplcenter_pk|PL Code|PL Name|_tac_mattakein_ap_pk|Get YN"
                format  ="0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3"
                aligns  ="1|0|1|1|1|0|0|1|3|3|3|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|1"
                defaults="0||||||||||||||||||||||||||"
                editcol ="1|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                widths  ="600|0|1500|1200|1300|2500|1500|600|1000|1300|1300|1300|1300|1500|0|800|1300|0|1200|2500|0|1400|0|1400|2000|0|700"
                styles  ="width:100%; height:100%"                
                sorting ="T"                				
				oncelldblclick="OnCopy()"
            />
        </td>
    </tr>
</table>	
<gw:textbox id="txtcompk"           style="display:none" />
<gw:textbox id="txtItemPK" text="" styles="width:100%;" />
<!---------------------------------------------------------------------------------------------------->
</body>
</html>