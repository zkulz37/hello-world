<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>New Sales Contract Popup</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
//===============================================================

function BodyInit()
{
	OnSearch();
}

function OnSearch()
{
	dso_rehs00020_popup.Call('SELECT');
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

<gw:data id="dso_rehs00020_popup"  onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso type="grid" parameter="" function="CRM.SP_SEL_REHS00020_POPUP">
			<input bind="grdData">
				<input bind="txtSlipNo" />
				<input bind="txtCustomer" />
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data>

<table style="height: 100%; width: 100%" border="0">
	<tr style="height: 1%; background: white" >
		<td style="width: 10%" align='right'>Slip No.</td>
		<td style="width: 25%">
			<gw:textbox id="txtSlipNo" text="" styles='width:100%' onchange="OnSearch()"/>
		</td>
		<td style="width: 10%" align='right'>Customer</td>
		<td style="width: 25%">
			<gw:textbox id="txtCustomer" text="" styles='width:100%' onchange="OnSearch()"/>
		</td>
		<td style="width: 28%" align='right'>
			<gw:label id="lblRecord" styles="color: blue" text="0 record(s)" />
		</td>
		<td style="width: 1%">
			<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()"/>
		</td>
		<td style="width: 1%" align='right'>
			<gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect()" />
		</td>
	</tr>
	<tr style="height: 99%">
		<td colspan="7">
		<gw:grid id="grdData" 
		header="_PK|Slip No|Date|Customer|Address|Deposit AMT|CCY|Description|_tco_buspartner_pk" 
		format="0|0|0|0|0|0|0|0|0" 
		aligns="0|0|0|0|0|0|0|0|0" 
		defaults="||||||||" 
	    editcol="0|0|0|0|0|0|0|0|0" 
		widths="0|0|0|0|0|0|0|0|0" 
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
