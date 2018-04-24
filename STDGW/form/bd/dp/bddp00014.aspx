<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Get Item</title>
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
    var data="";
    data = "<%=ESysLib.SetListDataSQL("select pk, grp_nm from comm.tco_itemgrp where del_if = 0 and use_yn='Y' and leaf_yn = 'Y' ")%>|%|Select all"; 
    lstGroup.SetDataText(data);    
}

function OnSearch()
{
    idData_dsql_tco_item.Call();
}

function OnSelect()
{
    var aRows = new Array();
        
    for ( var i=1; i<grdItem.rows;i++ )
    {
        if (grdItem.GetGridData(i, 6) == -1)
        {
            var aCols = new Array();
            for ( var j=0; j<grdItem.cols;j++)
            {
               
                aCols[aCols.length] = grdItem.GetGridData(i, j);                
            }
            aRows[aRows.length] = aCols;
        }
    }
    
    if (aRows.length == 0)
    {
        alert("You have not selected data yet. ");
		return;
    }   
    
    window.returnValue = aRows;
    window.close();
}

function OnRece()
{
    lbRecord.text = grdItem.rows-1 + " record(s)";
}
</script>
<body>
<gw:data id="idData_dsql_tco_item"  onreceive="OnRece()" > 
    <xml> 
       <dso id="1" type="grid" user="comm" function="comm.sp_sel_tco_item" >
            <input  bind="grdItem">
                <input bind="lstGroup" />
                <input bind="txtItemCode" />
            </input> 
            <output bind="grdItem" /> 
        </dso> 
    </xml> 
</gw:data> 

<table width="100%" border="0">
    <tr>
        <td width="10%"><b>&nbsp; &nbsp;Group</b></td>
        <td width="29%"><gw:list id="lstGroup" value="%" styles="width: 100%" /></td>
        <td width="15%"><b>&nbsp; Item Code</b></td>
        <td width="25%"><gw:textbox id="txtItemCode" styles="width: 90%"/></td>
        <td width="15%"><b><gw:label id="lbRecord" styles="color: blue"></gw:label></b></td>
        <td width="3%"><gw:imgBtn  img="search" alt="Search" onclick ="OnSearch()"/></td>
        <td width="3%"><gw:imgBtn  img="select" alt="Select" onclick ="OnSelect()"/></td>        
    </tr>
    <tr>
        <td colspan="7">
             <gw:grid
                id="grdItem"
                header="_PK|_Group|Item Code|Item Name|UOM|Stock Qty|Check"
                format="0|0|0|0|0|1|3"
                aligns="0|0|0|0|1|0|2"
                defaults="||||||"
                editcol="0|0|0|0|0|0|0"
                widths="0|0|2000|3500|800|1000|500"
                styles="width:100%; height:300"
                sorting="T"                
                param="0,1,2,3,4,5,6"/>
        </td>
    </tr>
</table>
</body>
</html>
