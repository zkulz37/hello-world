<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Guest</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>

function BodyInit()
{    
    dso_htbk00010_guest.Call("SELECT");
}

//-----------------------------------------------------------

function OnSearch()
{
    dso_htbk00010_guest.Call("SELECT");
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
	var path = System.RootURL + "/form/ht/bk/htbk00010_new_guest.aspx?";
	var object = System.OpenModal( path , 800 , 600 ,  'resizable:yes;status:yes');
	
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
<gw:data id="dso_htbk00010_guest" onreceive=""> 
	<xml> 
		<dso id="1" type="grid" function="CRM.SP_SEL_HTBK00010_GUEST" > 
			<input bind="idGrid" >
				<input bind="txtCustomer" /> 
			</input> 
			<output bind="idGrid" /> 
		</dso> 
	</xml> 
</gw:data>
    <!------------------------------------------------------------------------>
    <table style="height: 100%; width: 100%">
        <tr style="height: 1%">
            <td style="width: 5%" align="right">
                Customer
            </td>
            <td style="width: 60%">
                <gw:textbox id="txtCustomer" styles="width:100%" csstype="mandatory" onenterkey="OnSearch()" />
            </td>
            <td style="width: 10%" align="right">
            </td>
            <td style="width: 5%" align="left">
            </td>
            <td style="width: 10%" align="right">
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
                <gw:imgbtn id="idNew" img="new" alt="New Customer" onclick="OnNew()" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnCancel" img="cancel" alt="Close" onclick="OnCancel()" />
            </td>
        </tr>
        <!------------------------------------------------------------------------>
        <tr style="height: 99%">
            <td colspan="10">
                <gw:grid id="idGrid" header="_PK|Full Name|Gender|Address|Birthday|Company|Phone|Fax|Professional|Zip Code|Language|Country|Agent|City|Passport|Nationality|Visa|Exp ate|Credit_card|Entry Date|Deposit|Tax Code|Description|Email"
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    defaults="|||||||||||||||||||||||"
				   editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    styles="width:100%; height:100%" sorting="T" 
					autosize='T'
                    oncelldblclick="OnSelect()" />
            </td>
        </tr>
        <!------------------------------------------------------------------------>
    </table>
</body>
</html>
