<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
function BodyInit()
{ 
	System.Translate(document);
		
	lblCompany.text    = "<%=Request("Company")%>";
    lblSalMonth.text  = "<%=Request("SalMon")%>";
	lblCostCenter.text    = "<%=Request("CostCenterPK")%>";
	lblSearchCG.text    = "<%=Request("CostGroupPK")%>";
	lblSearchCT.text    = "<%=Request("CostTypePK")%>";
    
	lblSalAcc.text = "<%=Request("SalAccPk")%>";
	
	txtCostCenter.text = "<%=Request("CostCenterNm")%>";
	txtCostGroup.text = "<%=Request("CostGroupNm")%>";
	txtCostType.text = "<%=Request("CostTypeNm")%>";
	
	lblTitle.text = "<%=Request("SalAccNm")%>";
	
	
	txtCostCenter.SetEnable(false);
	txtCostGroup.SetEnable(false);
	txtCostType.SetEnable(false);
	
	datSearchSlipInfoDetail.Call("SELECT");
	
}

function OnDataReceive(obj)
{
	if(obj.id == "datSearchSlipInfoDetail")
	{
		lblEmpCount.text = grdList.rows-1 + " Employee(s).";
		datSumSlipInfoDetail.Call();
	}
	else
	{
	    return;
	}
}

function OnDataError(obj)
{
	AlertDBError(obj.errmsg)
	return;
}

function AlertDBError(errmsg)
{
	var aTmp = new Array();
	aTmp = errmsg.split("ORA-");
	if(aTmp.length >= 2)
	{
		alert(aTmp[1]);
	}
	else 
	{
		alert(errmsg);
	}
}


</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Popup Detail</title>
</head>
<body>
<gw:data id="datSearchSlipInfoDetail" onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
        <xml>
            <dso type="grid" function="ACNT.SP_SEL_SLIP_LIST_DETAIL">
                <input bind="grdList">
                    <input bind="lblCompany"/>
                    <input bind="lblSalMonth"/>
                    <input bind="lblCostCenter"/>
                    <input bind="lblSearchCG"/>
                    <input bind="lblSearchCT" />
					<input bind="lblSalAcc" />
					<input bind="txtEmpInfo" />
                </input>
                <output bind="grdList"/>
            </dso>
        </xml>
</gw:data>

<gw:data id="datSumSlipInfoDetail" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="process" procedure="ACNT.SP_PRO_SLIP_LIST_SUM" onerror="OnDataError(this)" > 
                <input>
                    <input bind="lblCompany"/>
                    <input bind="lblSalMonth"/>
                    <input bind="lblCostCenter"/>
                    <input bind="lblSearchCG"/>
                    <input bind="lblSearchCT" />
					<input bind="lblSalAcc" />
					<input bind="txtEmpInfo" />
                </input>
                <output>
                    <output bind="lblTotalTr" />
					<output bind="lblTotalBk" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<table width="100%" height="100%">
	<tr width="100%">
	<td width="100%">
		<fieldset style="padding: 5">
			<table>
				<tr width="100%">
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
					<td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
				</tr>
				<tr>
					<td colspan="15" align="right">Cost Center :</td>
					<td colspan="35"><gw:textbox id="txtCostCenter" styles="" /></td>
					<td colspan="15" align="right">Cost Group :</td>
					<td colspan="35"><gw:textbox id="txtCostGroup" styles="" /></td>
				</tr>
				<tr>
					<td colspan="15" align="right">Cost Type :</td>
					<td colspan="35"><gw:textbox id="txtCostType" styles="" /></td>
					<td colspan="15" align="right">Emp ID/Name :</td>
					<td colspan="20"><gw:textbox id="txtEmpInfo" styles="" onenterkey="datSearchSlipInfoDetail.Call('SELECT')" /></td>
					<td colspan="15"><gw:icon id="btnFilter" img="in" text="Filter" styles="width:100" onclick="datSearchSlipInfoDetail.Call('SELECT')" /></td>
					
				</tr>
			</table>
		</fieldset>
	</tr>	
	<tr>
		<td>
			<table width="100%"><tr width="100%">
				<td width="70%" align="center"><gw:label id="lblTitle" styles="color:blue;width:100%;font-weight: bold;font-size:16" /></td>
				<td width="30%" align="center"><gw:label id="lblEmpCount" text='0 Employee(s)' styles="color:red;width:100%;font-weight: bold;font-size:12"/></td>
			</tr></table>
		</td>
	</tr>
	<tr width="100%" height="100%">
		<td width="100%">
			<table width="100%" height = "100%" cellpadding="0" cellspacing="0"  border = "">
					<tr>
						<td>
							<gw:grid id="grdList" 
								header="Organization|Emp ID|Emp Name|Trans Amount|Currency|BK Rate|Books Amount"
                                format="0|0|0|1|0|1|1"
								aligns="0|0|0|0|0|0|0"
								defaults="||||||"
                                editcol="0|0|0|0|0|0|0"
								widths="2500|1000|2500|1500|1000|1000|1500"
                                styles="width:100%; height:100%" sorting="T" acceptnulldate="T" oncelldblclick="" />
						</td>
					</tr>
				</table>
		</td>
	</tr>
	<tr>
		<td>
			<table><tr>
				<td width="15%"><gw:label id="lblTotalTRtxt" text="Total Trans :" styles="color:black;width:100%;font-weight: bold;font-size:14" /></td>
				<td width="35%"><gw:label id="lblTotalTr" styles="color:red;width:100%;font-weight: bold;font-size:18;align:left" /></td>
				<td width="15%"><gw:label id="lblTotalBKtxt" text="Total BK:" styles="color:black;width:100%;font-weight: bold;font-size:14" /></td>
				<td width="35%"><gw:label id="lblTotalBk" styles="color:red;width:100%;font-weight: bold;font-size:18;align:left" /></td>
			</tr></table>
		</td>
	</tr>
</table>
<gw:label id="lblCompany" style="display: none" />
<gw:label id="lblSalMonth" style="display: none" />
<gw:label id="lblCostCenter" style="display: none" />
<gw:label id="lblSearchCG" style="display: none" />
<gw:label id="lblSearchCT" style="display: none" />
<gw:label id="lblSalAcc" style="display: none" />
</body>
</html>
