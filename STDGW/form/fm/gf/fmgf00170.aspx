<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Return Goods(Suheung)</title>
</head>

<script>

    var  user_pk = "<%=Session("USER_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;

        
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
    var data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_name  FROM inv.tin_warehouse  WHERE del_if = 0 ORDER BY wh_name  ASC" )%>|ALL|ALL";    
    lstWH.SetDataText(data); 
    lstWH.value = 'ALL';       
}
//-----------------------------------------------------

//-----------------------------------------------------
</script>

<body>
    <!-------------------------------------------------------------------->
    <!-------------------------------------------------------------------->	
<table style="width:100%; height:100% " border="1" cellpadding="0" cellspacing="0"  >
    <tr style="height:10%" >
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                <tr>
                    <td style="width: 12%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 11%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 2%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 12%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 20%"></td>
                    <td style="width: 3%"></td>
                </tr>
				<tr>
					<td align="right">Company&nbsp;</td>
					<td align="left"><gw:list id="lstCompany" /></td>
					<td align="right">Returned Date&nbsp;</td>
					<td align="center"><gw:datebox id="dtRtnFrom" lang="1" styles="width:100%" /></td>
					<td align="center">~</td>
					<td align="center"><gw:datebox id="dtRtnTo" lang="1" styles="width:100%" /></td>
					<td align="right"><a title="Click here to select customer" href="#tips" onclick="OnShowPopUp('customer')">Customer&nbsp;</a></td>
					<td><gw:textbox id="txtCustCD" styles="width:100%" /></td>
					<td colspan="2" ><gw:textbox id="txtCustNM" styles="width:100%" /></td>
				</tr>
				<tr>
					<td align="right"><a title="Click here to select item" href="#tips" onclick="OnShowPopUp('item')" >Item Code&nbsp;</a></td>
					<td align="left"><gw:textbox id="txtItemCD" styles="width:100%" /></td>
					<td colspan="4" align="left"><gw:textbox id="txtItemNM" styles="width:100%" /></td>
					<td align="center">Domestic Y/N&nbsp;</td>
					<td align="center"><gw:list id="lstDO_YN" styles="width:100%" /></td>
					<td align="right"><gw:imgBtn id="idbtnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
					<td align="right"><gw:imgBtn id="idbtnExcel" img="excel" alt="Print" onclick="OnPrint()" /></td>
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
                            header="No|Product Code|Pro. Name|Customer ID|Name|Returned Date|Q'ty|Trans Amt|Domestic"
                            format="0|0|0|0|0|4|0|0|0" 
                            aligns="1|1|2|1|2|1|3|3|1"
                            defaults="||||||||" 
                            editcol="0|0|0|0|0|0|0|0|0" 
                            widths="600|1400|2000|1300|2500|1500|1500|1500|800"
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
<gw:textbox id="txtCustPK" style="display:none;" />           
<gw:textbox id="txtItemPK" style="display:none;" />
</body>
</html>