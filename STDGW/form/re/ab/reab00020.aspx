<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Unit Type Scale Registry</title>
  </head>
  
 <%ESysLib.SetUser("crm")%>
 
 <script>
 var COL1_PK				= 0,
	 COL1_SEQ				= 1,
	 COL1_TYPE				= 2,
	 COL1_USING_AREA		= 3,
	 COL1_LIVING_AREA		= 4,
	 COL1_SUPPLYING_AREA	= 5,
	 COL1_PARKING_AREA		= 6,
	 COL1_SITE_AREA			= 7,
	 COL1_OFFICIAL_AREA		= 8,
	 COL1_OTHER_USING_AREA	= 9,
	 COL1_TOTAL_AREA		= 10,
	 COL1_VAT_RATE			= 11,
	 COL1_USE_YN			= 12,
	 COL1_DESCRIPTION		= 13;

var COL_PK						= 0,
	COL_VALID_FROM				= 1,
	COL_VALID_TO				= 2,
	COL_DIVISION_AREA			= 3,
	COL_DIVISION				= 4,
	COL_CONTRACT_AMT			= 5,
	COL_LAND_AMT				= 6,
	COL_BUILDING_AMT			= 7,
	COL_UNIT_OPTION				= 8,
	COL_CCY						= 9,
	COL_USE_YN					= 10,
	COL_DESCRIPTION				= 11,
	COL_THS_UNITTYPE_SCALE_PK	= 12;

function BodyInit()
{
	var data = '';

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='CCY'" ) %> ";;
	grdData.SetComboFormat(COL_CCY, data);
	OnSearch(1);
}

function OnSearch(n)
{
	switch(n)
	{
		case 1:
			dso_reab00010.Call('SELECT');
		break;
		case 2:
			dso_reab00020.Call('SELECT');
		break;
		case 3:
			THS_UNITTYPE_SCALE_PK.text = grdData1.GetGridData(grdData1.row, COL1_PK);			
			dso_reab00020_1.Call('SELECT');
		break;
	}
	
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_reab00010':			
			if (grdData1.rows > 1)
			{
				lblRecord1.text = grdData1.rows - 1 + " record(s)";
			}
		break;
		case 'dso_reab00020':
		case 'dso_reab00020_1':
			if (grdData.rows > 1)
			{
				lblRecord.text = grdData.rows - 1 + " record(s)";
			}
		break;
	}
}

function OnNew()
{
	if (grdData1.row > 0)
	{
		grdData.AddRow();
		grdData.SetGridText(grdData.rows-1, COL_THS_UNITTYPE_SCALE_PK, grdData1.GetGridData(grdData1.row, COL1_PK));
	}
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
	if (grdData.rows > 1)
	{
		dso_reab00020.Call();
	}
}

function OnCheckDate()
{
	if (event.col == COL_VALID_FROM || event.col == COL_VALID_TO)
	{
		if (grdData.GetGridData(grdData.row, COL_VALID_TO) - grdData.GetGridData(grdData.row, COL_VALID_FROM) < 0)
		{
			alert('Invalid Date. Please, check data column Date.');
			grdData.SetGridText(grdData.row, event.col, '');
			return;
		}	
	}
}

</script>

<body>
<gw:data id="dso_reab00010"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso id="1" type="grid" parameter="" function="CRM.SP_SEL_REAB00010" procedure="" > 
			<input bind="grdData1"   > 
				<input bind="txtSeq" /> 
			</input> 
			<output bind="grdData1" /> 
		</dso> 
	</xml> 
</gw:data> 

<gw:data id="dso_reab00020"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="CRM.SP_SEL_reab00020" procedure="CRM.SP_UPD_reab00020" > 
			<input bind="grdData"   > 
				<input bind="dtFrom" /> 
				<input bind="dtTo" /> 
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data> 


<gw:data id="dso_reab00020_1"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso id="1" type="grid" parameter="" function="CRM.SP_SEL_reab00020_1" procedure="" > 
			<input bind="grdData"   > 
				<input bind="THS_UNITTYPE_SCALE_PK" />
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data> 

