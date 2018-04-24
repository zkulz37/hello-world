<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
  
  <script type="text/javascript" language="javascript">
function BodyInit()
{
    //alert("hello");
}
function OnSearch()
{
    master.Call("SELECT");
}
function OnDataReceive(objData)
{
   if(objData.id == "master")
   {
        //
   }
}
function OnGridDoubleClick(objGrid)
{
    var arr = new Array();
    if(event.row > 0)
    {
      arr[0] = objGrid.GetGridData(event.row,0);
      arr[1] = objGrid.GetGridData(event.row,2);
      window.returnValue = arr;
      window.close();
    }
}
</script>
 
<body>	
<gw:data id="master"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso id="1" type="grid" function="GASP.sp_get_employee" > 
                <input bind="grdMaster" > 
                    <input bind="txtID" /> 
                    <input bind="txtName" /> 
                </input> 
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
</gw:data> 

<table width=100%>
 <tr>
    <td width=5%><b>Emp ID</b></td>
    <td width=10%><gw:textbox id="txtID" /></td>
    <td width=5%><b>Name</b></td>
    <td width=10%><gw:textbox id="txtName" /></td>
     <td width=67%></td>
     <td width=3%><gw:imgBtn  id="ibtnSearch" img="search" alt="search" onclick="OnSearch()" /></td>
 </tr>
 </table>
<table width=100%>
    <tr>
        <td>
            <gw:grid   
		    id="grdMaster"  
		    header="_PK|Emp ID|Emp Name|Join Date|Sex"   
		    format="0|0|0|0|0"  
		    aligns="0|0|0|0|0"  
		    defaults="||||"   
		    editcol="1|1|1|1|1"  
			widths="0|1200|2000|2000|0"  
		    styles="width:100%; height:400"   
		    sorting="T"   
		    acceptNullDate="true"
		    param="0,1,2,3,4"
			oncelldblclick="OnGridDoubleClick(this)"  />
        </td>
    </tr>
</table>
</body>
</html>
