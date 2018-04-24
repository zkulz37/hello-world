<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
   <%ESysLib.SetUser("comm")%>
   <% ESysLib.SetUser("inv")%>  
  <head>
    <title>Monthly Material Report Pop Up</title>
  </head>
 <script>
 //---------------------------------------------------------
var tmp_Item_PK = '<%= Request("Item_pk") %>';
 function BodyInit()
 { 
     dtbFrom.text = '<%= Request("dtbFrom") %>';
   dtbTo.text = '<%= Request("dtbTo") %>';
   cboWarehouse.text = '<%= Request("cboWarehouse") %>';
   txtItemGroup_PK.text = '<%= Request("ItemGroup_PK") %>';
   txtItem.text = '<%= Request("Item_PK") %>';
   cboTransType.text = '<%= Request("cboTransType") %>';
   datMonthlyMaterial.Call('SELECT'); 
 }
 //---------------------------------------------------------
 </script>

<body>


 <gw:data id="datMonthlyMaterial" >
    <xml> 
        <dso id="1" type="grid" function="inv.sp_sel_in_out_month_matd" > 
            <input bind="grdMonthlyMaterial" >
                <input bind="dtbFrom" />
				<input bind="dtbTo" />
                <input bind="cboWarehouse" />
               <input bind="txtItemGroup_PK" />
               <input bind="txtItem" />
               <input bind="cboTransType" />
            </input>
            <output bind="grdMonthlyMaterial" />
        </dso>
    </xml>
</gw:data>
  
  <table border="0" width="100%"  style="background: #BDE9FF">
   <tr>
    <td>
   <gw:grid id='grdMaterialDetail'
        header='Date|Slip No|Client/Line/Project|Incoming|Out to Line|Line Return|Adjust|Other In|Other Out|Current|Warehouse|_PK|_ST_BAL'
        format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
        aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
        defaults='||||||||||||||'
        editcols='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
        widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
        sorting='T'
        styles='width:100%; height:460'
/>
    </td>
   </tr> 
  </table>
    <gw:textbox id="dtbFrom" styles='display:none;' />
   <gw:textbox id="dtbTo" styles='display:none;' />
    <gw:textbox id="cboWarehouse" styles='display:none;' />
    <gw:textbox id="txtItemGroup_PK" styles='display:none;' />
    <gw:textbox id="txtItem" styles='display:none;' />
    <gw:textbox id="cboTransType" styles='display:none;' />
</body>
</html>


