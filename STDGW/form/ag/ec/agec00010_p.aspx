<!-- #include file="../../../system/lib/form.inc"  -->
 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
  
  <%ESysLib.SetUser("comm")%>
  
<script>
function BodyInit()
{   
    BindingDataList();
}

function BindingDataList()
{
    System.Translate(document); 
   var data = "";
   
   data = "Data|%|Select All|00|Customer|05|Supplier|10|Company"
   lstClientStyle.SetDataText(data);  
}

function onSearch()
{
    idData_Dsql_tco_company.Call('SELECT');
}

function OnClickGrid()
{
    var r_data = new Array()
	var ctrl = grdParent.GetGridControl();    
    
	if(ctrl.row > 0 )
	{
	    for ( var i=0; i<=grdParent.col; i++)
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
        <dso id="1" type="grid" function="comm.sp_get_tco_company" > 
            <input bind="grdParent" >
                <input bind="txtClient" />
                <input bind="lstClientStyle" />
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
                <gw:grid 
                id="grdParent"
                header="_PK|Parent ID|Parent Name|Address"
                format="0|0|0|0"
                aligns="0|0|0|0"
                defaults="|||"
                editcol="0|0|0|0"
                widths="0|2000|2000|1500"
                styles="width:100%; height:220"
                sorting="T"
                oncelldblclick="OnClickGrid()"
                 />
        </td>
    </tr>
</table>
</body>
</html>
