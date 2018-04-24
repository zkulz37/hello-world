<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>House Sales Reservation Popup</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
//===============================================================
var COL_PK							= 0,
	COL_SLIP_NO						= 1,
	COL_DATE    					= 2,
	COL_PARTNER_NAME				= 3,
	COL_ADDR1						= 4,
	COL_DEPOSIT_AMT					= 5,
	COL_DESCRIPTION     			= 6,
	COL_CCY                         = 7;

function BodyInit()
{
	BindingDataList();
	OnSearch();
}

function BindingDataList()
{ 	
	
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
		    alert(arr_data);
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
		<dso type="grid" parameter="" function="crm.sp_sel_rehs00021_lst">
			<input bind="grdData">
				<input bind="txtSlipNo" />
				<input bind="txtCusName" />
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data>

<table style="height: 100%; width: 100%" border="0">
	<tr style="height: 1%; background: white" >
		<td style="width: 10%">Slip No</td>
		<td style="width: 20%">
			<gw:textbox id="txtSlipNo" styles="width: 100%"/>
		</td>
		<td style="width: 15%">Customer Name</td>
		<td style="width: 25%">
			<gw:textbox id="txtCusName" styles="width: 100%"/>
		</td>
		<td style="width: 1%">
			<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()"/>
		</td>
		<td style="width: 15%">
			<gw:label id="lblRecord" styles="color: blue" text="0 record(s)" />
		</td>
		<td style="width: 14%" align='right'>
			<gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect()" />
		</td>
	</tr>
	<tr style="height: 99%">
		<td colspan="7">
		<gw:grid id="grdData" 
		header="_Pk|Slip No|Date|Cust Name|Address|_Deposit_amt|Description|_CCY" 
		format="0|0|0|0|0|0|0|0" 
		aligns="0|0|0|0|0|0|0|0" 
		defaults="|||||||" 
		editcol="0|0|0|0|0|0|0|0" 
		widths="0|0|0|0|0|0|0|0" 
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
