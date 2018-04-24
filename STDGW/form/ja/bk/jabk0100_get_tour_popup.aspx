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

function OnSelect()
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
           <dso id="1" type="grid"  function="CRM.sp_sel_jabk0100_get_tourname"  > 
                  <input bind="idGrid" > 
					<input bind="txtTourName" /> 
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------>
    <table style="height: 100%; width: 100%">
        <tr style="height: 1%">
            <td style="width: 15%" align="right">
                Tour name
            </td>
            <td style="width: 50%">
               <gw:textbox id="txtTourName" styles="width:100%" csstype="mandatory" onenterkey="OnSearch()" />
            </td>
			
			<td style="width: 29%">
                
            </td>
			 <td style="width:3%">
				<gw:imgbtn id="idSearch" img="search" alt="Search" onclick="OnSearch()" />
			</td>
            <td style="width: 3%" align="right">
                <gw:imgbtn id="idSelect" img="select" alt="Select" onclick="OnSelect()" />
            </td>
        </tr>
        <!------------------------------------------------------------------------>
        <tr style="height: 99%">
            <td colspan="5">
                <gw:grid id="idGrid" header="_pk|Tour Name"
                    format="0|0"
                    aligns="0|0"
                    defaults="|" 
					editcol="1|1"
                    widths="0|3000"
                    styles="width:100%; height:100%" autosize="T" sorting="T" 
                    oncelldblclick="OnSelect()" />
            </td>
        </tr>
        <!------------------------------------------------------------------------>
    </table>
</body>
</html>
