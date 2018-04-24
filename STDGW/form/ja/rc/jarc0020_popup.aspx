<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("crm")%>
<head id="Head1" runat="server">
    <title></title>
</head>

<script>
var p_inv = "<%=Request.querystring("p_inv_pk")%>";
function BodyInit()
{
	INVOICE_PK.text = p_inv;
	OnSearch(); 
}

function OnSearch()
{
	dso_jarc0020_dtl.Call('SELECT');
}
</script>
<body>
<gw:data id="dso_jarc0020_dtl">
    <xml>                                                               
        <dso id="1" type="grid" user="prod" function="CRM.SP_SEL_JARC0020_DTL"> 
            <input> 
                <input bind="INVOICE_PK" />
            </input> 
            <output bind="grdSearch" /> 
        </dso> 
    </xml> 
</gw:data>

<table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" valign='top'>
	<tr style="width: 100%; height: 100%">
		<td style="width: 100%">
			<gw:grid id="grdSearch" 			 
			 header		="No|_PK|Item|Qty|Unit|Price|VAT|Discount|_Free YN"
			 format		="0|0|0|1|0|1|1|1|0"
			 aligns		="0|0|0|3|1|3|3|3|0"
			 defaults	="|||||||||"
			 editcol	="0|0|0|0|0|0|0|0|0"
			 widths		="0|0|4000|0|0|0|0|0|0"
			 styles		="width:100%; height:100%" 
			 sorting	="F"/>
		</td>
	</tr>
</table>
</body>
<gw:textbox id='INVOICE_PK' style='display:none'></gw:textbox>
</html>
