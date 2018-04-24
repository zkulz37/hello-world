<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>House ID Registry</title>
  </head>
  
 <%ESysLib.SetUser("crm")%>
 
 <script>

function BodyInit()
{
	chkUseYN.value = 'T';
	OnSearch();
}

function OnSearch()
{
	dso_reab00010_house.Call('SELECT');
}

function OnDataReceive()
{
	lblRecord.text = grdData.rows - 1 + " record(s)";
}

function OnGridCellDoubleClick()
{
	if(event.row > 0 )
	{
		var col_val = grdData.GetGridData(event.row, 0);

		if(event.row > 0 && ( !CheckDataExist(grdData1, col_val)) )
		{
			SetRowBackGroundColor(grdData, col_val, 0x0000FF);
			grdData1.AddRow();
			for(var i = 0; i < grdData.cols; i++)
			{
				grdData1.SetGridText(grdData1.rows-1, i, grdData.GetGridData(event.row,i));
			}
		}
	}
	lblCount.text = grdData1.rows-1 + " record(s).";
}

function CheckDataExist(p_oGrid, p_value)
{
	for(var i=1;i<p_oGrid.rows;i++)
	{
		if(p_oGrid.GetGridData(i, 0) == p_value)
		{
			return true;
		}
	}
	return false;
}

function SetRowBackGroundColor(p_oGrid, p_col_val, p_color)
{

   for(var i=1;i<p_oGrid.rows;i++)
   {
      if(p_oGrid.GetGridData( i, 0) == p_col_val)
      {
         p_oGrid.SetCellFontColor(i,0,i,p_oGrid.cols-1,p_color);
         return;
      }
   }
}

function OnRemove()
{
	if(grdData1.row > 0)
	{
		var col_val = grdData1.GetGridData(grdData1.row, 0);

		grdData1.RemoveRowAt(grdData1.row);

		SetRowBackGroundColor(grdData, col_val, 0x000000); 

		lblCount.text = grdData1.rows-1 + " record(s).";
	}
}

function OnSelect(oGrid)
{
	var arr_data = new Array();
   
	if(oGrid.rows > 1)
	{   
		for(var i=1;i<oGrid.rows;i++)
		{
			var arrTemp=new Array();

			for(var j=0;j<oGrid.cols;j++)
			{
				arrTemp[arrTemp.length]= oGrid.GetGridData(i,j);
			}

			arr_data[arr_data.length]= arrTemp;
		}

		if ( arr_data !=null )
		{
			window.returnValue =  arr_data;
			window.close();
		}
		else
			alert("You have not selected data yet.");
	}
}
</script>

<body>
<gw:data id="dso_reab00010_house"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso id="1" type="grid" parameter="" function="CRM.SP_SEL_reab00010_house" procedure="" > 
			<input bind="grdData"   > 
				<input bind="txtBuilding" /> 
				<input bind="txtArea" /> 
				<input bind="txtFloor" /> 
				<input bind="txtType" /> 
				<input bind="txtHouseID" /> 
				<input bind="chkUseYN" /> 
			</input> 
			<output bind="grdData" /> 
		</dso> 
	</xml> 
</gw:data> 
<table  width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" >
	<tr width="100%" height="1%" >
		<td width="10%" align='center' nowrap>Building</td>
		<td width="15%">
			<gw:textbox id="txtBuilding" text="" styles='width:100%'	onenterkey ="OnSearch()"/>
		</td>
		<td width="10%" align='center' nowrap>Area</td>
		<td width="15%">
			<gw:textbox id="txtArea" text="" styles='width:100%'	onenterkey ="OnSearch()"/>
		</td>		
		<td width="10%" align='center' nowrap>Floor</td>
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
	</tr>
	<tr>
		<td width="10%" align='center' nowrap>Type</td>
		<td width="15%">
			<gw:textbox id="txtType" text="" styles='width:100%'	onenterkey ="OnSearch()"/>
		</td>
		<td width="10%" align='center' nowrap>House ID</td>
		<td width="15%">
			<gw:textbox id="txtHouseID" text="" styles='width:100%'	onenterkey="OnSearch()"/>
		</td>
		<td colspan='7' width="50%">
		</td>
	</tr>
	<tr width="100%">
		<td colspan='11' width="100%" height="50%" >
			<gw:grid   
				id="grdData"  
					header="_pk|Building|Area|Floor|House No|Type|Use YN|Description"
					format="0|0|0|0|0|0|3|0"
					aligns="0|0|0|0|0|0|0|0"
					defaults="||||||-1|"
					editcol="0|1|1|1|1|1|1|1"
					widths="0|0|0|0|0|0|0|0"
					check="|||||||"
					styles="width:100%; height:100%"   
					sorting="T"   
					autosize="true"
					oncelldblclick="OnGridCellDoubleClick(this)"/> 
		</td>
	</tr>
	<tr>
		<td colspan='17' width="100%" height="1%" >
                <table>
                    <tr>
                        <td style="width: 96%" align="right">
                            <gw:label id="lblCount" styles='width:100%;color:blue;font:9pt' />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(grdData1)" />
                        </td>
                    </tr>
                </table>
            </td>
	</tr>
	<tr width="100%" height="99%" >
		<td colspan='11' width="100%" height="49%" >
			<gw:grid   
				id="grdData1"  
					header="_pk|Building|Area|Floor|House No|Type|Use YN|Description"
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
