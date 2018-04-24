<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Process AR Data</title>
</head>
<script>
    var  user_pk = "<%=Session("EMPLOYEE_PK")%>"  ;
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
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), partner_name FROM COMM.TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
}
//------------------------------------------------------------------------
function OnAddNew()
{
	var l_row = idGrid.AddRow();
	l_row = idGrid.rows - 1;	
}
//------------------------------------------------------------------------
function OnSave()
{
	dso_ar_ny.Call();
}
//------------------------------------------------------------------------
function OnSearch()
{
	dso_ar_ny.Call("SELECT");
}
//------------------------------------------------------------------------
function OnProcess()
{
	if(confirm("Are you sure you want to convert data?"))
	{
		dso_process.Call();
	}
}

function OnDataReceive(iObj)
{
	if(iObj.id == "dso_process")
	{	
		alert(txtReturnValue.text);
	}
}
//------------------------------------------------------------------------
</script>

<body>
    <!-------------------------------------------------------------------->
  <gw:data id="dso_ar_ny" onreceive=""> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30" function="acnt.sp_sel_ar_namyang" procedure="acnt.sp_upd_ar_namyang" > 
                <input bind="idGrid" >                 
                    <input bind="lstCompany"/>
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>       
	
    <gw:data id="dso_process" onreceive="OnDataReceive(this)">
        <xml> 
            <dso type="process" procedure="ACNT.sp_pro_ar_namyang"> 
                <input> 
                     <input bind="lstCompany"/>
                </input>
                <output>
                     <output bind="txtReturnValue"/>
               </output> 
            </dso>
        </xml> 
    </gw:data>
	
    <!-------------------------------------------------------------------->	
<table style="width:100%; height:100% " border="1" cellpadding="0" cellspacing="0"  >
    <tr style="height:10%" >
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                <tr>
                    <td style="width: 8%"></td>
                    <td style="width: 14%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 16%"></td>
                    <td style="width: 2%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 8%"></td>
                    <td style="width: 16%"></td>
                    <td style="width: 2%"></td>
                    <td style="width: 4%"></td>
                    <td style="width: 2%"></td>
                    <td style="width: 2%"></td>
					<td style="width: 2%"></td>
                </tr>
                <tr >
                    <td align="right">Company&nbsp;</td>
                    <td align="left"><gw:list id="lstCompany" styles="width:100%" /></td>
                    <td align="right" ><a title="Click here to select account" onclick="OnPopUp('Account')" href="#tips">Account&nbsp;</a></td>
                    <td align="left"><gw:textbox id="txtAccountCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left"><gw:textbox id="txtAccountName" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="right">
                        <gw:imgbtn img="reset" alt="Reset" id="btnReset" onclick="OnReset('Account')" /></td>                                        
                    <td align="right" ><a title="Click here to select PL" onclick="OnPopUp('PL')" href="#tips">PL&nbsp;</a></td>
                    <td align="left"><gw:textbox id="txtPLCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left" ><gw:textbox id="txtPLName" text="" styles="width:100%; " csstype="mandatory" /></td>                    
                    <td align="right"><gw:imgbtn img="process" alt="Process" id="btnProcess" onclick="OnProcess()" /></td>                    
                    <td align="right"><gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" /></td>
                    <td align="right"><gw:imgbtn img="new" alt="New" id="btnNew" onclick="OnAddNew()" /></td>
                    <td align="right"><gw:imgbtn img="delete" alt="Delete" id="btnDel" onclick="OnDelete()" /></td>
					<td align="right"><gw:imgbtn img="save" alt="Save" id="btnSave" onclick="OnSave()" /></td>
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
                            header="_PK|Co Invoice No|Serial No|Invoice No|Invoice date|Item name|Style#|PO#|Qty|FOB Price|Amount FOB|UPrice|Amount_USD|On Board|Received|Date Received|Balance|Pay Advance|Remark|Declaration No|Declaration Date|Exp. Date|Exchange|Amount_VND|Transport by|Ship To|Cust Name|Payment Method|Annex No|Annex Date|Contract No"
                            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                            aligns="0|1|1|1|1|0|1|1|3|3|3|3|3|1|2|1|3|3|0|2|1|1|1|3|2|2|2|2|2|1|2"
                            defaults="||||||||||||||||||||||||||||||" 
                            editcol="0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" 
                            widths="0|1400|1400|1400|1400|1500|1500|1500|1500|1500|1500|1500|1200|1400|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"
                            styles="width:100%; height:100% " 
                            acceptNullDate="T" 
                            sorting="T"
                            param=""
							/>                    
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>            
<gw:textbox id="txtTAC_ABACCTCODE_PK" styles="display:none; " />
<gw:textbox id="txtTCO_ITEM_PK" styles="display:none; " />
<gw:textbox id="txttac_abplcenter_pk" styles="display:none; " />
<gw:textbox id="txtReturnValue" styles="display:none; " />
</body>
</html>