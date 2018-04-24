<%@ Page Language="C#"%>
<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Print contract</title>
</head>

<script language="javascript" type="text/javascript">
var contract_pk, com_pk;
function BodyInit()
{
    contract_pk= "<%=Request.QueryString["contract_pk"] %>";
    com_pk= "<%=Session["COMPANY_PK"] %>"
    System.Translate(document);  // Translate to language session
}
function onPrint(index)
{

    switch(index)
    {
        case "1": // 2 ben
            var  url= System.RootURL + "/reports/ep/ac/rpt_epac0001_saleContract.aspx?" + "contract_pk=" + contract_pk + "&Curr=USD" ;
	        System.OpenTargetPage( url, "_blank" ); 
        break;
        case "2": //3 ben
            var  url= System.RootURL + "/reports/ep/ac/rpt_epac00010_3part_E_V.aspx?" + "contract_pk=" + contract_pk + "&com_pk=" + com_pk;
	        System.OpenTargetPage( url, "_blank" ); 
        break;
        case "3": //4 ben
            var  url= System.RootURL + "/reports/ep/ac/rpt_epac00010_4part_E_V.aspx?" + "contract_pk=" + contract_pk + "&com_pk=" + com_pk;
	        System.OpenTargetPage( url, "_blank" ); 
        break;
    }
}    
</script>
<body>
<!---------------------------------------------------------------------------------------------->
    <form id="form1" runat="server">
    <table width="100%" cellpadding=0 cellspacing=0>
        <tr>
            <td colspan="2" height="10"></td>
        </tr>
        <tr>
            <td width="30%" nowrap >Print type</td>
            <td width="70%">
                <gw:list id="cboPrintType" value='1' styles="width:100%;" >
                    <data>Data|1|Contract 2 party|2|Contract 3 party|3|Contract 4 party</data>
                </gw:list>
            </td>
        </tr>
        <tr>
            <td colspan="2" height="10"></td>
        </tr>
        <tr>
            <td  colspan="2" align="center"><gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="onPrint(cboPrintType.value)" /></td>
        </tr>
    </table>
    </form>
</body>
</html>
