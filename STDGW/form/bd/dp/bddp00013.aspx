<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Get Material Consumtion For Order</title>
  </head>

<% ESysLib.SetUser("comm")%>
<script>

function BodyInit()
{
    System.Translate(document); 
}

function onPopup()
{
    
}

</script>
<body>
<%--<gw:data id="idData_dsql_"  onreceive="" > 
    <xml> 
       <dso id="1" type="grid" user="" function="" > 
            <input  bind="">
                <input bind="" />
            </input> 
            <output bind="" /> 
        </dso> 
    </xml> 
</gw:data> --%>

<table width="100%" border="0">
    <tr>
        <td width="15%"><b>&nbsp; &nbsp; Order</b></td>
        <td width="20%"><gw:textbox id="txtProj" style="width: 100%" ></gw:textbox></td>
        <td width="3%"><gw:imgBtn img="popup" alt="" onclick ="onPopup()"/></td>
        <td width="62%"></td>
    </tr>
    <tr>
        <td colspan="4">
             <gw:grid
                id="grdProj"
                header="_PK|Item Code|Item Name|UOM|Customer Name|Order No|Stock Qty|Need Qty|Check|PO Com Qty"
                format="0|0|0|0|0|0|0|0|0|0|0"
                aligns="0|0|0|0|0|0|0|0|0|0|0"
                defaults="||||||||||"
                editcol="0|0|0|0|0|0|0|0|0|0|0"
                widths="0|1500|2500|800|2500|2000|1500|1500|800|0|0"
                styles="width:100%; height:300"
                sorting="T"                            
                param="0,1,2,3,4,5,6,7,8,9,10"/>
        </td>
    </tr>
</table>
</body>
</html>
