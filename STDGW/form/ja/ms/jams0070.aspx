<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Fee Type</title>
     <%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{	
	Binding();
	OnSearch();
}

function Binding()
{
	txtFeeType.focus();
}

function OnNew()
{
	grdData.AddRow();
	grdData.SetGridText(grdData.rows-1, 3, '-1');
}

function OnDelete()
{
	if (grdData.row > 0)
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
	dsoGrdData.Call();
}

function OnSearch()
{
	dsoGrdData.Call('SELECT');
}

function countItem()
{
	lblCount.text = idGrid2.rows-1 + " record(s)."
}

function OnDataReceive()
{
	lblRecords.text = grdData.rows - 1 + ' record(s)';
	txtFeeType.focus();
}

function AfterEdit()
{
	//alert(grdData.GetGridData(1, 7));
}
</script>

</head>
<body>
 <gw:data id="dsoGrdData" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="grid"  parameter="0,1,2,3,4" function="CRM.SP_SEL_JAMS0070" procedure="CRM.SP_UPD_JAMS0070">  
			<input bind="grdData" >  
				<input bind="txtFeeType" /> 															
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data>

<table width="100%" style="height:100%" border="1">
	<tr style="width: 100%; height: 0%">
		<td style="background: white">
			<table style="width: 100%; height: 100%" border="0">
				<tr>
					<td style="width: 15%" align="right" >Fee Code/Name</td>
					<td style="width: 15%" >
						<gw:textbox id="txtFeeType" styles="width: 100%" onenterkey="OnSearch()" />
					</td>
					<td style="width: 3%">
						<gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
					</td>
					<td align="right" style="width: 67%" >
						<table style="width: 100%; height: 100%">
							<tr>
								<td style="width: 91%">
									<gw:label id="lblRecords" styles="color:blue">record(s)</gw:label>
								</td>
								<td style="width: 3%">
									<gw:imgbtn img="new" alt="New" onclick="OnNew()" />
								</td>
								<td style="width: 3%">
									<gw:imgbtn img="delete" alt="Delete" onclick="OnDelete()" />
								</td>
								<td style="width: 3%">
									<gw:imgbtn img="save" alt="Save" onclick="OnSave()" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>	
	<tr style="width:100%; height: 48%">
		<td colspan="9" >
			<gw:grid 
				id="grdData"
				header="_PK|*Fee Code|*Fee Name|Active|Description"
				format="0|0|0|3|0"
				aligns="0|0|0|0|0" 
				check="|0|0|0|"
				defaults="||||" 
				editcol="0|1|1|1|1" 
				widths="0|1500|2000|1200|3000"
				sorting='T'
				autosize='T'
				onafteredit='AfterEdit()'
				styles="width:100%; height:100%" />
		</td>
	</tr>
</table>
</body>
</html>