<table  width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
	<tr width="100%" height="20%">
		<td>
			<fieldset style="padding:1; width: 100%; height:95%">
				<legend><font color="black" size="2">Unit Type Scale</font></legend>
				<table width="100%" height="100%" >
					<tr height="1%" >
						<td width="10%" align='center'>Seq No.</td>
						<td width="15%">
							<gw:textbox id="txtSeq" text="" styles='width:100%'	onenterkey ="OnSearch(1)"/>
						</td>		
						<td width="1%">
							<gw:imgBtn id="ibtnSearch" alt="search" img="search" onclick="OnSearch(1)" />
						</td>
						<td width="14%" align="left" >	&nbsp;
							<gw:label id="lblRecord1" styles="color: blue" text="0 record(s)" />
						</td>
						<td width="60%" align='right'>
						</td>
					</tr>
					<tr width="100%" height="99%" >
						<td colspan='5' width="100%" height="60%">
							<gw:grid   
								id="grdData1"  
									header="_Pk|Seq|Type|Using Area|Living Area|Supplying Area|Parking Area|Site Area|Official Area|Other Using Area|Total Area|VAT Rate|Use YN|Description"
									format="0|0|0|1|1|1|1|1|1|1|1|1|3|0"
									aligns="0|0|0|3|3|3|3|3|3|3|3|3|0|0"
									defaults="||||||||||||-1|"
									editcol="0|0|0|1|1|1|1|1|1|1|1|1|1|1"
									widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
									check=="|||0-|0-|0-|0-|0-|0-|0-|0-|0-||4000"
									styles="width:100%; height:100%"   
									sorting="T"   
									autosize="true"
									oncellclick= "OnSearch(3)"/> 
						</td>
					</tr>
				</table>
			</fieldset>	
		</td>
	</tr>
	<tr width="100%" height="20%">
		<td>
			<fieldset style="padding:1; width: 100%; height:95%">
				<legend><font color="black" size="2">Unit Type Price</font></legend>
				<table>
					<tr>
						<td width="10%" align='center' nowrap>Valid Date</td>
						<td width="20%" nowrap>
							<gw:datebox id="dtFrom" text="" maxlen = "10" styles='width:100%' lang="<%=Session("Lang")%>" />~
							<gw:datebox id="dtTo"   text="" maxlen = "10" styles='width:100%' lang="<%=Session("Lang")%>" />
						</td>
						<td width="1%" nowrap>
							<gw:imgBtn id="ibtnSearch" alt="search" img="search" onclick="OnSearch(2)" />
						</td>
						<td width="15%" align="left" >&nbsp;&nbsp;
							<gw:label id="lblRecord" styles="color: blue" text="0 record(s)" />
						</td>
						<td width="54%" >
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
					<tr width="100%" height="100%">
						<td colspan='5' width="100%" height="90%">
							<gw:grid   
								id="grdData"  
									header="_pk|Valid From|Valid To|Division Area|Division|Contract AMT|Land AMT|Building AMT|Unit Option|CCY|Use YN|Description|_ths_unittype_scale_pk"
									format="0|4|4|1|1|1|1|1|1|0|3|0|0"
									aligns="0|0|0|3|3|3|3|3|3|0|0|0|0"
									defaults="|||||||||CCY-USD|-1||"
									editcol="0|1|1|1|1|1|1|1|1|1|1|1|1"
									widths="0|0|0|0|0|0|0|0|0|0|0|0|0"
									check="|0|0|0-|0-|0-|0-|0-|0-|||4000|"
									styles="width:100%; height:100%"   
									sorting="T"   
									autosize="true"
									debug="false"
									onafteredit="OnCheckDate()"/> 
						</td>
					</tr>
				</table>
			</fieldset>
		</td>
	</tr>	
</table>
</body>
<gw:textbox id="THS_UNITTYPE_SCALE_PK" styles="display: none" />
</html>
