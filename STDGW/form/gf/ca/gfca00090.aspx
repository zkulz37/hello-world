<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Inventory Inquiry</title>
</head>

<script>

    var  user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
    var  user_name = "<%=Session("USER_NAME")%>"  ;      
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();
//    idGrid.GetGridControl().FrozenCols = 2 ;
    
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
}
//------------------------------------------------------------------------

//------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'fmgf00110' :        
            fmgf00110.Call("SELECT")            
        break;
    }
}
//------------------------------------------------------------------------
function OnDataReceive(obj)
{

}
//------------------------------------------------------------------------
function OnExcel(iObj)
{
}
//-----------------------------------------------------
function OnFormatGrid()
{
    var trl ;
}
//-----------------------------------------------------
function OnReset(iObj)
{
}
//-----------------------------------------------------
//function Upcase()
//{
//    var c = String.fromCharCode (event.keyCode);
//	var x = c.toUpperCase().charCodeAt(0);
//	event.keyCode = x;
//}

//-----------------------------------------------------
</script>

<body>
    <!-------------------------------------------------------------------->
  <gw:data id="fmgf00110" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="ACNT.sp_sel_fmgf00110" > 
                <input bind="idGrid" >                 
                    <input bind="lstCompany"/>
                    <input bind="dbMonthly"/>
                    <input bind="txtAccountCode"/>
                    <input bind="txtAccountName"/>
                    <input bind="txtTCO_ITEM_PK"/>                    
                    <input bind="txtPLCode"/>
                    <input bind="txtPLName"/>
                    <input bind="lstWH"/>                    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>       
    <!-------------------------------------------------------------------->
<table style="width:100%; height:100% " border="1" cellpadding="0" cellspacing="0"  >
    <tr style="height:5%" >
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                <tr>
					<td style="width:20%;"></td>
					<td style="width:20%;"></td>
					<td style="width:10%;"></td>
					<td style="width:2%;"></td>
					<td style="width:10%;"></td>
					<td style="width:38%;"></td>
                </tr>
                <tr >
                    <td align="right">Company&nbsp;</td>
                    <td align="left"><gw:list id="lstCompany" styles="width:100%" /></td>
					<td align="right">Period&nbsp;</td>
					<td align="left"><gw:datebox id="dtFrom" lang="1" styles="width:100%" /></td>
					<td>~</td>
					<td align="left"><gw:datebox id="dtTo" lang="1" styles="width:100%" /></td>
                </tr>
            </table>            
        </td>                     
    </tr>        
    <tr style="height:95%" >
        <td >
            <table width="100%;" border="0" cellpadding="0" cellspacing="0" style="height:100%"  >
                <tr>
                    <td>
                        <gw:grid id="idGrid" 
                            header="|Acc.Cd|Acc.Nm|Item Code|Item Name|UOM|WH|PL CD|PL NM|Begin Qty|Begin Amt|IN Qty|IN Amt|OUT Qty|OUT Amt|End Qty|End Amt"
                            format="0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1" 
                            aligns="2|1|0|2|2|1|2|2|2|3|3|3|3|3|3|3|3"
                            defaults="||||||||||||||||" 
                            editcol="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
                            widths="1000|1200|2000|1200|3000|800|1800|1000|1500|1500|1500|1500|1500|1500|1500|1500|1500"
                            styles="width:100%; height:100% " 
                            acceptNullDate="T" 
                            sorting="T" 
                            param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" />                    
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>            
</body>
</html>