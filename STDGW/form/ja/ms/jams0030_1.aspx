<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Member Fee Popup</title>
     <%  ESysLib.SetUser("crm")%>

<script>
function BodyInit()
{
	OnSearch();
	Binding();
}

function Binding()
{
	txtFeeType.focus();
}

function OnSearch()
{
	dsoGrdData.Call('SELECT');
}

function OnDBClick(oGrid)
{	
	if(oGrid.id == "grdData" && event.row > 0 )
	{
		var col_val = oGrid.GetGridData(event.row, 0 );
		
		if (!CheckDataExist(idGrid2,col_val))
		{
			SetRowBackGroundColor(oGrid, col_val, 0x0000FF);
			idGrid2.AddRow();

			for(var i=0;i<oGrid.cols;i++)
			{
				idGrid2.SetGridText(idGrid2.rows-1,i,oGrid.GetGridData(event.row,i));
			}
		}

		countItem();
	}
}

function countItem()
{
	lblCount.text = idGrid2.rows-1 + " record(s)."
}

function CheckDataExist(p_oGrid,p_value)
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
	if(idGrid2.row > 0)
	{
		var col_val = idGrid2.GetGridData(idGrid2.row, 0);
		idGrid2.RemoveRowAt(idGrid2.row);
		SetRowBackGroundColor(grdData,col_val,0x000000); 
		countItem();
	}
}

function OnDataReceive()
{
	lblRecords.text = grdData.rows - 1 + ' record(s)';
	txtFeeType.focus();
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
      
	  if ( arr_data != null )
	  {
		window.returnValue =  arr_data;
		window.close();
	  }
	  else
	  {
	    alert("You have not selected data yet.");
	  }
   }  
}
</script>

</head>
<body>
 <gw:data id="dsoGrdData" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="grid" function="crm.sp_sel_jams0030_1" >  
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
					<td style="width: 15%" align="right" >Fee Code/Type</td>
					<td style="width: 15%" >
						<gw:textbox id="txtFeeType" styles="width: 100%" onenterkey="OnSearch()" />
					</td>
					<td style="width: 3%">
						<gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
					</td>
					<td style="width: 67%" align="right" >
						<gw:label id="lblRecords" styles="color:blue">record(s)</gw:label>
					</td>
				</tr>
			</table>
		</td>
	</tr>	
	<tr style="width:100%; height: 48%">
		<td colspan="9" >
			<gw:grid 
				id="grdData"
				header="_PK|Fee Code|Fee Name|Active|Description"
				format="0|0|0|3|0"
				aligns="0|0|0|0|0" 
				check="|0|0|0|"
				defaults="||||" 
				editcol="0|1|1|1|1" 
				widths="0|1500|2000|1200|3000"
				sorting='T'
				autosize='T'
				oncelldblclick ="OnDBClick(this)" 
				styles="width:100%; height:100%" />
		</td>
	</tr>
	<tr style="height: 1%">
		<td style="width:100%; height: 1%">
			<table>
				<tr>
					<td style="width: 97%" align="left">
						<gw:label id="lblCount" styles='width:100%;color:blue;font:9pt' />
					</td>
					<td style="width: 1%">
						<gw:imgbtn id="ibtnRemove" img="cancel" alt="Remove" onclick="OnRemove()" />
					</td>
					<td style="width: 1%">
						<gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid2)" />
					</td>
				</tr>
			</table>
		</td>
    </tr> 
	<tr style="width:100%; height: 48%">
		<td>
			<gw:grid 
				id="idGrid2"
				header="_PK|Fee Code|Fee Name|Active|Description"
				format="0|0|0|3|0"
				aligns="0|0|0|0|0" 
				check="|0|0|0|"
				defaults="||||" 
				editcol="0|1|1|1|1" 
				widths="0|1500|2000|1200|3000"
				sorting='T'
				autosize='T'
				styles="width:100%; height:100%" />
		</td>
	</tr>
</table>

</body>
</html>
