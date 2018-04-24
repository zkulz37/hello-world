<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Guest</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{    
	OnNew();
	BindingList();
}

function BindingList()
{
	var data="";
	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'" )%>"; 
	lstGender.SetDataText(data);

	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'" )%>"; 
	lstNation.SetDataText(data);
	lstCountry.SetDataText(data);

	data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='CITY'" )%>"; 
	lstCity.SetDataText(data);


}

function OnSave()
{
	dso_htbk00010_new_guest.Call();
}
function OnDataReceive(obj)
{

}
function OnNew()
{
	dso_htbk00010_new_guest.StatusInsert();
}
</script>

<body>
<gw:data id="dso_htbk00010_new_guest" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23" function="CRM.SP_SEL_HTBK00010_NEW_GUEST" procedure="CRM.SP_UPD_HTBK00010_NEW_GUEST"> 
			<inout>
				<inout bind="THT_GUEST_PROFILE" />
				<inout bind="txtFullName"/>
				<inout bind="lstGender"/>
				<inout bind="txtAddress"/>
				<inout bind="dtBirthday"/>
				<inout bind="txtCompany"/>
				<inout bind="txtPhone"/>
				<inout bind="txtFax"/>
				<inout bind="txtPro"/>
				<inout bind="txtZipcode"/>
				<inout bind="txtLag"/>
				<inout bind="lstCountry"/>
				<inout bind="txtAgent"/>
				<inout bind="lstCity"/>
				<inout bind="txtPassport"/>
				<inout bind="lstNation"/>
				<inout bind="txtVisa"/>
				<inout bind="dtExp"/>
				<inout bind="txtCredit"/>
				<inout bind="dtEntry"/>
				<inout bind="txtDeposit"/>
				<inout bind="txtTax"/>
				<inout bind="txtDesc"/>
				<inout bind="txtEmail"/>
			</inout>
		</dso> 
	</xml> 
</gw:data>
<table style="height: 100%; width: 100%">
	<tr style="height: 1%">	
		<td colspan='3' style="width: 20%" ></td>
		<td style="width: 20%" aign='right' nowrap >
			<table style="width: 100%" >
				<tr>
					<td style="width: 98%" ></td>
					<td style="width: 1%" ><gw:imgbtn img="new"  alt="New"  id="btnNew" style='vertical-align: right' onclick="OnNew()" /></td>
					<td style="width: 1%" ><gw:imgbtn img="save" alt="Save" id="btnSave" style='vertical-align: right' onclick="OnSave()" /></td>
				</tr>
			</table>
			
			
		</td>
	</tr>
	<tr style="height: 1%">
		<td style="width: 10%" nowrap>Full Name</td>
		<td style="width: 60%" ><gw:textbox id="txtFullName" styles="width: 100%" csstype="mandatory" /></td>
		<td style="width: 10%" nowrap>Gender</td>
		<td style="width: 20%" ><gw:list id="lstGender" styles="width: 100%" csstype="mandatory"/></td>
	</tr>
	<tr style="height: 1%">
		<td style="width: 10%" nowrap>Address</td>
		<td style="width: 60%" ><gw:textbox id="txtAddress" styles="width: 100%" /></td>
		<td style="width: 10%" nowrap>Birthday</td>
		<td style="width: 20%" ><gw:datebox id="dtBirthday" lang="1" styles="width:100%" /></td>
	</tr>
	<tr style="height: 1%">
		<td style="width: 10%" nowrap>Company</td>
		<td style="width: 60%" ><gw:textbox id="txtCompany" styles="width: 100%" /></td>
		<td style="width: 10%" nowrap>Phone</td>
		<td style="width: 20%" ><gw:textbox id="txtPhone" styles="width: 100%" /></td>
	</tr>
	<tr style="height: 1%">
		<td style="width: 10%" nowrap>Professional</td>
		<td style="width: 60%" ><gw:textbox id="txtPro" styles="width: 100%" /></td>
		<td style="width: 10%" nowrap>Fax</td>
		<td style="width: 20%" ><gw:textbox id="txtFax" styles="width: 100%" /></td>
	</tr>
	<tr style="height: 1%">
		<td style="width: 10%" nowrap>Language</td>
		<td style="width: 60%" ><gw:textbox id="txtLag" styles="width: 100%" /></td>
		<td style="width: 10%" nowrap>Country</td>
		<td style="width: 20%" ><gw:list id="lstCountry" styles="width: 100%"/></td>
	</tr>
	<tr style="height: 1%">
		<td style="width: 10%" nowrap>Agent</td>
		<td style="width: 60%" ><gw:textbox id="txtAgent" styles="width: 100%"/></td>
		<td style="width: 10%" nowrap>Nationality</td>
		<td style="width: 20%" ><gw:list id="lstNation" styles="width: 100%"/></td>
	</tr>
	<tr style="height: 1%">
		<td style="width: 10%" nowrap>Passport</td>
		<td style="width: 60%" ><gw:textbox id="txtPassport" styles="width: 100%" /></td>		
		<td style="width: 10%" nowrap>City</td>
		<td style="width: 20%" ><gw:list id="lstCity" styles="width: 100%"/></td>
	</tr>
	<tr style="height: 1%">
		<td style="width: 10%" nowrap>Visa</td>
		<td style="width: 60%" ><gw:textbox id="txtVisa" styles="width: 100%" /></td>
		<td style="width: 10%" nowrap>Zip Code</td>
		<td style="width: 20%" ><gw:textbox id="txtZipcode" styles="width: 100%" /></td>
	</tr>
	<tr style="height: 1%">
		<td style="width: 10%" nowrap>Credit Card</td>
		<td style="width: 60%" ><gw:textbox id="txtCredit" styles="width: 100%" /></td>
		<td style="width: 10%" nowrap>Tax Code</td>
		<td style="width: 20%" ><gw:textbox id="txtTax" styles="width: 100%" /></td>
	</tr>
	<tr style="height: 1%">
		<td style="width: 10%" nowrap>Deposit</td>
		<td style="width: 60%" ><gw:textbox id="txtDeposit" styles="width: 100%" /></td>
		<td style="width: 10%" nowrap>Exp Date</td>
		<td style="width: 20%" ><gw:datebox id="dtExp" lang="1" styles="width:100%" /></td>
	</tr>	
	<tr style="height: 1%">
		<td style="width: 10%" nowrap>Description</td>
		<td style="width: 60%" ><gw:textbox id="txtDesc" styles="width: 100%" /></td>
		<td style="width: 10%" nowrap>Entry Date</td>
		<td style="width: 20%" ><gw:datebox id="dtEntry" lang="1" styles="width:100%" /></td>
	</tr>
	<tr style="height: 1%">
		<td style="width: 10%" nowrap>Email</td>
		<td style="width: 60%" ><gw:textbox id="txtEmail" styles="width: 100%" /></td>
		<td style="width: 10%" nowrap></td>
		<td style="width: 20%" ></td>
	</tr>
	<tr style="height: 81%">
		<td colspan='4' style="width: 100%" ></td>
	</tr>
</table>
</body>
</html>
<gw:textbox id="THT_GUEST_PROFILE" styles="width: 100%; display: none" />
