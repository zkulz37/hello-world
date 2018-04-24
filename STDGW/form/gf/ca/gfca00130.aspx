<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Construction Sales Inq.</title>
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
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
}
//------------------------------------------------------------------------
function OnReset(iCase)
{
    if(iCase == "PL")
    {
        txtPLCode.SetDataText("");
        txtPLName.SetDataText("");        
        txttac_abplcenter_pk.SetDataText("");
    }
    else if(iCase == "Customer")
    {
        txtPLCode.SetDataText("");
        txtPLName.SetDataText("");        
        txtCustPK.SetDataText("");
    }
    else if (iCase == "Contract")
    {
        txtContrCode.SetDataText("");
        txtContrName.SetDataText("");
        txtContrPK.SetDataText("");
    }
}
//------------------------------------------------------------------------
function OnPopUp(iCase)
{
    if(iCase == "PL")
    {
        var path = System.RootURL + "/form/gf/co/gfco002005.aspx?dsqlid=ACNT.SP_SEL_fmgf00050_2&company=" + lstCompany.value + "&col_code=PL Code&col_nm=PL Name&comm_nm=" + "&val1=";
        var object = System.OpenModal( path, 800, 600, 'resizable:yes;status:yes');        
        if(object != null)
        {
            txttac_abplcenter_pk.text = object[2];
            txtPLCode.text = object[0];
            txtPLName.text = object[1];
        }        
    }
    else if(iCase == "Customer")    
    {
		var path    = System.RootURL + '/form/gf/co/ffbp00031.aspx';
		var object  = System.OpenModal( path, 800, 550,'resizable:yes;status:yes');
		if ( object != null )
		{
			txtCustPK.text = object[0];
			txtCustID.text = object[2];
			txtCustNM.text = object[1];
        }                                
    }
    else if(iCase == "Contract")
    {
	    var fpath = System.RootURL + "/form/gf/ca/gfca00010_contract.aspx";
	    var o = System.OpenModal( fpath , 850 , 550 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
	    if (o != null)
	    {
		    if(o[0] != 0)
		    {
			    txtContrPK.text = o[0];
			    txtContrCode.text = o[1];
		    }
	    }		    
    
    }
}
//------------------------------------------------------------------------
</script>

<body>
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
                    <td style="width: 3%"></td>
                    <td style="width: 3%"></td>
                </tr>
				<tr>
                    <td align="right">Company&nbsp;</td>
                    <td align="left"><gw:list id="lstCompany" styles="width:100%" /></td>				
                    <td align="right" ><a title="Click here to select PL" onclick="OnPopUp('PL')" href="#tips">Project&nbsp;</a></td>
                    <td align="left"><gw:textbox id="txtPLCode" text="" styles="width:100%; " /></td>
                    <td align="left" colspan="1" ><gw:textbox id="txtPLName" text="" styles="width:100%; " /></td>                    
                    <td align="right"><gw:imgbtn img="reset" alt="Reset" id="btnReset2" onclick="OnReset('PL')" /></td>                    					
                    <td align="right" ><a title="Click here to select customer" onclick="OnPopUp('Customer')" href="#tips">Customer&nbsp;</a></td>
                    <td align="left" ><gw:textbox id="txtCustID" styles="width:100%; " /></td>
                    <td align="left" ><gw:textbox id="txtCustNM" styles="width:100%; " /></td>
                    <td align="right"><gw:imgbtn img="reset" alt="Reset" id="btnReset_1" onclick="OnReset('Customer')" /></td>                                                            					
                    <td align="right"><gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch('fmgf00110')" /></td>
                    <td align="right"></td>
                    <td align="right"><gw:imgbtn img="printer" alt="Report" id="btnExcel2" onclick="OnExcel()" /></td>					
				</tr>
				<tr>
					<td align="right">Month&nbsp;</td>
					<td align="left" ><gw:datebox id="dbMonthly" type="month" lang="1" /></td>
                    <td align="right" ><a title="Click here to select contract no" onclick="OnPopUp('Contract')" href="#tips">Contract&nbsp;</a></td>
                    <td align="left"><gw:textbox id="txtContrCode" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="left"><gw:textbox id="txtContrName" text="" styles="width:100%; " csstype="mandatory" /></td>
                    <td align="right">
                        <gw:imgbtn img="reset" alt="Reset" id="btnReset" onclick="OnReset('Contract')" />
					</td>
                    <td align="right" ></td>
                    <td align="left"></td>
                    <td align="left" ></td>                    
                    <td align="right"></td>
					<td colspan="1" align="right" ><gw:icon id="btnProcess" text="Process" onclick="OnProcess()" /></td>
					<td colspan="2" align="right" ><gw:icon id="btnCancel" text="Cancel" onclick="OnCancell()" /></td>					
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
                            header="Form|Trans date|Account code|VAS Code|Account Name|Debit Amount|Account code|VAS Code|Account Name|Credit amount|Customer ID|Customer Name|PL Code|Contract No"
                            format="0|4|0|0|0|0|0|0|0|0|0|0|0|0" 
                            aligns="0|1|1|1|2|3|2|1|3|3|1|2|1|1"
                            defaults="|||||||||||||" 
                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                            widths="1200|1000|1300|1300|1600|1500|1400|1300|2000|1800|1300|2000|1400|1400"
                            styles="width:100%; height:100% " 
                            acceptNullDate="T" 
                            sorting="T" 
                            param="" />                    
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>            
<gw:textbox id="txttac_abplcenter_pk" styles="display:none; " />
<gw:textbox id="txtCustPK" styles="display:none; " />
<gw:textbox id="txtContrPK" styles="display:none; " />

</body>
</html>