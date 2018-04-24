<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Unit Type Scale Registry</title>
  </head>
  
 <%ESysLib.SetUser("crm")%>
 
 <script>
var COL1_PK					= 0,
	COL1_SEQ				= 1,
	COL1_TYPE				= 2,
	COL1_USING_AREA			= 3,
	COL1_LIVING_AREA		= 4,
	COL1_SUPPLYING_AREA		= 5,
	COL1_PARKING_AREA		= 6,
	COL1_SITE_AREA			= 7,
	COL1_OFFICIAL_AREA		= 8,
	COL1_OTHER_USING_AREA	= 9,
	COL1_TOTAL_AREA			= 10,
	COL1_VAT_RATE			= 11,
	COL1_USE_YN				= 12,
	COL1_DESCRIPTION		= 13;

var COL2_PK						= 0,
	COL2_VALID_FROM				= 1,
	COL2_VALID_TO				= 2,
	COL2_DIVISION_AREA			= 3,
	COL2_DIVISION				= 4,
	COL2_CONTRACT_AMT			= 5,
	COL2_LAND_AMT				= 6,
	COL2_BUILDING_AMT			= 7,
	COL2_UNIT_OPTION			= 8,
	COL2_CCY					= 9,
	COL2_USE_YN					= 10,
	COL2_DESCRIPTION			= 11,
	COL2_THS_UNITTYPE_SCALE_PK	= 12;

var COL3_PK						= 0,
	COL3_PAY_DATE				= 1,
	COL3_PAY_AMT				= 2,
	COL3_LAND_AMT				= 3,
	COL3_BUILDING_AMT			= 4,
	COL3_VAT_RATE				= 5,
	COL3_VAT_AMT				= 6,
	COL3_PAY_PERIOD				= 7,
	COL3_DESCRIPTION			= 8,
	COL3_THS_UNITTYPE_PRICE_PK	= 9;

function BodyInit()
{
	
	OnSearch(1);
}

function OnSearch(n)
{
	switch(n)
	{
		case 1:
			dso_reab00030_1.Call('SELECT');
		break;
		case 2:
			THS_UNITTYPE_SCALE_PK.text = grdData1.GetGridData(grdData1.row, COL1_PK);
			dso_reab00030_2.Call('SELECT');
		break;
		case 3:			
			THS_UNITTYPE_PRICE_PK.text = grdData2.GetGridData(grdData2.row, COL2_PK);
			dso_reab00030_3.Call('SELECT');
		break;
	}
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_reab00030_1':
			if (grdData1.rows > 1)
			{
				lblRecord1.text = grdData1.rows-1 + ' record(s)';
				THS_UNITTYPE_SCALE_PK.text = grdData1.GetGridData(1, COL1_PK);
				dso_reab00030_2.Call('SELECT');
			}
		break;
		case 'dso_reab00030_2':
			lblRecord2.text = grdData2.rows-1 + ' record(s)';
			if (grdData2.rows > 1)
			{				
				THS_UNITTYPE_PRICE_PK.text = grdData2.GetGridData(1, COL2_PK);
				dso_reab00030_3.Call('SELECT');
			}
			else
			{
				grdData3.ClearData();
				lblRecord3.text = '0 record(s)';
			}
		break;
		case 'dso_reab00030_3':	
			lblRecord3.text = grdData3.rows-1 + ' record(s)';
		break;
	}
}

function OnNew(n)
{
	switch(n)
	{
		case 1:
			var path = System.RootURL + "/form/re/ab/reab00010.aspx?";
			var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
			OnSearch(1);	
		break;
		case 2:
		break;
		case 3:			
			grdData3.AddRow();
			grdData3.SetGridText(grdData3.rows-1, COL3_THS_UNITTYPE_PRICE_PK, grdData2.GetGridData(grdData2.row, COL2_PK));
		break;
	}
}

function OnDelete()
{
	if (grdData3.rows > 1)
	{		
		if (confirm("Are you sure delete data ?"))
		{
			grdData3.DeleteRow();
		}
	}
}

function OnSave()
{
	dso_reab00030_3.Call();
}
</script>

<body>
<gw:data id="dso_reab00030_1"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso id="1" type="grid" parameter="" function="CRM.SP_SEL_reab00030_1" procedure="" > 
			<input bind="grdData1"   > 
				<input bind="txtSeq" />
			</input> 
			<output bind="grdData1" /> 
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_reab00030_2"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso id="2" type="grid" parameter="" function="CRM.SP_SEL_reab00030_2" procedure="" > 
			<input bind="grdData2">
				<input bind="THS_UNITTYPE_SCALE_PK" />
			</input> 
			<output bind="grdData2" /> 
		</dso> 
	</xml> 
</gw:data>
<gw:data id="dso_reab00030_3"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="CRM.SP_SEL_REAB00030_3" procedure="CRM.SP_UPD_reab00030" > 
			<input bind="grdData3"   > 
				<input bind="THS_UNITTYPE_PRICE_PK" /> 
			</input> 
			<output bind="grdData3" /> 
		</dso> 
	</xml> 
</gw:data>

