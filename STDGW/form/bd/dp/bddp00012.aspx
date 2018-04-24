<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Project</title>
  </head>

<%  ESysLib.SetUser("acnt")%>
<script>

function BodyInit()
{
    System.Translate(document); 
}

function onSearch()
{
    idData_dsql_tac_abpl.Call();
}

function OnDBClick()
{
    var data = new Array();
    
    for ( var i=0; i<grdProj.cols-1; i++)
    {
        data[i] = grdProj.GetGridData(grdProj.row, i);
    }
    
    window.returnValue = data;
    window.close();
}
</script>
<body>
<gw:data id="idData_dsql_tac_abpl"  onreceive="" > 
    <xml> 
       <dso id="1" type="grid" user="acnt" function="acnt.sp_sel_tac_abpl" > 
            <input  bind="grdProj">
                <input bind="txtProj" />
            </input> 
            <output bind="grdProj" /> 
        </dso> 
    </xml> 
</gw:data> 

<table width="100%" border="0">
    <tr>
        <td width="15%"><b>&nbsp; Project</b></td>
        <td width="20%"><gw:textbox id="txtProj" style="width: 100%" ></gw:textbox></td>
        <td width="3%"><gw:imgBtn img="search" alt="Search" onclick ="onSearch()"/></td>
        <td width="62%"></td>
    </tr>
    <tr>
        <td colspan="4">
             <gw:grid
                id="grdProj"
                header="_PK|Project Code|Project Name"
                format="0|0|0"
                aligns="1|0|0"
                defaults="||"
                editcol="0|0|0"
                widths="0|2500|0"
                styles="width:100%; height:300"
                sorting="T"
                oncelldblclick="OnDBClick()"
                param="0,1,2"/>
        </td>
    </tr>
</table>
</body>
</html>
