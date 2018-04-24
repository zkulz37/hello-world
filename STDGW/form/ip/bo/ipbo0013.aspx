<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Style Size</title>
</head>
<%  ESysLib.SetUser("stm")%>

<script> 
var style = "<%=request.QueryString("style_pk") %>"  ;
var gBlnFlag = true;
  function BodyInit()
 {
    txtStyler_pk.text = style
    OnSearch()
 }
 
 function OnSearch()
 {
    ipbo0013.Call('SELECT')
 }
   
//----------------------------popup-------------------------------
function OnSelect(oGrid)
{
   var arr_data = new Array();
   var control = oGrid.GetGridControl();
   var rows = control.Rows;
	
	if (control.SelectedRows >0)
	{
		for (i=0; i<control.SelectedRows ; i++)
		{
			var row = control.SelectedRow(i);
			
			var arrTemp=new Array();
         
             for(var j=0;j<oGrid.cols;j++)
             {
                arrTemp[arrTemp.length]= oGrid.GetGridData(row,j);
             }
             
             arr_data[arr_data.length]= arrTemp;
		}
		window.returnValue =  arr_data;
		window.close();
    }
	
	  else
	  {
	    alert("You have not selected data yet.");
	  }
}
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="ipbo0013" onreceive=""> 
	    <xml> 
		    <dso type="grid"  function="stm.sp_sel_ipbo0013"  > 
			    <input bind="grdStyle" > 
			        <input bind="txtStyler_pk" />	
			        <input bind="txtStyleSize" />			
			    </input> 
			    <output bind="grdStyle" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <table width="100%" height="100%">
        <tr height="5%">
            
            <td width="15%">
                Style Color
            </td>
            <td width="30%">
                <gw:textbox id="txtStyleSize"  styles="width:100%" onenterkey="OnSearch()" />
            </td>
            <td width="40%">
            </td>
            <td width="3%">
                <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(grdStyle)" />
            </td>
            <td width="3%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
        </tr>
        <tr border="1" height="95%">
            <td colspan="12">
                        <gw:grid id='grdStyle'
                        header='_PK|SEQ|Size|Remark '
                        format='0|0|0|0'
                        aligns='0|0|0|0'
                        defaults='||||'
                        editcol='0|0|0|0'
                        widths='0|1500|1500|2500'
                        sorting='T'
                        styles='width:100%; height:100%'
                        oncelldblclick='OnSelect(grdStyle)'
                        />
            </td>
        </tr>
    </table>
</body>
 <gw:textbox id="txtStyler_pk" text="" styles="display:none" />

</html>
