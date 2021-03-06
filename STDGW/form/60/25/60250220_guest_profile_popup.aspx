<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Partner</title>
</head>
<%  ESysLib.SetUser("prod")
  
%>

<script>
function BodyInit()
{    
    var data = '';
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'")%>";
	idGrid.SetComboFormat(2, data);//gender

	//data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='CITY'")%>";
	//idGrid.SetComboFormat(9, data);//city
	
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'")%>";
	idGrid.SetComboFormat(3, data);//nation
	txtCustomer.text = '<%=Request.QueryString("p_guest_name") %>';
	dso_htbk00010_bus.Call("SELECT");
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
	var path = System.RootURL + "/form/ht/fo/htfo00720.aspx?";
	var object = System.OpenModal( path ,1000 , 700 ,  'resizable:yes;status:yes');
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
		<dso id="1" type="grid" function="CRM.sp_sel_htfo00720_popup" > 
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
            <td style="width: 25%" align="right">
                Full Name/Passport/Phone:
            </td>
            <td style="width: 40%">
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
                <gw:grid id="idGrid" header="_pk|Full Name|Gender|Nationality|Passport|Birthday|Phone|Email|Description|Last Checkin|Last Checkout|Last Group Name" 
					format="0|0|0|0|0|4|0|0|0|4|4|0" 
					aligns="0|0|0|0|0|0|0|0|0|0|0|0" 
					defaults="|||||||||||||||||||||" 
					editcol="1|1|1|1|1|1|1|1|1|0|0|0" 
					widths="0|0|0|0|0|4|0|0|0|0|0|0" 
					debug='false'
                    styles="width:100%; height:100%" autosize="T" sorting="T" param="0,1,2,3,4,5,6,7,8,9,10,11"
                    oncelldblclick="OnSelect()" />
            </td>
        </tr>
        <!------------------------------------------------------------------------>
    </table>
</body>
</html>
