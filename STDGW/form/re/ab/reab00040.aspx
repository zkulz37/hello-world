<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>House ID Registry</title>
  </head>
  
 <%ESysLib.SetUser("crm")%>
 
 <script>
var COL_PK			= 0,
	COL_TYPE		= 1,
	COL_BUILDING	= 2,
	COL_AREA		= 3,
	COL_FLOOR		= 4,
	COL_HOUSE_NO	= 5,
	COL_USE_YN		= 6,
	COL_DESCRIPTION	= 7;

function BodyInit()
{
	var data = '';

	data = "#10;Villa|#20;Apartment";
	grdData.SetComboFormat(COL_TYPE, data);
	
	data = "DATA|10|Villa|20|Apartment|ALL|Select All";
	lstType.SetDataText(data);
	lstType.value = 'ALL';

	chkUseYN.value = 'T';
	OnSearch();
}

function OnSearch()
{
	dso_reab00040.Call('SELECT');
}

function OnDataReceive()
{
	lblRecord.text = grdData.rows - 1 + " record(s)";
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
	dso_reab00040.Call();
}
</script>

<body>
<gw:data id="dso_reab00040"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7" function="CRM.SP_SEL_REAB00040" procedure="CRM.SP_UPD_REAB00040" > 
			<input bind="grdData"   >  
				<input bind="lstType" /> 
				<input bind="txtBuilding" /> 
				<input bind="txtArea" /> 
				<input bind="txtFloor" />
				<input bind="txtHouseID" /> 
				<input bind="chkUseYN" /> 
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data> 
<table  width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" >
	<tr width="100%" height="1%" >
		<td width="10%" align='right' nowrap >Building&nbsp&nbsp&nbsp</td>
		<td width="15%">
			<gw:textbox id="txtBuilding" text="" styles='width:100%'	onenterkey ="OnSearch()"/>
		</td>
		<td width="10%" align='right' nowrap>Area&nbsp&nbsp</td>
		<td width="15%">
			<gw:textbox id="txtArea" text="" styles='width:100%'	onenterkey ="OnSearch()"/>
		</td>		
		<td width="10%" align='right' nowrap>Floor&nbsp&nbsp</td>
		<td width="15%">
			<gw:textbox id="txtFloor" text="" styles='width:100%'	onenterkey ="OnSearch()"/>
		</td>
		<td width="5%">
			<gw:checkbox id="chkUseYN" value='-1' styles='width:100%' onchange="OnSearch()"/>
		</td>
		<td width="10%" align='left'>User YN</td>
		<td width="1%">
			<gw:imgBtn id="ibtnSearch" alt="search" img="search" onclick="OnSearch()" />
		</td>
		<td width="%6" align="left" nowrap >	&nbsp;
			<gw:label id="lblRecord" styles="color: blue" text="0 record(s)" />
		</td>
		<td width="%3" align='right'>
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
	<tr>
		<td width="10%" align='right' nowrap>Type&nbsp&nbsp</td>
		<td width="15%">
			<gw:list id="lstType" text="" styles='width:100%'	onchange ="OnSearch()"/>
		</td>
		<td width="10%" align='right' nowrap>House ID&nbsp&nbsp</td>
		<td width="15%">
			<gw:textbox id="txtHouseID" text="" styles='width:100%'	onenterkey="OnSearch()"/>
		</td>
		<td colspan='7' width="50%">
		</td>
	</tr>
	<tr width="100%" height="99%" >
		<td colspan='11' width="100%" height="100%" >
			<gw:grid   
				id="grdData"  
					header="_pk|Type|Building|Area|Floor|House No|Use YN|Description"
					format="0|0|0|0|0|0|3|0"
					aligns="0|0|0|0|0|0|0|0"
					defaults="||||||-1|"
					editcol="0|1|1|1|1|1|1|1"
					widths="0|0|0|0|0|0|0|0"
					check="|||||||"
					styles="width:100%; height:100%"   
					sorting="T"   
					autosize="true"/> 
		</td>
	</tr>
</table>
</body>
</html>
