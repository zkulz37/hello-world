<!-- #include file="../../../system/lib/form.inc"  -->
 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
  
<script>
function BodyInit()
{   
    BindingDataList();
	onSearch();
}

function BindingDataList()
{
   
}

function onSearch()
{
    idData_Dsql_tco_company.Call('SELECT');
}

function OnClickGrid()
{
    var r_data = new Array()
    
	if(grdParent.row > 0 )
	{
	    for ( var i=0; i < grdParent.cols; i++)
	    {	        
	        r_data[i] = grdParent.GetGridData( grdParent.row , i );	        
	    }
	}
	window.returnValue = r_data; 
	this.close();
}
</script>

<html>
<head runat="server">
    <title>Parent Comm</title>
</head>
<body>

<gw:data id="idData_Dsql_tco_company" >
    <xml> 
        <dso id="1" type="grid" function="gasp.sp_get_tco_company" > 
            <input bind="grdParent" >
                <input bind="txtClient" />
            </input>
            <output bind="grdParent" />
        </dso>
    </xml>
</gw:data>
                   
<table width="100%" >
    <tr>
        <td width="100%">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" >
                <tr>
                    <td width="5%"><b>Client</b></td>
                    <td width="20%"><gw:textbox id="txtClient" style="width:80%" text="" /></td>
                    <td width="8%"><b>Client Style</b></td>
                    <td width="20%"><gw:list id="lstClientStyle" style="width:80%" value="%" ></gw:list></td>                    
                    
                    <td width="3%"><gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="onSearch()" /></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="background: #BDE9FF" >
        <div style="width:100%; height:260; overflow:auto;">
                <gw:grid 
                id="grdParent"
                header="Customer ID|Customer Name|Address|_PK"
                format="0|0|0|0"
                aligns="0|0|0|0"
                defaults="|||"
                editcol="0|0|0|0"
                autosize="true" 
                styles="width:100%; height:100%"
                sorting="T" 
                oncelldblclick="OnClickGrid()"
                 />
          </div>       
        </td>
    </tr>
</table>
</body>
</html>
