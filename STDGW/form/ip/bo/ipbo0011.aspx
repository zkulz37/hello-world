<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Style Popup</title>
</head>
<%  ESysLib.SetUser("stm")%>

<script> 
var style = "<%=request.QueryString("style_pk") %>"  ;
var 
G_gender = 3,
G_season = 7,
G_unit = 8,
G_ccy = 9;
var gBlnFlag = true;
  function BodyInit()
 {
    txtStyle_pk.text = style
   // Set Gender to grid combo
    var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0013'" )  %> " ; 
     grdStyle.SetComboFormat(G_gender,data);
   // Set Season to grid combo
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0014'" )  %> " ; 
     grdStyle.SetComboFormat(G_season,data);
    // Set Season to grid combo
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0015'" )  %> " ; 
     grdStyle.SetComboFormat(G_unit,data);
    // Set Season to grid combo
     data = "<%=ESysLib.SetGridColumnDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0006'" )  %> " ; 
     grdStyle.SetComboFormat(G_ccy,data);    
 }
 
 function OnSearch()
 {
    ipbo0011.Call('SELECT')
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
    <gw:data id="ipbo0011" onreceive=""> 
	    <xml> 
		    <dso type="grid"  function="stm.sp_sel_ipbo0011"  > 
			    <input bind="grdStyle" > 
			        <input bind="lstSBrand" />	
			        <input bind="txtStyle" />			
			    </input> 
			    <output bind="grdStyle" /> 
		    </dso> 
	    </xml> 
    </gw:data>  
        
    </gw:data>
    <table width="100%" height="100%">
        <tr height="5%">
            
            <td width="10%">
                Brand
            </td>
             <td width="15%">
                <gw:list  id="lstSBrand" value ="ALL" styles='width:100%'onchange="OnSearch()" >
					<data>
						<%=ESysLib.SetListDataSQL("SELECT B.PK, B.BRAND_ID FROM TST_BRAND B WHERE B.DEL_IF = 0 AND B.USE_YN = 'Y' ORDER BY B.BRAND_ID")%> |ALL|Select All
					</data>
				</gw:list>
            </td>
            <td width="20%">
                Style ID/Name
            </td>
            <td width="30%">
                <gw:textbox id="txtStyle"  styles="width:100%" onenterkey="OnSearch()" />
            </td>
            <td width="20%">
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
                        header='_PK|_TST_BRAND_PK|Brand|Gender|Style Id|Style Desc|Style Year|Season|Unit|CCY|U.Price|Description|ST Date|End Date|Use YN'
                        format='0|0|0|0|0|0|0|0|0|0|1|0|0|0|3'
                        aligns='0|0|0|0|0|0|0|0|1|1|0|0|0|0|0'
                        defaults='||||||||||||||'
                        editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                        widths='0|0|1500|1500|1500|2500|1500|1500|1500|1000|1500|1500|1200|1200|1500'
                        sorting='T'
                        styles='width:100%; height:100%'
                        oncelldblclick='OnSelect(grdStyle)'
                        />
            </td>
        </tr>
    </table>
</body>
 <gw:textbox id="txtStyle_pk" text="" styles="display:none" />

</html>
