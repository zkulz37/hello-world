<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Adjusted Inventory Slip</title>
</head>

<script>

    var  user_pk = "<%=Session("USER_PK")%>" ;
    var  user_name = "<%=Session("USER_NAME")%>" ;
    var  g_dept_pk = "<%=Session("DEPT_PK")%>" ;
//------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);
    BindingDataList();	    
    var fg = idGrid.GetGridControl();
    fg.ColFormat(8) = "###,###,###.##";
    fg.ColFormat(9) = "###,###,###.##";
}
//------------------------------------------------------------------------
function BindingDataList()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
    txtUser_PK.SetDataText(user_pk);
    lstType.value = '0';
    txtDeptPK.SetDataText(g_dept_pk);
}
//------------------------------------------------------------------------
function OnProcess()
{
    if(confirm("Are you sure you want to adjusted month " + dtTime.value + "?"))
    {
        dso_adj_inventory.Call();
    }    
}
//------------------------------------------------------------------------
function OnDataReceive(iObj)
{
    if(iObj.id == "dso_adj_inventory")
    {
        fmgf00380.Call("SELECT");
    }
    else if(iObj.id == "fmgf00380")
    {
        
    }
    else if(iObj.id == "dso_cancel_adj")
    {
        fmgf00380.Call("SELECT");
    }
}
//------------------------------------------------------------------------
function OnSearch()
{
    fmgf00380.Call("SELECT");
}
//------------------------------------------------------------------------
function OnUnProcess()
{
    if(idGrid.rows > 1)
    {
        txtTac_hgtrh_PK.text = idGrid.GetGridData(1, 13 );
        dso_cancel_adj.Call();
    }
}
//------------------------------------------------------------------------
function OnPeriodType()
{
    if(lstType.value == "0")
    {
        dtTime_1.style.display = "";
        dtTime.style.display = "none";
    }
    else if(lstType.value == "1")
    {
        dtTime_1.style.display = "none";
        dtTime.style.display = "";        
    }
}
//------------------------------------------------------------------------
</script>

<body>
    <!-------------------------------------------------------------------->    
    <gw:data id="dso_adj_inventory" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_FMGF00380">
                <input>
                     <input bind="lstCompany"/>
                     <input bind="lstType"/>
                     <input bind="dtTime"/>
                     <input bind="dtTime_1"/>
                     <input bind="dtTrDate"/>
                     <input bind="txtUser_PK"/>
                     <input bind="txtDeptPK"/>
                </input>
                <output>
                     <output bind="txtRtn_tac_omcost_pk"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
        <gw:data id="dso_cancel_adj" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_FMGF00380_1">
                <input>
                     <input bind="txtTac_hgtrh_PK"/>
                </input>
                <output>
                     <output bind="txtRtn_tac_omcost_pk"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
<!-------------------------------------------------------------------->
  <gw:data id="fmgf00380" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="ACNT.sp_sel_fmgf00380" > 
                <input bind="idGrid" >                 
                    <input bind="lstCompany" />
                    <input bind="txtVoucherNo" />
                    <input bind="dtTrDate" />
                    <input bind="txtRtn_tac_omcost_pk" />
                    <input bind="dtTime" />
                    <input bind="dtTime_1" />
                    <input bind="lstType"/>
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>       
    <!-------------------------------------------------------------------->    
<table style="width:100%; height:100% " border="1" cellpadding="0" cellspacing="0"  >
    <tr style="height:10%" >
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                <tr>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                    <td style="width: 10%"></td>
                </tr>
				<tr>
                    <td align="right">Company&nbsp;</td>
                    <td align="left"><gw:list id="lstCompany" styles="width:100%" />                        
                    </td>				
					<td align="right">Type&nbsp;</td>
					<td align="left" ><gw:list id="lstType" styles="width:100%;" onchange="OnPeriodType()" >
					    <data>DATA|0|Month|1|Date</data>
					    </gw:list>
					</td>
					<td align="right">Adjusted Time&nbsp;</td>
					<td>
					    <gw:datebox id="dtTime" lang="1" type="date" style="display:none;" />
					    <gw:datebox id="dtTime_1" lang="1" type="month"  />
					</td>
					<td align="right">Trans Date&nbsp;</td>
					<td><gw:datebox id="dtTrDate" lang="1" type="date" styles="width:100%" /></td>
					<td align="right">Voucher No&nbsp;</td>
					<td><gw:textbox id="txtVoucherNo" styles="width:100%" /></td>
				</tr>
				<tr>
				    <td colspan="7"></td>
				    <td align="left"><gw:imgBtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
				    <td align="left"><gw:icon id="btnProcess" img="in" alt="Process" text="Process" onclick="OnProcess()" /></td>
				   <td align="left"><gw:icon id="btnCancelPro" img="in" alt="Process" text="UnProcess" onclick="OnUnProcess()" /></td> 
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
                            header="|Item Code|Item Name|Acc Code|Acc Name|_AccPk|_Item_Pk|_Qty|Trans Amt|Books Amt|Voucher No|Trans Date|Month|Seq"
                            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                            aligns="1|1|2|1|2|2|2|3|3|3|2|1|1|3"
                            defaults="|||||||||||||" 
                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                            widths="0|1500|2500|1500|2500|0|0|0|1500|1500|1500|1500|1200|1200"
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
<gw:textbox id="txtRtn_tac_omcost_pk" styles="display:none; " />
<gw:textbox id="txtUser_PK" styles="display:none; " />
<gw:textbox id="txtDeptPK" styles="display:none;" />
<gw:textbox id="txtTac_hgtrh_PK" styles="display:none;" />
</body>
</html>