<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>House Sales Reservation Popup</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
//===============================================================
var COL_PK							= 0,
	COL_TYPE						= 1,
	COL_BUILDING					= 2,
	COL_AREA						= 3,
	COL_FLOOR						= 4,
	COL_HOUSE_NO					= 5,
	COL_USING_AREA					= 6,
	COL_LIVING_AREA					= 7,
	COL_SUPPLYING_AREA				= 8,
	COL_PARKING_AREA				= 9,
	COL_SITE_AREA					= 10,
	COL_OFFICIAL_AREA				= 11,
	COL_OTHER_AREA					= 12,
	COL_TOTAL_AREA					= 13,
	COL_VAT_RATE					= 14;

function BodyInit()
{
	BindingDataList();
	OnSearch();
}

function BindingDataList()
{ 	
	data = "DATA|10|Villa|20|Apartment|ALL|Select All";
	lstType.SetDataText(data);
	lstType.value = 'ALL';
}

function OnSearch()
{
	dso_rehs00010_popup.Call('SELECT');
}

function OnSelect()
{
	var arr_data = new Array();
   
	if (grdData.rows > 1)
	{   
		for(i =1 ; i < grdData.rows; i++)
		{
			if (grdData.GetGridControl().isSelected(i) == true)
			{
				var arrTemp = new Array();
			 
				for(j = 0; j < grdData.cols; j++)
				 {
					arrTemp[arrTemp.length] = grdData.GetGridData(i, j);
				 }
				 
				 arr_data[arr_data.length] = arrTemp;
			}
		}
	  
		if (arr_data != null)
		{
			window.returnValue = arr_data;
			window.close();
		}
	}
}

function OnDataReceive()
{
	lblRecord.text = grdData.rows-1 + ' record(s)';
}
</script>
<body>

<gw:data id="dso_rehs00010_popup"  onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso type="grid" parameter="" function="CRM.SP_SEL_REHS00010_POPUP">
			<input bind="grdData">
				<input bind="lstType" />
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data>

<table style="height: 100%; width: 100%" border="0">
	<tr style="height: 1%; background: white" >
		<td style="width: 10%">Type</td>
		<td style="width: 25%">
			<gw:list id="lstType" text="" styles='width:100%' onchange="OnSearch()"/>
		</td>
		<td style="width: 1%">
			<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()"/>
		</td>
		<td style="width: 50%">
			<gw:label id="lblRecord" styles="color: blue" text="0 record(s)" />
		</td>
		<td style="width: 14%" align='right'>
			<gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect()" />
		</td>
	</tr>
	<tr style="height: 99%">
		<td colspan="5">
		<gw:grid id="grdData" 
		header="_PK|Type|Building|Area|Floor|House No|Using Area|Living Area|Supplying Area|Parking Area|Site Area|Official Area|Other Area|Total Area|VAT Rate|_ths_unittype_price_pk|Price" 
		format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
		aligns="0|0|0|3|0|0|3|3|3|3|3|3|3|3|3|3|3" 
		defaults="||||||||||||||||" 
		editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
		widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
		styles="width:100%;height:100%" 
		autosize='T'
		oncelldblclick='OnSelect()'
		/>
		</td>
	</tr>
</table>
</body>
<!--------------------------------------------------------------------------------------->
<gw:textbox id="TCO_BUSPARTNER_PK" styles="width: 100%; display:none"/>

</html>
