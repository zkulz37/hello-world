<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Member Fee</title>
     <%  ESysLib.SetUser("crm")%>

<script>
var COL_PK				= 0,
	COL_MEMBER_TYPE		= 1,
	COL_FEE_TYPE		= 2,
	COL_FEE_AMT			= 3,
	COL_FEE_AMT_USD		= 4,
	COL_DISCOUNT_AMT	= 5,
	COL_FINAL_FEE_AMT	= 6,
	COL_VALID_FROM		= 7,
	COL_VALID_TO		= 8,
	COL_ACTIVE			= 9,
	COL_DES				= 10,
	COL_TGM_FEE_TYPE_PK = 11;

function BodyInit()
{
	Binding();
	OnSearch();	
}

function Binding()
{
	var data = '';

	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT PK, ID || '-' || NAME FROM TCM_MEMBER_TYPE WHERE DEL_IF = 0")%>";
	grdData.SetComboFormat( 1 , data );
	txtMemberType.focus();
}

function OnSearch()
{
	dsoGrdData.Call('SELECT');
}

function OnSave()
{
	if(CheckData())
	{
	    dsoGrdData.Call();
	}
}

function CheckData()
{
	for(row = 1; row < grdData.rows; row++)
	{
		if(grdData.GetGridData(row, COL_MEMBER_TYPE) == '')
		{
			alert('Please, input column Member Type.');
			return false;
		}
	}
	return true;
}

function OnNew()
{
	var path   = System.RootURL + "/form/ja/ms/jams0030_1.aspx";
	var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	var tempobject;

	if ( object != null )
	{
		for(i = 0; i < object.length; i++)
		{
			tempboject = object[i];
			grdData.AddRow();
			grdData.SetGridText(grdData.rows-1, COL_FEE_TYPE, tempboject[2]);
			grdData.SetGridText(grdData.rows-1, COL_FEE_AMT, '0');
			grdData.SetGridText(grdData.rows-1, COL_FEE_AMT_USD, '0');
			grdData.SetGridText(grdData.rows-1, COL_DISCOUNT_AMT, '0');
			grdData.SetGridText(grdData.rows-1, COL_FINAL_FEE_AMT, '0');
			grdData.SetGridText(grdData.rows-1, COL_VALID_FROM, '');
			grdData.SetGridText(grdData.rows-1, COL_VALID_TO, '');
			grdData.SetGridText(grdData.rows-1, COL_ACTIVE, '-1');
			grdData.SetGridText(grdData.rows-1, COL_TGM_FEE_TYPE_PK, tempboject[0]);
		}		
	}
}

function OnDelete()
{
	if(grdData.rows > 0)
	{
		if (confirm('Are you sure delete data ?'))
		{
			grdData.DeleteRow();
			dsoGrdData.Call();
		}
	}
}

function OnUnDelete()
{
	if(grdData.rows > 1)
	{
		grdData.UnDeleteRow();
	}
}

function OnDataReceive()
{
	lblRecords.text = grdData.rows - 1 + ' record(s)';
	txtMemberType.focus();
}

function AfterEdit()
{
	switch(event.col)
	{
		case COL_FEE_AMT:
		case COL_FEE_AMT_USD:
		case COL_DISCOUNT_AMT:
		case COL_FINAL_FEE_AMT:
			if (isNaN(grdData.GetGridData(grdData.row, event.col)))
			{
				grdData.SetGridText(grdData.row, event.col, '0');
			}
			else
			{
				if (Number(grdData.GetGridData(grdData.row, event.col)) < 0)
				{
					//grdData.SetGridText(grdData.row, event.col, '0');
				}
			}
		break;

		case COL_VALID_FROM:
			valid_form = grdData.GetGridData(grdData.row, COL_VALID_FROM);
			valid_to   = grdData.GetGridData(grdData.row, COL_VALID_TO);

			if (valid_to - valid_form < 0)
			{
				alert('Invalid date.');
				grdData.SetGridText(grdData.row, event.col, grdData.GetGridData(grdData.row, COL_VALID_TO));
			}
		break;
		
		case COL_VALID_TO:
			valid_form = grdData.GetGridData(grdData.row, COL_VALID_FROM);
			valid_to   = grdData.GetGridData(grdData.row, COL_VALID_TO);

			if (valid_to - valid_form < 0)
			{
				alert('Invalid date.');
				grdData.SetGridText(grdData.row, event.col, '');
			}
		break;
	}
}
</script>

</head>
<body>
 <gw:data id="dsoGrdData" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="crm.sp_sel_jams0030" procedure="crm.sp_upd_jams0030">  
			<input bind="grdData" >  
				<input bind="txtMemberType" /> 															
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
					<td style="width: 15%" align="right" >Member Type</td>
					<td style="width: 15%" >
						<gw:textbox id="txtMemberType" styles="width: 100%" onenterkey="OnSearch()" />
					</td>
					<td style="width: 3%">
						<gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
					</td>
					<td style="width: 20%" align="left">
						<gw:label id="lblRecords" styles="color:blue">record(s)</gw:label>
					</td>
					<td align="right" style="width: 47%" >
						<table style="width: 100%; height: 100%">
							<tr>
								<td style="width: 88%"></td>								
								<td style="width: 3%">
									<gw:imgbtn img="new" alt="New" onclick="OnNew()" />
								</td>
								<td style="width: 3%">
									<gw:imgbtn img="delete" alt="Delete" onclick="OnDelete()" />
								</td>
								<td style="width: 3%">
									<gw:imgbtn img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
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
				header="_pk|Member Type|Fee Name|_Fee AMT|Fee AMT(USD)|Discount AMT|Final Fee AMT|Valid From|Valid To|Active|Description|_tgm_fee_type_pk"
				format="0|0|0|-0|1|1|1|4|4|3|0|0"
				aligns="0|0|0|3|3|3|3|1|1|0|0|0" 
				check="|||0|0-|-|-|0|0|||"
				defaults="|||||||||||" 
				editcol="0|1|0|1|1|1|1|1|1|1|1|0" 
				widths="0||1500|1500|2000|1200|3000|1000|1000|1000|0|0|0"
				sorting='T'
				autosize='T'
				onafteredit='AfterEdit()'
				styles="width:100%; height:100%" />
		</td>
	</tr>
</table>
</body>
</html>
