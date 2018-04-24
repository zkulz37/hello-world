<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Interest Rate Registry</title>
  </head>
  
 <%ESysLib.SetUser("crm")%>
 
 <script>
var COL_PK					= 0,
	COL_VALID_FROM			= 1,
	COL_VALID_TO			= 2,
	COL_DAILY_RATE			= 3,
	COL_DESCRIPTION			= 4;

function BodyInit()
{
	OnSearch();
}

function OnSearch()
{
	dso_reab00060.Call('SELECT');
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
	if (grdData.row > 1)
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
	dso_reab00060.Call();
}
</script>

<body>
<gw:data id="dso_reab00060"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso id="1" type="grid" parameter="0,1,2,3,4" function="CRM.SP_SEL_REAB00060" procedure="CRM.SP_UPD_REAB00060" > 
			<input bind="grdData"   > 
				<input bind="dtFrom" /> 
				<input bind="dtTo" /> 
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data> 
<table  width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" >
	<tr width="100%" height="1%" >
		<td width="7%" align='center' nowrap>Valid From</td>
		<td width="10%"><gw:datebox id="dtFrom" text="" maxlen = "10" styles='width:100%' lang="<%=Session("Lang")%>" /></td>
		<td width="6%" align='center' nowrap> ~ Valid To </td>
	    <td width="10%"><gw:datebox id="dtTo"   text="" maxlen = "10" styles='width:100%' lang="<%=Session("Lang")%>" /></td>
		<td width="1%"><gw:imgBtn id="ibtnSearch" alt="search" img="search" onclick="OnSearch()" /></td>
		<td width="14%" align="left" >	&nbsp;
			<gw:label id="lblRecord" styles="color: blue" text="0 record(s)" />
		</td>
		<td width="52%" align='right'>
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
					header="_Pk|Valid From|Valid To|Daily Rate|Decription"
					format="0|4|4|1|1"
					aligns="0|1|1|3|2"
					defaults="||||"
					editcol="0|1|1|1|1"
					widths="0|0|0|0|0"
					check=="|||0-|"
					styles="width:100%; height:100%"
					sorting="T"   
					autosize="true" /> 
		</td>
	</tr>
</table>
</body>
</html>
