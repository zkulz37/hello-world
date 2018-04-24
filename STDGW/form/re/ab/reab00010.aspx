<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Unit Type Scale Registry</title>
  </head>
  
 <%ESysLib.SetUser("crm")%>
 
 <script>
var COL_PK					= 0,
	COL_SEQ					= 1,
	COL_TYPE				= 2,
	COL_USING_AREA			= 3,
	COL_LIVING_AREA			= 4,
	COL_SUPPLYING_AREA		= 5,
	COL_PARKING_AREA		= 6,
	COL_SITE_AREA			= 7,
	COL_OFFICIAL_AREA		= 8,
	COL_OTHER_USING_AREA	= 9,
	COL_TOTAL_AREA			= 10,
	COL_VAT_RATE			= 11,
	COL_USE_YN				= 12,
	COL_DESCRIPTION			= 13;

var COL1_PK						= 0,
	COL1_BUILDING				= 1,
	COL1_AREA					= 2,
	COL1_FLOOR					= 3,
	COL1_HOUSE_NO				= 4,
	COL1_TYPE					= 5,
	COL1_USE_YN					= 6,
	COL1_DESCRIPTION			= 7,
	COL1_THS_UNITTYPE_SCALE_PK	= 8,
	COL1_THS_HOUSE_PK			= 9;

function BodyInit()
{
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
			if (grdData.row > 0)
			{
				THS_UNIT_TYPE_SCALE_PK.text = grdData.GetGridData(grdData.row, COL_PK);
				dso_reab00010_1.Call('SELECT');
			}
		break;
	}
}

function OnDataReceive(obj)
{
	switch(obj.id)
	{
		case 'dso_reab00010':
			lblRecord.text = grdData.rows - 1 + " record(s)";
		break;
		case 'dso_reab00010_1':
			lblRecord1.text = grdData1.rows - 1 + " record(s)";
		break;
	}
}

function OnNew(n)
{
	switch(n)
	{
		case 1:			
			grdData.AddRow();
		break;
		case 2:
			if (grdData.row > 0)
			{
				var path = System.RootURL + "/form/re/ab/reab00010_house.aspx?";
				var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');

				if (object != null)
				{
					var arrTemp
					for( var i=0; i < object.length; i++)	  
					{	
						arrTemp = object[i];
						grdData1.AddRow();
						grdData1.SetGridText(grdData1.rows-1, COL1_THS_HOUSE_PK, arrTemp[0]);
						grdData1.SetGridText(grdData1.rows-1, COL1_BUILDING, arrTemp[1]);
						grdData1.SetGridText(grdData1.rows-1, COL1_AREA, arrTemp[2]);
						grdData1.SetGridText(grdData1.rows-1, COL1_FLOOR, arrTemp[3]);
						grdData1.SetGridText(grdData1.rows-1, COL1_HOUSE_NO, arrTemp[4]);
						grdData1.SetGridText(grdData1.rows-1, COL1_TYPE, arrTemp[5]);
						grdData1.SetGridText(grdData1.rows-1, COL1_USE_YN, arrTemp[6]);
						grdData1.SetGridText(grdData1.rows-1, COL1_DESCRIPTION, arrTemp[7]);
						grdData1.SetGridText(grdData1.rows-1, COL1_THS_UNITTYPE_SCALE_PK, grdData.GetGridData(grdData.row, COL_PK));
					}
				}
			}
		break;
	}
}

function OnDelete(n)
{
	switch(n)
	{
		case 1:			
			if (grdData.row > 1)
			{
				if (confirm('Are you sure delete data ?'))
				{
					grdData.DeleteRow();
					OnSave(1);
				}
			}
		break;
		case 2:
			if (grdData1.rows > 1)
			{
				if (grdData1.GetGridData(grdData1.row, COL1_PK) == '')
				{
					grdData1.RemoveRow();
				}
				else
				{
					if (confirm('Are you sure delete data ?'))
					{
						grdData1.DeleteRow();
						OnSave(2);
					}
				}
			}
		break;
	}
}

function OnSave(n)
{
	switch(n)
	{
		case 1:
			dso_reab00010.Call();
		break;
		case 2:
			dso_reab00010_1.Call();
		break;
	}
}
</script>

