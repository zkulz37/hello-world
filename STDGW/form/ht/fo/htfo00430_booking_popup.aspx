<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Partner</title>
</head>
<%  ESysLib.SetUser("crm")
  
%>

<script>
//-----------------------------------------------------------

function BodyInit()
{    
    //dso_htbk00010_bus.Call("SELECT");
	OnSearch();
}

//-----------------------------------------------------------

function OnSearch()
{
    dso_htbk00010_bus.Call("SELECT");
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
//-----------------------------------------------------------
function OnNew()
{
	var path = System.RootURL + "/form/ag/ic/agic00010.aspx?";
	var object = System.OpenModal( path ,1024 , 768 ,  'resizable:yes;status:yes');
	
	OnSearch();
}
//-----------------------------------------------------------
function OnCancel()
{
    var code_data=new Array()
    
    for( j=0 ; j < idGrid.cols ; j++ )
    {
        code_data[j] = '' ;
    } 
	    
    window.returnValue = code_data; 
    this.close(); 	
}
//-----------------------------------------------------------

</script>

<body>
    <!------------------------------------------------------------------------>
<gw:data id="dso_htbk00010_bus" onreceive=""> 
	<xml> 
		<dso id="1" type="grid" function="CRM.sp_sel_htfo00430_popup" > 
			<input bind="idGrid" > 
				<input bind="dtFrom" /> 
				<input bind="dtTo" /> 
			</input> 
			<output bind="idGrid" /> 
		</dso> 
	</xml> 
</gw:data>
    <!------------------------------------------------------------------------>
    <table style="height: 100%; width: 100%">
        <tr style="height: 1%">
            <td style="width: 20%" align="right">
                Arrive Date
            </td>
            <td style="width: 60%">
                <gw:datebox id="dtFrom" lang="1" onchange="OnSearch()" />
				~
				<gw:datebox id="dtTo" lang="1" onchange="OnSearch()" />
            </td>
            <td style="width: 3%" align="right">
            </td>
            <td style="width: 5%" align="left">
            </td>
            <td style="width: 2%" align="right">
            </td>
            <td style="width: 5%" align="left">
            </td>
            <td style="width: 3%" align="right">
                <gw:imgbtn id="idSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="idSelect" img="select" alt="Select" onclick="OnSelect()" />
            </td>
			<td style="width: 3%" align="right">
                <gw:imgbtn id="idNew" img="new" alt="New Customer" onclick="OnNew()" styles="width:100%; display:none"  />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnCancel" img="cancel" alt="Close" onclick="OnCancel()" styles="width:100%; display:none"  />
            </td>
        </tr>
        <!------------------------------------------------------------------------>
        <tr style="height: 99%">
            <td colspan="10">
                <gw:grid id="idGrid" header="_PK|Arrive Date|Last Name|First Name|RSV#"
                    format="0|0|0|0|0"
                    aligns="0|0|0|0|0"
                    defaults="||||" editcol="0|0|0|0|0"
                    widths="0|1000|3000|4000|0"
                    styles="width:100%; height:100%" autosize="T" sorting="T" 
                    oncelldblclick="OnSelect()" />
            </td>
        </tr>
        <!------------------------------------------------------------------------>
    </table>
</body>
</html>
