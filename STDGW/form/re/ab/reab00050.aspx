<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Interest Rate Registry</title>
  </head>
  
 <%ESysLib.SetUser("crm")%>
 
 <script>
var COL_PK					= 0,
	COL_FEE_CODE			= 1,
	COL_FEE_NAME			= 2,
	COL_FEE_AMT 			= 3,
	COL_USE_YN              = 4,
	COL_DESCRIPTION			= 5;

function BodyInit()
{
	OnSearch();
}

function OnSearch()
{
	dso_reab00050.Call('SELECT');
}

function OnDataReceive()
{
	if (grdData.rows > 1)
	{
		lblRecord.text = grdData.rows - 1 + " record(s)";
	}
}

function OnNew()
{
	grdData.AddRow();
}

function OnDelete()
{   
	if (grdData.rows > 1)
	{
		if (confirm('Are you sure delete data ?'))
		{
			grdData.DeleteRow();
			OnSave();
		}
	}
}

function OnSave()
{
	dso_reab00050.Call();
}
</script>

<body>
<gw:data id="dso_reab00050"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso id="1" type="grid" parameter="0,1,2,3,4,5" function="CRM.SP_SEL_REAB00050" procedure="CRM.SP_UPD_REAB00050" > 
			<input bind="grdData"   > 
				<input bind="txtFeeCode" /> 
				<input bind="txtFeeName" /> 
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data> 
<table  width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" >
	<tr width="100%" height="1%" >
		<td width="7%" align='center' nowrap>Fee Code</td>
		<td width="10%"><gw:textbox id="txtFeeCode" text="" styles='width:100%' /></td>
		<td width="8%" align='center' nowrap> Fee Name </td>
	    <td width="10%"><gw:textbox id="txtFeeName" text="" styles='width:100%' /></td>
		<td width="1%"><gw:imgBtn id="ibtnSearch" alt="search" img="search" onclick="OnSearch()" /></td>
		<td width="14%" align="left" >	&nbsp;
			<gw:label id="lblRecord" styles="color: blue" text="0 record(s)" />
		</td>
		<td width="50%" align='right'>
			<table width="100%" height="100%" >
				<tr width="100%" >
					<td width="97%"></td>	
					<td width="1%"><gw:imgBtn id="ibtnNew"		alt="new"		img="new"		onclick="OnNew()" /></td>
					<td width="1%"><gw:imgBtn id="ibtnDelete"	alt="Delete"	img="delete"	onclick="OnDelete()" /></td>
					<td width="1%"><gw:imgBtn id="ibtnSave"		alt="Save"		img="save"		onclick="OnSave()" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr width="100%" height="99%" >
		<td colspan='7' width="100%" height="100%" >
			<gw:grid   
				id="grdData"  
					header="_Pk|Fee Code|Fee Name|Fee AMT|Active|Decription"
					format="0|1|1|1|3|1"
					aligns="0|2|2|2|1|2"
					defaults="|||||"
					editcol="0|1|1|1|1|1"
					widths="0|0|0|0|0|0"
					check=="|||0-||"
					styles="width:100%; height:100%"
					sorting="T"   
					autosize="true" /> 
		</td>
	</tr>
</table>
</body>
</html>