<table  width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
	<tr width="100%" height="100%">
		<td width="40%" height="100%" styles="vertical-align: top" >
			<table width="100%" height="100%" border='0'>
				<tr>
					<td width="100%" height="50%">
						<fieldset style="padding:1; width: 100%; height:95%">
						<legend><font color="black" size="2">Unit Type Scale</font></legend>
						<table width="100%" height="100%" >
							<tr height="1%" >
								<td width="15%" align='center' nowrap>Seq No.</td>
								<td width="25%">
									<gw:textbox id="txtSeq" text="" styles='width:100%'	onenterkey ="OnSearch(1)"/>
								</td>		
								<td width="1%">
									<gw:imgBtn id="ibtnSearch" alt="search" img="search" onclick="OnSearch(1)" />
								</td>
								<td width="48%" align="right" >
								</td>
								<td width="19%" align="right" nowrap >
									<gw:label id="lblRecord1" styles="color: blue" text="0 record(s)" />
								</td>
								<td width="1%">
									<gw:imgBtn id="ibtnNew1" alt="New" img="new" onclick="OnNew(1)" />
								</td>
							</tr>
							<tr width="100%" height="99%" >
								<td colspan='6' width="100%" height="50%">
									<gw:grid   
										id="grdData1"  
											header="_Pk|Seq|Type|Using Area|Living Area|Supplying Area|Parking Area|Site Area|Official Area|Other Using Area|Total Area|VAT Rate|Use YN|Description"
											format="0|0|0|1|1|1|1|1|1|1|1|1|3|0"
											aligns="0|0|0|3|3|3|3|3|3|3|3|3|0|0"
											defaults="||||||||||||-1|"
											editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
											widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
											check=="|||0-|0-|0-|0-|0-|0-|0-|0-|0-||4000"
											styles="width:100%; height:90%"   
											sorting="T"   
											autosize="true"
											oncellclick= "OnSearch(2)"/> 
								</td>
							</tr>
						</table>
					</fieldset>	
					</td>
				</tr>
				<tr>
					<td width="100%" height="50%">
						<fieldset style="padding:1; width: 100%; height:95%">
							<legend><font color="black" size="2">Unit Type Price</font></legend>
							<table width="100%" height="100%">
								<tr>
									<td width="100%" align="right" >
										<gw:label id="lblRecord2" styles="color: blue" text="0 record(s)" />
									</td>
								</tr>
								<tr width="100%" height="100%">
									<td colspan='5' width="100%" height="90%">
										<gw:grid   
											id="grdData2"  
												header="_pk|Valid From|Valid To|Division Area|Division|Contract AMT|Land AMT|Building AMT|Unit Option|CCY|Use YN|Description|_ths_unittype_scale_pk"
												format="0|4|4|1|1|1|1|1|1|0|3|0|0"
												aligns="0|0|0|3|3|3|3|3|3|0|0|0|0"
												defaults="||||||||||-1||"
												editcol="0|0|0|0|0|0|0|0|0|0|0|0|0"
												widths="0|0|0|0|0|0|0|0|0|0|0|0|0"
												check="|0|0|0-|0-|0-|0-|0-|0-|||4000|"
												styles="width:100%; height:90%"   
												sorting="T"   
												autosize="true"
												debug="false"
												oncellclick="OnSearch(3)"/> 
									</td>
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
			</table>
		</td>
		<td width="60%" height="100%">
			<fieldset style="padding:1; width: 100%; height:95%">
				<legend><font color="black" size="2">Unit Type Schedule</font></legend>
				<table width="100%" height="100%">
					<tr width="100%" height="1%">
						<td width="15%" styles='display: none' align='center' nowrap></td>
						<td width="25%" nowrap>
						</td>
						<td width="1%">
						</td>
						<td width="19%" align="left" >
							<table width="100%" height="100%" >
								<tr width="100%" >
									<td width="80%"></td>	
									<td width="17%"  nowrap>
										<gw:label id="lblRecord3" styles="color: blue" text="0 record(s)" />
									</td>
									<td width="1%"><gw:imgBtn id="ibtnNew"		alt="new"		img="new"		onclick="OnNew(3)" /></td>
									<td width="1%"><gw:imgBtn id="ibtnDelete"	alt="Delete"	img="delete"	onclick="OnDelete()" /></td>
									<td width="1%"><gw:imgBtn id="ibtnSave"		alt="Save"		img="save"		onclick="OnSave()" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr width="100%" height="99%">
						<td colspan='4' width="100%">
							<gw:grid   
								id="grdData3"  
									header="_pk|Pay Date|Pay AMT|Land AMT|Building AMT|VAT Rate|VAT AMT|Pay Period|Description|_ths_unittype_price_pk"
									format="0|4|1|1|1|1|1|1|0|0"
									aligns="0|0|3|3|3|3|3|3|0|0"
									defaults="||||||||||"
									editcol="0|1|1|1|1|1|1|1|1|0"
									widths="0|0|0|0|0|0|0|0|0|0"
									check="|0|0-|n|n|n|n|n||0"
									styles="width:100%; height:98%"   
									sorting="T"   
									debug='false'
									autosize="true"/> 
						</td>
					</tr>
				</table>
			</fieldset>
		</td>
	</tr>
</table>
</body>
<gw:textbox id="THS_UNITTYPE_SCALE_PK" styles="display: none" />
<gw:textbox id="THS_UNITTYPE_PRICE_PK" styles="display: none" />
</html>
