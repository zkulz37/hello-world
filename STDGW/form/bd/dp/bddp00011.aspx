<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Employee</title>
  </head>

<% ESysLib.SetUser("comm")%>

<script>
function BodyInit()
{
    System.Translate(document); 
    BindingDataList();
}
 
function BindingDataList()
{   
    var data = "";    
    
    data = "<%=ESysLib.SetListDataSQL("select pk, dept_nm from tco_dept where del_if = 0")%>";     
    lstDep.SetDataText(data);
    
    data ="DATA|1|ID|2|NAME";
    lstEmp.SetDataText(data);
}

function onSearch()
{
    idData_dsql_thr_employee.Call();
}

function OnDBClick()
{
    var a = new Array();
    for (var i=0; i < grdEmp.cols-1; i++)
    {
        a[i] = grdEmp.GetGridData(grdEmp.row, i);        
    }
    window.returnValue = a;
    window.close();
}
</script>
<body>
<gw:data id="idData_dsql_thr_employee"  onreceive="" > 
    <xml> 
       <dso id="1" type="grid" user="hr" function="hr.sp_sel_thr_employee" > 
            <input  bind="grdEmp">
                <input bind="lstDep" />
                <input bind="lstEmp" />
                <input bind="txtEmp" />
            </input> 
            <output bind="grdEmp" /> 
        </dso> 
    </xml> 
</gw:data> 

<table width="100%" border="0">
    <tr>
        <td width="20%"><b>&nbsp; Department</b></td>
        <td width="20%"><gw:list id="lstDep" style="width: 100%" ></gw:list></td>
        <td width="7%"></td>
        <td width="20%"><b>&nbsp; &nbsp; &nbsp;Employee</b></td>
        <td width="10%"><gw:list id="lstEmp" style="width: 100%" ></gw:list></td>
        <td width="20%"><gw:textbox id="txtEmp" style="width: 100%" onenterkey="onSearch()" ></gw:textbox></td>
        <td width="3%"><gw:imgBtn img="search" alt="Search" onclick ="onSearch()"/></td>        
    </tr>
    <tr>
        <td colspan="7">
             <gw:grid
                id="grdEmp"
                header="_PK|ID|NAME"
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
