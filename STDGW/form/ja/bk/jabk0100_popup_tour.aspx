<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Partner</title>
</head>
<%  ESysLib.SetUser("crm")
  
%>

<script>



function BodyInit()
{	
    data_jabk0100.Call("SELECT");
}

//-----------------------------------------------------------

function OnSearch()
{
    data_jabk0100.Call("SELECT");
}

//-----------------------------------------------------------
function OnSelect_Btn()
{
	var code_data=new Array()
	var ctrl = idGrid.GetGridControl();
	var index, rowNo
	
	index =0;
	rowNo = 0 ;
	
	if ( ctrl.SelectedRows == 0 )
	{
		   return ;
	}
	else
	{
		for(i=0; i < ctrl.SelectedRows; i++)
		{	  
				rowNo = ctrl.SelectedRow(i)
				for(j=0; j < idGrid.cols -1; j++)
				{
					code_data[index] = idGrid.GetGridData(rowNo , j );
					index ++;
				}        
		}
	}
	window.returnValue = code_data; 
	this.close(); 
}
/*function OnSelect()
{
	if(idGrid.col=='2')
	{
		var path = System.RootURL + "/form/ja/bk/jabk0100_get_tour_popup.aspx?";
			var object = System.OpenModal( path ,550 , 550 ,  'resizable:yes;status:yes');
			if ( object != null )
			{
				//alert(object[1]);
				idGrid.SetGridText(idGrid.row,2,object[1]);
			}
			return;
	}
	var code_data=new Array()
	var ctrl = idGrid.GetGridControl();
	var index, rowNo
	
	index =0;
	rowNo = 0 ;
	
	if ( ctrl.SelectedRows == 0 )
	{
		   return ;
	}
	else
	{
		for(i=0; i < ctrl.SelectedRows; i++)
		{	  
				rowNo = ctrl.SelectedRow(i)
				for(j=0; j < idGrid.cols -1; j++)
				{
					code_data[index] = idGrid.GetGridData(rowNo , j );
					index ++;
				}        
		}
	}
	window.returnValue = code_data; 
	this.close(); 
}*/
function OnNew()
{
	idGrid.AddRow();
}
function OnSave()
{
	if(CheckValidate())
	{
		data_jabk0100.Call();
	}
}
function CheckValidate()
{
	for ( var i=1; i<idGrid.rows;i++)
		{
			if ( idGrid.GetGridData( i, 2) == "" )
			{
				alert("Please,input tour name row at "+i);
				return false;
			}    
			
		}
		return true;
}
//-----------------------------------------------------------
function OnDelete()
{
	if(confirm("Are you sure to delete ?"))
			   {
					idGrid.DeleteRow();
					data_jabk0100.Call();			
			   }
}
function OnDataReceive(obj)
{
	if(obj.id=='data_jabk0100')
	{
		
	}
}
//-----------------------------------------------------------

</script>

<body>
    <!------------------------------------------------------------------------>
    <gw:data id="data_jabk0100" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="1" type="grid" parameter="0,1,2" function="CRM.sp_sel_jabk0100_popup" procedure="crm.sp_upd_jabk0100_popup" > 
                  <input bind="idGrid" > 
                    <input bind="dtFrom" /> 
					<input bind="dtTo" /> 
					<input bind="txtTourName" /> 
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------>
    <table style="height: 100%; width: 100%">
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
                Date
            </td>
            <td style="width: 20%">
                <gw:datebox id="dtFrom" lang="1" onchange="OnSearch()" />
                ~<gw:datebox id="dtTo" lang="1" onchange="OnSearch()" />
            </td>
			<td style="width: 10%" align="right">
                Tour name
            </td>
			<td style="width: 24%">
                <gw:textbox id="txtTourName" styles="width:100%" csstype="mandatory" onenterkey="OnSearch()" />
            </td>
            <td style="width: 3%" align="right">
                <gw:imgbtn id="idSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
             <td width="3%"><gw:imgbtn id="btnNewMST" img="new" alt="New" onclick="OnNew()" /></td>
            <td style="width: 1%" align="right">
               <gw:imgbtn id="btnDelete1" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />
            </td>
			 <td style="width:3%">
				<gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave()" />
			</td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="idSelect" img="select" alt="Select" onclick="OnSelect_Btn()" />
            </td>
        </tr>
        <!------------------------------------------------------------------------>
        <tr style="height: 99%">
            <td colspan="11">
                <gw:grid id="idGrid" header="_pk|Tour Date|Tour Name"
                    format="0|4|0"
                    aligns="0|0|0"
                    defaults="||" 
					editcol="1|1|1"
                    widths="0|1200|3000"
                    styles="width:100%; height:100%" autosize="T" sorting="T" 
                    oncelldblclick="OnSelect_Btn()" />
            </td>
        </tr>
        <!------------------------------------------------------------------------>
    </table>
</body>
</html>