<body>
<gw:data id="dso_reab00010"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso id="1" type="grid" parameter="0,2,3,4,5,6,7,8,9,10,11,12,13" function="CRM.SP_SEL_REAB00010" procedure="CRM.SP_UPD_REAB00010" > 
			<input bind="grdData"   > 
				<input bind="txtSeq" /> 
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data> 
<gw:data id="dso_reab00010_1"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso id="1" type="grid" parameter="0,8,9" function="CRM.SP_SEL_REAB00010_1" procedure="CRM.SP_UPD_REAB00010_1" > 
			<input bind="grdData1"   > 
				<input bind="THS_UNIT_TYPE_SCALE_PK" /> 
			</input> 
			<output bind="grdData1" /> 
		</dso> 
	</xml> 
</gw:data>
<table  width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" >
	<tr width="100%" height="1%" >
		<td width="10%" align='center' nowrap>Seq No.</td>
		<td width="15%">
			<gw:textbox id="txtSeq" text="" styles='width:100%'	onenterkey ="OnSearch(1)"/>
		</td>		
		<td width="1%">
			<gw:imgBtn id="ibtnSearch" alt="search" img="search" onclick="OnSearch(1)" />
		</td>
		<td width="60%" align='right'>
			<table width="100%" height="100%" >
				<tr width="100%" >
					<td width="82%"></td>	
					<td width="15%" align="right" >
						<gw:label id="lblRecord" styles="color: blue" text="0 record(s)" />
					</td>
					<td width="1%"><gw:imgBtn id="ibtnNew"		alt="New"		img="new"		onclick="OnNew(1)" /></td>
					<td width="1%"><gw:imgBtn id="ibtnDelete"	alt="Delete"	img="delete"	onclick="OnDelete(1)" /></td>
					<td width="1%"><gw:imgBtn id="ibtnSave"		alt="Save"		img="save"		onclick="OnSave(1)" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr width="100%" height="50%" >
		<td colspan='4' width="100%" height="50%" >
			<gw:grid   
				id="grdData"  
					header="_Pk|Seq|Type|Using Area|Living Area|Supplying Area|Parking Area|Site Area|Official Area|Other Using Area|Total Area|VAT Rate|Use YN|Description"
					format="0|0|0|1|1|1|1|1|1|1|1|1|3|0"
					aligns="0|0|0|3|3|3|3|3|3|3|3|3|0|0"
					defaults="||||||||||||-1|"
					editcol="0|0|1|1|1|1|1|1|1|1|1|1|1|1"
					widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0"
					check="|||0-|0-|0-|0-|0-|0-|0-|0-|0-||4000"
					styles="width:100%; height:100%"   
					sorting="T"   
					autosize="true"
					oncellclick="OnSearch(2)"/> 
		</td>
	</tr>
	<tr>
		<td colspan='4' width="60%" align='right'>
			<table width="100%" height="100%" >
				<tr width="100%" >
					<td width="82%"></td>	
					<td width="15%" align="right" >
						<gw:label id="lblRecord1" styles="color: blue" text="0 record(s)" />
					</td>
					<td width="1%"><gw:imgBtn id="ibtnNew"		alt="Add House"		img="new"		onclick="OnNew(2)" /></td>
					<td width="1%"><gw:imgBtn id="ibtnDelete"	alt="Delete"	img="delete"	onclick="OnDelete(2)" /></td>
					<td width="1%"><gw:imgBtn id="ibtnSave"		alt="Save"		img="save"		onclick="OnSave(2)" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr width="100%" height="49%" >
		<td colspan='4' width="100%" height="49%" >
			<gw:grid   
				id="grdData1"  
					header="_pk|Building|Area|Floor|House No|Type|Use YN|Description|_ths_unittype_scale_pk|_ths_house"
					format="0|0|0|0|0|0|3|0|0|0"
					aligns="0|0|0|0|0|0|0|0|0|0"
					defaults="||||||-1|||"
					editcol="0|0|0|0|0|0|0|0|0|0"
					widths="0|0|0|0|0|0|0|0|0|0"
					check="||||||||"
					styles="width:100%; height:100%"   
					sorting="T"   
					autosize="true"
					debug="false"/>
		</td>
	</tr>
</table>
<gw:textbox id="THS_UNIT_TYPE_SCALE_PK" styles='width:100%; display:none'/>
</body>
</html>
