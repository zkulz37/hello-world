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
	txtName.focus();
	var data="";
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'" )%>"; 
	grdData.SetComboFormat(3,data);//gender
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'" ) %> "; 
	grdData.SetComboFormat(5,data);//nationality
}

function OnNew()
{
	grdData.AddRow();
	for(row = 1; row < grdData.rows; row++)
	{
		if(grdData.GetGridData(row, 1) == '')
		{
	        grdData.SetGridText(row, 1, grdData.rows-1);
	    }
	}
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
	txtName.focus();
}

function OnPrint()
{
	var url = '/reports/ja/st/jast00070.aspx?p_name='+txtName.GetData();
	System.OpenTargetPage( System.RootURL+url , "newform" );
}
</script>

</head>
<body>
 <gw:data id="dsoGrdData" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="CRM.sp_sel_jast00070" procedure="CRM.sp_upd_jast00070">  
			<input bind="grdData" >  
				<input bind="txtName" /> 															
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
					<td style="width: 15%" align="right" >Name</td>
					<td style="width: 15%" >
						<gw:textbox id="txtName" styles="width: 100%" onenterkey="OnSearch()" />
					</td>
					<td style="width: 3%">
						<gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
					</td>
					<td align="right" style="width: 67%" >
						<table style="width: 100%; height: 100%">
							<tr>
								<td style="width: 88%">
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
								<td style="width: 3%"><gw:imgBtn id="ibtnPrint" img="printer" alt="Print" onclick="OnPrint()" /></td>
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
				header="_PK|No|Golfer Name| Gender|Birthday|Nationality| Mobile Phone| Telephone| Home  Address| Company Name|Company Address| Company Phone|Hobby| Description| Tax Code"
				format="0|0|0|0|4|0|0|0|0|0|0|0|0|0|0"
				aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
				check="||0|0||0|||||||||"
				defaults="||||||||||||||" 
				editcol="0|0|1|1|1|1|1|1|1|1|1|1|1" 
				widths="0|1000|1500|2000|1200|30000|1500|2000|1200|3000|100|1000"
				sorting='T'
				acceptNullDate="T"
				autosize='T'
				styles="width:100%; height:100%" />
		</td>
	</tr>
</table>
</body>
</html>
